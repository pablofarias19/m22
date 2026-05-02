<?php
/**
 * POST /api/bulk_import.php
 *
 * Importa negocios o marcas desde un archivo JSON generado por IA.
 * Se espera un multipart/form-data con:
 *   - file: archivo .json (máx 2MB)
 *   - type: "businesses" | "brands"
 *
 * Responde con {success, imported, errors[]} por cada fila del array JSON.
 */

ini_set('display_errors', 0);
error_reporting(E_ALL);
header('Content-Type: application/json; charset=utf-8');
session_start();

require_once __DIR__ . '/../core/Database.php';
require_once __DIR__ . '/../core/helpers.php';

if (!isAdmin()) {
    http_response_code(403);
    echo json_encode(['success' => false, 'error' => 'Solo administradores pueden usar la importación masiva.']);
    exit;
}

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(['success' => false, 'error' => 'Método no válido.']);
    exit;
}

$type = trim($_POST['type'] ?? '');
if (!in_array($type, ['businesses', 'brands'], true)) {
    echo json_encode(['success' => false, 'error' => 'El parámetro "type" debe ser "businesses" o "brands".']);
    exit;
}

// ── File validation ──────────────────────────────
if (empty($_FILES['file']) || $_FILES['file']['error'] !== UPLOAD_ERR_OK) {
    $errMsg = match($_FILES['file']['error'] ?? -1) {
        UPLOAD_ERR_INI_SIZE, UPLOAD_ERR_FORM_SIZE => 'El archivo supera el tamaño máximo (2MB).',
        UPLOAD_ERR_NO_FILE => 'No se recibió ningún archivo.',
        default => 'Error al recibir el archivo.',
    };
    echo json_encode(['success' => false, 'error' => $errMsg]);
    exit;
}

if ($_FILES['file']['size'] > 2 * 1024 * 1024) {
    echo json_encode(['success' => false, 'error' => 'El archivo supera el límite de 2MB.']);
    exit;
}

$raw = file_get_contents($_FILES['file']['tmp_name']);
if ($raw === false) {
    echo json_encode(['success' => false, 'error' => 'No se pudo leer el archivo.']);
    exit;
}

$items = json_decode($raw, true);
if (!is_array($items) || empty($items)) {
    echo json_encode(['success' => false, 'error' => 'El archivo no contiene un array JSON válido.']);
    exit;
}

// ── DB connection ────────────────────────────────
try {
    $db = \Core\Database::getInstance()->getConnection();
} catch (Throwable $e) {
    error_log('bulk_import db: ' . $e->getMessage());
    echo json_encode(['success' => false, 'error' => 'Error de conexión a la base de datos.']);
    exit;
}

$userId   = (int)$_SESSION['user_id'];
$imported = 0;
$errors   = [];
$skipped  = []; // marcas omitidas por ya existir en la BD

// ── Geocodificación con cascada ──────────────────────────────────────────────

/**
 * Consulta Nominatim con una query específica.
 * Aplica bias a Latinoamérica (ar, pe, cl, uy, bo, br, co, mx, ve, ec, py).
 * Devuelve ['lat', 'lng'] o null.
 */
function nominatimLookup(string $query): ?array {
    static $lastCall = 0;
    // Respetar 1 request/segundo (ToS Nominatim)
    $elapsed = microtime(true) - $lastCall;
    if ($elapsed < 1.1) usleep((int)(($elapsed - 1.1) * -1000000));

    $ctx = stream_context_create(['http' => [
        'timeout' => 6,
        'method'  => 'GET',
        'header'  => "User-Agent: Mapita-BulkImport/1.0 (contacto@mapita.com.ar)\r\n",
    ]]);

    $url  = 'https://nominatim.openstreetmap.org/search?format=json&limit=1'
          . '&countrycodes=ar,pe,cl,uy,bo,br,co,mx,ve,ec,py'
          . '&q=' . urlencode($query);
    $raw  = @file_get_contents($url, false, $ctx);
    $lastCall = microtime(true);

    if ($raw === false) return null;
    $data = json_decode($raw, true);
    if (empty($data[0]['lat'])) return null;

    $lat = (float)$data[0]['lat'];
    $lng = (float)$data[0]['lon'];
    if ($lat < -90 || $lat > 90 || $lng < -180 || $lng > 180) return null;
    return ['lat' => $lat, 'lng' => $lng];
}

/**
 * Estrategia de cascada para geocodificar una marca cuando no vienen lat/lng en el JSON.
 *
 * Niveles en orden de precisión:
 *   1. address   — campo "address" explícito del titular (ej: "Av. Colón 1234, Córdoba")
 *   2. ubicacion — campo "ubicacion" si es específico (no "Argentina" genérico)
 *   3. aproximado — nombre de marca + rubro + ubicacion (último intento)
 *   4. null      — no se pudo geocodificar → guardar sin coords, admin lo resuelve
 *
 * NUNCA se usa Buenos Aires como fallback: una posición falsa es peor que ninguna.
 *
 * @return array{lat:float,lng:float,nivel:string}|null
 */
function geocodeWithCascade(array $row): ?array {
    $strategies = [];

    // Nivel 1: dirección explícita del titular
    if (!empty($row['address'])) {
        $strategies[] = ['q' => trim((string)$row['address']), 'nivel' => 'address'];
    }

    // Nivel 2: ubicacion específica
    $ubicacion = trim((string)($row['ubicacion'] ?? ''));
    $isGeneric = in_array(strtolower($ubicacion), ['', 'argentina', 'arg', 'ar'], true)
              || preg_match('/^https?:\/\//i', $ubicacion); // evitar URLs en ubicacion
    if (!$isGeneric) {
        $strategies[] = ['q' => $ubicacion, 'nivel' => 'ubicacion'];
    }

    // Nivel 3: nombre + ubicacion (aproximado — útil para marcas con ciudad conocida)
    $nombre = trim((string)($row['nombre'] ?? ''));
    $rubro  = trim((string)($row['rubro']  ?? ''));
    if ($nombre) {
        $parts = array_filter([$nombre, !$isGeneric ? $ubicacion : '', $rubro, 'Argentina']);
        $strategies[] = ['q' => implode(', ', $parts), 'nivel' => 'aproximado'];
    }

    foreach ($strategies as $strategy) {
        $coords = nominatimLookup($strategy['q']);
        if ($coords !== null) {
            return array_merge($coords, ['nivel' => $strategy['nivel']]);
        }
    }

    return null; // Sin coordenadas → lat/lng NULL en BD, pendiente de geocodificación manual
}

// Contadores de geocodificación para el reporte final
$geo_json     = 0; // coords vinieron en el JSON
$geo_address  = 0; // geocodificado por campo address
$geo_ubicacion= 0; // geocodificado por campo ubicacion
$geo_aprox    = 0; // geocodificado de forma aproximada
$geo_pending  = 0; // sin coords → quedó NULL

// ── NEGOCIOS ─────────────────────────────────────
if ($type === 'businesses') {
    $REQUIRED = ['name', 'business_type', 'address', 'lat', 'lng'];
    $VALID_TYPES = [
        'restaurante','cafeteria','bar','panaderia','heladeria','pizzeria',
        'supermercado','comercio','autos_venta','motos_venta','indumentaria','verduleria','carniceria','pastas','ferreteria',
        'electronica','muebleria','floristeria','libreria',
        'productora_audiovisual','escuela_musicos','taller_artes','biodecodificacion','libreria_cristiana',
        'farmacia','hospital','medico_pediatra','medico_traumatologo','laboratorio','odontologia','psicologo','psicopedagogo','fonoaudiologo','grafologo','enfermeria','asistencia_ancianos','veterinaria','optica',
        'salon_belleza','barberia','spa','gimnasio','danza',
        'banco','inmobiliaria','seguros','abogado','agente_inpi','contador','arquitectura','ingenieria','ingenieria_civil','electricista','gasista','gas_en_garrafa','seguridad','grafica','astrologo','zapatero','videojuegos','maestro_particular','alquiler_mobiliario_fiestas','propalacion_musica','animacion_fiestas','taller','herreria','carpinteria','modista','construccion','centro_vecinal','remate',
        'transporte','transporte_envios','transporte_pasajeros','transporte_carga','transportista','logistica','flota',
        'academia','idiomas','escuela','hotel','turismo','cine',
        'obra_de_arte',
        'musico','cantante','bailarin','actor','actriz','director_artistico','guionista','escenografo',
        'fotografo_artistico','productor_artistico','maquillador','pintor','poeta','musicalizador',
        'editor_grafico','asistente_artistico',
        'otros'
    ];

    $stmt = $db->prepare("
        INSERT INTO businesses
            (user_id, name, business_type, address, lat, lng, phone, email, website,
             instagram, facebook, tiktok, description, certifications,
             has_delivery, has_card_payment, is_franchise, price_range,
             company_size, location_city, style, visible, status, created_at, updated_at)
        VALUES
            (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,1,'active',NOW(),NOW())
    ");

    foreach ($items as $i => $row) {
        $rowNum = $i + 1;

        // Required field check
        $missing = [];
        foreach ($REQUIRED as $f) {
            if (!isset($row[$f]) || (string)$row[$f] === '') $missing[] = $f;
        }
        if ($missing) {
            $errors[] = "Fila {$rowNum}: faltan campos obligatorios: " . implode(', ', $missing);
            continue;
        }

        if (!in_array($row['business_type'], $VALID_TYPES, true)) {
            $errors[] = "Fila {$rowNum}: business_type '{$row['business_type']}' no es válido.";
            continue;
        }

        $lat = filter_var($row['lat'], FILTER_VALIDATE_FLOAT);
        $lng = filter_var($row['lng'], FILTER_VALIDATE_FLOAT);
        if ($lat === false || $lng === false) {
            $errors[] = "Fila {$rowNum}: lat/lng no son números válidos.";
            continue;
        }

        try {
            $stmt->execute([
                $userId,
                mb_substr((string)$row['name'], 0, 255),
                $row['business_type'],
                mb_substr((string)$row['address'], 0, 500),
                $lat,
                $lng,
                isset($row['phone'])          ? mb_substr((string)$row['phone'], 0, 50)           : null,
                isset($row['email'])          ? mb_substr((string)$row['email'], 0, 255)          : null,
                isset($row['website'])        ? mb_substr((string)$row['website'], 0, 500)        : null,
                isset($row['instagram'])      ? mb_substr((string)$row['instagram'], 0, 100)      : null,
                isset($row['facebook'])       ? mb_substr((string)$row['facebook'], 0, 255)       : null,
                isset($row['tiktok'])         ? mb_substr((string)$row['tiktok'], 0, 100)         : null,
                isset($row['description'])    ? mb_substr((string)$row['description'], 0, 2000)   : null,
                isset($row['certifications']) ? mb_substr((string)$row['certifications'], 0, 500) : null,
                isset($row['has_delivery'])   ? (int)(bool)$row['has_delivery']                   : 0,
                isset($row['has_card_payment'])? (int)(bool)$row['has_card_payment']              : 0,
                isset($row['is_franchise'])   ? (int)(bool)$row['is_franchise']                   : 0,
                isset($row['price_range'])    ? min(5, max(1, (int)$row['price_range']))           : null,
                isset($row['company_size'])   ? mb_substr((string)$row['company_size'], 0, 50)    : null,
                isset($row['location_city'])  ? mb_substr((string)$row['location_city'], 0, 100)  : null,
                isset($row['style'])          ? mb_substr((string)$row['style'], 0, 255)           : null,
            ]);
            $imported++;
        } catch (Throwable $e) {
            error_log("bulk_import negocio fila {$rowNum}: " . $e->getMessage());
            $errors[] = "Fila {$rowNum}: error al insertar (" . $e->getMessage() . ')';
        }
    }
}

// ── MARCAS ───────────────────────────────────────
if ($type === 'brands') {
    $REQUIRED = ['nombre', 'rubro'];

    $stmt = $db->prepare("
        INSERT INTO brands
            (user_id, nombre, rubro, website, ubicacion, lat, lng, description, extended_description,
             clase_principal, founded_year, annual_revenue,
             instagram, facebook, tiktok, twitter, linkedin, youtube, whatsapp,
             historia_marca, target_audience, propuesta_valor,
             inpi_registrada, inpi_numero, inpi_fecha_registro, inpi_vencimiento,
             inpi_clases_registradas, inpi_tipo,
             es_franquicia, tiene_zona, zona_radius_km, tiene_licencia, estado,
             visible, created_at, updated_at)
        VALUES
            (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,1,NOW(),NOW())
    ");

    foreach ($items as $i => $row) {
        $rowNum = $i + 1;

        $missing = [];
        foreach ($REQUIRED as $f) {
            if (!isset($row[$f]) || (string)$row[$f] === '') $missing[] = $f;
        }
        if ($missing) {
            $errors[] = "Fila {$rowNum}: faltan campos obligatorios: " . implode(', ', $missing);
            continue;
        }

        // ── Detección de duplicados contra la BD ─────────────────────────────
        // Prioridad 1: inpi_numero (identificador único más confiable)
        if (!empty($row['inpi_numero'])) {
            $chk = $db->prepare("SELECT id, nombre FROM brands WHERE inpi_numero = ? LIMIT 1");
            $chk->execute([mb_substr((string)$row['inpi_numero'], 0, 50)]);
            if ($existing = $chk->fetch(PDO::FETCH_ASSOC)) {
                $skipped[] = "'{$row['nombre']}': ya existe con INPI N° {$row['inpi_numero']} (ID #{$existing['id']} — omitida).";
                continue;
            }
        }
        // Prioridad 2: nombre exacto (normalizado)
        $chkNombre = $db->prepare("SELECT id FROM brands WHERE LOWER(TRIM(nombre)) = LOWER(TRIM(?)) LIMIT 1");
        $chkNombre->execute([(string)$row['nombre']]);
        if ($existingId = $chkNombre->fetchColumn()) {
            $skipped[] = "'{$row['nombre']}': ya existe con ese nombre (ID #{$existingId} — omitida).";
            continue;
        }

        // ── Coordenadas: cascada de geocodificación ──────────────────────────
        $latRaw = isset($row['lat']) ? filter_var($row['lat'], FILTER_VALIDATE_FLOAT) : false;
        $lngRaw = isset($row['lng']) ? filter_var($row['lng'], FILTER_VALIDATE_FLOAT) : false;

        if ($latRaw !== false && $lngRaw !== false) {
            // Caso ideal: el JSON ya trae coordenadas precisas
            $lat = $latRaw;
            $lng = $lngRaw;
            $geo_json++;
        } else {
            // Sin coords en el JSON → intentar geocodificación por cascada
            $geoResult = geocodeWithCascade($row);
            if ($geoResult !== null) {
                $lat = $geoResult['lat'];
                $lng = $geoResult['lng'];
                switch ($geoResult['nivel']) {
                    case 'address':   $geo_address++;   break;
                    case 'ubicacion': $geo_ubicacion++; break;
                    default:          $geo_aprox++;
                }
            } else {
                // No fue posible geocodificar → NULL es mejor que una posición falsa
                $lat = null;
                $lng = null;
                $geo_pending++;
            }
        }

        // ── Fechas INPI: sanitizar '0000-00-00' y formatos inválidos ─────────
        $inpiFecha = !empty($row['inpi_fecha_registro'])
            && $row['inpi_fecha_registro'] !== '0000-00-00'
            && preg_match('/^\d{4}-\d{2}-\d{2}$/', $row['inpi_fecha_registro'])
                ? $row['inpi_fecha_registro'] : null;

        $inpiVencimiento = !empty($row['inpi_vencimiento'])
            && $row['inpi_vencimiento'] !== '0000-00-00'
            && preg_match('/^\d{4}-\d{2}-\d{2}$/', $row['inpi_vencimiento'])
                ? $row['inpi_vencimiento'] : null;

        try {
            $stmt->execute([
                $userId,
                mb_substr((string)$row['nombre'], 0, 255),
                mb_substr((string)$row['rubro'], 0, 255),
                isset($row['website'])          ? mb_substr((string)$row['website'], 0, 500)          : null,
                // ubicacion: usar address si ubicacion es genérico y address es específico
                mb_substr((string)(
                    (!empty($row['address']))
                        ? ((empty($row['ubicacion']) || strtolower(trim($row['ubicacion'])) === 'argentina')
                            ? $row['address']           // address más específico que "Argentina"
                            : $row['ubicacion'])         // ubicacion ya es específico, conservarlo
                        : ($row['ubicacion'] ?? 'Argentina')
                ), 0, 255),
                $lat,
                $lng,
                isset($row['description'])      ? mb_substr((string)$row['description'], 0, 2000)     : null,
                isset($row['extended_description'])? mb_substr((string)$row['extended_description'], 0, 5000) : null,
                isset($row['clase_principal'])  ? mb_substr((string)$row['clase_principal'], 0, 50)   : null,
                isset($row['founded_year'])     ? (int)$row['founded_year']                           : null,
                isset($row['annual_revenue'])   ? mb_substr((string)$row['annual_revenue'], 0, 100)   : null,
                isset($row['instagram'])        ? mb_substr((string)$row['instagram'], 0, 100)        : null,
                isset($row['facebook'])         ? mb_substr((string)$row['facebook'], 0, 255)         : null,
                isset($row['tiktok'])           ? mb_substr((string)$row['tiktok'], 0, 100)           : null,
                isset($row['twitter'])          ? mb_substr((string)$row['twitter'], 0, 100)          : null,
                isset($row['linkedin'])         ? mb_substr((string)$row['linkedin'], 0, 255)         : null,
                isset($row['youtube'])          ? mb_substr((string)$row['youtube'], 0, 255)          : null,
                isset($row['whatsapp'])         ? mb_substr((string)$row['whatsapp'], 0, 50)          : null,
                isset($row['historia_marca'])   ? mb_substr((string)$row['historia_marca'], 0, 10000) : null,
                isset($row['target_audience'])  ? mb_substr((string)$row['target_audience'], 0, 1000) : null,
                isset($row['propuesta_valor'])  ? mb_substr((string)$row['propuesta_valor'], 0, 1000) : null,
                isset($row['inpi_registrada'])  ? (int)(bool)$row['inpi_registrada']                  : 0,
                isset($row['inpi_numero'])      ? mb_substr((string)$row['inpi_numero'], 0, 50)       : null,
                $inpiFecha,
                $inpiVencimiento,
                isset($row['inpi_clases_registradas'])? mb_substr((string)$row['inpi_clases_registradas'], 0, 255) : null,
                isset($row['inpi_tipo'])        ? mb_substr((string)$row['inpi_tipo'], 0, 100)        : null,
                isset($row['es_franquicia'])    ? (int)(bool)$row['es_franquicia']                    : 0,
                isset($row['tiene_zona'])       ? (int)(bool)$row['tiene_zona']                       : 0,
                isset($row['zona_radius_km'])   ? (int)$row['zona_radius_km']                         : null,
                isset($row['tiene_licencia'])   ? (int)(bool)$row['tiene_licencia']                   : 0,
                isset($row['estado'])           ? mb_substr((string)$row['estado'], 0, 50)            : 'Activa',
            ]);
            $imported++;
        } catch (Throwable $e) {
            error_log("bulk_import marca fila {$rowNum}: " . $e->getMessage());
            $errors[] = "Fila {$rowNum}: error al insertar (" . $e->getMessage() . ')';
        }
    }
}

// ── Armar mensaje enriquecido con reporte de geocodificación ────────────────
$geoMsg = '';
if ($type === 'brands') {
    $geoParts = [];
    if ($geo_json)      $geoParts[] = "{$geo_json} con coords del JSON";
    if ($geo_address)   $geoParts[] = "{$geo_address} geocodificadas por dirección";
    if ($geo_ubicacion) $geoParts[] = "{$geo_ubicacion} geocodificadas por ubicación";
    if ($geo_aprox)     $geoParts[] = "{$geo_aprox} geocodificadas aproximadamente";
    if ($geo_pending)   $geoParts[] = "⚠️ {$geo_pending} sin coords (requieren geocodificación manual desde Admin → Marcas)";
    if ($geoParts) $geoMsg = ' | Geolocalización: ' . implode(', ', $geoParts) . '.';
}

$baseMsg = "{$imported} de " . count($items) . " importados correctamente.";
if (count($skipped)) $baseMsg .= ' ' . count($skipped) . ' omitidas (ya existen en la BD).';
if (count($errors))  $baseMsg .= ' ' . count($errors)  . ' con errores.';

echo json_encode([
    'success'   => true,
    'imported'  => $imported,
    'total'     => count($items),
    'skipped'   => $skipped,
    'errors'    => $errors,
    'message'   => $baseMsg . $geoMsg,
    'geo_report'=> $type === 'brands' ? [
        'json'      => $geo_json,
        'address'   => $geo_address,
        'ubicacion' => $geo_ubicacion,
        'aprox'     => $geo_aprox,
        'pending'   => $geo_pending,
    ] : null,
]);

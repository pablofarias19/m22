<?php
/**
 * GET /api/admin_brands.php
 *
 * Devuelve TODAS las marcas de la tabla `brands` para el panel admin,
 * incluyendo las que no tienen coordenadas (lat/lng NULL).
 *
 * A diferencia de /api/brands.php (que filtra por lat IS NOT NULL para el mapa),
 * este endpoint no aplica el filtro de coordenadas para que el admin pueda
 * ver, editar y completar marcas importadas sin geolocalización.
 *
 * Requiere: sesión de administrador activa.
 */

ini_set('display_errors', 0);
error_reporting(E_ALL);
ob_start();

require_once __DIR__ . '/../core/Database.php';
require_once __DIR__ . '/../core/helpers.php';

ob_end_clean();
header('Content-Type: application/json; charset=utf-8');
session_start();

if (!isAdmin()) {
    http_response_code(403);
    echo json_encode(['success' => false, 'error' => 'Acceso denegado.']);
    exit;
}

try {
    $db = \Core\Database::getInstance()->getConnection();

    $stmt = $db->query("
        SELECT
            id, user_id, nombre, rubro, ubicacion,
            lat, lng, website, clase_principal,
            nivel_proteccion, riesgo_oposicion, valor_activo,
            mapita_id, extended_description, description,
            tiene_zona, zona_radius_km, tiene_licencia,
            es_franquicia, zona_exclusiva, zona_exclusiva_radius_km,
            created_at, estado,
            inpi_registrada, inpi_numero, inpi_fecha_registro,
            inpi_vencimiento, inpi_clases_registradas, inpi_tipo,
            franchise_details, whatsapp, founded_year,
            instagram, facebook, tiktok, twitter, linkedin, youtube,
            country_code, language_code, currency_code,
            registry_authority, registry_number, registry_date,
            registry_expiry, registry_type,
            crear_franquicia, visible
        FROM brands
        ORDER BY created_at DESC
    ");

    $marcas = $stmt->fetchAll(PDO::FETCH_ASSOC);

    // Enriquecer con logo si existe en disco
    $uploadsBase = __DIR__ . '/../uploads/brands/';
    foreach ($marcas as &$m) {
        $id  = (int)$m['id'];
        $dir = $uploadsBase . $id . '/';
        $m['logo_url'] = null;
        foreach (['png','jpg','jpeg','webp'] as $ext) {
            $f = $dir . 'logo.' . $ext;
            if (file_exists($f)) {
                $m['logo_url'] = '/uploads/brands/' . $id . '/logo.' . $ext . '?t=' . filemtime($f);
                break;
            }
        }
        // Indicar si la marca tiene coordenadas (para mostrar alerta en admin)
        $m['tiene_coords'] = ($m['lat'] !== null && $m['lng'] !== null) ? 1 : 0;
    }
    unset($m);

    respond_success($marcas, count($marcas) . " marcas obtenidas.");
} catch (Throwable $e) {
    error_log('admin_brands.php fatal: ' . $e->getMessage() . ' en ' . $e->getFile() . ':' . $e->getLine());
    respond_error("Error: " . $e->getMessage());
}

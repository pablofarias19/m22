<?php
/**
 * API MULTITUDES — grupos de transmisiones/links con períodos y artistas/grupos
 * Tablas: multitudes + multitud_items
 */
ini_set('display_errors', 0);
header('Content-Type: application/json; charset=utf-8');
header('Cache-Control: no-cache');
session_start();

function respond_success($data, $msg = 'OK') {
    echo json_encode(['success' => true, 'data' => $data, 'message' => $msg]); exit;
}
function respond_error($msg, $code = 400) {
    http_response_code($code);
    echo json_encode(['success' => false, 'error' => $msg]); exit;
}

require_once __DIR__ . '/../core/Database.php';

$method = $_SERVER['REQUEST_METHOD'];
$action = $_GET['action'] ?? 'list';
$id     = (int)($_GET['id'] ?? 0);

$db = null;
try { $db = \Core\Database::getInstance()->getConnection(); }
catch (Exception $e) { error_log('Multitudes BD: ' . $e->getMessage()); }

// ── GET ───────────────────────────────────────────────────────────────────────
if ($method === 'GET') {
    if (!$db) respond_error('BD no disponible', 503);
    try {
        $db->query("SELECT 1 FROM multitudes LIMIT 1");

        // Una multitud con sus ítems
        if ($id > 0) {
            $s = $db->prepare("SELECT * FROM multitudes WHERE id = ?");
            $s->execute([$id]);
            $m = $s->fetch(\PDO::FETCH_ASSOC);
            if (!$m) respond_error('No encontrada', 404);

            $si = $db->prepare(
                "SELECT * FROM multitud_items
                 WHERE multitud_id = ? AND activo = 1
                 ORDER BY orden ASC, fecha_periodo ASC, id ASC"
            );
            $si->execute([$id]);
            $m['items'] = $si->fetchAll(\PDO::FETCH_ASSOC);
            respond_success($m);
        }

        // Nearby
        if ($action === 'nearby') {
            $lat   = (float)($_GET['lat']   ?? 0);
            $lng   = (float)($_GET['lng']   ?? 0);
            $radio = (float)($_GET['radio'] ?? 50);
            if (!$lat || !$lng) respond_error('Coordenadas requeridas');
            $sql = "SELECT *, (6371 * ACOS(COS(RADIANS(?)) * COS(RADIANS(lat)) *
                    COS(RADIANS(lng)-RADIANS(?)) + SIN(RADIANS(?)) * SIN(RADIANS(lat)))) AS dist_km
                    FROM multitudes WHERE activo = 1 AND lat IS NOT NULL AND lng IS NOT NULL
                    HAVING dist_km <= ? ORDER BY dist_km ASC";
            $s = $db->prepare($sql);
            $s->execute([$lat, $lng, $lat, $radio]);
            respond_success($s->fetchAll(\PDO::FETCH_ASSOC), 'Multitudes cercanas');
        }

        // Listar todas con conteo de ítems
        $s = $db->query(
            "SELECT m.*, COUNT(mi.id) AS total_items
             FROM multitudes m
             LEFT JOIN multitud_items mi ON mi.multitud_id = m.id AND mi.activo = 1
             WHERE m.activo = 1
             GROUP BY m.id
             ORDER BY m.nombre ASC"
        );
        respond_success($s->fetchAll(\PDO::FETCH_ASSOC), 'Multitudes obtenidas');

    } catch (\PDOException $e) {
        error_log('Multitudes GET: ' . $e->getMessage());
        respond_success([], 'Tabla multitudes no existe aún. Ejecutar migrations/041_multitudes.sql');
    }
}

// ── POST ─────────────────────────────────────────────────────────────────────
if ($method === 'POST') {
    if (empty($_SESSION['is_admin'])) respond_error('Solo admin', 403);
    if (!$db) respond_error('BD no disponible', 500);

    $ct    = $_SERVER['CONTENT_TYPE'] ?? '';
    $input = strpos($ct, 'application/json') !== false
           ? json_decode(file_get_contents('php://input'), true)
           : $_POST;
    if (!$input && !in_array($action, ['delete', 'delete_item'])) {
        respond_error('Datos inválidos');
    }
    if (!$input) $input = [];

    try {
        // ── Multitudes CRUD ───────────────────────────────────────────────────
        if ($action === 'create') {
            $nombre = trim($input['nombre'] ?? '');
            if (!$nombre) respond_error('Nombre requerido');
            $s = $db->prepare(
                "INSERT INTO multitudes (nombre, descripcion, lat, lng, activo, created_at)
                 VALUES (?,?,?,?,?,NOW())"
            );
            $ok = $s->execute([
                $nombre,
                $input['descripcion'] ?? null,
                isset($input['lat']) && $input['lat'] !== '' ? (float)$input['lat'] : null,
                isset($input['lng']) && $input['lng'] !== '' ? (float)$input['lng'] : null,
                (int)(bool)($input['activo'] ?? true),
            ]);
            if ($ok) respond_success(['id' => $db->lastInsertId()], 'Multitud creada');
            respond_error('Error al crear', 500);
        }

        if ($action === 'update') {
            $mid = (int)($input['id'] ?? $_GET['id'] ?? 0);
            if ($mid <= 0) respond_error('ID inválido');
            $upd = []; $vals = [];
            foreach (['nombre','descripcion'] as $c) {
                if (array_key_exists($c, $input)) {
                    $upd[] = "$c = ?"; $vals[] = $input[$c] === '' ? null : $input[$c];
                }
            }
            foreach (['lat','lng'] as $co) {
                if (array_key_exists($co, $input)) {
                    $upd[] = "$co = ?"; $vals[] = ($input[$co] === '' || $input[$co] === null) ? null : (float)$input[$co];
                }
            }
            if (isset($input['activo'])) { $upd[] = 'activo = ?'; $vals[] = (int)(bool)$input['activo']; }
            if (empty($upd)) respond_error('Sin datos');
            $upd[] = 'updated_at = NOW()'; $vals[] = $mid;
            $s = $db->prepare("UPDATE multitudes SET " . implode(', ', $upd) . " WHERE id = ?");
            if ($s->execute($vals)) respond_success([], 'Multitud actualizada');
            respond_error('Error al actualizar', 500);
        }

        if ($action === 'delete') {
            $mid = (int)($input['id'] ?? $_GET['id'] ?? 0);
            if ($mid <= 0) respond_error('ID inválido');
            $s = $db->prepare("DELETE FROM multitudes WHERE id = ?");
            if ($s->execute([$mid])) respond_success([], 'Eliminada');
            respond_error('Error al eliminar', 500);
        }

        // ── Items CRUD ────────────────────────────────────────────────────────
        if ($action === 'create_item') {
            $multitud_id = (int)($input['multitud_id'] ?? 0);
            $titulo      = trim($input['titulo'] ?? '');
            $url         = trim($input['stream_url'] ?? '');
            if (!$multitud_id) respond_error('multitud_id requerido');
            if (!$titulo)      respond_error('Título requerido');
            if (!$url)         respond_error('URL requerida');
            $s = $db->prepare(
                "INSERT INTO multitud_items
                    (multitud_id, titulo, descripcion_corta, stream_url,
                     grupo_artista, fecha_periodo, orden, activo, created_at)
                 VALUES (?,?,?,?,?,?,?,?,NOW())"
            );
            $ok = $s->execute([
                $multitud_id,
                $titulo,
                $input['descripcion_corta'] ?? null,
                $url,
                $input['grupo_artista'] ?? null,
                !empty($input['fecha_periodo']) ? $input['fecha_periodo'] : null,
                isset($input['orden']) ? (int)$input['orden'] : 0,
                (int)(bool)($input['activo'] ?? true),
            ]);
            if ($ok) respond_success(['id' => $db->lastInsertId()], 'Ítem creado');
            respond_error('Error al crear ítem', 500);
        }

        if ($action === 'update_item') {
            $iid = (int)($input['id'] ?? $_GET['id'] ?? 0);
            if ($iid <= 0) respond_error('ID de ítem inválido');
            $upd = []; $vals = [];
            foreach (['titulo','descripcion_corta','stream_url','grupo_artista'] as $c) {
                if (array_key_exists($c, $input)) {
                    $upd[] = "$c = ?"; $vals[] = $input[$c] === '' ? null : $input[$c];
                }
            }
            if (array_key_exists('fecha_periodo', $input)) {
                $upd[] = 'fecha_periodo = ?';
                $vals[] = !empty($input['fecha_periodo']) ? $input['fecha_periodo'] : null;
            }
            if (array_key_exists('orden', $input)) {
                $upd[] = 'orden = ?'; $vals[] = (int)$input['orden'];
            }
            if (isset($input['activo'])) { $upd[] = 'activo = ?'; $vals[] = (int)(bool)$input['activo']; }
            if (empty($upd)) respond_error('Sin datos');
            $vals[] = $iid;
            $s = $db->prepare("UPDATE multitud_items SET " . implode(', ', $upd) . " WHERE id = ?");
            if ($s->execute($vals)) respond_success([], 'Ítem actualizado');
            respond_error('Error al actualizar ítem', 500);
        }

        if ($action === 'delete_item') {
            $iid = (int)($input['id'] ?? $_GET['id'] ?? 0);
            if ($iid <= 0) respond_error('ID de ítem inválido');
            $s = $db->prepare("DELETE FROM multitud_items WHERE id = ?");
            if ($s->execute([$iid])) respond_success([], 'Ítem eliminado');
            respond_error('Error al eliminar ítem', 500);
        }

    } catch (\PDOException $e) {
        error_log('Multitudes POST: ' . $e->getMessage());
        respond_error('Error: ' . $e->getMessage(), 500);
    }
}

respond_error('Método no válido', 405);

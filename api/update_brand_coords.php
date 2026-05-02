<?php
/**
 * POST /api/update_brand_coords.php
 *
 * Actualiza lat y lng de una marca. Solo accesible para administradores.
 *
 * Body JSON: { "id": int, "lat": float, "lng": float }
 * Responde:  { "success": bool, "message": string }
 */

ini_set('display_errors', 0);
error_reporting(E_ALL);
header('Content-Type: application/json; charset=utf-8');
session_start();

require_once __DIR__ . '/../core/Database.php';
require_once __DIR__ . '/../core/helpers.php';

if (!isAdmin()) {
    http_response_code(403);
    echo json_encode(['success' => false, 'message' => 'Acceso denegado.']);
    exit;
}

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(['success' => false, 'message' => 'Método no válido.']);
    exit;
}

$raw  = file_get_contents('php://input');
$body = json_decode($raw, true);

$id  = isset($body['id'])  ? (int)$body['id']   : 0;
$lat = isset($body['lat']) ? filter_var($body['lat'], FILTER_VALIDATE_FLOAT) : false;
$lng = isset($body['lng']) ? filter_var($body['lng'], FILTER_VALIDATE_FLOAT) : false;

if ($id <= 0) {
    echo json_encode(['success' => false, 'message' => 'ID de marca inválido.']);
    exit;
}
if ($lat === false || $lng === false) {
    echo json_encode(['success' => false, 'message' => 'lat/lng inválidos.']);
    exit;
}
if ($lat < -90 || $lat > 90 || $lng < -180 || $lng > 180) {
    echo json_encode(['success' => false, 'message' => 'Coordenadas fuera de rango mundial.']);
    exit;
}

try {
    $db   = \Core\Database::getInstance()->getConnection();
    $stmt = $db->prepare("UPDATE brands SET lat = ?, lng = ?, updated_at = NOW() WHERE id = ?");
    $stmt->execute([$lat, $lng, $id]);

    if ($stmt->rowCount() === 0) {
        echo json_encode(['success' => false, 'message' => 'Marca no encontrada (id=' . $id . ').']);
        exit;
    }

    echo json_encode([
        'success' => true,
        'message' => 'Coordenadas actualizadas correctamente.',
        'id'      => $id,
        'lat'     => $lat,
        'lng'     => $lng,
    ]);
} catch (Throwable $e) {
    error_log('update_brand_coords.php: ' . $e->getMessage());
    echo json_encode(['success' => false, 'message' => 'Error de base de datos.']);
}

<?php
header('Content-Type: application/json; charset=utf-8');

try {
    require_once __DIR__ . '/../delegation_helpers.php';

    if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
        respond_error('Método HTTP no soportado.', 405);
    }

    delegationRequireAuthUserId();
    $query = trim((string)($_GET['query'] ?? ''));
    if ($query === '') {
        respond_error('query es obligatorio.');
    }

    $db = getDbConnection();
    if (!$db || !mapitaTableExists($db, 'users')) {
        respond_error('Tabla users no disponible.', 500);
    }

    $user = delegationLookupUserByQuery($db, $query);
    if (!$user) {
        respond_error('No se encontró usuario con ese username o email.', 404);
    }

    respond_success([
        'user' => [
            'id'       => (int)$user['id'],
            'username' => $user['username'],
            'email'    => $user['email'],
        ],
    ], 'Usuario encontrado.');

} catch (Throwable $e) {
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'message' => 'Error interno del servidor.',
        'debug'   => (defined('APP_DEBUG') && APP_DEBUG) ? $e->getMessage() : null,
    ]);
}

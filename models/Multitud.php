<?php
/**
 * Modelo Multitud — ORM para las tablas `multitudes` y `multitud_items`
 */

namespace App\Models;

use Core\Database;
use PDO;

class Multitud
{
    // ── Multitudes (cabeceras) ─────────────────────────────────────────────────

    public static function getAll(): array
    {
        $db = Database::getInstance()->getConnection();
        return $db->query(
            "SELECT * FROM multitudes ORDER BY nombre ASC"
        )->fetchAll(PDO::FETCH_ASSOC);
    }

    public static function getAllActive(int $limit = 100, int $offset = 0): array
    {
        $db = Database::getInstance()->getConnection();
        $s  = $db->prepare(
            "SELECT * FROM multitudes
             WHERE activo = 1
             ORDER BY nombre ASC
             LIMIT ? OFFSET ?"
        );
        $s->execute([$limit, $offset]);
        return $s->fetchAll(PDO::FETCH_ASSOC);
    }

    public static function getById(int $id): ?array
    {
        $db = Database::getInstance()->getConnection();
        $s  = $db->prepare("SELECT * FROM multitudes WHERE id = ?");
        $s->execute([$id]);
        $row = $s->fetch(PDO::FETCH_ASSOC);
        return $row ?: null;
    }

    public static function getNearby(float $lat, float $lng, float $radio = 50): array
    {
        $db  = Database::getInstance()->getConnection();
        $sql = "SELECT *,
                       (6371 * ACOS(
                           COS(RADIANS(?)) * COS(RADIANS(lat)) *
                           COS(RADIANS(lng) - RADIANS(?)) +
                           SIN(RADIANS(?)) * SIN(RADIANS(lat))
                       )) AS dist_km
                FROM multitudes
                WHERE activo = 1 AND lat IS NOT NULL AND lng IS NOT NULL
                HAVING dist_km <= ?
                ORDER BY dist_km ASC";
        $s = $db->prepare($sql);
        $s->execute([$lat, $lng, $lat, $radio]);
        return $s->fetchAll(PDO::FETCH_ASSOC);
    }

    public static function getStats(): array
    {
        $db  = Database::getInstance()->getConnection();
        $row = $db->query(
            "SELECT
                COUNT(*)            AS total,
                SUM(activo = 1)     AS activas,
                SUM(activo = 0)     AS inactivas,
                (SELECT COUNT(*) FROM multitud_items WHERE activo = 1) AS total_items
             FROM multitudes"
        )->fetch(PDO::FETCH_ASSOC);
        return $row ?: ['total' => 0, 'activas' => 0, 'inactivas' => 0, 'total_items' => 0];
    }

    public static function create(array $data): int|false
    {
        $db = Database::getInstance()->getConnection();
        $s  = $db->prepare(
            "INSERT INTO multitudes (nombre, descripcion, lat, lng, activo, created_at)
             VALUES (?, ?, ?, ?, ?, NOW())"
        );
        $ok = $s->execute([
            $data['nombre'],
            $data['descripcion'] ?? null,
            isset($data['lat']) && $data['lat'] !== '' ? (float)$data['lat'] : null,
            isset($data['lng']) && $data['lng'] !== '' ? (float)$data['lng'] : null,
            isset($data['activo']) ? (int)(bool)$data['activo'] : 1,
        ]);
        return $ok ? (int)$db->lastInsertId() : false;
    }

    public static function update(int $id, array $data): bool
    {
        $db   = Database::getInstance()->getConnection();
        $upd  = []; $vals = [];
        foreach (['nombre', 'descripcion'] as $col) {
            if (array_key_exists($col, $data)) {
                $upd[]  = "$col = ?";
                $vals[] = ($data[$col] === '') ? null : $data[$col];
            }
        }
        foreach (['lat', 'lng'] as $coord) {
            if (array_key_exists($coord, $data)) {
                $upd[]  = "$coord = ?";
                $vals[] = ($data[$coord] === '' || $data[$coord] === null)
                    ? null : (float)$data[$coord];
            }
        }
        if (isset($data['activo'])) {
            $upd[]  = 'activo = ?';
            $vals[] = (int)(bool)$data['activo'];
        }
        if (empty($upd)) return false;
        $upd[]  = 'updated_at = NOW()';
        $vals[] = $id;
        return $db->prepare("UPDATE multitudes SET " . implode(', ', $upd) . " WHERE id = ?")
                  ->execute($vals);
    }

    public static function activate(int $id): bool
    {
        return Database::getInstance()->getConnection()
            ->prepare("UPDATE multitudes SET activo = 1, updated_at = NOW() WHERE id = ?")
            ->execute([$id]);
    }

    public static function deactivate(int $id): bool
    {
        return Database::getInstance()->getConnection()
            ->prepare("UPDATE multitudes SET activo = 0, updated_at = NOW() WHERE id = ?")
            ->execute([$id]);
    }

    public static function delete(int $id): bool
    {
        return Database::getInstance()->getConnection()
            ->prepare("DELETE FROM multitudes WHERE id = ?")
            ->execute([$id]);
    }

    // ── Items ──────────────────────────────────────────────────────────────────

    public static function getItems(int $multitud_id): array
    {
        $db = Database::getInstance()->getConnection();
        $s  = $db->prepare(
            "SELECT * FROM multitud_items
             WHERE multitud_id = ? AND activo = 1
             ORDER BY orden ASC, fecha_periodo ASC, id ASC"
        );
        $s->execute([$multitud_id]);
        return $s->fetchAll(PDO::FETCH_ASSOC);
    }

    public static function getAllItems(int $multitud_id): array
    {
        $db = Database::getInstance()->getConnection();
        $s  = $db->prepare(
            "SELECT * FROM multitud_items
             WHERE multitud_id = ?
             ORDER BY orden ASC, fecha_periodo ASC, id ASC"
        );
        $s->execute([$multitud_id]);
        return $s->fetchAll(PDO::FETCH_ASSOC);
    }

    public static function getItemById(int $id): ?array
    {
        $db = Database::getInstance()->getConnection();
        $s  = $db->prepare("SELECT * FROM multitud_items WHERE id = ?");
        $s->execute([$id]);
        $row = $s->fetch(PDO::FETCH_ASSOC);
        return $row ?: null;
    }

    public static function createItem(array $data): int|false
    {
        $db = Database::getInstance()->getConnection();
        $s  = $db->prepare(
            "INSERT INTO multitud_items
                (multitud_id, titulo, descripcion_corta, stream_url,
                 grupo_artista, fecha_periodo, orden, activo, created_at)
             VALUES (?, ?, ?, ?, ?, ?, ?, ?, NOW())"
        );
        $ok = $s->execute([
            (int)$data['multitud_id'],
            $data['titulo'],
            $data['descripcion_corta'] ?? null,
            $data['stream_url'],
            $data['grupo_artista'] ?? null,
            (!empty($data['fecha_periodo'])) ? $data['fecha_periodo'] : null,
            isset($data['orden']) ? (int)$data['orden'] : 0,
            isset($data['activo']) ? (int)(bool)$data['activo'] : 1,
        ]);
        return $ok ? (int)$db->lastInsertId() : false;
    }

    public static function updateItem(int $id, array $data): bool
    {
        $db   = Database::getInstance()->getConnection();
        $upd  = []; $vals = [];
        foreach (['titulo', 'descripcion_corta', 'stream_url', 'grupo_artista'] as $col) {
            if (array_key_exists($col, $data)) {
                $upd[]  = "$col = ?";
                $vals[] = ($data[$col] === '') ? null : $data[$col];
            }
        }
        if (array_key_exists('fecha_periodo', $data)) {
            $upd[]  = 'fecha_periodo = ?';
            $vals[] = (!empty($data['fecha_periodo'])) ? $data['fecha_periodo'] : null;
        }
        if (array_key_exists('orden', $data)) {
            $upd[]  = 'orden = ?';
            $vals[] = (int)$data['orden'];
        }
        if (isset($data['activo'])) {
            $upd[]  = 'activo = ?';
            $vals[] = (int)(bool)$data['activo'];
        }
        if (empty($upd)) return false;
        $vals[] = $id;
        return $db->prepare("UPDATE multitud_items SET " . implode(', ', $upd) . " WHERE id = ?")
                  ->execute($vals);
    }

    public static function deleteItem(int $id): bool
    {
        return Database::getInstance()->getConnection()
            ->prepare("DELETE FROM multitud_items WHERE id = ?")
            ->execute([$id]);
    }
}

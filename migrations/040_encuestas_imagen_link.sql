-- ============================================================
-- MIGRACIÓN 040: Encuestas — imagen de popup y columna link
-- Ejecutar UNA SOLA VEZ
-- ============================================================

-- Imagen ilustrativa para el popup del mapa
ALTER TABLE encuestas
    ADD COLUMN IF NOT EXISTS imagen VARCHAR(255) NULL
    COMMENT 'Nombre de archivo de la imagen ilustrativa del popup';

-- link ya existe desde migración 020/023 — solo asegurar que esté
ALTER TABLE encuestas
    MODIFY COLUMN IF EXISTS link VARCHAR(500) NULL
    COMMENT 'URL externa (redirige al hacer clic en Responder en lugar de abrir el modal)';

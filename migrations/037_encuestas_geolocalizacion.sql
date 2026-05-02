-- ============================================================
-- MIGRACIÓN 037: Encuestas — Geolocalización y campos faltantes
-- Ejecutar UNA SOLA VEZ en la base de datos
-- Todas las sentencias son idempotentes (IF NOT EXISTS)
--
-- PROBLEMA: La tabla `encuestas` fue creada originalmente solo con
-- (id, titulo, descripcion, activa, user_id, created_at, updated_at).
-- Todo el código del modelo, la API y el admin espera los campos
-- lat, lng, link, fecha_expiracion, fecha_creacion y `activo`
-- (nombre diferente a la columna `activa` del schema original).
-- Sin estos campos las encuestas no se muestran en el mapa porque
-- mostrarMarcadoresEncuestas() filtra: if (!enc.lat || !enc.lng) return;
-- ============================================================

-- ─────────────────────────────────────────────────────────────
-- 1. Geolocalización — lat / lng para el pin en el mapa
-- ─────────────────────────────────────────────────────────────
ALTER TABLE encuestas
    ADD COLUMN IF NOT EXISTS lat  DECIMAL(10,6) NULL COMMENT 'Latitud del pin en el mapa',
    ADD COLUMN IF NOT EXISTS lng  DECIMAL(10,6) NULL COMMENT 'Longitud del pin en el mapa';

-- Índice espacial para la consulta Haversine (nearby)
ALTER TABLE encuestas
    ADD INDEX IF NOT EXISTS idx_enc_coords (lat, lng);

-- ─────────────────────────────────────────────────────────────
-- 2. Campo activo (el código usa `activo`, la tabla tenía `activa`)
-- ─────────────────────────────────────────────────────────────
ALTER TABLE encuestas
    ADD COLUMN IF NOT EXISTS activo TINYINT(1) NOT NULL DEFAULT 1
        COMMENT '1 = encuesta visible y activa; 0 = oculta';

-- ─────────────────────────────────────────────────────────────
-- 3. Fecha de creación y de expiración
-- ─────────────────────────────────────────────────────────────
ALTER TABLE encuestas
    ADD COLUMN IF NOT EXISTS fecha_creacion   DATETIME NULL DEFAULT NULL
        COMMENT 'Fecha de publicación de la encuesta',
    ADD COLUMN IF NOT EXISTS fecha_expiracion DATE     NULL DEFAULT NULL
        COMMENT 'Fecha de vencimiento; NULL = sin vencimiento';

-- Poblar fecha_creacion con created_at en registros existentes
UPDATE encuestas
SET fecha_creacion = created_at
WHERE fecha_creacion IS NULL AND created_at IS NOT NULL;

-- ─────────────────────────────────────────────────────────────
-- 4. Link externo (para render_mode = 'link')
-- ─────────────────────────────────────────────────────────────
ALTER TABLE encuestas
    ADD COLUMN IF NOT EXISTS link VARCHAR(500) NULL
        COMMENT 'URL externa de la encuesta (activa render_mode link)';

-- ─────────────────────────────────────────────────────────────
-- FIN DE MIGRACIÓN 037
-- ─────────────────────────────────────────────────────────────

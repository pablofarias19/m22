-- ============================================================
-- MIGRACIÓN 039: Eventos, Noticias y Encuestas — Nuevos campos
-- Ejecutar UNA SOLA VEZ en la base de datos
-- Todas las sentencias son idempotentes (IF NOT EXISTS)
-- ============================================================

-- ─────────────────────────────────────────────────────────────
-- 1. EVENTOS — link externo e ícono personalizado
-- ─────────────────────────────────────────────────────────────
ALTER TABLE eventos
    ADD COLUMN IF NOT EXISTS link  VARCHAR(500) NULL
        COMMENT 'URL externa del evento (sitio web, compra de entradas, etc.)',
    ADD COLUMN IF NOT EXISTS icono VARCHAR(20)  NULL
        COMMENT 'Emoji o símbolo para el pin en el mapa (ej: 🎵 🏟️ 🎭)';

-- ─────────────────────────────────────────────────────────────
-- 2. NOTICIAS — link de YouTube para video de la noticia
-- ─────────────────────────────────────────────────────────────
ALTER TABLE noticias
    ADD COLUMN IF NOT EXISTS youtube_link VARCHAR(500) NULL
        COMMENT 'URL de YouTube para video vinculado a la noticia';

-- ─────────────────────────────────────────────────────────────
-- 3. ENCUESTAS — link de YouTube para video explicativo
-- ─────────────────────────────────────────────────────────────
ALTER TABLE encuestas
    ADD COLUMN IF NOT EXISTS youtube_link VARCHAR(500) NULL
        COMMENT 'URL de YouTube para video explicativo de la encuesta';

-- ─────────────────────────────────────────────────────────────
-- FIN DE MIGRACIÓN 039
-- ─────────────────────────────────────────────────────────────

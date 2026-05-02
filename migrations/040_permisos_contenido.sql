-- ============================================================
-- MIGRACIÓN 040: Permisos de contenido — Noticias y Eventos
-- Extiende el sistema de permisos de encuestas a noticias y eventos.
-- El Admin siempre conserva sus permisos; estos controles
-- solo afectan a negocios, industrias y otras entidades.
-- Ejecutar UNA SOLA VEZ en la base de datos
-- Todas las sentencias son idempotentes (IF NOT EXISTS)
-- ============================================================

-- ─────────────────────────────────────────────────────────────
-- 1. INDUSTRIES — permisos de publicación por industria
-- ─────────────────────────────────────────────────────────────
ALTER TABLE industries
    ADD COLUMN IF NOT EXISTS noticias_permitidas TINYINT(1) NOT NULL DEFAULT 0
        COMMENT '1 = la industria puede publicar noticias; 0 = no puede',
    ADD COLUMN IF NOT EXISTS eventos_permitidos  TINYINT(1) NOT NULL DEFAULT 0
        COMMENT '1 = la industria puede publicar eventos; 0 = no puede';

-- ─────────────────────────────────────────────────────────────
-- 2. BUSINESSES — overrides de permisos por negocio individual
-- ─────────────────────────────────────────────────────────────
ALTER TABLE businesses
    ADD COLUMN IF NOT EXISTS noticias_override ENUM('heredar','habilitada','deshabilitada') NOT NULL DEFAULT 'heredar'
        COMMENT 'Override de permiso de noticias: heredar de industria, o forzar habilitada/deshabilitada',
    ADD COLUMN IF NOT EXISTS eventos_override  ENUM('heredar','habilitada','deshabilitada') NOT NULL DEFAULT 'heredar'
        COMMENT 'Override de permiso de eventos: heredar de industria, o forzar habilitada/deshabilitada';

-- ─────────────────────────────────────────────────────────────
-- FIN DE MIGRACIÓN 040
-- ─────────────────────────────────────────────────────────────

-- ============================================================
-- MIGRACIÓN 038: Encuestas — Mejoras profesionales
-- Ejecutar UNA SOLA VEZ en la base de datos
-- Todas las sentencias son idempotentes
-- ============================================================

-- ─────────────────────────────────────────────────────────────
-- 1. Ampliar ENUM de tipo en preguntas_encuesta (agregar escala_10)
-- ─────────────────────────────────────────────────────────────
ALTER TABLE preguntas_encuesta
    MODIFY COLUMN tipo ENUM('opcion_multiple','si_no','escala','escala_10','texto')
    NOT NULL DEFAULT 'opcion_multiple';

-- ─────────────────────────────────────────────────────────────
-- 2. Campo "requerida" por pregunta
-- ─────────────────────────────────────────────────────────────
ALTER TABLE preguntas_encuesta
    ADD COLUMN IF NOT EXISTS requerida TINYINT(1) NOT NULL DEFAULT 0
    COMMENT '1 = respuesta obligatoria para enviar el formulario';

-- ─────────────────────────────────────────────────────────────
-- 3. UNIQUE KEY en participaciones para INSERT IGNORE
-- ─────────────────────────────────────────────────────────────
ALTER TABLE encuesta_participaciones
    ADD UNIQUE KEY IF NOT EXISTS uq_participacion (encuesta_id, user_id);

-- ─────────────────────────────────────────────────────────────
-- FIN DE MIGRACIÓN 038
-- ─────────────────────────────────────────────────────────────

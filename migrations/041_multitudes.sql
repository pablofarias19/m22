-- ============================================================
-- MIGRACIÓN 041: Entidad MULTITUDES
-- Agrupa múltiples links/transmisiones bajo un único pin geográfico,
-- cada uno con título, descripción corta, grupo/artista y fecha de período.
-- Ejecutar UNA SOLA VEZ en la base de datos.
-- ============================================================

CREATE TABLE IF NOT EXISTS `multitudes` (
  `id`          INT(11)       NOT NULL AUTO_INCREMENT,
  `nombre`      VARCHAR(255)  NOT NULL             COMMENT 'Nombre del punto MULTITUDES (ej: Estadio de Boca, Festival de Viña)',
  `descripcion` TEXT          DEFAULT NULL         COMMENT 'Descripción general del punto',
  `lat`         DECIMAL(10,8) DEFAULT NULL,
  `lng`         DECIMAL(11,8) DEFAULT NULL,
  `activo`      TINYINT(1)    NOT NULL DEFAULT 1,
  `created_at`  TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at`  TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_multitudes_activo` (`activo`),
  KEY `idx_multitudes_coords` (`lat`, `lng`)
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci
  COMMENT='Puntos MULTITUDES: agrupan múltiples transmisiones/links por período y grupo/artista';

CREATE TABLE IF NOT EXISTS `multitud_items` (
  `id`               INT(11)       NOT NULL AUTO_INCREMENT,
  `multitud_id`      INT(11)       NOT NULL,
  `titulo`           VARCHAR(255)  NOT NULL             COMMENT 'Título del ítem (ej: Boca 3 - River 1 | Copa 2024)',
  `descripcion_corta`VARCHAR(255)  DEFAULT NULL         COMMENT 'Línea de texto breve (ej: Goles: Cavani x2, Borja)',
  `stream_url`       VARCHAR(500)  NOT NULL             COMMENT 'URL del stream o video',
  `grupo_artista`    VARCHAR(255)  DEFAULT NULL         COMMENT 'Grupo, artista o participante (ej: Soda Stereo, Boca Juniors)',
  `fecha_periodo`    DATE          DEFAULT NULL         COMMENT 'Fecha del período (ej: 2024-11-10)',
  `orden`            INT(11)       NOT NULL DEFAULT 0   COMMENT 'Orden de visualización manual',
  `activo`           TINYINT(1)    NOT NULL DEFAULT 1,
  `created_at`       TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_mi_multitud`      (`multitud_id`),
  KEY `idx_mi_activo`        (`activo`),
  KEY `idx_mi_fecha`         (`fecha_periodo`),
  KEY `idx_mi_grupo`         (`grupo_artista`(80)),
  CONSTRAINT `fk_mi_multitud` FOREIGN KEY (`multitud_id`) REFERENCES `multitudes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci
  COMMENT='Ítems de un punto MULTITUDES: un link con título, descripción, grupo/artista y fecha';

-- ─────────────────────────────────────────────────────────────
-- FIN DE MIGRACIÓN 041
-- ─────────────────────────────────────────────────────────────

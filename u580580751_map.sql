-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 02-05-2026 a las 16:03:56
-- Versión del servidor: 11.8.6-MariaDB-log
-- Versión de PHP: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `u580580751_map`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `agencies`
--

CREATE TABLE `agencies` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `area` varchar(150) NOT NULL COMMENT 'Area: turismo, comercio exterior, etc.',
  `description` text DEFAULT NULL,
  `website` varchar(500) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(60) DEFAULT NULL,
  `status` enum('activa','inactiva') NOT NULL DEFAULT 'activa',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `agencies`
--

INSERT INTO `agencies` (`id`, `name`, `area`, `description`, `website`, `email`, `phone`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Agencia de Turismo Nacional', 'turismo', 'Agencia gubernamental de promocion turistica.', NULL, NULL, NULL, 'activa', '2026-04-26 19:06:50', NULL),
(2, 'Agencia de Comercio Exterior', 'comercio_exterior', 'Agencia de promocion de exportaciones e inversiones.', NULL, NULL, NULL, 'activa', '2026-04-26 19:06:50', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `agency_sector`
--

CREATE TABLE `agency_sector` (
  `agency_id` int(10) UNSIGNED NOT NULL,
  `sector_type` enum('industrial','commercial') NOT NULL,
  `sector_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `agency_sector`
--

INSERT INTO `agency_sector` (`agency_id`, `sector_type`, `sector_id`) VALUES
(2, 'commercial', 1),
(2, 'commercial', 2),
(1, 'commercial', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `analisis_marcario`
--

CREATE TABLE `analisis_marcario` (
  `id` int(11) NOT NULL,
  `marca_id` int(11) NOT NULL,
  `distintividad` enum('ALTA','MEDIA','BAJA') DEFAULT NULL,
  `riesgo_confusion` text DEFAULT NULL,
  `conflictos_clases` text DEFAULT NULL,
  `nivel_proteccion` varchar(255) DEFAULT NULL,
  `expansion_internacional` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `analytics_events`
--

CREATE TABLE `analytics_events` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `event_type` varchar(60) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `visitor_id` varchar(64) DEFAULT NULL COMMENT 'Cookie anónimo para visitantes no logueados',
  `business_id` int(11) DEFAULT NULL,
  `meta_json` text DEFAULT NULL COMMENT 'Detalles adicionales: query, filtro, etc.',
  `ip` varchar(45) DEFAULT NULL,
  `user_agent` varchar(512) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `analytics_events`
--

INSERT INTO `analytics_events` (`id`, `created_at`, `event_type`, `user_id`, `visitor_id`, `business_id`, `meta_json`, `ip`, `user_agent`) VALUES
(1, '2026-04-26 01:57:29', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(2, '2026-04-26 01:59:53', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(3, '2026-04-26 02:00:23', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 4, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(4, '2026-04-26 02:02:53', 'map_open', NULL, '1a23bdce895e0a59983e0b216a906b1d', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(5, '2026-04-26 02:04:10', 'business_open', NULL, '1a23bdce895e0a59983e0b216a906b1d', 4, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(6, '2026-04-26 15:01:38', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(7, '2026-04-26 15:01:46', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9152, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(8, '2026-04-26 15:04:29', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(9, '2026-04-26 15:04:31', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9152, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(10, '2026-04-26 15:11:02', 'website_click', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9152, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(11, '2026-04-26 15:11:16', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9151, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(12, '2026-04-26 15:28:23', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(13, '2026-04-26 15:28:37', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9151, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(14, '2026-04-26 15:41:33', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(15, '2026-04-26 15:55:56', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 1, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(16, '2026-04-26 16:01:12', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(17, '2026-04-26 16:01:18', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 6, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(18, '2026-04-26 16:05:58', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(19, '2026-04-26 16:06:04', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 6, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(20, '2026-04-26 16:06:22', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 6, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(21, '2026-04-26 16:22:05', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(22, '2026-04-26 16:22:09', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9152, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(23, '2026-04-26 16:22:19', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(24, '2026-04-26 16:41:08', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(25, '2026-04-26 17:23:44', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(26, '2026-04-26 17:28:04', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(27, '2026-04-26 17:28:19', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(28, '2026-04-26 17:28:30', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(29, '2026-04-26 17:30:37', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(30, '2026-04-26 17:32:41', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 6, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(31, '2026-04-26 18:11:24', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(32, '2026-04-26 19:51:33', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(33, '2026-04-26 19:51:44', 'brand_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 5, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(34, '2026-04-26 19:52:24', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(35, '2026-04-26 19:54:35', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(36, '2026-04-26 19:55:55', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(37, '2026-04-26 20:12:06', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(38, '2026-04-26 20:13:49', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(39, '2026-04-26 20:14:00', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(40, '2026-04-26 20:14:16', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(41, '2026-04-26 20:15:20', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 4, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(42, '2026-04-26 20:23:26', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(43, '2026-04-26 20:28:15', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(44, '2026-04-26 20:31:29', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(45, '2026-04-26 20:32:03', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(46, '2026-04-26 20:33:38', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(47, '2026-04-26 20:33:48', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(48, '2026-04-26 20:34:00', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(49, '2026-04-26 20:34:05', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(50, '2026-04-26 20:34:15', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(51, '2026-04-26 20:40:42', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(52, '2026-04-26 20:42:18', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(53, '2026-04-26 21:40:03', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(54, '2026-04-26 21:44:00', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(55, '2026-04-26 21:48:14', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(56, '2026-04-26 21:48:18', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(57, '2026-04-26 21:54:07', 'map_open', NULL, '66a3841edb47c096458508bcceb1a5c5', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 13; SM-A226BR Build/TP1A.220624.014; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/147.0.7727.55 Mobile Safari/537.36'),
(58, '2026-04-26 21:54:47', 'map_open', NULL, '66a3841edb47c096458508bcceb1a5c5', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 13; SM-A226BR Build/TP1A.220624.014; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/147.0.7727.55 Mobile Safari/537.36'),
(59, '2026-04-26 21:55:02', 'map_open', NULL, '66a3841edb47c096458508bcceb1a5c5', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 13; SM-A226BR Build/TP1A.220624.014; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/147.0.7727.55 Mobile Safari/537.36'),
(60, '2026-04-26 21:55:28', 'business_open', NULL, '66a3841edb47c096458508bcceb1a5c5', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 13; SM-A226BR Build/TP1A.220624.014; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/147.0.7727.55 Mobile Safari/537.36'),
(61, '2026-04-26 21:55:33', 'business_open', NULL, '66a3841edb47c096458508bcceb1a5c5', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 13; SM-A226BR Build/TP1A.220624.014; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/147.0.7727.55 Mobile Safari/537.36'),
(62, '2026-04-26 21:55:41', 'business_open', NULL, '66a3841edb47c096458508bcceb1a5c5', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 13; SM-A226BR Build/TP1A.220624.014; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/147.0.7727.55 Mobile Safari/537.36'),
(63, '2026-04-26 21:55:53', 'business_open', NULL, '66a3841edb47c096458508bcceb1a5c5', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 13; SM-A226BR Build/TP1A.220624.014; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/147.0.7727.55 Mobile Safari/537.36'),
(64, '2026-04-26 21:55:59', 'business_open', NULL, '66a3841edb47c096458508bcceb1a5c5', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 13; SM-A226BR Build/TP1A.220624.014; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/147.0.7727.55 Mobile Safari/537.36'),
(65, '2026-04-26 21:59:15', 'map_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(66, '2026-04-26 21:59:29', 'business_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(67, '2026-04-26 21:59:37', 'business_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(68, '2026-04-26 22:49:43', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(69, '2026-04-26 22:59:19', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(70, '2026-04-26 22:59:42', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(71, '2026-04-26 22:59:45', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(72, '2026-04-26 22:59:52', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(73, '2026-04-26 22:59:54', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(74, '2026-04-26 23:00:57', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(75, '2026-04-26 23:01:17', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(76, '2026-04-26 23:01:33', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(77, '2026-04-26 23:01:48', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(78, '2026-04-26 23:01:55', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(79, '2026-04-26 23:01:58', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(80, '2026-04-26 23:02:05', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(81, '2026-04-26 23:34:18', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(82, '2026-04-26 23:34:31', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(83, '2026-04-26 23:36:16', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(84, '2026-04-26 23:36:21', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(85, '2026-04-26 23:36:25', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(86, '2026-04-26 23:36:35', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(87, '2026-04-26 23:38:55', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(88, '2026-04-26 23:41:21', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(89, '2026-04-26 23:44:37', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(90, '2026-04-26 23:44:43', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(91, '2026-04-26 23:44:47', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(92, '2026-04-26 23:44:50', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(93, '2026-04-26 23:44:54', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(94, '2026-04-26 23:45:01', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(95, '2026-04-26 23:45:03', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(96, '2026-04-26 23:45:37', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(97, '2026-04-26 23:45:48', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(98, '2026-04-26 23:49:35', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(99, '2026-04-26 23:55:27', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(100, '2026-04-27 01:04:52', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(101, '2026-04-27 01:05:03', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(102, '2026-04-27 01:05:08', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(103, '2026-04-27 01:05:38', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(104, '2026-04-27 01:08:13', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(105, '2026-04-27 01:08:22', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(106, '2026-04-27 01:08:26', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(107, '2026-04-27 01:08:33', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(108, '2026-04-27 01:11:22', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(109, '2026-04-27 01:11:31', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(110, '2026-04-27 01:38:22', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(111, '2026-04-27 01:38:41', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(112, '2026-04-27 01:38:59', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(113, '2026-04-27 01:39:06', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(114, '2026-04-27 01:39:22', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(115, '2026-04-27 01:39:25', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(116, '2026-04-27 01:41:18', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(117, '2026-04-27 01:41:29', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(118, '2026-04-27 01:44:11', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(119, '2026-04-27 01:46:04', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(120, '2026-04-27 01:47:44', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(121, '2026-04-27 01:47:52', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(122, '2026-04-27 01:47:56', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(123, '2026-04-27 01:59:51', 'map_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(124, '2026-04-27 02:00:50', 'map_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(125, '2026-04-27 02:01:39', 'business_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(126, '2026-04-27 02:01:45', 'business_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(127, '2026-04-27 02:01:54', 'business_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(128, '2026-04-27 02:02:12', 'map_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(129, '2026-04-27 02:02:17', 'map_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(130, '2026-04-27 02:02:34', 'business_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(131, '2026-04-27 02:02:40', 'business_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(132, '2026-04-27 02:03:00', 'map_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(133, '2026-04-27 02:03:10', 'map_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(134, '2026-04-27 02:03:15', 'business_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', 1, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(135, '2026-04-27 02:03:20', 'business_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', 1, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(136, '2026-04-27 02:03:21', 'business_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', 1, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(137, '2026-04-27 02:15:59', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(138, '2026-04-27 02:16:06', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(139, '2026-04-27 02:16:16', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(140, '2026-04-27 02:20:17', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(141, '2026-04-27 02:20:24', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(142, '2026-04-27 02:21:16', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(143, '2026-04-27 02:21:39', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(144, '2026-04-27 02:22:15', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 1, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(145, '2026-04-27 02:22:37', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(146, '2026-04-27 02:22:43', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(147, '2026-04-27 02:23:08', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(148, '2026-04-27 02:23:17', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(149, '2026-04-27 02:24:56', 'map_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(150, '2026-04-27 02:25:20', 'business_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(151, '2026-04-27 02:25:26', 'business_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(152, '2026-04-27 02:25:32', 'business_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(153, '2026-04-27 02:25:38', 'business_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(154, '2026-04-27 02:25:41', 'business_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(155, '2026-04-27 02:26:04', 'business_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(156, '2026-04-27 03:38:03', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(157, '2026-04-27 03:38:24', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(158, '2026-04-27 03:42:53', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(159, '2026-04-27 03:43:09', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(160, '2026-04-27 03:44:40', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(161, '2026-04-27 03:47:29', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(162, '2026-04-27 03:51:36', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(163, '2026-04-27 03:51:37', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(164, '2026-04-27 03:52:22', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(165, '2026-04-27 03:52:28', 'directions_click', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(166, '2026-04-27 03:52:41', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(167, '2026-04-27 04:02:58', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(168, '2026-04-27 04:11:53', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(169, '2026-04-27 04:12:04', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 1, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(170, '2026-04-27 04:12:14', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(171, '2026-04-27 04:12:24', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(172, '2026-04-27 04:12:45', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(173, '2026-04-27 04:12:51', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(174, '2026-04-27 04:13:18', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(175, '2026-04-27 04:13:24', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(176, '2026-04-27 04:14:38', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(177, '2026-04-27 04:37:52', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(178, '2026-04-27 04:38:09', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(179, '2026-04-27 04:38:14', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(180, '2026-04-27 04:38:35', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(181, '2026-04-27 04:38:39', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(182, '2026-04-27 04:39:47', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(183, '2026-04-27 04:39:55', 'search', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, '{\"q\":\"maria celeste ortiz\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(184, '2026-04-27 04:39:57', 'search', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, '{\"q\":\"ma\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(185, '2026-04-27 04:39:59', 'search', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, '{\"q\":\"INMOBI\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(186, '2026-04-27 04:40:02', 'search', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, '{\"q\":\"IN\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(187, '2026-04-27 04:40:04', 'search', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, '{\"q\":\"MARIA\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(188, '2026-04-27 04:40:37', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(189, '2026-04-27 04:40:41', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(190, '2026-04-27 04:41:42', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(191, '2026-04-27 04:41:53', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(192, '2026-04-27 04:57:38', 'map_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(193, '2026-04-27 04:58:05', 'business_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(194, '2026-04-27 04:58:09', 'business_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(195, '2026-04-27 04:58:13', 'business_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(196, '2026-04-27 04:58:18', 'business_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(197, '2026-04-27 04:59:45', 'map_open', NULL, '66a3841edb47c096458508bcceb1a5c5', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 13; SM-A226BR Build/TP1A.220624.014; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/147.0.7727.55 Mobile Safari/537.36'),
(198, '2026-04-27 05:00:02', 'map_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(199, '2026-04-27 05:00:11', 'business_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(200, '2026-04-27 05:00:22', 'business_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(201, '2026-04-27 05:00:29', 'business_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(202, '2026-04-27 05:00:49', 'map_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(203, '2026-04-27 05:00:58', 'business_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(204, '2026-04-27 05:01:32', 'map_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(205, '2026-04-27 05:01:57', 'search', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', NULL, '{\"q\":\"Paris\"}', '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(206, '2026-04-27 05:02:10', 'search', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', NULL, '{\"q\":\"Pa\"}', '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(207, '2026-04-27 05:02:20', 'filter_change', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', NULL, '{\"tipo\":\"inmobiliaria\",\"q\":\"\"}', '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(208, '2026-04-27 05:02:55', 'filter_change', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', NULL, '{\"tipo\":\"contador\",\"q\":\"\"}', '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(209, '2026-04-27 05:03:01', 'filter_change', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', NULL, '{\"tipo\":\"gas_en_garrafa\",\"q\":\"\"}', '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(210, '2026-04-27 05:03:10', 'filter_change', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', NULL, '{\"tipo\":\"\",\"q\":\"\"}', '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(211, '2026-04-27 05:03:14', 'business_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(212, '2026-04-27 05:03:16', 'business_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(213, '2026-04-27 05:03:22', 'filter_change', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', NULL, '{\"tipo\":\"bar\",\"q\":\"\"}', '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(214, '2026-04-27 05:04:47', 'map_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36');
INSERT INTO `analytics_events` (`id`, `created_at`, `event_type`, `user_id`, `visitor_id`, `business_id`, `meta_json`, `ip`, `user_agent`) VALUES
(215, '2026-04-27 05:05:36', 'search', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', NULL, '{\"q\":\"Ortiz\"}', '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(216, '2026-04-27 05:06:02', 'search', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', NULL, '{\"q\":\"Or\"}', '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(217, '2026-04-27 05:07:42', 'map_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(218, '2026-04-27 05:07:45', 'map_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(219, '2026-04-27 12:55:38', 'map_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(220, '2026-04-27 12:55:45', 'map_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(221, '2026-04-27 12:56:18', 'map_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(222, '2026-04-27 12:56:37', 'map_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(223, '2026-04-27 13:07:21', 'business_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', 1, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(224, '2026-04-27 13:07:32', 'business_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(225, '2026-04-27 13:07:36', 'business_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(226, '2026-04-27 13:07:45', 'business_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(227, '2026-04-27 13:11:23', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(228, '2026-04-27 13:11:28', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(229, '2026-04-27 13:12:17', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(230, '2026-04-27 13:12:27', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(231, '2026-04-27 13:12:30', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(232, '2026-04-27 13:12:45', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(233, '2026-04-27 13:12:49', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(234, '2026-04-27 13:12:52', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(235, '2026-04-27 13:26:58', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(236, '2026-04-27 13:27:01', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(237, '2026-04-27 13:53:44', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(238, '2026-04-27 13:58:36', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(239, '2026-04-27 13:58:39', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(240, '2026-04-27 14:03:37', 'map_open', NULL, '18ec00c2934a5228e7866b4a09477416', NULL, NULL, '2800:2505:42:68c8:18a8:4dbe:a0f5:f16d', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(241, '2026-04-27 14:04:13', 'business_open', NULL, '18ec00c2934a5228e7866b4a09477416', 9153, NULL, '2800:2505:42:68c8:18a8:4dbe:a0f5:f16d', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(242, '2026-04-27 14:04:30', 'business_open', NULL, '18ec00c2934a5228e7866b4a09477416', NULL, NULL, '2800:2505:42:68c8:18a8:4dbe:a0f5:f16d', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(243, '2026-04-27 14:07:17', 'search', NULL, '18ec00c2934a5228e7866b4a09477416', NULL, '{\"q\":\"Inmo\"}', '2800:2505:42:68c8:18a8:4dbe:a0f5:f16d', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(244, '2026-04-27 14:07:18', 'search', NULL, '18ec00c2934a5228e7866b4a09477416', NULL, '{\"q\":\"Inmob\"}', '2800:2505:42:68c8:18a8:4dbe:a0f5:f16d', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(245, '2026-04-27 14:07:19', 'search', NULL, '18ec00c2934a5228e7866b4a09477416', NULL, '{\"q\":\"Inmobiliaria\"}', '2800:2505:42:68c8:18a8:4dbe:a0f5:f16d', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(246, '2026-04-27 14:07:43', 'filter_change', NULL, '18ec00c2934a5228e7866b4a09477416', NULL, '{\"tipo\":\"supermercado\",\"q\":\"Inmobiliaria \"}', '2800:2505:42:68c8:18a8:4dbe:a0f5:f16d', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(247, '2026-04-27 14:07:59', 'search', NULL, '18ec00c2934a5228e7866b4a09477416', NULL, '{\"q\":\"Inm\"}', '2800:2505:42:68c8:18a8:4dbe:a0f5:f16d', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(248, '2026-04-27 14:08:02', 'filter_change', NULL, '18ec00c2934a5228e7866b4a09477416', NULL, '{\"tipo\":\"\",\"q\":\"\"}', '2800:2505:42:68c8:18a8:4dbe:a0f5:f16d', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(249, '2026-04-27 17:18:06', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(250, '2026-04-27 17:18:13', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(251, '2026-04-27 17:18:29', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(252, '2026-04-27 17:18:36', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(253, '2026-04-27 17:18:42', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(254, '2026-04-27 17:19:41', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(255, '2026-04-27 17:19:54', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(256, '2026-04-27 17:19:58', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(257, '2026-04-27 17:22:30', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(258, '2026-04-27 17:22:43', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(259, '2026-04-27 17:23:48', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(260, '2026-04-27 17:23:51', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(261, '2026-04-27 17:50:46', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(262, '2026-04-27 17:50:52', 'search', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, '{\"q\":\"maria\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(263, '2026-04-27 17:50:54', 'search', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, '{\"q\":\"ma\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(264, '2026-04-27 17:50:56', 'search', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, '{\"q\":\"MARIA\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(265, '2026-04-27 17:51:00', 'search', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, '{\"q\":\"MARIA CELESTE ORTIZ\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(266, '2026-04-27 17:51:02', 'search', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, '{\"q\":\"MA\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(267, '2026-04-27 17:51:18', 'filter_change', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, '{\"tipo\":\"cafeteria\",\"q\":\"\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(268, '2026-04-27 17:51:20', 'search', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, '{\"q\":\"KJ\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(269, '2026-04-27 17:51:23', 'filter_change', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, '{\"tipo\":\"\",\"q\":\"\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(270, '2026-04-27 17:51:36', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(271, '2026-04-27 17:51:39', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(272, '2026-04-27 17:51:46', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(273, '2026-04-27 17:51:55', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(274, '2026-04-27 17:51:59', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(275, '2026-04-27 17:52:14', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(276, '2026-04-27 17:52:17', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(277, '2026-04-27 17:52:48', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(278, '2026-04-27 17:53:24', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(279, '2026-04-27 17:53:41', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(280, '2026-04-27 17:56:13', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(281, '2026-04-27 18:34:03', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(282, '2026-04-27 18:34:07', 'search', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, '{\"q\":\"MAR\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(283, '2026-04-27 18:34:11', 'search', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, '{\"q\":\"MARIA CELESTE ORTIZ\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(284, '2026-04-27 18:34:23', 'search', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, '{\"q\":\"MA\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(285, '2026-04-27 18:34:27', 'brand_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 5, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(286, '2026-04-27 18:34:49', 'search', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, '{\"q\":\"ADI\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(287, '2026-04-27 18:34:52', 'search', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, '{\"q\":\"AD\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(288, '2026-04-27 18:34:54', 'search', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, '{\"q\":\"MAR\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(289, '2026-04-27 18:34:56', 'search', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, '{\"q\":\"MA\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(290, '2026-04-27 18:35:00', 'search', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, '{\"q\":\"MAR\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(291, '2026-04-27 18:35:01', 'search', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, '{\"q\":\"IN\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(292, '2026-04-27 18:35:05', 'search', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, '{\"q\":\"MA\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(293, '2026-04-27 18:35:14', 'search', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, '{\"q\":\"AD\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(294, '2026-04-27 18:35:15', 'search', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, '{\"q\":\"MARIA\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(295, '2026-04-27 18:35:17', 'search', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, '{\"q\":\"MA\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(296, '2026-04-27 18:35:46', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 1, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(297, '2026-04-27 19:21:45', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(298, '2026-04-27 19:21:49', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(299, '2026-04-27 19:22:03', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(300, '2026-04-27 19:22:29', 'search', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, '{\"q\":\"adi\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(301, '2026-04-27 19:22:32', 'search', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, '{\"q\":\"ad\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(302, '2026-04-27 19:22:33', 'search', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, '{\"q\":\"mari\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(303, '2026-04-27 19:22:34', 'search', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, '{\"q\":\"maria\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(304, '2026-04-27 19:22:42', 'search', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, '{\"q\":\"ma\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(305, '2026-04-27 19:22:48', 'search', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, '{\"q\":\"maria\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(306, '2026-04-27 19:22:51', 'search', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, '{\"q\":\"ma\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(307, '2026-04-27 19:25:57', 'brand_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 5, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(308, '2026-04-27 19:51:06', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(309, '2026-04-27 19:51:12', 'brand_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 5, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(310, '2026-04-27 19:51:23', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(311, '2026-04-27 19:51:25', 'brand_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 5, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(312, '2026-04-27 20:21:50', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(313, '2026-04-27 20:21:52', 'brand_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 5, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(314, '2026-04-27 20:22:06', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(315, '2026-04-27 20:22:08', 'brand_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 5, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(316, '2026-04-27 20:25:05', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(317, '2026-04-27 20:27:37', 'brand_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 5, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(318, '2026-04-27 20:31:46', 'brand_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 5, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(319, '2026-04-27 20:32:37', 'search', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, '{\"q\":\"adi\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(320, '2026-04-27 20:32:55', 'search', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, '{\"q\":\"ad\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(321, '2026-04-27 20:33:42', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(322, '2026-04-27 20:33:46', 'brand_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 5, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(323, '2026-04-27 20:34:34', 'brand_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 5, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(324, '2026-04-27 20:34:38', 'brand_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 5, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(325, '2026-04-27 20:56:52', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(326, '2026-04-27 20:57:04', 'brand_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 5, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(327, '2026-04-27 20:57:15', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(328, '2026-04-27 20:57:16', 'brand_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 5, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(329, '2026-04-27 22:44:32', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(330, '2026-04-27 22:50:56', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(331, '2026-04-27 23:12:15', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(332, '2026-04-27 23:36:05', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(333, '2026-04-27 23:37:37', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(334, '2026-04-27 23:38:53', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(335, '2026-04-27 23:39:22', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(336, '2026-04-27 23:40:37', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(337, '2026-04-27 23:40:50', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(338, '2026-04-27 23:41:06', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(339, '2026-04-28 00:44:14', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(340, '2026-04-28 01:05:22', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(341, '2026-04-28 01:09:35', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(342, '2026-04-28 01:09:47', 'brand_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 6, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(343, '2026-04-28 01:10:03', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(344, '2026-04-28 01:10:18', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(345, '2026-04-28 01:11:24', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(346, '2026-04-28 01:11:38', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(347, '2026-04-28 01:30:02', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(348, '2026-04-28 01:30:07', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(349, '2026-04-28 01:30:27', 'brand_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 6, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(350, '2026-04-28 01:44:05', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(351, '2026-04-28 01:44:16', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(352, '2026-04-28 01:44:24', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(353, '2026-04-28 01:45:06', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(354, '2026-04-28 01:45:19', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(355, '2026-04-28 01:45:27', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(356, '2026-04-28 01:51:46', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(357, '2026-04-28 01:51:52', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(358, '2026-04-28 01:51:55', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(359, '2026-04-28 01:51:59', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(360, '2026-04-28 02:04:23', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(361, '2026-04-28 02:04:30', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9154, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(362, '2026-04-28 02:05:41', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(363, '2026-04-28 02:07:00', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(364, '2026-04-28 02:07:08', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9154, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(365, '2026-04-28 02:07:37', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(366, '2026-04-28 02:07:42', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9154, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(367, '2026-04-28 02:07:46', 'whatsapp_click', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9154, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(368, '2026-04-28 02:09:01', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(369, '2026-04-28 02:09:05', 'whatsapp_click', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(370, '2026-04-28 02:19:54', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(371, '2026-04-28 02:21:03', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(372, '2026-04-28 02:21:09', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(373, '2026-04-28 02:21:29', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(374, '2026-04-28 02:21:33', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(375, '2026-04-28 02:21:43', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(376, '2026-04-28 02:21:53', 'phone_click', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(377, '2026-04-28 02:21:58', 'email_click', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(378, '2026-04-28 02:21:59', 'email_click', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(379, '2026-04-28 02:22:01', 'whatsapp_click', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(380, '2026-04-28 02:22:19', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(381, '2026-04-28 02:26:09', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(382, '2026-04-28 02:26:14', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(383, '2026-04-28 02:26:41', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(384, '2026-04-28 02:26:55', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(385, '2026-04-28 02:27:02', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(386, '2026-04-28 02:29:24', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(387, '2026-04-28 02:29:26', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(388, '2026-04-28 02:29:35', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(389, '2026-04-28 02:29:48', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(390, '2026-04-28 02:34:00', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(391, '2026-04-28 02:34:09', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9154, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(392, '2026-04-28 02:34:16', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(393, '2026-04-28 02:34:31', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(394, '2026-04-28 02:34:54', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(395, '2026-04-28 02:37:59', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(396, '2026-04-28 02:38:12', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(397, '2026-04-28 02:38:21', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(398, '2026-04-28 02:38:24', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(399, '2026-04-28 02:40:17', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(400, '2026-04-28 02:40:23', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(401, '2026-04-28 02:40:26', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(402, '2026-04-28 02:41:55', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(403, '2026-04-28 02:42:03', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(404, '2026-04-28 02:42:07', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(405, '2026-04-28 02:42:11', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(406, '2026-04-28 02:43:08', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(407, '2026-04-28 02:43:14', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(408, '2026-04-28 02:43:16', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(409, '2026-04-28 02:43:27', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(410, '2026-04-28 02:43:34', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(411, '2026-04-28 02:43:38', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(412, '2026-04-28 02:43:48', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(413, '2026-04-28 02:43:58', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(414, '2026-04-28 02:44:01', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(415, '2026-04-28 02:46:05', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(416, '2026-04-28 02:46:12', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(417, '2026-04-28 02:46:16', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(418, '2026-04-28 02:46:19', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(419, '2026-04-28 02:46:32', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(420, '2026-04-28 02:46:38', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(421, '2026-04-28 02:46:40', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(422, '2026-04-28 02:47:59', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(423, '2026-04-28 02:48:03', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(424, '2026-04-28 02:48:06', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(425, '2026-04-28 02:48:15', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(426, '2026-04-28 02:50:12', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(427, '2026-04-28 02:50:18', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(428, '2026-04-28 02:50:23', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(429, '2026-04-28 02:50:26', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(430, '2026-04-28 02:50:40', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9154, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36');
INSERT INTO `analytics_events` (`id`, `created_at`, `event_type`, `user_id`, `visitor_id`, `business_id`, `meta_json`, `ip`, `user_agent`) VALUES
(431, '2026-04-28 02:54:14', 'directions_click', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9154, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(432, '2026-04-28 02:54:23', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(433, '2026-04-28 02:54:35', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(434, '2026-04-28 03:11:20', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(435, '2026-04-28 03:11:30', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(436, '2026-04-28 03:17:05', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(437, '2026-04-28 03:17:14', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9154, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(438, '2026-04-28 03:17:26', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(439, '2026-04-28 03:17:32', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(440, '2026-04-28 03:19:15', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(441, '2026-04-28 03:19:20', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(442, '2026-04-28 03:19:37', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9154, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(443, '2026-04-28 03:19:45', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(444, '2026-04-28 03:21:33', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(445, '2026-04-28 03:21:43', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9154, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(446, '2026-04-28 03:21:48', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(447, '2026-04-28 03:21:59', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(448, '2026-04-28 03:22:04', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(449, '2026-04-28 03:25:35', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(450, '2026-04-28 03:25:41', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(451, '2026-04-28 03:27:27', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(452, '2026-04-28 03:27:32', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(453, '2026-04-28 03:27:43', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(454, '2026-04-28 03:30:57', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(455, '2026-04-28 03:31:01', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(456, '2026-04-28 03:31:06', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(457, '2026-04-28 03:32:23', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(458, '2026-04-28 03:32:29', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(459, '2026-04-28 03:32:41', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(460, '2026-04-28 03:32:45', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9154, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(461, '2026-04-28 03:32:47', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(462, '2026-04-28 03:34:16', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(463, '2026-04-28 03:34:22', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(464, '2026-04-28 03:34:42', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(465, '2026-04-28 03:34:46', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(466, '2026-04-28 03:34:54', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9154, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(467, '2026-04-28 03:35:00', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(468, '2026-04-28 03:35:21', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(469, '2026-04-28 03:35:54', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(470, '2026-04-28 03:35:56', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 1, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(471, '2026-04-28 03:36:11', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(472, '2026-04-28 03:36:17', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(473, '2026-04-28 03:37:07', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(474, '2026-04-28 03:37:18', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(475, '2026-04-28 03:37:21', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(476, '2026-04-28 03:37:31', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(477, '2026-04-28 03:38:47', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(478, '2026-04-28 03:38:59', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(479, '2026-04-28 03:39:16', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(480, '2026-04-28 03:39:25', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(481, '2026-04-28 03:40:10', 'map_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(482, '2026-04-28 03:40:19', 'business_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(483, '2026-04-28 03:40:52', 'map_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(484, '2026-04-28 03:41:01', 'business_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(485, '2026-04-28 03:41:32', 'business_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(486, '2026-04-28 03:41:53', 'business_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(487, '2026-04-28 03:43:51', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(488, '2026-04-28 03:43:57', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(489, '2026-04-28 03:44:05', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(490, '2026-04-28 03:44:11', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(491, '2026-04-28 03:44:23', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(492, '2026-04-28 03:44:29', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(493, '2026-04-28 03:44:41', 'map_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(494, '2026-04-28 03:44:50', 'business_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(495, '2026-04-28 03:45:09', 'map_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(496, '2026-04-28 03:45:16', 'business_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(497, '2026-04-28 03:45:21', 'business_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(498, '2026-04-28 03:47:36', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(499, '2026-04-28 03:47:42', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(500, '2026-04-28 03:47:55', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(501, '2026-04-28 03:48:00', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(502, '2026-04-28 03:49:09', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(503, '2026-04-28 03:49:16', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9154, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(504, '2026-04-28 03:49:20', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(505, '2026-04-28 03:49:37', 'business_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(506, '2026-04-28 03:49:48', 'map_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(507, '2026-04-28 03:49:56', 'business_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(508, '2026-04-28 03:50:17', 'map_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(509, '2026-04-28 03:50:26', 'business_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(510, '2026-04-28 03:50:55', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(511, '2026-04-28 03:51:09', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(512, '2026-04-28 03:54:53', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(513, '2026-04-28 03:55:03', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(514, '2026-04-28 03:55:17', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(515, '2026-04-28 03:55:25', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(516, '2026-04-28 03:55:28', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(517, '2026-04-28 03:55:31', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(518, '2026-04-28 03:56:08', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(519, '2026-04-28 03:56:20', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(520, '2026-04-28 03:56:29', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(521, '2026-04-28 03:57:01', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9154, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(522, '2026-04-28 03:57:03', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(523, '2026-04-28 03:57:48', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9154, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(524, '2026-04-28 03:57:57', 'brand_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 6, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(525, '2026-04-28 03:58:05', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(526, '2026-04-28 03:58:13', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 1, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(527, '2026-04-28 03:58:17', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 1, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(528, '2026-04-28 03:58:20', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(529, '2026-04-28 04:42:12', 'map_open', NULL, '1a23bdce895e0a59983e0b216a906b1d', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(530, '2026-04-28 04:43:45', 'map_open', NULL, '1a23bdce895e0a59983e0b216a906b1d', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(531, '2026-04-28 04:43:54', 'business_open', NULL, '1a23bdce895e0a59983e0b216a906b1d', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(532, '2026-04-28 04:58:40', 'business_open', NULL, '1a23bdce895e0a59983e0b216a906b1d', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(533, '2026-04-28 04:58:44', 'business_open', NULL, '1a23bdce895e0a59983e0b216a906b1d', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(534, '2026-04-28 04:59:00', 'business_open', NULL, '1a23bdce895e0a59983e0b216a906b1d', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(535, '2026-04-28 04:59:48', 'map_open', NULL, '1a23bdce895e0a59983e0b216a906b1d', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(536, '2026-04-28 04:59:50', 'business_open', NULL, '1a23bdce895e0a59983e0b216a906b1d', 1, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(537, '2026-04-28 06:36:50', 'map_open', NULL, 'fb917d383fa3db601c8189d9c8d870dd', NULL, NULL, '202.8.42.91', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)'),
(538, '2026-04-28 11:34:06', 'map_open', NULL, '66a3841edb47c096458508bcceb1a5c5', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 13; SM-A226BR Build/TP1A.220624.014; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/147.0.7727.55 Mobile Safari/537.36'),
(539, '2026-04-28 11:35:06', 'business_open', NULL, '66a3841edb47c096458508bcceb1a5c5', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 13; SM-A226BR Build/TP1A.220624.014; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/147.0.7727.55 Mobile Safari/537.36'),
(540, '2026-04-28 11:35:09', 'business_open', NULL, '66a3841edb47c096458508bcceb1a5c5', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 13; SM-A226BR Build/TP1A.220624.014; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/147.0.7727.55 Mobile Safari/537.36'),
(541, '2026-04-28 11:35:12', 'business_open', NULL, '66a3841edb47c096458508bcceb1a5c5', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 13; SM-A226BR Build/TP1A.220624.014; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/147.0.7727.55 Mobile Safari/537.36'),
(542, '2026-04-28 11:35:45', 'map_open', NULL, 'f411ffa78f93e3d18ed24b26ec1ca4c6', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(543, '2026-04-28 11:36:00', 'map_open', NULL, 'f411ffa78f93e3d18ed24b26ec1ca4c6', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(544, '2026-04-28 11:36:07', 'business_open', NULL, 'f411ffa78f93e3d18ed24b26ec1ca4c6', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(545, '2026-04-28 11:37:07', 'business_open', NULL, 'f411ffa78f93e3d18ed24b26ec1ca4c6', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(546, '2026-04-28 11:37:07', 'business_open', NULL, 'f411ffa78f93e3d18ed24b26ec1ca4c6', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(547, '2026-04-28 11:37:07', 'business_open', NULL, 'f411ffa78f93e3d18ed24b26ec1ca4c6', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(548, '2026-04-28 11:37:07', 'email_click', NULL, 'f411ffa78f93e3d18ed24b26ec1ca4c6', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(549, '2026-04-28 11:37:51', 'map_open', NULL, 'f411ffa78f93e3d18ed24b26ec1ca4c6', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(550, '2026-04-28 11:38:03', 'map_open', NULL, 'f411ffa78f93e3d18ed24b26ec1ca4c6', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(551, '2026-04-28 11:38:17', 'business_open', NULL, 'f411ffa78f93e3d18ed24b26ec1ca4c6', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(552, '2026-04-28 11:38:23', 'business_open', NULL, 'f411ffa78f93e3d18ed24b26ec1ca4c6', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(553, '2026-04-28 11:39:37', 'business_open', NULL, 'f411ffa78f93e3d18ed24b26ec1ca4c6', 9154, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(554, '2026-04-28 11:40:16', 'business_open', NULL, 'f411ffa78f93e3d18ed24b26ec1ca4c6', 9154, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(555, '2026-04-28 11:40:33', 'business_open', NULL, 'f411ffa78f93e3d18ed24b26ec1ca4c6', 9154, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(556, '2026-04-28 14:46:24', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(557, '2026-04-28 14:46:33', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(558, '2026-04-28 14:46:38', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(559, '2026-04-28 14:50:52', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(560, '2026-04-28 14:50:55', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(561, '2026-04-28 14:51:20', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(562, '2026-04-28 14:51:23', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(563, '2026-04-28 14:51:35', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(564, '2026-04-28 15:05:27', 'map_open', NULL, '1a23bdce895e0a59983e0b216a906b1d', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(565, '2026-04-28 15:05:48', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(566, '2026-04-28 15:06:01', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(567, '2026-04-28 15:06:05', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(568, '2026-04-28 15:06:11', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(569, '2026-04-28 15:06:16', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(570, '2026-04-28 15:06:20', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(571, '2026-04-28 15:06:25', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(572, '2026-04-28 15:08:20', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(573, '2026-04-28 15:08:30', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(574, '2026-04-28 15:08:36', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(575, '2026-04-28 15:09:52', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(576, '2026-04-28 15:09:56', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(577, '2026-04-28 15:10:27', 'map_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(578, '2026-04-28 15:10:43', 'business_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(579, '2026-04-28 15:15:24', 'brand_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', 6, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(580, '2026-04-28 15:50:32', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(581, '2026-04-28 15:50:39', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(582, '2026-04-28 15:50:46', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(583, '2026-04-28 15:51:10', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(584, '2026-04-28 15:51:40', 'map_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(585, '2026-04-28 15:51:50', 'business_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(586, '2026-04-28 15:52:09', 'map_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(587, '2026-04-28 15:52:16', 'business_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(588, '2026-04-28 15:52:24', 'business_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(589, '2026-04-28 15:53:54', 'map_open', NULL, '66a3841edb47c096458508bcceb1a5c5', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 13; SM-A226BR Build/TP1A.220624.014; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/147.0.7727.55 Mobile Safari/537.36'),
(590, '2026-04-28 15:54:01', 'business_open', NULL, '66a3841edb47c096458508bcceb1a5c5', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 13; SM-A226BR Build/TP1A.220624.014; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/147.0.7727.55 Mobile Safari/537.36'),
(591, '2026-04-28 15:54:06', 'business_open', NULL, '66a3841edb47c096458508bcceb1a5c5', 9154, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 13; SM-A226BR Build/TP1A.220624.014; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/147.0.7727.55 Mobile Safari/537.36'),
(592, '2026-04-28 15:54:12', 'business_open', NULL, '66a3841edb47c096458508bcceb1a5c5', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 13; SM-A226BR Build/TP1A.220624.014; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/147.0.7727.55 Mobile Safari/537.36'),
(593, '2026-04-28 15:54:17', 'business_open', NULL, '66a3841edb47c096458508bcceb1a5c5', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 13; SM-A226BR Build/TP1A.220624.014; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/147.0.7727.55 Mobile Safari/537.36'),
(594, '2026-04-28 15:56:37', 'map_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(595, '2026-04-28 15:56:45', 'business_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(596, '2026-04-28 15:56:53', 'map_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(597, '2026-04-28 15:57:00', 'business_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(598, '2026-04-28 15:57:49', 'map_open', NULL, 'f411ffa78f93e3d18ed24b26ec1ca4c6', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(599, '2026-04-28 15:58:16', 'business_open', NULL, 'f411ffa78f93e3d18ed24b26ec1ca4c6', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(600, '2026-04-28 16:03:57', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(601, '2026-04-28 16:09:21', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(602, '2026-04-28 16:09:24', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(603, '2026-04-28 16:09:34', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(604, '2026-04-28 16:09:54', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(605, '2026-04-28 16:10:19', 'map_open', NULL, 'f411ffa78f93e3d18ed24b26ec1ca4c6', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(606, '2026-04-28 16:10:29', 'business_open', NULL, 'f411ffa78f93e3d18ed24b26ec1ca4c6', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(607, '2026-04-28 16:10:49', 'map_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(608, '2026-04-28 16:10:58', 'business_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(609, '2026-04-28 16:11:30', 'business_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(610, '2026-04-28 16:13:34', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(611, '2026-04-28 16:15:23', 'business_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', 9154, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(612, '2026-04-28 16:15:48', 'brand_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', 6, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(613, '2026-04-28 16:16:33', 'search', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', NULL, '{\"q\":\"Noelia\"}', '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(614, '2026-04-28 16:16:39', 'search', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', NULL, '{\"q\":\"No\"}', '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(615, '2026-04-28 16:17:40', 'map_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(616, '2026-04-28 16:17:48', 'business_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', 9154, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(617, '2026-04-28 16:19:58', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(618, '2026-04-28 16:20:10', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(619, '2026-04-28 16:20:13', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(620, '2026-04-28 16:20:46', 'map_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(621, '2026-04-28 16:20:56', 'business_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(622, '2026-04-28 16:20:59', 'business_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(623, '2026-04-28 16:22:42', 'map_open', NULL, '6fbd712d99773daf892b9611d2250f74', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(624, '2026-04-28 16:23:00', 'business_open', NULL, '6fbd712d99773daf892b9611d2250f74', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(625, '2026-04-28 16:23:47', 'business_open', NULL, '6fbd712d99773daf892b9611d2250f74', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(626, '2026-04-28 17:49:40', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(627, '2026-04-28 17:49:53', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9154, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(628, '2026-04-28 17:56:15', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(629, '2026-04-28 17:56:27', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9155, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(630, '2026-04-28 17:58:31', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(631, '2026-04-28 17:58:38', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9155, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(632, '2026-04-28 17:59:09', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(633, '2026-04-28 17:59:17', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9155, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(634, '2026-04-28 18:03:58', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9155, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(635, '2026-04-28 18:24:06', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9155, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(636, '2026-04-28 18:31:57', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9155, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(637, '2026-04-28 19:43:51', 'map_open', NULL, '1a23bdce895e0a59983e0b216a906b1d', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(638, '2026-04-28 20:17:02', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(639, '2026-04-28 20:59:49', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(640, '2026-04-28 20:59:55', 'search', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, '{\"q\":\"NO\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(641, '2026-04-28 20:59:56', 'search', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, '{\"q\":\"NOE\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(642, '2026-04-28 20:59:57', 'search', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, '{\"q\":\"NO\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(643, '2026-04-28 21:00:03', 'search', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, '{\"q\":\"NOE\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36');
INSERT INTO `analytics_events` (`id`, `created_at`, `event_type`, `user_id`, `visitor_id`, `business_id`, `meta_json`, `ip`, `user_agent`) VALUES
(644, '2026-04-28 21:01:13', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(645, '2026-04-28 21:07:12', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(646, '2026-04-28 21:08:14', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(647, '2026-04-28 21:19:00', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(648, '2026-04-28 21:19:13', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(649, '2026-04-28 21:19:16', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(650, '2026-04-28 21:20:54', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(651, '2026-04-28 21:21:09', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(652, '2026-04-28 21:21:20', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(653, '2026-04-28 21:21:29', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(654, '2026-04-28 21:21:50', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(655, '2026-04-28 21:27:58', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(656, '2026-04-28 21:31:04', 'search', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, '{\"q\":\"mar\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(657, '2026-04-28 21:31:06', 'search', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, '{\"q\":\"ma\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(658, '2026-04-28 21:32:34', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(659, '2026-04-28 21:34:58', 'search', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, '{\"q\":\"ma\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(660, '2026-04-28 21:36:25', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(661, '2026-04-28 21:36:48', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(662, '2026-04-28 21:41:25', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(663, '2026-04-28 21:43:10', 'map_open', NULL, '1a23bdce895e0a59983e0b216a906b1d', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(664, '2026-04-28 21:43:16', 'map_open', NULL, 'a164cd6723885c79426741ee21f13c46', NULL, NULL, '181.199.158.7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36'),
(665, '2026-04-28 21:43:22', 'map_open', 7, '1a23bdce895e0a59983e0b216a906b1d', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(666, '2026-04-28 21:44:34', 'filter_change', 7, '1a23bdce895e0a59983e0b216a906b1d', NULL, '{\"tipo\":\"inmobiliaria\",\"q\":\"\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(667, '2026-04-28 21:44:59', 'search', 7, '1a23bdce895e0a59983e0b216a906b1d', NULL, '{\"q\":\"inmobiliaria\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(668, '2026-04-28 21:45:11', 'filter_change', 7, '1a23bdce895e0a59983e0b216a906b1d', NULL, '{\"tipo\":\"banco\",\"q\":\"\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(669, '2026-04-28 21:45:20', 'filter_change', 7, '1a23bdce895e0a59983e0b216a906b1d', NULL, '{\"tipo\":\"inmobiliaria\",\"q\":\"\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(670, '2026-04-28 21:47:02', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(671, '2026-04-28 21:47:33', 'map_open', 7, '1a23bdce895e0a59983e0b216a906b1d', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(672, '2026-04-28 21:47:48', 'filter_change', 7, '1a23bdce895e0a59983e0b216a906b1d', NULL, '{\"tipo\":\"restaurante\",\"q\":\"\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(673, '2026-04-28 21:48:02', 'filter_change', 7, '1a23bdce895e0a59983e0b216a906b1d', NULL, '{\"tipo\":\"inmobiliaria\",\"q\":\"\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(674, '2026-04-28 21:48:03', 'business_open', 7, '1a23bdce895e0a59983e0b216a906b1d', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(675, '2026-04-28 21:48:41', 'directions_click', 7, '1a23bdce895e0a59983e0b216a906b1d', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(676, '2026-04-28 21:48:51', 'email_click', 7, '1a23bdce895e0a59983e0b216a906b1d', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(677, '2026-04-28 21:56:01', 'map_open', 7, '1a23bdce895e0a59983e0b216a906b1d', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(678, '2026-04-28 21:58:07', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(679, '2026-04-28 21:58:37', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(680, '2026-04-28 21:58:44', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(681, '2026-04-28 22:00:47', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(682, '2026-04-28 22:00:55', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(683, '2026-04-28 22:00:58', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(684, '2026-04-28 22:59:10', 'map_open', NULL, '7f7a6d160244d3a6a27b884454f353bb', NULL, NULL, '45.189.77.134', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(685, '2026-04-28 22:59:28', 'map_open', NULL, '45043175a4873ffdddaf7d2c90455122', NULL, NULL, '190.94.160.196', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36'),
(686, '2026-04-28 23:01:04', 'business_open', NULL, '7f7a6d160244d3a6a27b884454f353bb', 9153, NULL, '45.189.77.134', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(687, '2026-04-28 23:01:18', 'business_open', NULL, '7f7a6d160244d3a6a27b884454f353bb', 9153, NULL, '45.189.77.134', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(688, '2026-04-28 23:01:30', 'brand_open', NULL, '7f7a6d160244d3a6a27b884454f353bb', 6, NULL, '45.189.77.134', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(689, '2026-04-28 23:03:33', 'business_open', NULL, '7f7a6d160244d3a6a27b884454f353bb', 1, NULL, '45.189.77.134', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(690, '2026-04-28 23:05:07', 'business_open', NULL, '7f7a6d160244d3a6a27b884454f353bb', 4, NULL, '45.189.77.134', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(691, '2026-04-28 23:05:31', 'map_open', NULL, '7f7a6d160244d3a6a27b884454f353bb', NULL, NULL, '45.189.77.134', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(692, '2026-04-28 23:09:45', 'map_open', NULL, '7f7a6d160244d3a6a27b884454f353bb', NULL, NULL, '45.189.77.134', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(693, '2026-04-28 23:09:50', 'map_open', NULL, '70313f824dd8f969d92e897c02f23b49', NULL, NULL, '190.94.160.196', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36'),
(694, '2026-04-28 23:17:30', 'map_open', NULL, '7f7a6d160244d3a6a27b884454f353bb', NULL, NULL, '45.189.77.134', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(695, '2026-04-28 23:17:36', 'business_open', NULL, '7f7a6d160244d3a6a27b884454f353bb', 9153, NULL, '45.189.77.134', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(696, '2026-04-28 23:17:55', 'website_click', NULL, '7f7a6d160244d3a6a27b884454f353bb', 9153, NULL, '45.189.77.134', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(697, '2026-04-28 23:18:07', 'map_open', NULL, '7f7a6d160244d3a6a27b884454f353bb', NULL, NULL, '45.189.77.134', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(698, '2026-04-28 23:18:26', 'business_open', NULL, '7f7a6d160244d3a6a27b884454f353bb', NULL, NULL, '45.189.77.134', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(699, '2026-04-28 23:18:40', 'business_open', NULL, '7f7a6d160244d3a6a27b884454f353bb', 9153, NULL, '45.189.77.134', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(700, '2026-04-28 23:47:36', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(701, '2026-04-28 23:47:44', 'map_open', NULL, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(702, '2026-04-28 23:50:32', 'map_open', NULL, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(703, '2026-04-28 23:50:48', 'map_open', NULL, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(704, '2026-04-28 23:53:23', 'map_open', NULL, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(705, '2026-04-29 00:03:34', 'map_open', NULL, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(706, '2026-04-29 00:04:28', 'map_open', NULL, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(707, '2026-04-29 00:04:38', 'business_open', NULL, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(708, '2026-04-29 00:04:41', 'business_open', NULL, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(709, '2026-04-29 00:04:54', 'map_open', NULL, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(710, '2026-04-29 00:05:01', 'business_open', NULL, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(711, '2026-04-29 00:05:03', 'business_open', NULL, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(712, '2026-04-29 00:05:25', 'business_open', NULL, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(713, '2026-04-29 00:13:14', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(714, '2026-04-29 00:13:20', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9156, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(715, '2026-04-29 00:13:27', 'whatsapp_click', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9156, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(716, '2026-04-29 00:16:16', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(717, '2026-04-29 00:16:20', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9156, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(718, '2026-04-29 00:16:33', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(719, '2026-04-29 00:16:40', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9156, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(720, '2026-04-29 00:16:55', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(721, '2026-04-29 00:17:01', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9156, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(722, '2026-04-29 00:17:04', 'whatsapp_click', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9156, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(723, '2026-04-29 00:19:39', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(724, '2026-04-29 00:19:45', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(725, '2026-04-29 00:19:47', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(726, '2026-04-29 00:21:05', 'map_open', NULL, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(727, '2026-04-29 00:21:13', 'business_open', NULL, '67670c2421f4da3bdde95e7d5c2e6d27', 9156, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(728, '2026-04-29 00:21:19', 'map_open', NULL, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(729, '2026-04-29 00:21:29', 'business_open', NULL, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(730, '2026-04-29 00:23:10', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(731, '2026-04-29 00:23:13', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(732, '2026-04-29 00:23:23', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(733, '2026-04-29 00:28:55', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(734, '2026-04-29 00:28:58', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(735, '2026-04-29 00:29:05', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9156, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(736, '2026-04-29 00:29:08', 'whatsapp_click', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9156, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(737, '2026-04-29 00:30:42', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(738, '2026-04-29 00:31:46', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(739, '2026-04-29 00:31:48', 'whatsapp_click', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(740, '2026-04-29 00:33:31', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(741, '2026-04-29 00:35:08', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(742, '2026-04-29 00:52:36', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(743, '2026-04-29 00:52:55', 'map_open', NULL, '0540aa486d77f9740e6354feb620114b', NULL, NULL, '201.251.56.18', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(744, '2026-04-29 00:54:19', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9157, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(745, '2026-04-29 00:54:26', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9156, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(746, '2026-04-29 00:54:30', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(747, '2026-04-29 00:55:54', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(748, '2026-04-29 00:56:01', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9157, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(749, '2026-04-29 00:56:05', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(750, '2026-04-29 00:56:08', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(751, '2026-04-29 01:01:57', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(752, '2026-04-29 01:02:10', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 5, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(753, '2026-04-29 01:02:51', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 5, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(754, '2026-04-29 01:09:15', 'brand_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 6, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(755, '2026-04-29 01:10:25', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(756, '2026-04-29 01:10:32', 'brand_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 6, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(757, '2026-04-29 01:11:42', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(758, '2026-04-29 01:14:00', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(759, '2026-04-29 01:21:06', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(760, '2026-04-29 01:23:48', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(761, '2026-04-29 01:36:59', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(762, '2026-04-29 01:37:03', 'email_click', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(763, '2026-04-29 01:45:00', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(764, '2026-04-29 01:45:08', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9158, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(765, '2026-04-29 01:45:43', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(766, '2026-04-29 01:57:15', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(767, '2026-04-29 01:57:18', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9159, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(768, '2026-04-29 01:57:43', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(769, '2026-04-29 01:58:07', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(770, '2026-04-29 02:08:38', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(771, '2026-04-29 02:08:46', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9160, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(772, '2026-04-29 02:57:19', 'map_open', NULL, 'bff02008fe0640b9efd0f9036bc8a99e', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(773, '2026-04-29 03:47:44', 'map_open', NULL, 'a48533fca88c659f7ae0ee2f8adc272e', NULL, NULL, '186.13.125.128', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(774, '2026-04-29 03:47:53', 'business_open', NULL, 'a48533fca88c659f7ae0ee2f8adc272e', 9159, NULL, '186.13.125.128', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(775, '2026-04-29 03:48:22', 'business_open', NULL, 'a48533fca88c659f7ae0ee2f8adc272e', 5, NULL, '186.13.125.128', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(776, '2026-04-29 03:48:41', 'brand_open', NULL, 'a48533fca88c659f7ae0ee2f8adc272e', 6, NULL, '186.13.125.128', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(777, '2026-04-29 04:48:09', 'map_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(778, '2026-04-29 04:48:47', 'map_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(779, '2026-04-29 04:48:59', 'email_click', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(780, '2026-04-29 04:51:18', 'search', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', NULL, '{\"q\":\"Ma\"}', '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(781, '2026-04-29 04:52:13', 'map_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(782, '2026-04-29 04:53:00', 'map_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(783, '2026-04-29 09:18:17', 'map_open', NULL, '28c28d10bea8ea77ae4770fc05f86bb9', NULL, NULL, '2a01:599:143:51fc:d503:9b58:eab5:3395', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36'),
(784, '2026-04-29 09:58:20', 'map_open', NULL, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(785, '2026-04-29 10:13:24', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(786, '2026-04-29 10:21:38', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(787, '2026-04-29 10:29:21', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(788, '2026-04-29 10:29:36', 'brand_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(789, '2026-04-29 10:42:48', 'brand_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 8, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(790, '2026-04-29 12:11:06', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(791, '2026-04-29 13:11:34', 'map_open', NULL, '52adfc541a46bfb33060d53b9ff83e7d', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(792, '2026-04-29 13:11:49', 'business_open', NULL, '52adfc541a46bfb33060d53b9ff83e7d', 9156, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(793, '2026-04-29 13:12:15', 'business_open', NULL, '52adfc541a46bfb33060d53b9ff83e7d', 9158, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(794, '2026-04-29 13:12:21', 'business_open', NULL, '52adfc541a46bfb33060d53b9ff83e7d', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(795, '2026-04-29 13:23:13', 'map_open', NULL, '1a23bdce895e0a59983e0b216a906b1d', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(796, '2026-04-29 13:23:16', 'map_open', NULL, '1a23bdce895e0a59983e0b216a906b1d', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(797, '2026-04-29 13:23:20', 'map_open', NULL, 'd1c614e24f92528bba6062492cf63334', NULL, NULL, '181.15.96.135', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36'),
(798, '2026-04-29 14:26:54', 'map_open', NULL, '1a23bdce895e0a59983e0b216a906b1d', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(799, '2026-04-29 14:27:08', 'business_open', NULL, '1a23bdce895e0a59983e0b216a906b1d', 9157, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(800, '2026-04-29 14:27:38', 'brand_open', NULL, '1a23bdce895e0a59983e0b216a906b1d', 9, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(801, '2026-04-29 14:59:04', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(802, '2026-04-29 14:59:09', 'search', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, '{\"q\":\"banza\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(803, '2026-04-29 14:59:23', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9161, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(804, '2026-04-29 15:07:25', 'map_open', NULL, 'e60f729993e0c8142f607e06ceeaa83b', NULL, NULL, '181.98.147.7', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/29.0 Chrome/136.0.0.0 Mobile Safari/537.36'),
(805, '2026-04-29 15:09:46', 'map_open', NULL, '00caf085d4466b25a000d47985529c8c', NULL, NULL, '148.227.121.163', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(806, '2026-04-29 15:51:20', 'map_open', NULL, '1d4aacf9d9ed74f5fe7864cce8228a21', NULL, NULL, '2800:250a:c4:5bd4:e0e3:bbff:fe2e:9263', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(807, '2026-04-29 15:51:25', 'map_open', NULL, '274dee19fe29222d8bd7a13f00c6dc0f', NULL, NULL, '200.110.188.101', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36'),
(808, '2026-04-29 15:52:14', 'map_open', NULL, '44518ee075a735c7c8203865547b21ac', NULL, NULL, '204.199.71.86', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(809, '2026-04-29 15:54:20', 'map_open', NULL, '57a54bcad3efdb06e6c0d2034062df5c', NULL, NULL, '209.170.91.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.75 Safari/537.36'),
(810, '2026-04-29 15:55:06', 'map_open', NULL, '32a2e486e2af6091503993f98490b5f9', NULL, NULL, '200.105.110.35', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(811, '2026-04-29 15:58:40', 'map_open', NULL, '1b90459e8d269529a42a1738ac3f3175', NULL, NULL, '190.234.82.156', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(812, '2026-04-29 15:58:47', 'map_open', NULL, 'f4ca573e6bdb6a2afddecd10bef7deea', NULL, NULL, '177.91.255.68', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36'),
(813, '2026-04-29 16:22:18', 'map_open', NULL, '5291d0741086c80657048d073d5b776f', NULL, NULL, '50.172.72.26', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(814, '2026-04-29 16:23:02', 'search', NULL, '5291d0741086c80657048d073d5b776f', NULL, '{\"q\":\"embotelladores\"}', '50.172.72.26', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(815, '2026-04-29 16:24:15', 'map_open', NULL, '1baf5362e03e841b0e4e2ec52d0daa6e', NULL, NULL, '24.232.22.114', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(816, '2026-04-29 16:41:34', 'map_open', NULL, '6b72a3d3ed9dac89f0c49b695b067f3a', NULL, NULL, '170.233.68.221', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.3 Mobile/15E148 Safari/604.1'),
(817, '2026-04-29 16:54:13', 'map_open', NULL, '8e7a0f25f1423ba01c25fdd3772a1e4d', NULL, NULL, '181.239.16.57', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(818, '2026-04-29 17:01:21', 'map_open', NULL, '1a23bdce895e0a59983e0b216a906b1d', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(819, '2026-04-29 17:04:05', 'map_open', 7, '1a23bdce895e0a59983e0b216a906b1d', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(820, '2026-04-29 17:22:40', 'map_open', NULL, '2e524cc32ee44232ebd00e0e5d262bbd', NULL, NULL, '45.189.187.204', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(821, '2026-04-29 17:27:39', 'map_open', 7, '1a23bdce895e0a59983e0b216a906b1d', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(822, '2026-04-29 17:30:50', 'map_open', NULL, '1e65a693b95d060f32bfc2264385a5f5', NULL, NULL, '2800:40:76:b6ce:d0a0:e727:6f3:9f28', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(823, '2026-04-29 17:35:15', 'map_open', NULL, '1e65a693b95d060f32bfc2264385a5f5', NULL, NULL, '190.210.36.18', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(824, '2026-04-29 18:26:16', 'map_open', NULL, '1d4aacf9d9ed74f5fe7864cce8228a21', NULL, NULL, '200.81.152.23', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(825, '2026-04-29 18:27:15', 'map_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(826, '2026-04-29 18:47:01', 'map_open', 8, '1e65a693b95d060f32bfc2264385a5f5', NULL, NULL, '2800:40:76:b6ce:d0a0:e727:6f3:9f28', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(827, '2026-04-29 18:47:06', 'search', 8, '1e65a693b95d060f32bfc2264385a5f5', NULL, '{\"q\":\"abogado\"}', '2800:40:76:b6ce:d0a0:e727:6f3:9f28', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(828, '2026-04-29 18:47:13', 'business_open', 8, '1e65a693b95d060f32bfc2264385a5f5', 9162, NULL, '2800:40:76:b6ce:d0a0:e727:6f3:9f28', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(829, '2026-04-29 18:49:03', 'website_click', 8, '1e65a693b95d060f32bfc2264385a5f5', 9162, NULL, '2800:40:76:b6ce:d0a0:e727:6f3:9f28', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(830, '2026-04-29 18:49:07', 'whatsapp_click', 8, '1e65a693b95d060f32bfc2264385a5f5', 9162, NULL, '2800:40:76:b6ce:d0a0:e727:6f3:9f28', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(831, '2026-04-29 18:50:12', 'map_open', NULL, '1baf5362e03e841b0e4e2ec52d0daa6e', NULL, NULL, '2803:9800:9888:54be:e5a0:40b0:c9c0:633c', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(832, '2026-04-29 18:52:05', 'map_open', NULL, '1baf5362e03e841b0e4e2ec52d0daa6e', NULL, NULL, '2803:9800:9888:54be:e5a0:40b0:c9c0:633c', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(833, '2026-04-29 18:52:07', 'business_open', NULL, '1baf5362e03e841b0e4e2ec52d0daa6e', 9162, NULL, '2803:9800:9888:54be:e5a0:40b0:c9c0:633c', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(834, '2026-04-29 18:55:52', 'map_open', NULL, 'dfa86cf6c3401d7af39523b905e489d7', NULL, NULL, '201.213.22.43', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(835, '2026-04-29 19:16:25', 'map_open', NULL, 'bff02008fe0640b9efd0f9036bc8a99e', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(836, '2026-04-29 19:17:21', 'map_open', NULL, 'bff02008fe0640b9efd0f9036bc8a99e', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(837, '2026-04-29 19:29:49', 'map_open', NULL, 'f6f3710e9e84b79e12d814227e9cdcb5', NULL, NULL, '190.139.199.204', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.4 Mobile/15E148 Safari/604.1'),
(838, '2026-04-29 19:53:47', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(839, '2026-04-29 19:53:55', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9162, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(840, '2026-04-29 19:54:20', 'map_open', 7, '1a23bdce895e0a59983e0b216a906b1d', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(841, '2026-04-29 19:54:39', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(842, '2026-04-29 19:54:42', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9162, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(843, '2026-04-29 19:55:10', 'brand_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 8, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(844, '2026-04-29 19:55:14', 'brand_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 6, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(845, '2026-04-29 19:56:20', 'map_open', 7, '1a23bdce895e0a59983e0b216a906b1d', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(846, '2026-04-29 19:56:21', 'business_open', 7, '1a23bdce895e0a59983e0b216a906b1d', 9162, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(847, '2026-04-29 19:57:43', 'business_open', 7, '1a23bdce895e0a59983e0b216a906b1d', 5, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(848, '2026-04-29 19:59:19', 'business_open', 7, '1a23bdce895e0a59983e0b216a906b1d', 5, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(849, '2026-04-29 20:02:50', 'business_open', 7, '1a23bdce895e0a59983e0b216a906b1d', 9158, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(850, '2026-04-29 20:12:42', 'map_open', 7, '1a23bdce895e0a59983e0b216a906b1d', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(851, '2026-04-29 20:25:56', 'map_open', NULL, 'cfd8bec533f7e9a3d4acd21826d6ef8d', NULL, NULL, '45.186.208.99', 'Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36'),
(852, '2026-04-29 20:27:41', 'filter_change', NULL, 'cfd8bec533f7e9a3d4acd21826d6ef8d', NULL, '{\"tipo\":\"psicologo\",\"q\":\"\"}', '45.186.208.99', 'Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36'),
(853, '2026-04-29 20:36:37', 'map_open', 7, '1a23bdce895e0a59983e0b216a906b1d', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(854, '2026-04-29 20:43:53', 'map_open', NULL, '20e391ac3e53d76804289e62806a662e', NULL, NULL, '2800:2505:71:4573:487c:cbe5:19cd:e209', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(855, '2026-04-29 20:44:23', 'map_open', NULL, '529b8527868bc53948be63d2c5f5b755', NULL, NULL, '186.138.44.9', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(856, '2026-04-29 20:44:47', 'map_open', NULL, '8039581612fc76d2334df13926aa2a37', NULL, NULL, '190.105.123.81', 'Mozilla/5.0 (iPhone; CPU iPhone OS 26_4_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/147.0.7727.99 Mobile/15E148 Safari/604.1'),
(857, '2026-04-29 20:46:32', 'map_open', NULL, '2c2d22b04b79c3df7979e516ca9571af', NULL, NULL, '2800:810:503:26f:491a:1f8f:21be:6105', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.3 Mobile/15E148 Safari/604.1'),
(858, '2026-04-29 20:46:41', 'map_open', NULL, '2c2d22b04b79c3df7979e516ca9571af', NULL, NULL, '2800:810:503:26f:491a:1f8f:21be:6105', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.3 Mobile/15E148 Safari/604.1'),
(859, '2026-04-29 20:52:51', 'map_open', 7, '1a23bdce895e0a59983e0b216a906b1d', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36');
INSERT INTO `analytics_events` (`id`, `created_at`, `event_type`, `user_id`, `visitor_id`, `business_id`, `meta_json`, `ip`, `user_agent`) VALUES
(860, '2026-04-29 20:53:53', 'map_open', NULL, 'a20286d7cda6a9349f0efd9c89219fca', NULL, NULL, '2800:810:503:26f:491a:1f8f:21be:6105', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.3 Mobile/15E148 Safari/604.1'),
(861, '2026-04-29 20:54:46', 'email_click', NULL, 'a20286d7cda6a9349f0efd9c89219fca', NULL, NULL, '2800:810:503:26f:491a:1f8f:21be:6105', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.3 Mobile/15E148 Safari/604.1'),
(862, '2026-04-29 20:57:24', 'map_open', NULL, '3050d47f058ec7308e32a33ecfa64219', NULL, NULL, '179.60.243.100', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36'),
(863, '2026-04-29 20:57:34', 'map_open', NULL, '8039581612fc76d2334df13926aa2a37', NULL, NULL, '2800:af0:1088:8db:f54c:4f0f:62be:e4e3', 'Mozilla/5.0 (iPhone; CPU iPhone OS 26_4_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/147.0.7727.99 Mobile/15E148 Safari/604.1'),
(864, '2026-04-29 21:11:24', 'map_open', NULL, '9c42b6e43f7d55a069e32c7c9a66406d', NULL, NULL, '38.41.42.235', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 OPR/130.0.0.0'),
(865, '2026-04-29 21:11:32', 'map_open', NULL, '9c42b6e43f7d55a069e32c7c9a66406d', NULL, NULL, '38.41.42.235', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 OPR/130.0.0.0'),
(866, '2026-04-29 21:38:31', 'map_open', NULL, '919df20f56bf3742d227328043f82486', NULL, NULL, '2802:8010:10a:b600:d930:1a3d:37dc:d3e3', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/29.0 Chrome/136.0.0.0 Mobile Safari/537.36'),
(867, '2026-04-29 21:43:45', 'map_open', NULL, '5a320b583166348b57b11ac1b6b6b981', NULL, NULL, '2800:810:503:26f:491a:1f8f:21be:6105', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.3 Mobile/15E148 Safari/604.1'),
(868, '2026-04-29 21:45:51', 'map_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(869, '2026-04-29 21:47:37', 'map_open', NULL, '5a320b583166348b57b11ac1b6b6b981', NULL, NULL, '2800:810:503:26f:491a:1f8f:21be:6105', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.3 Mobile/15E148 Safari/604.1'),
(870, '2026-04-29 21:49:57', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(871, '2026-04-29 21:50:12', 'map_open', 7, '1a23bdce895e0a59983e0b216a906b1d', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(872, '2026-04-29 21:52:05', 'business_open', 7, '1a23bdce895e0a59983e0b216a906b1d', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(873, '2026-04-29 21:56:32', 'business_open', 7, '1a23bdce895e0a59983e0b216a906b1d', 9160, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(874, '2026-04-29 21:56:53', 'map_open', 7, '1a23bdce895e0a59983e0b216a906b1d', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(875, '2026-04-29 22:15:27', 'map_open', NULL, '9a17189c68315e02e5b9c3433aec75e2', NULL, NULL, '108.77.84.128', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(876, '2026-04-29 22:15:50', 'business_open', NULL, '9a17189c68315e02e5b9c3433aec75e2', 5, NULL, '108.77.84.128', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(877, '2026-04-29 22:15:58', 'business_open', NULL, '9a17189c68315e02e5b9c3433aec75e2', 9160, NULL, '108.77.84.128', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(878, '2026-04-29 22:16:00', 'brand_open', NULL, '9a17189c68315e02e5b9c3433aec75e2', 9, NULL, '108.77.84.128', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(879, '2026-04-29 22:16:05', 'business_open', NULL, '9a17189c68315e02e5b9c3433aec75e2', 9158, NULL, '108.77.84.128', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(880, '2026-04-29 22:21:21', 'map_open', NULL, '18ec00c2934a5228e7866b4a09477416', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(881, '2026-04-29 22:30:03', 'map_open', NULL, 'bff02008fe0640b9efd0f9036bc8a99e', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(882, '2026-04-29 22:31:37', 'map_open', NULL, 'bff02008fe0640b9efd0f9036bc8a99e', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(883, '2026-04-29 22:33:50', 'map_open', NULL, '567ab49c39856a4e69ab3ea97eda4799', NULL, NULL, '2803:9800:9888:41a5:b597:a8db:1d0e:49c0', 'Mozilla/5.0 (iPhone; CPU iPhone OS 26_3_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/147.0.7727.99 Mobile/15E148 Safari/604.1'),
(884, '2026-04-29 22:35:08', 'map_open', NULL, '9337b14fc4e404abba4bcdf6524d3b29', NULL, NULL, '2803:9800:9888:41a5:6545:6c79:fdb1:78c0', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(885, '2026-04-29 22:41:47', 'map_open', NULL, '5f9faace2acb8ccab373550023e84676', NULL, NULL, '186.157.168.56', 'Mozilla/5.0 (iPhone; CPU iPhone OS 26_3_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/147.0.7727.47 Mobile/15E148 Safari/604.1'),
(886, '2026-04-29 22:43:05', 'map_open', NULL, '0e3b7f04688822ddd8b35be4f047c8e7', NULL, NULL, '181.31.41.43', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(887, '2026-04-29 22:48:04', 'map_open', NULL, '91dd34608fc59b501b8516386292498f', NULL, NULL, '190.18.237.29', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(888, '2026-04-29 22:49:05', 'map_open', NULL, 'dfa86cf6c3401d7af39523b905e489d7', NULL, NULL, '201.213.22.43', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(889, '2026-04-29 23:18:52', 'map_open', NULL, 'c1de2a1c7689af22332ffc01a42f71bc', NULL, NULL, '181.105.137.31', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(890, '2026-04-29 23:19:17', 'business_open', NULL, 'c1de2a1c7689af22332ffc01a42f71bc', 9161, NULL, '181.105.137.31', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(891, '2026-04-29 23:19:24', 'map_open', NULL, 'c1de2a1c7689af22332ffc01a42f71bc', NULL, NULL, '181.105.137.31', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(892, '2026-04-29 23:19:30', 'map_open', NULL, 'c1de2a1c7689af22332ffc01a42f71bc', NULL, NULL, '181.105.137.31', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(893, '2026-04-29 23:19:48', 'map_open', NULL, '567ab49c39856a4e69ab3ea97eda4799', NULL, NULL, '2803:9800:9888:41a5:b597:a8db:1d0e:49c0', 'Mozilla/5.0 (iPhone; CPU iPhone OS 26_3_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/147.0.7727.99 Mobile/15E148 Safari/604.1'),
(894, '2026-04-29 23:21:03', 'map_open', NULL, 'c1de2a1c7689af22332ffc01a42f71bc', NULL, NULL, '181.105.137.31', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(895, '2026-04-29 23:22:59', 'map_open', NULL, 'cdb2e64b1a917653b610e1d88d0a3081', NULL, NULL, '181.2.166.7', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.3 Mobile/15E148 Safari/604.1'),
(896, '2026-04-29 23:23:03', 'business_open', NULL, 'cdb2e64b1a917653b610e1d88d0a3081', 9162, NULL, '181.2.166.7', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.3 Mobile/15E148 Safari/604.1'),
(897, '2026-04-29 23:23:10', 'business_open', NULL, 'cdb2e64b1a917653b610e1d88d0a3081', 9159, NULL, '181.2.166.7', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.3 Mobile/15E148 Safari/604.1'),
(898, '2026-04-29 23:25:02', 'map_open', NULL, 'c1de2a1c7689af22332ffc01a42f71bc', NULL, NULL, '181.105.137.31', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(899, '2026-04-29 23:26:47', 'map_open', NULL, 'c1de2a1c7689af22332ffc01a42f71bc', NULL, NULL, '181.105.137.31', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(900, '2026-04-29 23:27:19', 'map_open', NULL, 'c1de2a1c7689af22332ffc01a42f71bc', NULL, NULL, '181.105.137.31', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(901, '2026-04-29 23:27:30', 'business_open', NULL, 'c1de2a1c7689af22332ffc01a42f71bc', 9159, NULL, '181.105.137.31', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(902, '2026-04-29 23:27:47', 'map_open', NULL, 'c1de2a1c7689af22332ffc01a42f71bc', NULL, NULL, '181.105.137.31', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(903, '2026-04-29 23:27:58', 'map_open', NULL, 'c1de2a1c7689af22332ffc01a42f71bc', NULL, NULL, '181.105.137.31', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(904, '2026-04-29 23:28:16', 'business_open', NULL, 'c1de2a1c7689af22332ffc01a42f71bc', 9157, NULL, '181.105.137.31', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(905, '2026-04-29 23:28:33', 'business_open', NULL, 'c1de2a1c7689af22332ffc01a42f71bc', 9157, NULL, '181.105.137.31', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(906, '2026-04-29 23:28:38', 'map_open', NULL, 'c1de2a1c7689af22332ffc01a42f71bc', NULL, NULL, '181.105.137.31', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(907, '2026-04-29 23:28:50', 'business_open', NULL, 'c1de2a1c7689af22332ffc01a42f71bc', 9156, NULL, '181.105.137.31', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(908, '2026-04-29 23:29:12', 'map_open', NULL, 'c1de2a1c7689af22332ffc01a42f71bc', NULL, NULL, '181.105.137.31', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(909, '2026-04-29 23:33:35', 'map_open', NULL, 'c1de2a1c7689af22332ffc01a42f71bc', NULL, NULL, '181.105.137.31', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(910, '2026-04-29 23:34:22', 'map_open', NULL, 'c1de2a1c7689af22332ffc01a42f71bc', NULL, NULL, '181.105.137.31', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(911, '2026-04-29 23:34:31', 'map_open', NULL, 'c1de2a1c7689af22332ffc01a42f71bc', NULL, NULL, '181.105.137.31', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(912, '2026-04-29 23:34:57', 'business_open', NULL, 'c1de2a1c7689af22332ffc01a42f71bc', 9161, NULL, '181.105.137.31', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(913, '2026-04-29 23:36:54', 'map_open', NULL, 'c1de2a1c7689af22332ffc01a42f71bc', NULL, NULL, '181.105.137.31', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(914, '2026-04-29 23:37:19', 'map_open', NULL, 'c1de2a1c7689af22332ffc01a42f71bc', NULL, NULL, '181.105.137.31', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(915, '2026-04-29 23:37:32', 'map_open', NULL, 'c1de2a1c7689af22332ffc01a42f71bc', NULL, NULL, '181.105.137.31', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(916, '2026-04-29 23:38:56', 'map_open', NULL, 'c1de2a1c7689af22332ffc01a42f71bc', NULL, NULL, '181.105.137.31', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(917, '2026-04-29 23:40:02', 'map_open', NULL, 'c1de2a1c7689af22332ffc01a42f71bc', NULL, NULL, '181.105.137.31', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(918, '2026-04-29 23:41:07', 'map_open', NULL, 'c1de2a1c7689af22332ffc01a42f71bc', NULL, NULL, '181.105.137.31', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(919, '2026-04-29 23:42:51', 'map_open', 7, '1a23bdce895e0a59983e0b216a906b1d', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(920, '2026-04-29 23:44:40', 'brand_open', NULL, 'c1de2a1c7689af22332ffc01a42f71bc', 8, NULL, '181.105.137.31', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(921, '2026-04-29 23:44:45', 'brand_open', NULL, 'c1de2a1c7689af22332ffc01a42f71bc', 8, NULL, '181.105.137.31', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(922, '2026-04-29 23:45:08', 'brand_open', NULL, 'c1de2a1c7689af22332ffc01a42f71bc', 8, NULL, '181.105.137.31', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(923, '2026-04-29 23:45:09', 'brand_open', NULL, 'c1de2a1c7689af22332ffc01a42f71bc', 8, NULL, '181.105.137.31', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(924, '2026-04-30 00:09:34', 'map_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(925, '2026-04-30 00:09:46', 'business_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', 9162, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(926, '2026-04-30 00:10:53', 'map_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(927, '2026-04-30 00:41:41', 'map_open', NULL, '24e663fa05d5d807f383ea1abb894020', NULL, NULL, '201.212.24.32', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(928, '2026-04-30 01:19:49', 'map_open', NULL, '18ec00c2934a5228e7866b4a09477416', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(929, '2026-04-30 02:51:20', 'map_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(930, '2026-04-30 02:51:28', 'business_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', 9162, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(931, '2026-04-30 02:52:45', 'map_open', 5, '0625fc06335d1ae10c96cc4cc85e3efd', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(932, '2026-04-30 02:53:55', 'map_open', NULL, 'cf3d60cc2853c4b43730a3cf65389fc9', NULL, NULL, '2806:250:1504:bff8:7157:22f8:f525:2407', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36'),
(933, '2026-04-30 03:30:18', 'map_open', NULL, '8039581612fc76d2334df13926aa2a37', NULL, NULL, '190.105.123.81', 'Mozilla/5.0 (iPhone; CPU iPhone OS 26_4_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/147.0.7727.99 Mobile/15E148 Safari/604.1'),
(934, '2026-04-30 04:12:41', 'map_open', NULL, '4965f735bbe596186f2bb70187216854', NULL, NULL, '181.117.26.182', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(935, '2026-04-30 04:13:08', 'brand_open', NULL, '4965f735bbe596186f2bb70187216854', 9, NULL, '181.117.26.182', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(936, '2026-04-30 04:13:14', 'map_open', NULL, '8e7a0f25f1423ba01c25fdd3772a1e4d', NULL, NULL, '2803:9800:9881:b4ba:45e3:9fe3:8cd2:c857', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(937, '2026-04-30 04:13:20', 'business_open', NULL, '4965f735bbe596186f2bb70187216854', 9153, NULL, '181.117.26.182', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(938, '2026-04-30 04:28:13', 'map_open', 10, '8e7a0f25f1423ba01c25fdd3772a1e4d', NULL, NULL, '2803:9800:9881:b4ba:45e3:9fe3:8cd2:c857', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(939, '2026-04-30 04:29:33', 'business_open', 10, '8e7a0f25f1423ba01c25fdd3772a1e4d', 9153, NULL, '2803:9800:9881:b4ba:45e3:9fe3:8cd2:c857', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(940, '2026-04-30 04:30:32', 'directions_click', 10, '8e7a0f25f1423ba01c25fdd3772a1e4d', 9153, NULL, '2803:9800:9881:b4ba:45e3:9fe3:8cd2:c857', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(941, '2026-04-30 04:31:19', 'website_click', 10, '8e7a0f25f1423ba01c25fdd3772a1e4d', 9153, NULL, '2803:9800:9881:b4ba:45e3:9fe3:8cd2:c857', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(942, '2026-04-30 04:32:00', 'email_click', 10, '8e7a0f25f1423ba01c25fdd3772a1e4d', 9153, NULL, '2803:9800:9881:b4ba:45e3:9fe3:8cd2:c857', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(943, '2026-04-30 04:32:08', 'whatsapp_click', 10, '8e7a0f25f1423ba01c25fdd3772a1e4d', 9153, NULL, '2803:9800:9881:b4ba:45e3:9fe3:8cd2:c857', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(944, '2026-04-30 04:34:38', 'map_open', 10, '8e7a0f25f1423ba01c25fdd3772a1e4d', NULL, NULL, '2803:9800:9881:b4ba:45e3:9fe3:8cd2:c857', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(945, '2026-04-30 12:30:16', 'map_open', 7, '1a23bdce895e0a59983e0b216a906b1d', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(946, '2026-04-30 12:36:44', 'map_open', NULL, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(947, '2026-04-30 12:37:55', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(948, '2026-04-30 13:55:12', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(949, '2026-04-30 14:54:29', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(950, '2026-04-30 16:56:17', 'map_open', NULL, '8039581612fc76d2334df13926aa2a37', NULL, NULL, '2800:af0:1088:8db:b5b8:782e:c0de:591c', 'Mozilla/5.0 (iPhone; CPU iPhone OS 26_4_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/147.0.7727.99 Mobile/15E148 Safari/604.1'),
(951, '2026-04-30 18:15:15', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(952, '2026-04-30 19:41:58', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(953, '2026-04-30 19:42:37', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(954, '2026-04-30 19:42:43', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(955, '2026-04-30 19:42:47', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(956, '2026-04-30 19:42:51', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(957, '2026-04-30 19:43:39', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(958, '2026-04-30 19:43:51', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(959, '2026-04-30 19:52:33', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(960, '2026-04-30 19:55:26', 'map_open', NULL, '18ec00c2934a5228e7866b4a09477416', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(961, '2026-04-30 19:55:42', 'map_open', NULL, '6fbd712d99773daf892b9611d2250f74', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(962, '2026-04-30 19:56:13', 'map_open', NULL, '18ec00c2934a5228e7866b4a09477416', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(963, '2026-04-30 19:56:20', 'brand_open', NULL, '6fbd712d99773daf892b9611d2250f74', 9, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(964, '2026-04-30 19:56:27', 'brand_open', NULL, '6fbd712d99773daf892b9611d2250f74', 9, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(965, '2026-04-30 19:56:37', 'map_open', NULL, '18ec00c2934a5228e7866b4a09477416', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(966, '2026-04-30 19:56:44', 'brand_open', NULL, '6fbd712d99773daf892b9611d2250f74', 7, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(967, '2026-04-30 19:56:47', 'business_open', NULL, '6fbd712d99773daf892b9611d2250f74', 9160, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(968, '2026-04-30 19:56:53', 'business_open', NULL, '6fbd712d99773daf892b9611d2250f74', 9156, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(969, '2026-04-30 19:56:55', 'map_open', NULL, '18ec00c2934a5228e7866b4a09477416', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(970, '2026-04-30 19:56:59', 'business_open', NULL, '6fbd712d99773daf892b9611d2250f74', 9161, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(971, '2026-04-30 19:57:05', 'business_open', NULL, '6fbd712d99773daf892b9611d2250f74', 9162, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(972, '2026-04-30 19:57:13', 'map_open', NULL, '18ec00c2934a5228e7866b4a09477416', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(973, '2026-04-30 19:57:27', 'business_open', NULL, '6fbd712d99773daf892b9611d2250f74', 9159, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(974, '2026-04-30 19:57:29', 'business_open', NULL, '6fbd712d99773daf892b9611d2250f74', 9162, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(975, '2026-04-30 19:57:38', 'brand_open', NULL, '6fbd712d99773daf892b9611d2250f74', 9, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(976, '2026-04-30 19:57:44', 'business_open', NULL, '6fbd712d99773daf892b9611d2250f74', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(977, '2026-04-30 20:05:46', 'map_open', NULL, '0d24a9fc76e4eefd0b7cda9a9fb9e3f1', NULL, NULL, '190.175.38.176', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(978, '2026-04-30 20:06:28', 'map_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(979, '2026-04-30 20:12:07', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(980, '2026-04-30 20:23:12', 'map_open', NULL, 'c2515b5f11ada31cabd7f03ec8f35e40', NULL, NULL, '179.41.5.40', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(981, '2026-04-30 20:38:52', 'map_open', NULL, '18ec00c2934a5228e7866b4a09477416', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(982, '2026-04-30 20:39:08', 'business_open', NULL, '18ec00c2934a5228e7866b4a09477416', 9160, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(983, '2026-04-30 20:39:20', 'business_open', NULL, '18ec00c2934a5228e7866b4a09477416', 9158, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(984, '2026-04-30 20:47:32', 'map_open', NULL, '18ec00c2934a5228e7866b4a09477416', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(985, '2026-04-30 20:50:50', 'map_open', 7, '18ec00c2934a5228e7866b4a09477416', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(986, '2026-04-30 21:21:19', 'map_open', NULL, '66a3841edb47c096458508bcceb1a5c5', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 13; SM-A226BR Build/TP1A.220624.014; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/147.0.7727.111 Mobile Safari/537.36'),
(987, '2026-04-30 21:25:19', 'map_open', NULL, '66a3841edb47c096458508bcceb1a5c5', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 13; SM-A226BR Build/TP1A.220624.014; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/147.0.7727.111 Mobile Safari/537.36'),
(988, '2026-04-30 21:52:30', 'map_open', NULL, 'f7e1298e5303132a90e3f743c0e5a2f7', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(989, '2026-04-30 22:03:57', 'map_open', NULL, '84dc0dd3d07de0cb21b9832a2cf622e4', NULL, NULL, '2802:8010:d0b4:e401:63d4:4236:614e:2d6b', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/29.0 Chrome/136.0.0.0 Mobile Safari/537.36'),
(990, '2026-04-30 23:40:27', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(991, '2026-04-30 23:41:21', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(992, '2026-04-30 23:43:03', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9162, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(993, '2026-04-30 23:52:46', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(994, '2026-04-30 23:52:53', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(995, '2026-04-30 23:53:08', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(996, '2026-04-30 23:55:51', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9162, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(997, '2026-04-30 23:56:46', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(998, '2026-04-30 23:57:20', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9157, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(999, '2026-04-30 23:57:40', 'directions_click', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9157, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1000, '2026-05-01 00:00:35', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1001, '2026-05-01 00:00:38', 'search', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, '{\"q\":\"san\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1002, '2026-05-01 00:00:51', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9157, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1003, '2026-05-01 00:01:13', 'search', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, '{\"q\":\"mar\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1004, '2026-05-01 00:01:16', 'search', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, '{\"q\":\"maria\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1005, '2026-05-01 00:01:22', 'search', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, '{\"q\":\"ma\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1006, '2026-05-01 00:01:24', 'search', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, '{\"q\":\"san\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1007, '2026-05-01 00:01:32', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9157, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1008, '2026-05-01 00:05:02', 'map_open', NULL, '594b298f2b15ae8c38b088eb7003fb60', NULL, NULL, '2803:68e0:213:3d00:98a7:fc40:b451:5262', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1009, '2026-05-01 00:11:49', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9157, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1010, '2026-05-01 00:12:49', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1011, '2026-05-01 00:12:55', 'map_open', NULL, '594b298f2b15ae8c38b088eb7003fb60', NULL, NULL, '2803:68e0:213:3d00:98a7:fc40:b451:5262', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1012, '2026-05-01 00:28:04', 'map_open', 11, '594b298f2b15ae8c38b088eb7003fb60', NULL, NULL, '2803:68e0:213:3d00:98a7:fc40:b451:5262', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1013, '2026-05-01 00:28:04', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1014, '2026-05-01 00:35:45', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9163, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1015, '2026-05-01 00:36:21', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9157, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1016, '2026-05-01 00:38:27', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9163, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1017, '2026-05-01 00:38:32', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9157, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1018, '2026-05-01 00:40:18', 'business_open', 11, '594b298f2b15ae8c38b088eb7003fb60', 5, NULL, '2803:68e0:213:3d00:98a7:fc40:b451:5262', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1019, '2026-05-01 00:40:27', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9157, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1020, '2026-05-01 00:41:12', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9157, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1021, '2026-05-01 00:41:15', 'business_open', 11, '594b298f2b15ae8c38b088eb7003fb60', 9163, NULL, '2803:68e0:213:3d00:98a7:fc40:b451:5262', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1022, '2026-05-01 00:45:50', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 5, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1023, '2026-05-01 00:46:09', 'business_open', 11, '594b298f2b15ae8c38b088eb7003fb60', 5, NULL, '2803:68e0:213:3d00:98a7:fc40:b451:5262', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1024, '2026-05-01 01:00:31', 'map_open', NULL, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1025, '2026-05-01 01:05:01', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1026, '2026-05-01 01:05:56', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1027, '2026-05-01 01:09:16', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1028, '2026-05-01 01:09:21', 'search', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, '{\"q\":\"encu\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1029, '2026-05-01 01:09:22', 'search', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, '{\"q\":\"en\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1030, '2026-05-01 01:09:24', 'search', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, '{\"q\":\"horar\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1031, '2026-05-01 01:09:26', 'search', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, '{\"q\":\"ho\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1032, '2026-05-01 01:12:41', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1033, '2026-05-01 01:12:45', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 1, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1034, '2026-05-01 01:12:52', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1035, '2026-05-01 01:13:00', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 1, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1036, '2026-05-01 01:23:41', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 1, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1037, '2026-05-01 01:24:09', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1038, '2026-05-01 01:27:26', 'map_open', NULL, '59a98a0dc3db9960e6c9183ef43bb0c0', NULL, NULL, '209.170.91.202', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.75 Safari/537.36'),
(1039, '2026-05-01 02:21:22', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1040, '2026-05-01 02:25:16', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1041, '2026-05-01 02:25:20', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 1, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1042, '2026-05-01 02:26:51', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1043, '2026-05-01 02:27:30', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1044, '2026-05-01 02:27:39', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 7, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1045, '2026-05-01 02:28:52', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 7, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1046, '2026-05-01 02:29:03', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 7, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1047, '2026-05-01 02:29:06', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 7, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1048, '2026-05-01 02:29:33', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9161, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1049, '2026-05-01 02:29:42', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 1, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1050, '2026-05-01 02:35:49', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1051, '2026-05-01 02:46:06', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1052, '2026-05-01 02:46:14', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 3, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1053, '2026-05-01 02:47:44', 'search', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, '{\"q\":\"cino\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1054, '2026-05-01 02:47:46', 'search', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, '{\"q\":\"cine\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1055, '2026-05-01 02:47:47', 'search', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, '{\"q\":\"ci\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1056, '2026-05-01 03:20:22', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1057, '2026-05-01 03:20:24', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1058, '2026-05-01 03:20:28', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1059, '2026-05-01 03:26:20', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1060, '2026-05-01 04:18:35', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1061, '2026-05-01 04:18:40', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9162, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1062, '2026-05-01 04:19:06', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1063, '2026-05-01 04:19:11', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9162, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1064, '2026-05-01 04:19:26', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9162, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1065, '2026-05-01 04:19:54', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1066, '2026-05-01 04:19:58', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 1, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1067, '2026-05-01 04:20:08', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9161, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1068, '2026-05-01 04:20:15', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1069, '2026-05-01 04:20:16', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9162, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1070, '2026-05-01 04:25:48', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1071, '2026-05-01 04:26:06', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1072, '2026-05-01 04:26:12', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9162, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36');
INSERT INTO `analytics_events` (`id`, `created_at`, `event_type`, `user_id`, `visitor_id`, `business_id`, `meta_json`, `ip`, `user_agent`) VALUES
(1073, '2026-05-01 04:27:10', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1074, '2026-05-01 04:27:18', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 5, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1075, '2026-05-01 04:27:27', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9164, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1076, '2026-05-01 04:30:13', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1077, '2026-05-01 04:30:24', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9164, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1078, '2026-05-01 04:34:17', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1079, '2026-05-01 04:34:24', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1080, '2026-05-01 04:34:36', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1081, '2026-05-01 04:34:43', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1082, '2026-05-01 04:34:50', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1083, '2026-05-01 04:34:54', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1084, '2026-05-01 04:35:13', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1085, '2026-05-01 04:36:59', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1086, '2026-05-01 04:37:11', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1087, '2026-05-01 04:37:14', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1088, '2026-05-01 04:37:37', 'brand_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1089, '2026-05-01 04:37:56', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1090, '2026-05-01 04:37:57', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9162, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1091, '2026-05-01 04:38:20', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1092, '2026-05-01 04:38:25', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 1, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1093, '2026-05-01 04:38:40', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 3, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1094, '2026-05-01 04:38:51', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 7, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1095, '2026-05-01 04:41:38', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1096, '2026-05-01 04:41:39', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9162, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1097, '2026-05-01 04:42:00', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1098, '2026-05-01 04:42:01', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9162, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1099, '2026-05-01 04:42:11', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 1, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1100, '2026-05-01 04:42:22', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 5, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1101, '2026-05-01 04:42:25', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 7, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1102, '2026-05-01 04:42:32', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 3, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1103, '2026-05-01 04:42:39', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 3, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1104, '2026-05-01 04:42:48', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9164, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1105, '2026-05-01 04:42:52', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9158, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1106, '2026-05-01 04:42:55', 'brand_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1107, '2026-05-01 04:43:21', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 3, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1108, '2026-05-01 04:43:53', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 5, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(1109, '2026-05-01 04:44:01', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 7, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(1110, '2026-05-01 04:44:07', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(1111, '2026-05-01 04:44:27', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(1112, '2026-05-01 04:44:31', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(1113, '2026-05-01 04:44:54', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(1114, '2026-05-01 04:44:58', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(1115, '2026-05-01 04:45:38', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(1116, '2026-05-01 04:45:44', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(1117, '2026-05-01 04:45:47', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(1118, '2026-05-01 04:45:57', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(1119, '2026-05-01 04:46:21', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(1120, '2026-05-01 04:49:06', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 3, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1121, '2026-05-01 04:56:54', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1122, '2026-05-01 04:57:02', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 1, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1123, '2026-05-01 05:01:55', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1124, '2026-05-01 05:01:59', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 1, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1125, '2026-05-01 05:02:38', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1126, '2026-05-01 05:02:42', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 1, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1127, '2026-05-01 05:03:13', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 3, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1128, '2026-05-01 05:03:34', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 7, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1129, '2026-05-01 05:03:55', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 7, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1130, '2026-05-01 05:04:20', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 7, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1131, '2026-05-01 05:04:29', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 5, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1132, '2026-05-01 05:04:33', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1133, '2026-05-01 05:04:39', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1134, '2026-05-01 05:04:42', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1135, '2026-05-01 05:04:52', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1136, '2026-05-01 05:05:40', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1137, '2026-05-01 05:05:46', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1138, '2026-05-01 05:05:52', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1139, '2026-05-01 05:05:55', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1140, '2026-05-01 05:06:35', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1141, '2026-05-01 05:06:40', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1142, '2026-05-01 05:07:42', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1143, '2026-05-01 05:07:54', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1144, '2026-05-01 05:07:56', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1145, '2026-05-01 05:07:59', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1146, '2026-05-01 05:08:11', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1147, '2026-05-01 05:09:53', 'map_open', NULL, '66a3841edb47c096458508bcceb1a5c5', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 13; SM-A226BR Build/TP1A.220624.014; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/147.0.7727.111 Mobile Safari/537.36'),
(1148, '2026-05-01 05:09:55', 'business_open', NULL, '66a3841edb47c096458508bcceb1a5c5', 9162, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 13; SM-A226BR Build/TP1A.220624.014; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/147.0.7727.111 Mobile Safari/537.36'),
(1149, '2026-05-01 05:10:15', 'business_open', NULL, '66a3841edb47c096458508bcceb1a5c5', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 13; SM-A226BR Build/TP1A.220624.014; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/147.0.7727.111 Mobile Safari/537.36'),
(1150, '2026-05-01 05:10:18', 'business_open', NULL, '66a3841edb47c096458508bcceb1a5c5', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 13; SM-A226BR Build/TP1A.220624.014; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/147.0.7727.111 Mobile Safari/537.36'),
(1151, '2026-05-01 05:10:51', 'map_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(1152, '2026-05-01 05:11:21', 'business_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(1153, '2026-05-01 05:11:28', 'business_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(1154, '2026-05-01 05:12:08', 'map_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(1155, '2026-05-01 05:12:38', 'business_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', 9153, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(1156, '2026-05-01 05:12:41', 'business_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(1157, '2026-05-01 05:13:00', 'business_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', 7, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(1158, '2026-05-01 05:15:29', 'map_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(1159, '2026-05-01 05:15:30', 'map_open', NULL, '0625fc06335d1ae10c96cc4cc85e3efd', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(1160, '2026-05-01 12:38:42', 'map_open', NULL, 'c1de2a1c7689af22332ffc01a42f71bc', NULL, NULL, '181.105.137.31', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(1161, '2026-05-01 12:46:00', 'map_open', NULL, 'c1de2a1c7689af22332ffc01a42f71bc', NULL, NULL, '181.105.137.31', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(1162, '2026-05-01 17:08:21', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '2803:9800:9888:bbee:b111:f2ce:4fdc:111d', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1163, '2026-05-01 17:08:51', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '2803:9800:9888:bbee:b111:f2ce:4fdc:111d', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1164, '2026-05-01 17:11:12', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 7, NULL, '2803:9800:9888:bbee:b111:f2ce:4fdc:111d', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1165, '2026-05-01 17:12:14', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 5, NULL, '2803:9800:9888:bbee:b111:f2ce:4fdc:111d', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1166, '2026-05-01 17:13:18', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 7, NULL, '2803:9800:9888:bbee:b111:f2ce:4fdc:111d', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1167, '2026-05-01 17:13:56', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 1, NULL, '2803:9800:9888:bbee:b111:f2ce:4fdc:111d', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1168, '2026-05-01 17:14:41', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 1, NULL, '2803:9800:9888:bbee:b111:f2ce:4fdc:111d', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1169, '2026-05-01 17:15:05', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 3, NULL, '2803:9800:9888:bbee:b111:f2ce:4fdc:111d', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1170, '2026-05-01 17:17:12', 'filter_change', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, '{\"tipo\":\"restaurante\",\"q\":\"\"}', '2803:9800:9888:bbee:b111:f2ce:4fdc:111d', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1171, '2026-05-01 17:18:25', 'filter_change', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, '{\"tipo\":\"\",\"q\":\"\"}', '2803:9800:9888:bbee:b111:f2ce:4fdc:111d', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1172, '2026-05-01 17:26:58', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '2803:9800:9888:bbee:b111:f2ce:4fdc:111d', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1173, '2026-05-01 17:27:11', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 9164, NULL, '2803:9800:9888:bbee:b111:f2ce:4fdc:111d', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1174, '2026-05-01 17:27:53', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '2803:9800:9888:bbee:b111:f2ce:4fdc:111d', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1175, '2026-05-01 17:34:59', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '2803:9800:9888:bbee:b111:f2ce:4fdc:111d', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1176, '2026-05-01 18:06:32', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '2803:9800:9888:bbee:249b:7b62:a1fe:7389', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1177, '2026-05-01 18:24:56', 'map_open', NULL, 'fdcb0b441b6406b4fa2839299c89137d', NULL, NULL, '181.9.206.193', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(1178, '2026-05-01 19:16:59', 'map_open', NULL, '489d79454f7da5b8d57505c19481268f', NULL, NULL, '190.16.133.183', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(1179, '2026-05-01 19:59:44', 'map_open', NULL, '18ec00c2934a5228e7866b4a09477416', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(1180, '2026-05-01 20:00:05', 'business_open', NULL, '18ec00c2934a5228e7866b4a09477416', 3, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(1181, '2026-05-01 20:01:09', 'brand_open', NULL, '18ec00c2934a5228e7866b4a09477416', 7, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(1182, '2026-05-01 20:01:17', 'brand_open', NULL, '18ec00c2934a5228e7866b4a09477416', 7, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(1183, '2026-05-01 20:01:28', 'brand_open', NULL, '18ec00c2934a5228e7866b4a09477416', 7, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(1184, '2026-05-01 20:01:30', 'business_open', NULL, '18ec00c2934a5228e7866b4a09477416', 9164, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(1185, '2026-05-01 20:01:39', 'business_open', NULL, '18ec00c2934a5228e7866b4a09477416', 9164, NULL, '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(1186, '2026-05-01 20:36:22', 'map_open', NULL, '1a23bdce895e0a59983e0b216a906b1d', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1187, '2026-05-01 20:38:12', 'business_open', NULL, '1a23bdce895e0a59983e0b216a906b1d', 3, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1188, '2026-05-01 22:34:21', 'map_open', NULL, 'f6f3710e9e84b79e12d814227e9cdcb5', NULL, NULL, '190.139.199.204', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.4 Mobile/15E148 Safari/604.1'),
(1189, '2026-05-02 00:43:41', 'map_open', NULL, 'cf33b6516a00163d12ebcdf1a76863d2', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 AVG/146.0.34394.179'),
(1190, '2026-05-02 13:56:09', 'map_open', NULL, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1191, '2026-05-02 13:56:17', 'business_open', NULL, '67670c2421f4da3bdde95e7d5c2e6d27', 7, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1192, '2026-05-02 13:56:39', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1193, '2026-05-02 13:56:45', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 7, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1194, '2026-05-02 14:09:36', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1195, '2026-05-02 14:25:24', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1196, '2026-05-02 14:25:47', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1197, '2026-05-02 14:25:57', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 7, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1198, '2026-05-02 14:29:25', 'map_open', NULL, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1199, '2026-05-02 14:29:30', 'business_open', NULL, '67670c2421f4da3bdde95e7d5c2e6d27', 7, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1200, '2026-05-02 14:32:02', 'business_open', NULL, '67670c2421f4da3bdde95e7d5c2e6d27', 1, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1201, '2026-05-02 14:36:39', 'business_open', NULL, '67670c2421f4da3bdde95e7d5c2e6d27', 1, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1202, '2026-05-02 14:44:46', 'map_open', NULL, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1203, '2026-05-02 14:44:48', 'business_open', NULL, '67670c2421f4da3bdde95e7d5c2e6d27', 7, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1204, '2026-05-02 14:48:19', 'business_open', NULL, '67670c2421f4da3bdde95e7d5c2e6d27', 1, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1205, '2026-05-02 14:54:28', 'map_open', NULL, '1a23bdce895e0a59983e0b216a906b1d', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1206, '2026-05-02 14:55:02', 'map_open', NULL, '1a23bdce895e0a59983e0b216a906b1d', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1207, '2026-05-02 14:55:28', 'map_open', 7, '1a23bdce895e0a59983e0b216a906b1d', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1208, '2026-05-02 14:56:14', 'map_open', NULL, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1209, '2026-05-02 14:56:52', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1210, '2026-05-02 15:01:46', 'map_open', NULL, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1211, '2026-05-02 15:06:41', 'map_open', NULL, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1212, '2026-05-02 15:07:03', 'map_open', NULL, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1213, '2026-05-02 15:09:15', 'map_open', NULL, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1214, '2026-05-02 15:11:11', 'map_open', NULL, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1215, '2026-05-02 15:12:36', 'map_open', NULL, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1216, '2026-05-02 15:18:17', 'map_open', 7, '1a23bdce895e0a59983e0b216a906b1d', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1217, '2026-05-02 15:19:14', 'business_open', NULL, '67670c2421f4da3bdde95e7d5c2e6d27', 5, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1218, '2026-05-02 15:19:20', 'business_open', NULL, '67670c2421f4da3bdde95e7d5c2e6d27', 7, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1219, '2026-05-02 15:24:41', 'business_open', NULL, '67670c2421f4da3bdde95e7d5c2e6d27', 7, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1220, '2026-05-02 15:25:26', 'business_open', NULL, '67670c2421f4da3bdde95e7d5c2e6d27', 7, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1221, '2026-05-02 15:26:34', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1222, '2026-05-02 15:30:51', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1223, '2026-05-02 15:32:04', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1224, '2026-05-02 15:32:05', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 8, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1225, '2026-05-02 15:33:12', 'map_open', 7, '1a23bdce895e0a59983e0b216a906b1d', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1226, '2026-05-02 15:33:20', 'business_open', 7, '1a23bdce895e0a59983e0b216a906b1d', 8, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1227, '2026-05-02 15:52:54', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1228, '2026-05-02 15:52:56', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 8, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1229, '2026-05-02 15:53:12', 'map_open', 7, '1a23bdce895e0a59983e0b216a906b1d', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1230, '2026-05-02 15:55:15', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1231, '2026-05-02 15:55:19', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 8, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1232, '2026-05-02 15:55:30', 'map_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1233, '2026-05-02 15:55:52', 'business_open', 5, '67670c2421f4da3bdde95e7d5c2e6d27', 8, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1234, '2026-05-02 15:58:56', 'map_open', NULL, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1235, '2026-05-02 15:58:58', 'business_open', NULL, '67670c2421f4da3bdde95e7d5c2e6d27', 8, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(1236, '2026-05-02 15:59:10', 'map_open', NULL, '67670c2421f4da3bdde95e7d5c2e6d27', NULL, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `articulos`
--

CREATE TABLE `articulos` (
  `id` int(11) NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `contenido` longtext NOT NULL,
  `resumen` text DEFAULT NULL,
  `imagen_portada` varchar(255) DEFAULT NULL,
  `autor_id` int(11) DEFAULT NULL,
  `categoria` varchar(100) DEFAULT NULL,
  `fecha_publicacion` datetime DEFAULT NULL,
  `publicado` tinyint(1) DEFAULT 1,
  `vistas` int(11) DEFAULT 0,
  `tags` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `attachments`
--

CREATE TABLE `attachments` (
  `id` int(11) NOT NULL,
  `business_id` int(11) DEFAULT NULL,
  `brand_id` int(11) DEFAULT NULL,
  `file_path` varchar(255) NOT NULL,
  `type` enum('photo','document','logo') DEFAULT 'photo',
  `uploaded_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `audit_log`
--

CREATE TABLE `audit_log` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `username` varchar(100) DEFAULT NULL,
  `action` varchar(60) NOT NULL COMMENT 'create|update|delete|login|logout|resolve_report|...',
  `entity_type` varchar(40) DEFAULT NULL,
  `entity_id` int(11) DEFAULT NULL,
  `details` text DEFAULT NULL COMMENT 'JSON con datos adicionales',
  `ip` varchar(45) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `audit_log`
--

INSERT INTO `audit_log` (`id`, `user_id`, `username`, `action`, `entity_type`, `entity_id`, `details`, `ip`, `user_agent`, `created_at`) VALUES
(1, 5, 'Pablo_Farias', 'login', 'user', 5, '{\"username\":\"Pablo_Farias\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-21 18:19:16'),
(2, 5, 'Pablo_Farias', 'login', 'user', 5, '{\"username\":\"Pablo_Farias\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-22 18:13:38'),
(3, 5, 'Pablo_Farias', 'login', 'user', 5, '{\"username\":\"Pablo_Farias\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-23 22:22:09'),
(4, 5, 'Pablo_Farias', 'login', 'user', 5, '{\"username\":\"Pablo_Farias\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-24 15:54:51'),
(5, 5, 'Pablo_Farias', 'login', 'user', 5, '{\"username\":\"Pablo_Farias\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-24 18:43:46'),
(6, 5, 'Pablo_Farias', 'login', 'user', 5, '{\"username\":\"Pablo_Farias\"}', '181.9.226.160', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '2026-04-24 21:33:07'),
(7, 5, 'Pablo_Farias', 'logout', 'user', 5, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-25 02:49:09'),
(8, 5, 'Pablo_Farias', 'login', 'user', 5, '{\"username\":\"Pablo_Farias\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-25 02:49:30'),
(9, 5, 'Pablo_Farias', 'toggle_consulta_habilitada', 'business', 9150, '{\"consulta_habilitada\":1}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-25 02:49:52'),
(10, 5, 'Pablo_Farias', 'toggle_consulta_siempre', 'business', 9150, '{\"consulta_siempre\":1}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-25 02:49:55'),
(11, 5, 'Pablo_Farias', 'login', 'user', 5, '{\"username\":\"Pablo_Farias\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-25 12:35:38'),
(12, 5, 'Pablo_Farias', 'login', 'user', 5, '{\"username\":\"Pablo_Farias\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-25 17:30:01'),
(13, 5, 'Pablo_Farias', 'toggle_consulta_habilitada', 'business', 9151, '{\"consulta_habilitada\":1}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-26 16:01:56'),
(14, 5, 'Pablo_Farias', 'toggle_consulta_siempre', 'business', 9151, '{\"consulta_siempre\":1}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-26 16:02:04'),
(15, 5, 'Pablo_Farias', 'toggle_consulta_habilitada', 'business', 9153, '{\"consulta_habilitada\":1}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-26 20:31:48'),
(16, 5, 'Pablo_Farias', 'toggle_consulta_siempre', 'business', 9153, '{\"consulta_siempre\":1}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-26 20:31:49'),
(17, 5, 'Pablo_Farias', 'consulta_send', 'consulta_masiva', 1, '{\"tipo\":\"general\",\"dest\":1,\"rubro\":null,\"biz_type\":\"inmobiliaria\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-27 00:00:51'),
(18, 5, 'Pablo_Farias', 'consulta_send', 'consulta_masiva', 2, '{\"tipo\":\"general\",\"dest\":1,\"rubro\":null,\"biz_type\":null}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-27 19:24:02'),
(19, 5, 'Pablo_Farias', 'close_consulta', 'consulta_masiva', 2, '{\"status\":\"closed\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-27 19:24:15'),
(20, 5, 'Pablo_Farias', 'consulta_send', 'consulta_masiva', 3, '{\"tipo\":\"masiva\",\"dest\":1,\"rubro\":null,\"biz_type\":null}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-27 19:25:06'),
(21, 5, 'Pablo_Farias', 'close_consulta', 'consulta_masiva', 3, '{\"status\":\"closed\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-27 19:25:11'),
(22, 7, 'Celeste_Ortiz_22', 'login', 'user', 7, '{\"username\":\"Celeste_Ortiz_22\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-28 21:43:16'),
(23, 5, 'Pablo_Farias', 'consulta_send', 'consulta_masiva', 4, '{\"tipo\":\"general\",\"dest\":1,\"rubro\":null,\"biz_type\":null}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-28 21:48:10'),
(24, 5, 'Pablo_Farias', 'close_consulta', 'consulta_masiva', 4, '{\"status\":\"closed\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-28 21:48:27'),
(25, 5, 'Pablo_Farias', 'logout', 'user', 5, NULL, '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-28 23:47:43'),
(26, 5, 'Pablo_Farias', 'login', 'user', 5, '{\"username\":\"Pablo_Farias\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-29 00:08:33'),
(27, 5, 'Pablo_Farias', 'login', 'user', 5, '{\"username\":\"Pablo_Farias\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-29 00:21:43'),
(28, 5, 'Pablo_Farias', 'login', 'user', 5, '{\"username\":\"Pablo_Farias\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-29 09:58:27'),
(29, 7, 'Celeste_Ortiz_22', 'login', 'user', 7, '{\"username\":\"Celeste_Ortiz_22\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-29 17:03:51'),
(30, 8, 'GoldfarbHabasyAsociados', 'login', 'user', 8, '{\"username\":\"GoldfarbHabasyAsociados\"}', '190.210.36.18', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-29 17:35:22'),
(31, 8, 'GoldfarbHabasyAsociados', 'review_upsert', 'review', NULL, '{\"business_id\":9162}', '2800:40:76:b6ce:d0a0:e727:6f3:9f28', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-29 18:48:41'),
(32, 5, 'Pablo_Farias', 'toggle_consulta_habilitada', 'business', 9162, '{\"consulta_habilitada\":1}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-29 19:52:10'),
(33, 5, 'Pablo_Farias', 'login', 'user', 5, '{\"username\":\"Pablo_Farias\"}', '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '2026-04-30 02:51:53'),
(34, 10, 'Luisvillegas', 'login', 'user', 10, '{\"username\":\"Luisvillegas\"}', '2803:9800:9881:b4ba:45e3:9fe3:8cd2:c857', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '2026-04-30 04:16:24'),
(35, 5, 'Pablo_Farias', 'login', 'user', 5, '{\"username\":\"Pablo_Farias\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-30 12:36:50'),
(36, 7, 'Celeste_Ortiz_22', 'login', 'user', 7, '{\"username\":\"Celeste_Ortiz_22\"}', '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36', '2026-04-30 20:47:42'),
(37, 7, 'Celeste_Ortiz_22', 'login', 'user', 7, '{\"username\":\"Celeste_Ortiz_22\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-30 22:45:12'),
(38, 11, 'MIGUEL', 'login', 'user', 11, '{\"username\":\"MIGUEL\"}', '2803:68e0:213:3d00:98a7:fc40:b451:5262', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-05-01 00:13:16'),
(39, 5, 'Pablo_Farias', 'consulta_send', 'consulta_masiva', 5, '{\"tipo\":\"masiva\",\"dest\":2,\"rubro\":null,\"biz_type\":null}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-05-01 00:37:12'),
(40, 5, 'Pablo_Farias', 'login', 'user', 5, '{\"username\":\"Pablo_Farias\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-05-01 01:00:38'),
(41, 5, 'Pablo_Farias', 'login', 'user', 5, '{\"username\":\"Pablo_Farias\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-05-02 13:56:27'),
(42, 7, 'Celeste_Ortiz_22', 'login', 'user', 7, '{\"username\":\"Celeste_Ortiz_22\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-05-02 14:55:23'),
(43, 5, 'Pablo_Farias', 'login', 'user', 5, '{\"username\":\"Pablo_Farias\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-05-02 14:56:49'),
(44, 5, 'Pablo_Farias', 'login', 'user', 5, '{\"username\":\"Pablo_Farias\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-05-02 15:25:39'),
(45, 5, 'Pablo_Farias', 'login', 'user', 5, '{\"username\":\"Pablo_Farias\"}', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-05-02 15:26:56');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `brands`
--

CREATE TABLE `brands` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `nombre` varchar(255) NOT NULL,
  `clase_principal` varchar(50) DEFAULT NULL,
  `clases_complementarias` varchar(255) DEFAULT NULL COMMENT 'Clases Niza complementarias (ej: "9,35,42")',
  `riesgo_colision` text DEFAULT NULL COMMENT 'Riesgo de colisión con marcas registradas en cada clase',
  `rubro` varchar(255) DEFAULT NULL,
  `lat` decimal(10,8) DEFAULT NULL,
  `lng` decimal(11,8) DEFAULT NULL,
  `website` varchar(500) DEFAULT NULL,
  `nivel_proteccion` varchar(50) DEFAULT NULL,
  `distintividad` varchar(10) DEFAULT NULL COMMENT 'ALTA | MEDIA | BAJA — grado de distintividad del signo',
  `riesgo_confusion` text DEFAULT NULL COMMENT 'Descripción del riesgo de confusión con marcas existentes',
  `conflictos_clases` text DEFAULT NULL COMMENT 'Conflictos potenciales en clases Niza relevantes',
  `expansion_internacional` text DEFAULT NULL COMMENT 'Posibilidades y estrategia de expansión internacional',
  `riesgo_oposicion` varchar(100) DEFAULT NULL,
  `riesgo_nulidad` text DEFAULT NULL COMMENT 'Riesgo de nulidad absoluta o relativa del registro',
  `riesgo_infraccion` text DEFAULT NULL COMMENT 'Riesgo de infracción o uso no autorizado por terceros',
  `estrategias_defensivas` text DEFAULT NULL COMMENT 'Estrategias defensivas y plan de vigilancia marcaria',
  `valor_activo` varchar(50) DEFAULT NULL,
  `fuentes_ingresos` text DEFAULT NULL COMMENT 'Fuentes de ingresos actuales y futuras de la marca',
  `escalabilidad` varchar(100) DEFAULT NULL COMMENT 'Evaluación de la escalabilidad del modelo de negocio',
  `margen_potencial` varchar(100) DEFAULT NULL COMMENT 'Estimación del margen potencial por canal de monetización',
  `tiene_zona` tinyint(1) DEFAULT 0,
  `zona_radius_km` int(11) DEFAULT 10,
  `tiene_licencia` tinyint(1) DEFAULT 0,
  `licencia_detalle` varchar(255) DEFAULT NULL,
  `es_franquicia` tinyint(1) DEFAULT 0,
  `franchise_details` varchar(500) DEFAULT NULL,
  `zona_exclusiva` tinyint(1) DEFAULT 0,
  `zona_exclusiva_radius_km` int(11) DEFAULT 2,
  `scope` varchar(255) DEFAULT NULL,
  `channels` varchar(255) DEFAULT NULL,
  `annual_revenue` varchar(50) DEFAULT NULL,
  `founded_year` int(11) DEFAULT NULL,
  `extended_description` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `visible` tinyint(1) DEFAULT 1,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `ubicacion` varchar(255) DEFAULT 'Argentina',
  `estado` varchar(50) DEFAULT 'Activa',
  `inpi_registrada` tinyint(1) NOT NULL DEFAULT 0,
  `inpi_numero` varchar(100) DEFAULT NULL,
  `inpi_fecha_registro` date DEFAULT NULL,
  `inpi_vencimiento` date DEFAULT NULL,
  `inpi_clases_registradas` varchar(255) DEFAULT NULL,
  `inpi_tipo` varchar(100) DEFAULT NULL,
  `historia_marca` longtext DEFAULT NULL,
  `target_audience` text DEFAULT NULL,
  `propuesta_valor` text DEFAULT NULL,
  `instagram` varchar(255) DEFAULT NULL,
  `facebook` varchar(255) DEFAULT NULL,
  `tiktok` varchar(255) DEFAULT NULL,
  `twitter` varchar(255) DEFAULT NULL,
  `linkedin` varchar(255) DEFAULT NULL,
  `youtube` varchar(255) DEFAULT NULL,
  `whatsapp` varchar(50) DEFAULT NULL,
  `logo_url` varchar(255) DEFAULT NULL COMMENT 'Ruta pública del logo del mapa',
  `mapita_id` varchar(64) DEFAULT NULL,
  `country_code` char(2) DEFAULT NULL COMMENT 'ISO 3166-1 alpha-2 del país de registro',
  `language_code` char(5) DEFAULT NULL COMMENT 'BCP 47 del idioma principal de la marca',
  `currency_code` char(3) DEFAULT NULL COMMENT 'Moneda del valor_activo (ISO 4217)',
  `registry_authority` varchar(50) DEFAULT NULL COMMENT 'Organismo registrador: INPI, USPTO, EUIPO, JPO…',
  `registry_number` varchar(100) DEFAULT NULL COMMENT 'Número de expediente genérico',
  `registry_date` date DEFAULT NULL COMMENT 'Fecha de registro (genérico)',
  `registry_expiry` date DEFAULT NULL COMMENT 'Fecha de vencimiento (genérico)',
  `registry_type` varchar(20) DEFAULT NULL COMMENT 'national|madrid_protocol|eu_trademark|us_federal',
  `crear_franquicia` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1 = la marca ofrece franquicias (habilita panel Franquicias)',
  `franquicia_descripcion` text DEFAULT NULL COMMENT 'Texto explicativo de la franquicia',
  `franquicia_condiciones` text DEFAULT NULL COMMENT 'Condiciones generales de la franquicia',
  `franquicia_exclusividad` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1 = con exclusividad territorial',
  `franquicia_territorio` text DEFAULT NULL COMMENT 'Ámbito territorial de la franquicia',
  `franquicia_productos` text DEFAULT NULL COMMENT 'Productos o servicios incluidos en la franquicia',
  `franquicia_garantias` text DEFAULT NULL COMMENT 'Garantías ofrecidas al franquiciado',
  `franquicia_url` varchar(500) DEFAULT NULL COMMENT 'URL con más información sobre la franquicia'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `brands`
--

INSERT INTO `brands` (`id`, `user_id`, `nombre`, `clase_principal`, `clases_complementarias`, `riesgo_colision`, `rubro`, `lat`, `lng`, `website`, `nivel_proteccion`, `distintividad`, `riesgo_confusion`, `conflictos_clases`, `expansion_internacional`, `riesgo_oposicion`, `riesgo_nulidad`, `riesgo_infraccion`, `estrategias_defensivas`, `valor_activo`, `fuentes_ingresos`, `escalabilidad`, `margen_potencial`, `tiene_zona`, `zona_radius_km`, `tiene_licencia`, `licencia_detalle`, `es_franquicia`, `franchise_details`, `zona_exclusiva`, `zona_exclusiva_radius_km`, `scope`, `channels`, `annual_revenue`, `founded_year`, `extended_description`, `description`, `visible`, `created_at`, `updated_at`, `ubicacion`, `estado`, `inpi_registrada`, `inpi_numero`, `inpi_fecha_registro`, `inpi_vencimiento`, `inpi_clases_registradas`, `inpi_tipo`, `historia_marca`, `target_audience`, `propuesta_valor`, `instagram`, `facebook`, `tiktok`, `twitter`, `linkedin`, `youtube`, `whatsapp`, `logo_url`, `mapita_id`, `country_code`, `language_code`, `currency_code`, `registry_authority`, `registry_number`, `registry_date`, `registry_expiry`, `registry_type`, `crear_franquicia`, `franquicia_descripcion`, `franquicia_condiciones`, `franquicia_exclusividad`, `franquicia_territorio`, `franquicia_productos`, `franquicia_garantias`, `franquicia_url`) VALUES
(6, 5, 'LOS MIRLOS DE JORGE RODRIGUEZ GRANDEZ', '41', NULL, NULL, 'Servicios musicales, actividad cultural', -12.03054200, -77.05242300, NULL, 'Internacional', NULL, NULL, NULL, NULL, 'Muy Bajo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 10, 0, NULL, 0, NULL, 0, 2, 'nacional,internacional', 'ecommerce,redes_sociales', '5m+', 1974, NULL, '“LOS MIRLOS” constituye una marca notoriamente conocida, con explotación continua, registro vigente desde 1996 (renovado en 2021) y reconocimiento nacional e internacional.', 1, '2026-04-27 21:51:27', '2026-04-29 01:10:13', 'La Victoria 135 - San Martin de Porres', 'Activa', 1, '3280127', '2022-04-29', '2031-04-20', '41', 'Denominativa', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(7, 5, 'KAMALI. ESPIRITU GUIA. TU LUGAR HOLISTICO.', '45', NULL, NULL, 'Servicios prestados por terceros', -31.39247200, -64.18799400, NULL, 'Registrada', NULL, NULL, NULL, NULL, 'Muy Bajo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 10, 0, NULL, 0, NULL, 0, 2, 'nacional', NULL, NULL, 2019, NULL, NULL, 1, '2026-04-29 10:12:56', '2026-04-29 10:12:56', NULL, 'Activa', 1, '3014012', '2019-09-04', '2029-09-10', NULL, 'Denominativa', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(8, 5, 'CONTACTAR SALUD', '44', NULL, NULL, 'Servicios médicos; servicios veterinarios; tratamientos de higiene y de belleza para personas o animales', -23.83275300, -64.78791900, NULL, 'Registrada', NULL, NULL, NULL, NULL, 'Muy Bajo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 10, 0, NULL, 0, NULL, 0, 2, 'nacional', NULL, NULL, 2019, NULL, NULL, 1, '2026-04-29 10:18:56', '2026-04-29 10:21:18', NULL, 'Activa', 1, '3014030', '2019-09-10', '2029-09-10', NULL, 'Mixta', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL),
(9, 5, 'DANUCCI', '30', NULL, NULL, 'Helados, alimentos', -31.35917800, -64.20951700, NULL, 'Registrada', NULL, NULL, NULL, NULL, 'Muy Bajo', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 10, 0, NULL, 0, NULL, 0, 2, 'nacional', NULL, NULL, 2019, NULL, NULL, 1, '2026-04-29 10:28:50', '2026-04-29 10:29:05', NULL, 'Activa', 1, '3031233', '2019-10-08', '2029-10-08', NULL, 'Mixta', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `brand_delegations`
--

CREATE TABLE `brand_delegations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `brand_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `role` enum('admin') NOT NULL DEFAULT 'admin',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `brand_gallery`
--

CREATE TABLE `brand_gallery` (
  `id` int(11) NOT NULL,
  `brand_id` int(11) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `titulo` varchar(255) DEFAULT NULL,
  `es_principal` tinyint(1) NOT NULL DEFAULT 0,
  `type` enum('photo','logo','document') DEFAULT 'photo',
  `uploaded_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `orden` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `brand_gallery`
--

INSERT INTO `brand_gallery` (`id`, `brand_id`, `file_path`, `filename`, `titulo`, `es_principal`, `type`, `uploaded_at`, `orden`, `created_at`) VALUES
(1, 6, '', 'brand_6_1777338561_1564.png', 'los mirlos_mini.png', 1, 'photo', '2026-04-28 01:09:21', 0, '2026-04-28 01:09:21');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `brand_gallery_v2`
--

CREATE TABLE `brand_gallery_v2` (
  `id` int(11) NOT NULL,
  `brand_id` int(11) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `titulo` varchar(255) DEFAULT NULL,
  `es_principal` tinyint(1) NOT NULL DEFAULT 0,
  `orden` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `businesses`
--

CREATE TABLE `businesses` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `lat` decimal(10,6) DEFAULT NULL,
  `lng` decimal(10,6) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `instagram` varchar(100) DEFAULT NULL,
  `facebook` varchar(100) DEFAULT NULL,
  `tiktok` varchar(100) DEFAULT NULL,
  `certifications` text DEFAULT NULL,
  `has_delivery` tinyint(1) DEFAULT 0,
  `has_card_payment` tinyint(1) DEFAULT 0,
  `is_franchise` tinyint(1) DEFAULT 0,
  `verified` tinyint(1) DEFAULT 0,
  `business_type` varchar(50) DEFAULT NULL,
  `visible` tinyint(1) NOT NULL DEFAULT 1,
  `status` enum('active','inactive','pending') DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `price_range` int(1) DEFAULT NULL COMMENT 'Rango de precio: 1-5 (económico a caro)',
  `description` text DEFAULT NULL,
  `subcategory_id` int(11) DEFAULT NULL,
  `company_size` enum('familiar','pyme','grande','multinacional') DEFAULT NULL,
  `location_city` varchar(50) DEFAULT NULL,
  `style` varchar(100) DEFAULT NULL,
  `mapita_id` varchar(64) DEFAULT NULL,
  `oferta_activa_id` int(10) UNSIGNED DEFAULT NULL,
  `disponibles_activo` tinyint(1) NOT NULL DEFAULT 0,
  `job_offer_active` tinyint(1) NOT NULL DEFAULT 0,
  `job_offer_position` varchar(255) DEFAULT NULL,
  `job_offer_description` text DEFAULT NULL,
  `job_offer_url` varchar(500) DEFAULT NULL COMMENT 'Link externo opcional',
  `og_image_url` varchar(255) DEFAULT NULL COMMENT 'URL pública de la imagen Open Graph del negocio',
  `es_proveedor` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1 = negocio marcado como Proveedor (P); solo negocios comerciales/industriales',
  `consulta_habilitada` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Admin designa: 1 = habilitado para recibir CONSULTA GENERAL (servicios especiales)',
  `consulta_siempre` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Admin: 1 = este negocio siempre entra en Consulta Masiva dentro del área',
  `proveedor_siempre` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Admin: 1 = este negocio P siempre entra en Consulta Global Proveedores',
  `timezone` varchar(64) NOT NULL DEFAULT 'America/Argentina/Buenos_Aires',
  `country_code` char(2) DEFAULT NULL COMMENT 'ISO 3166-1 alpha-2 (AR, US, DE…)',
  `language_code` char(5) DEFAULT NULL COMMENT 'BCP 47 (es-AR, en-US, ja-JP…)',
  `currency_code` char(3) DEFAULT NULL COMMENT 'ISO 4217 (ARS, USD, EUR, JPY…)',
  `phone_country_code` varchar(6) DEFAULT NULL COMMENT 'Prefijo internacional (+54, +1, +81…)',
  `address_format` varchar(20) DEFAULT NULL COMMENT 'Perfil de formato de dirección: ar|us|jp|eu',
  `oda_descripcion_proyecto` text DEFAULT NULL COMMENT 'Descripcion del proyecto (obra_de_arte)',
  `oda_requisitos` text DEFAULT NULL COMMENT 'Requisitos para participar (obra_de_arte)',
  `oda_roles_buscados` text DEFAULT NULL COMMENT 'JSON array de roles que busca (obra_de_arte)',
  `encuestas_override` enum('heredar','habilitada','deshabilitada') NOT NULL DEFAULT 'heredar' COMMENT 'Override de permiso de encuestas: heredar de industria, o forzar habilitada/deshabilitada',
  `ofertas_permitidas` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1 = el negocio puede publicar sus propias ofertas; 0 = solo admin',
  `ofertas_max` int(11) NOT NULL DEFAULT 0 COMMENT 'Máximo de ofertas activas permitidas (0 = sin límite, solo aplica si ofertas_permitidas=1)',
  `images_max` int(11) DEFAULT NULL COMMENT 'Override: máx imágenes de galería. NULL = usar default por tipo o global (2)',
  `visibility_min_zoom` tinyint(3) UNSIGNED DEFAULT 12 COMMENT 'Zoom mínimo del mapa para que este negocio sea visible. NULL = usar default del tipo.',
  `is_premium` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1 = negocio premium: visible desde zoom bajo (ej. 3)',
  `inmuebles_max` int(11) DEFAULT NULL COMMENT 'Override: máx inmuebles activos. NULL = usar default por tipo o global (10)',
  `inmuebles_destacado` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1 = inmobiliaria destacada: mayor visibilidad en CERCA',
  `influence_zones` text DEFAULT NULL COMMENT 'Zonas de influencia (barrios/zonas atendidas). Uso: inmobiliarias. Texto separado por comas.',
  `transport_subtype` enum('envios','pasajeros','carga') DEFAULT NULL COMMENT 'Subtipo de transporte: envios, pasajeros o carga. Solo para negocios de tipo transporte.',
  `noticias_override` enum('heredar','habilitada','deshabilitada') NOT NULL DEFAULT 'heredar' COMMENT 'Override de permiso de noticias: heredar de industria, o forzar habilitada/deshabilitada',
  `eventos_override` enum('heredar','habilitada','deshabilitada') NOT NULL DEFAULT 'heredar' COMMENT 'Override de permiso de eventos: heredar de industria, o forzar habilitada/deshabilitada'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `businesses`
--

INSERT INTO `businesses` (`id`, `user_id`, `name`, `address`, `lat`, `lng`, `phone`, `email`, `website`, `instagram`, `facebook`, `tiktok`, `certifications`, `has_delivery`, `has_card_payment`, `is_franchise`, `verified`, `business_type`, `visible`, `status`, `created_at`, `updated_at`, `price_range`, `description`, `subcategory_id`, `company_size`, `location_city`, `style`, `mapita_id`, `oferta_activa_id`, `disponibles_activo`, `job_offer_active`, `job_offer_position`, `job_offer_description`, `job_offer_url`, `og_image_url`, `es_proveedor`, `consulta_habilitada`, `consulta_siempre`, `proveedor_siempre`, `timezone`, `country_code`, `language_code`, `currency_code`, `phone_country_code`, `address_format`, `oda_descripcion_proyecto`, `oda_requisitos`, `oda_roles_buscados`, `encuestas_override`, `ofertas_permitidas`, `ofertas_max`, `images_max`, `visibility_min_zoom`, `is_premium`, `inmuebles_max`, `inmuebles_destacado`, `influence_zones`, `transport_subtype`, `noticias_override`, `eventos_override`) VALUES
(9153, 5, 'MARIA CELESTE ORTIZ', '6 de Agosto 331, Cba Cap, CP 5000', -31.371452, -64.178822, '+549-11-1566311985', 'propiedades@mariacelesteortiz.com.ar', 'https://www.mariacelesteortiz.com.ar', NULL, NULL, NULL, 'Estacionamiento, Acceso universal, Reservas online, Factura fiscal, Mercado Pago | Estacionamiento, Acceso universal, Reservas online, Factura fiscal, Mercado Pago', 0, 0, 0, 0, 'inmobiliaria', 1, 'active', '2026-04-26 20:18:24', '2026-05-01 05:05:34', 3, 'Con más de 15 años de experiencia en el mercado inmobiliario, María Celeste Ortiz se destaca como una de las principales tasadoras y administradoras en el país.\r\n\r\nEspecializada en la valuación de inmuebles, administración de propiedades, fideicomisos, y activos intangibles, María Celeste ha desarrollado numerosos proyectos que han sido muy favorables para el sector inmobiliario en Argentina, resolviendo distintas cuestiones de análisis, valoración y determinación de activos para negocios.\r\n\r\nSu capacidad resolutiva y enfoque personalizado garantizan soluciones adaptadas a las necesidades de cada cliente, logrando acuerdos y documentos técnicamente prolijos y eficientes.', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, 0, 1, 1, 0, 'America/Argentina/Buenos_Aires', 'AR', 'es', 'ARS', '+54', 'ar', NULL, NULL, NULL, 'heredar', 0, 0, NULL, 7, 1, NULL, 0, NULL, NULL, 'heredar', 'heredar'),
(9156, 5, 'Noelia Lucila Sandoval Leiva', 'Gabriel Giménez 275 Villa del Prado', -31.612623, -64.388248, '+5491161401262', NULL, NULL, NULL, NULL, NULL, 'Estacionamiento, Acceso universal, Factura fiscal, Mercado Pago | Estacionamiento, Acceso universal, Factura fiscal, Mercado Pago', 0, 1, 0, 0, 'fonoaudiologo', 1, 'active', '2026-04-29 00:12:14', '2026-04-29 00:12:56', 3, 'Asistencia profesional personalizada', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 'America/Argentina/Buenos_Aires', 'AR', NULL, 'ARS', '+54', 'ar', NULL, NULL, NULL, 'heredar', 0, 0, NULL, 12, 0, NULL, 0, NULL, NULL, 'heredar', 'heredar'),
(9157, 5, 'San Regali', '25 de Mayo 98 Villa Dolores', -31.943342, -65.189236, '+5493516664830', NULL, NULL, NULL, NULL, NULL, 'Estacionamiento, Acceso universal, Factura fiscal, Retiro en local, Mercado Pago | Estacionamiento, Acceso universal, Factura fiscal, Retiro en local, Mercado Pago', 1, 1, 0, 0, 'libreria_cristiana', 1, 'active', '2026-04-29 00:44:49', '2026-05-01 00:25:25', 3, 'Santería - Librería católica. Atendida por sus dueños.', NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 'America/Argentina/Buenos_Aires', 'AR', NULL, 'ARS', '+54', 'ar', NULL, NULL, NULL, 'heredar', 0, 0, NULL, 12, 0, NULL, 0, NULL, NULL, 'heredar', 'heredar'),
(9158, 5, 'Universo Canino Pelu', 'Sagrada Familia 1228, Córdoba Capital', -31.387399, -64.227972, '+5493515147850', NULL, NULL, 'universocanino.pelu', NULL, NULL, 'Estacionamiento, Acceso universal, Mercado Pago | Estacionamiento, Acceso universal, Mercado Pago', 1, 1, 0, 0, 'otros', 1, 'active', '2026-04-29 01:44:08', '2026-04-29 01:44:57', 3, 'Peluquería Canina 🐾🐶\r\n💦🐶Brindamos belleza, salud y 🥰para tus peludos.', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 'America/Argentina/Buenos_Aires', 'AR', NULL, 'ARS', '+54', 'ar', NULL, NULL, NULL, 'heredar', 0, 0, NULL, 12, 0, NULL, 0, NULL, NULL, 'heredar', 'heredar'),
(9159, 5, 'Marek', 'Calle 821 1251 - Quilmes Oeste |Buenos Aires', -34.756935, -58.309333, '+5491170815762', 'ventas2@tejados.com.ar', 'https://www.marek.com.ar/', 'marekargentina', NULL, NULL, 'Estacionamiento, Acceso universal, Factura fiscal, Retiro en local, Mercado Pago | Estacionamiento, Acceso universal, Factura fiscal, Retiro en local, Mercado Pago', 1, 1, 0, 0, 'construccion', 1, 'active', '2026-04-29 01:56:16', '2026-04-29 01:56:52', 3, 'Stampin Marek es una empresa que se especializa en la fabricación, comercialización, distribución y exportación de diversos productos de alta calidad, con linea gourmet y linea calefacción exclusiva, para argentina y el resto del mundo.\r\n\r\nEn el departamento tecnico de Stampin Marek, brindamos toda la asesoria a nuestros clientes, realizando sin cargo los computos sobre base de planos para aconsejar el mejor material a utilizar.\r\n\r\nProductos de altísima calidad con los mejores costos, resistencia, eficiencia y flexibilidad de diseños con una garantía extendida por su sólida estructura metálica.', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 'America/Argentina/Buenos_Aires', 'AR', 'es', 'ARS', '+54', 'ar', NULL, NULL, NULL, 'heredar', 0, 0, NULL, 12, 0, NULL, 0, NULL, NULL, 'heredar', 'heredar'),
(9160, 5, 'MCA INGENIERIA SA', 'Cam. A Capilla de los Remedios 7375, X5000 Córdoba', -31.452868, -64.079944, '0810 220 0218', 'info@mca-ingenieria.com.ar', 'https://mca-ingenieria.com.ar/', 'mca.ingenieriaok', NULL, NULL, 'Estacionamiento, Factura fiscal, Retiro en local | Estacionamiento, Factura fiscal, Retiro en local', 1, 1, 0, 0, 'construccion', 1, 'active', '2026-04-29 02:05:14', '2026-04-29 02:08:25', 3, 'Fabricantes y exportadores de Tanques y Surtidores Inteligentes de Combustibles', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 'America/Argentina/Buenos_Aires', 'AR', NULL, 'ARS', '+54', 'ar', NULL, NULL, NULL, 'heredar', 0, 0, NULL, 12, 0, NULL, 0, NULL, NULL, 'heredar', 'heredar'),
(9161, 5, 'BANZAI CORDOBA SAS', 'José Ingenieros 452, X5900 Villa María, Córdoba', -32.401072, -63.217712, '+54 9 3535 66-6806', 'contacto@banzaicordoba.com.ar', 'https://banzaicordoba.com.ar/', NULL, NULL, NULL, 'Estacionamiento | Estacionamiento', 0, 0, 0, 0, 'seguridad', 1, 'active', '2026-04-29 14:58:19', '2026-04-29 14:58:58', 3, 'Protección confiable para hogares, empresas y personas.  \r\n\r\nEn Banzai Córdoba S.A.S., brindamos soluciones avanzadas de seguridad privada orientadas a la protección de Personalidades, Empresas, Residencias Privadas y Edificios Públicos. Nuestro enfoque combina experiencia operativa, formación continua y protocolos estrictos para garantizar un servicio confiable y de excelencia.\r\n\r\nNuestro equipo profesional está altamente capacitado para actuar con precisión, discreción y compromiso. A través de métodos modernos y una visión integral, aseguramos la protección de aquello que nuestros clientes más valoran.\r\n\r\nCon una trayectoria sólida y en constante evolución, nos destacamos por superar los estándares del sector y ofrecer un servicio de seguridad premium adaptado a cada necesidad.', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 'America/Argentina/Buenos_Aires', 'AR', 'es', 'ARS', '+54', 'ar', NULL, NULL, NULL, 'heredar', 0, 0, NULL, 12, 0, NULL, 0, NULL, NULL, 'heredar', 'heredar'),
(9162, 8, 'Goldfarb, Habas & Asociados - Abogados', 'Tucumán 1441, CABA', -34.601632, -58.387279, '54-1153316661', 'ghaboga2@gmail.com', 'https://linktr.ee/ghaboga2', 'ghaboga2', 'leandro.abogado', NULL, 'fijate en nuestro linkedin.com/in/ghabogados | WiFi, Estacionamiento, Acceso universal, Reservas online, Factura fiscal, Retiro en local, Mercado Pago', 1, 1, 0, 0, 'abogado', 1, 'pending', '2026-04-29 17:53:42', '2026-04-29 19:52:10', 3, 'Hola, Soy Leandro Goldfarb, socio del estudio, somos abogados en ejercicio en la Ciudad de Buenos Aires, enfocados en ayudar a nuestros clientes brindando soluciones concretas a conflictos de diversas areas. \r\nNuestra práctica en el estudio abarca derecho laboral, civil, comercial, familia, y Penal, asistiendo tanto a personas como a empresas en la prevención y resolución de controversias.\r\nTrabajo con un criterio claro: cada caso requiere estrategia, precisión y compromiso. \r\nIntervengo desde la primera consulta hasta la instancia final, combinando análisis jurídico sólido con una mirada práctica orientada a resultados. \r\nLa experiencia profesional de varias decadas, nos permitió actuar en negociaciones, mediaciones y litigios, siempre priorizando la defensa efectiva de los intereses de nuestros clientes.\r\nEntiendo que detrás de cada caso hay una situación personal o empresarial que no admite demoras ni respuestas genéricas. Por eso, ofrecemos un trato directo, seguimiento constante y asesoramiento claro, sin vueltas.\r\nMi objetivo es simple: TU SATISFACCIÓN, tener el tema que nos traes resuelto, lo mejor y más rápido posible con seriedad, eficiencia y criterio profesional. Contactanos!', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'America/Argentina/Buenos_Aires', 'AR', NULL, 'ARS', '+54911', 'ar', NULL, NULL, NULL, 'heredar', 0, 0, NULL, 12, 0, NULL, 0, NULL, NULL, 'heredar', 'heredar'),
(9163, 11, 'SANREGALI', '25 de Mayo 98', -31.943514, -65.189341, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 'libreria_cristiana', 1, 'active', '2026-05-01 00:23:59', NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 'America/Argentina/Buenos_Aires', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'heredar', 0, 0, NULL, 12, 0, NULL, 0, NULL, NULL, 'heredar', 'heredar'),
(9164, 5, 'HAMLET -Obra adaptada-', '9 de Julio 340', -31.413069, -64.189843, '+541168480793', 'pablofarias19@gmail.com', NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 'obra_de_arte', 1, 'active', '2026-05-01 03:59:19', '2026-05-01 04:29:56', 3, 'La convocatoria propone la creación de una adaptación escénica infantil de Hamlet, de William Shakespeare, pensada como una experiencia teatral accesible, lúdica y formativa. El proyecto invita a directores, actores, escenógrafos, músicos y pedagogos a reinterpretar la obra desde una perspectiva sensible a la infancia, conservando sus ejes dramáticos —la duda, la justicia, la identidad— pero traducidos en un lenguaje simbólico, visual y narrativo adecuado para niños. Se busca una puesta que combine actuación, narración, recursos visuales y música en vivo o diseñada, priorizando el asombro y la comprensión emocional.\r\n\r\nDesde el punto de vista artístico, la propuesta de valor radica en la resignificación de un clásico universal mediante códigos escénicos contemporáneos: uso de máscaras, teatro físico, títeres, proyecciones o escenografías dinámicas que faciliten la lectura de la historia sin perder profundidad. La adaptación no simplifica el conflicto, sino que lo reconfigura en términos cercanos al mundo infantil, enfatizando valores como la empatía, la toma de decisiones y la resolución de conflictos. Se fomenta además la experimentación estética, permitiendo a los equipos creativos', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 'America/Argentina/Buenos_Aires', 'AR', 'es', 'ARS', '+54', 'ar', 'El presente proyecto propone el desarrollo y puesta en escena de una adaptación teatral infantil de Hamlet, obra emblemática de William Shakespeare, concebida como una experiencia artística, pedagógica y cultural orientada a niños. La iniciativa parte de la necesidad de acercar los grandes clásicos universales a las nuevas generaciones mediante lenguajes accesibles, sin perder la riqueza conceptual de la obra original. En este sentido, el proyecto plantea una relectura escénica que traduce los conflictos centrales —la duda, la justicia, la identidad y las decisiones morales— en códigos comprensibles y emocionalmente significativos para el público infantil.\n\nEn términos de desarrollo artístico, el proyecto contempla la creación integral de una puesta interdisciplinaria que combine actuación, narración, recursos visuales, música y elementos del teatro físico. Se prevé el uso de herramientas como máscaras, títeres, escenografías dinámicas y proyecciones, con el objetivo de generar una experiencia inmersiva que favorezca la comprensión narrativa y estimule la imaginación. El proceso incluirá etapas de investigación, adaptación dramatúrgica, ensayos y validación pedagógica, asegurando que los contenidos sean apropiados para la edad destinataria sin caer en simplificaciones que desvirtúen el valor original de la obra.\n\nDesde su dimensión cultural y educativa, el proyecto se posiciona como una herramienta de formación que promueve el acceso temprano al patrimonio literario universal, fortaleciendo el vínculo entre la infancia y las artes escénicas. Se prevé su circulación en teatros, instituciones educativas y espacios culturales, facilitando su alcance a públicos diversos. Asimismo, se incorpora un enfoque pedagógico que busca fomentar el pensamiento crítico, la empatía y la reflexión sobre los conflictos humanos, consolidando al teatro como un medio de aprendizaje activo y significativo. En conjunto, el proyecto aspira a generar un impacto sostenido en la formación cultural de los niños, integrando arte, educación y comunidad.', 'Para formar parte del proyecto de adaptación teatral infantil de Hamlet, se establece una convocatoria abierta dirigida a artistas y profesionales de las artes escénicas, la educación y disciplinas afines. Podrán postularse actores, actrices, directores, dramaturgos, escenógrafos, músicos, docentes y especialistas en pedagogía teatral que acrediten experiencia previa en trabajo con público infantil o en producciones culturales. Se valorará especialmente la capacidad de reinterpretar contenidos complejos en formatos accesibles, así como la disposición al trabajo colaborativo y multidisciplinario.\n\nEn cuanto a los requisitos formales, los postulantes deberán presentar un dossier que incluya currículum actualizado, portfolio o reel artístico, y una propuesta breve (máximo una carilla) donde expongan su enfoque creativo para la adaptación de la obra. Asimismo, deberán detallar su disponibilidad horaria para ensayos y funciones, y en caso de roles técnicos o de dirección, una propuesta metodológica de trabajo. Para actores y actrices, se podrá requerir audición presencial o virtual, con escenas adaptadas al lenguaje infantil o ejercicios de improvisación orientados a este público.\n\nFinalmente, el proyecto priorizará perfiles que demuestren sensibilidad artística, compromiso con la formación cultural y capacidad de generar vínculos con el público infantil. Se considerará un plus la experiencia en proyectos educativos, comunitarios o de difusión cultural. La selección se realizará mediante un comité evaluador que analizará tanto la calidad técnica como la coherencia entre la propuesta individual y los objetivos generales del proyecto, buscando conformar un equipo sólido, creativo y alineado con la visión artística y pedagógica de la iniciativa.', '[\"bailarin\",\"actor\",\"actriz\",\"director_artistico\",\"guionista\",\"escenografo\",\"productor_artistico\"]', 'heredar', 0, 0, NULL, 12, 0, NULL, 0, NULL, NULL, 'heredar', 'heredar');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `business_categories`
--

CREATE TABLE `business_categories` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `emoji` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `business_delegations`
--

CREATE TABLE `business_delegations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `business_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `role` enum('admin') NOT NULL DEFAULT 'admin',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `business_delegations`
--

INSERT INTO `business_delegations` (`id`, `business_id`, `user_id`, `role`, `created_at`, `created_by`) VALUES
(2, 9153, 7, 'admin', '2026-04-30 18:15:54', 5),
(3, 9157, 11, 'admin', '2026-05-01 00:12:18', 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `business_emoji_groups`
--

CREATE TABLE `business_emoji_groups` (
  `id` int(11) NOT NULL,
  `business_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `business_emoji_links`
--

CREATE TABLE `business_emoji_links` (
  `id` int(11) NOT NULL,
  `business_id` int(11) NOT NULL,
  `emoji_id` int(11) NOT NULL,
  `relation_type` varchar(50) DEFAULT 'location',
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `business_icons`
--

CREATE TABLE `business_icons` (
  `id` int(11) NOT NULL,
  `business_type` varchar(100) NOT NULL,
  `emoji` varchar(10) NOT NULL,
  `icon_class` varchar(100) DEFAULT NULL,
  `color` varchar(7) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `business_icons`
--

INSERT INTO `business_icons` (`id`, `business_type`, `emoji`, `icon_class`, `color`, `created_at`) VALUES
(1, 'comercio', '🛍️', 'icon-comercio', '#e74c3c', '2026-05-01 02:26:39'),
(2, 'hotel', '🏨', 'icon-hotel', '#3498db', '2026-05-01 02:26:39'),
(3, 'restaurante', '🍽️', 'icon-restaurante', '#e67e22', '2026-05-01 02:26:39'),
(4, 'inmobiliaria', '🏠', 'icon-inmobiliaria', '#27ae60', '2026-05-01 02:26:39'),
(5, 'farmacia', '💊', 'icon-farmacia', '#9b59b6', '2026-05-01 02:26:39'),
(6, 'gimnasio', '💪', 'icon-gimnasio', '#1abc9c', '2026-05-01 02:26:39'),
(7, 'cafeteria', '☕', 'icon-cafeteria', '#d35400', '2026-05-01 02:26:39'),
(8, 'academia', '📚', 'icon-academia', '#2980b9', '2026-05-01 02:26:39'),
(9, 'bar', '🍺', 'icon-bar', '#8e44ad', '2026-05-01 02:26:39'),
(10, 'salon_belleza', '💇', 'icon-salon', '#e91e63', '2026-05-01 02:26:39'),
(11, 'banco', '🏦', 'icon-banco', '#16a085', '2026-05-01 02:26:39'),
(12, 'tienda_ropa', '👕', 'icon-ropa', '#c0392b', '2026-05-01 02:26:39'),
(13, 'supermercado', '🛒', 'icon-super', '#8e44ad', '2026-05-01 02:26:39'),
(14, 'cine', '🎬', 'icon-cine', '#2980b9', '2026-05-01 02:26:39'),
(15, 'biblioteca', '📖', 'icon-biblioteca', '#27ae60', '2026-05-01 02:26:39'),
(16, 'parque', '🌳', 'icon-parque', '#16a085', '2026-05-01 02:26:39'),
(17, 'hospital', '🏥', 'icon-hospital', '#e74c3c', '2026-05-01 02:26:39'),
(18, 'escuela', '🎓', 'icon-escuela', '#3498db', '2026-05-01 02:26:39'),
(19, 'estacion', '🚂', 'icon-estacion', '#34495e', '2026-05-01 02:26:39'),
(20, 'gasolinera', '⛽', 'icon-gasolina', '#f39c12', '2026-05-01 02:26:39'),
(21, 'estacionamiento', '🅿️', 'icon-parking', '#95a5a6', '2026-05-01 02:26:39'),
(22, 'taxi', '🚕', 'icon-taxi', '#f1c40f', '2026-05-01 02:26:39'),
(23, 'carne', '🥩', 'icon-carne', '#e74c3c', '2026-05-01 02:26:39'),
(24, 'pescaderia', '🐟', 'icon-pescado', '#3498db', '2026-05-01 02:26:39'),
(25, 'panaderia', '🥐', 'icon-pan', '#d35400', '2026-05-01 02:26:39'),
(26, 'pasteleria', '🎂', 'icon-pastel', '#e91e63', '2026-05-01 02:26:39'),
(27, 'heladeria', '🍦', 'icon-helado', '#3498db', '2026-05-01 02:26:39'),
(28, 'fruteria', '🍎', 'icon-frutas', '#27ae60', '2026-05-01 02:26:39'),
(29, 'verduleria', '🥬', 'icon-verduras', '#27ae60', '2026-05-01 02:26:39'),
(30, 'bebidas', '🥤', 'icon-bebidas', '#9b59b6', '2026-05-01 02:26:39'),
(31, 'otros', '📍', 'icon-otros', '#667eea', '2026-05-01 02:26:39'),
(32, 'pizzeria', '🍕', 'icon-pizzeria', '#e74c3c', '2026-05-01 02:26:39'),
(33, 'indumentaria', '👕', 'icon-indumentaria', '#9b59b6', '2026-05-01 02:26:39'),
(34, 'muebleria', '🛋️', 'icon-muebleria', '#8e6914', '2026-05-01 02:26:39'),
(35, 'floristeria', '💐', 'icon-floristeria', '#e91e63', '2026-05-01 02:26:39'),
(36, 'libreria', '📖', 'icon-libreria', '#1abc9c', '2026-05-01 02:26:39'),
(37, 'productora_audiovisual', '🎥', 'icon-productora-audiovisual', '#6c5ce7', '2026-05-01 02:26:39'),
(38, 'escuela_musicos', '🎼', 'icon-escuela-musicos', '#8e44ad', '2026-05-01 02:26:39'),
(39, 'taller_artes', '🎨', 'icon-taller-artes', '#e67e22', '2026-05-01 02:26:39'),
(40, 'biodecodificacion', '🧬', 'icon-biodecodificacion', '#16a085', '2026-05-01 02:26:39'),
(41, 'libreria_cristiana', '📚', 'icon-libreria-cristiana', '#2d6a4f', '2026-05-01 02:26:39'),
(42, 'odontologia', '🦷', 'icon-odontologia', '#3498db', '2026-05-01 02:26:39'),
(43, 'veterinaria', '🐾', 'icon-veterinaria', '#27ae60', '2026-05-01 02:26:39'),
(44, 'optica', '👓', 'icon-optica', '#2980b9', '2026-05-01 02:26:39'),
(45, 'barberia', '💈', 'icon-barberia', '#c0392b', '2026-05-01 02:26:39'),
(46, 'spa', '💆', 'icon-spa', '#9b59b6', '2026-05-01 02:26:39'),
(47, 'seguros', '🛡️', 'icon-seguros', '#2980b9', '2026-05-01 02:26:39'),
(48, 'abogado', '⚖️', 'icon-abogado', '#34495e', '2026-05-01 02:26:39'),
(49, 'contador', '📊', 'icon-contador', '#2c3e50', '2026-05-01 02:26:39'),
(50, 'taller', '🔩', 'icon-taller', '#7f8c8d', '2026-05-01 02:26:39'),
(51, 'remate', '🔨', 'icon-remate', '#d35400', '2026-05-01 02:26:39'),
(52, 'construccion', '🏗️', 'icon-construccion', '#e67e22', '2026-05-01 02:26:39'),
(53, 'turismo', '✈️', 'icon-turismo', '#16a085', '2026-05-01 02:26:39'),
(54, 'electronica', '📱', 'icon-electronica', '#2980b9', '2026-05-01 02:26:39'),
(55, 'autos_venta', '🚗', 'icon-autos-venta', '#2980b9', '2026-05-01 02:26:39'),
(56, 'motos_venta', '🏍️', 'icon-motos-venta', '#8e44ad', '2026-05-01 02:26:39'),
(57, 'medico_pediatra', '🧒', 'icon-medico-pediatra', '#0ea5e9', '2026-05-01 02:26:39'),
(58, 'medico_traumatologo', '🦴', 'icon-medico-traumatologo', '#2563eb', '2026-05-01 02:26:39'),
(59, 'laboratorio', '🧪', 'icon-laboratorio', '#14b8a6', '2026-05-01 02:26:39'),
(60, 'ingenieria_civil', '🏗️', 'icon-ingenieria-civil', '#f59e0b', '2026-05-01 02:26:39'),
(61, 'astrologo', '🔮', 'icon-astrologo', '#6366f1', '2026-05-01 02:26:39'),
(62, 'grafica', '🖨️', 'icon-grafica', '#a855f7', '2026-05-01 02:26:39'),
(63, 'alquiler_mobiliario_fiestas', '🪑', 'icon-alquiler-mobiliario-fiestas', '#f59e0b', '2026-05-01 02:26:39'),
(64, 'propalacion_musica', '🔊', 'icon-propalacion-musica', '#6366f1', '2026-05-01 02:26:39'),
(65, 'animacion_fiestas', '🎉', 'icon-animacion-fiestas', '#ec4899', '2026-05-01 02:26:39'),
(66, 'zapatero', '👞', 'icon-zapatero', '#7c2d12', '2026-05-01 02:26:39'),
(67, 'gas_en_garrafa', '🛢️', 'icon-gas-en-garrafa', '#0ea5e9', '2026-05-01 02:26:39'),
(68, 'videojuegos', '🎮', 'icon-videojuegos', '#8b5cf6', '2026-05-01 02:26:39'),
(69, 'seguridad', '🛡️', 'icon-seguridad', '#334155', '2026-05-01 02:26:39'),
(70, 'electricista', '💡', 'icon-electricista', '#facc15', '2026-05-01 02:26:39'),
(71, 'gasista', '🔥', 'icon-gasista', '#f97316', '2026-05-01 02:26:39'),
(72, 'maestro_particular', '📘', 'icon-maestro-particular', '#0ea5e9', '2026-05-01 02:26:39'),
(73, 'asistencia_ancianos', '🧓', 'icon-asistencia-ancianos', '#14b8a6', '2026-05-01 02:26:39'),
(74, 'enfermeria', '🩺', 'icon-enfermeria', '#0ea5e9', '2026-05-01 02:26:39');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `business_images`
--

CREATE TABLE `business_images` (
  `id` int(11) NOT NULL,
  `business_id` int(11) NOT NULL,
  `image_path` varchar(255) NOT NULL,
  `title` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `is_primary` tinyint(1) DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `business_subcategories`
--

CREATE TABLE `business_subcategories` (
  `id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `code` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `business_type_limits`
--

CREATE TABLE `business_type_limits` (
  `business_type` varchar(80) NOT NULL,
  `images_max_default` int(11) NOT NULL DEFAULT 2 COMMENT 'Máximo de imágenes para todos los negocios de este tipo',
  `visibility_min_zoom_default` tinyint(3) UNSIGNED NOT NULL DEFAULT 12 COMMENT 'Zoom mínimo por defecto para este tipo de negocio',
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `inmuebles_max_default` int(11) NOT NULL DEFAULT 10 COMMENT 'Máximo de inmuebles activos para todos los negocios de este tipo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Límites y configuraciones por tipo de negocio (gestionados desde admin)';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `categories`
--

INSERT INTO `categories` (`id`, `name`) VALUES
(1, 'Generales'),
(2, 'Gastronomía'),
(3, 'Bienestar'),
(4, 'Servicios Profesionales'),
(5, 'Salud'),
(6, 'Hogar'),
(7, 'Entretenimiento');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `certificaciones_profesionales`
--

CREATE TABLE `certificaciones_profesionales` (
  `id` int(11) NOT NULL,
  `business_id` int(11) NOT NULL,
  `nombre_certificacion` varchar(200) NOT NULL,
  `institucion_emisora` varchar(200) DEFAULT NULL,
  `pais_emision` varchar(100) DEFAULT NULL,
  `fecha_obtencion` date DEFAULT NULL,
  `fecha_expiracion` date DEFAULT NULL COMMENT 'NULL si no expira',
  `numero_credencial` varchar(100) DEFAULT NULL COMMENT 'Número de matrícula o credencial',
  `url_verificacion` varchar(255) DEFAULT NULL COMMENT 'Link para verificar la certificación',
  `imagen_certificado` varchar(255) DEFAULT NULL COMMENT 'Path a imagen del certificado escaneado',
  `tipo` enum('titulo_universitario','posgrado','certificacion_tecnica','curso_especializado','licencia_profesional','otro') NOT NULL,
  `area` varchar(150) DEFAULT NULL COMMENT 'Área de especialización',
  `verificado` tinyint(1) DEFAULT 0 COMMENT 'Si fue verificado por administrador',
  `verificado_por` int(11) DEFAULT NULL COMMENT 'ID del admin que verificó',
  `fecha_verificacion` timestamp NULL DEFAULT NULL,
  `notas_verificacion` text DEFAULT NULL,
  `destacada` tinyint(1) DEFAULT 0 COMMENT 'Mostrar como destacada en el perfil',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Certificaciones y credenciales profesionales';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `chambers`
--

CREATE TABLE `chambers` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `area` varchar(150) NOT NULL COMMENT 'Area tematica: energia, transporte, etc.',
  `description` text DEFAULT NULL,
  `website` varchar(500) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(60) DEFAULT NULL,
  `status` enum('activa','inactiva') NOT NULL DEFAULT 'activa',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `chambers`
--

INSERT INTO `chambers` (`id`, `name`, `area`, `description`, `website`, `email`, `phone`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Camara de Comercio', 'comercio', 'Camara de comercio general.', NULL, NULL, NULL, 'activa', '2026-04-26 19:06:50', NULL),
(2, 'Camara de Importadores y Exportadores', 'comercio_exterior', 'Camara de comercio exterior e importadores.', NULL, NULL, NULL, 'activa', '2026-04-26 19:06:50', NULL),
(3, 'Camara de la Industria del Turismo', 'turismo', 'Camara sectorial del turismo y hospitalidad.', NULL, NULL, NULL, 'activa', '2026-04-26 19:06:50', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `chamber_sector`
--

CREATE TABLE `chamber_sector` (
  `chamber_id` int(10) UNSIGNED NOT NULL,
  `sector_type` enum('industrial','commercial') NOT NULL,
  `sector_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `chamber_sector`
--

INSERT INTO `chamber_sector` (`chamber_id`, `sector_type`, `sector_id`) VALUES
(1, 'commercial', 1),
(2, 'commercial', 1),
(2, 'commercial', 2),
(3, 'commercial', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clasificacion_niza`
--

CREATE TABLE `clasificacion_niza` (
  `id` int(11) NOT NULL,
  `marca_id` int(11) NOT NULL,
  `clase_principal` int(11) DEFAULT NULL,
  `clases_complementarias` varchar(255) DEFAULT NULL,
  `riesgo_colision` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comercios`
--

CREATE TABLE `comercios` (
  `id` int(11) NOT NULL,
  `business_id` int(11) NOT NULL,
  `tipo_comercio` varchar(100) DEFAULT NULL,
  `horario_apertura` time DEFAULT NULL,
  `horario_cierre` time DEFAULT NULL,
  `dias_cierre` varchar(100) DEFAULT NULL,
  `timezone` varchar(64) NOT NULL DEFAULT 'America/Argentina/Buenos_Aires',
  `categorias_productos` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `comercios`
--

INSERT INTO `comercios` (`id`, `business_id`, `tipo_comercio`, `horario_apertura`, `horario_cierre`, `dias_cierre`, `timezone`, `categorias_productos`) VALUES
(12, 9153, 'Ventas - Alquileres - Tasación', '10:00:00', '16:00:00', 'Sábado,Domingo', 'America/Argentina/Buenos_Aires', 'alquiler,venta,tasaciones'),
(15, 9156, NULL, '09:00:00', '18:00:00', 'Martes,Jueves,Sábado,Domingo', 'America/Argentina/Buenos_Aires', 'lenguaje,voz,audiología,tartamudez,niños'),
(16, 9157, NULL, '09:00:00', '18:00:00', NULL, 'America/Argentina/Buenos_Aires', 'biblias,devocionales,música cristiana,regalería,libros infantiles,estudio bíblico'),
(17, 9158, 'Estetica para perritos', '09:00:00', '18:00:00', 'Domingo', 'America/Argentina/Buenos_Aires', NULL),
(18, 9159, 'Tejados - Calefacción - Gourmet', '09:00:00', '18:00:00', 'Domingo', 'America/Argentina/Buenos_Aires', NULL),
(19, 9160, NULL, '09:00:00', '18:00:00', 'Sábado,Domingo', 'America/Argentina/Buenos_Aires', NULL),
(20, 9161, 'Seguridad Privada', '09:00:00', '18:00:00', NULL, 'America/Argentina/Buenos_Aires', 'vigilancia,monitoreo,custodia'),
(21, 9162, NULL, '09:00:00', '19:00:00', 'Sábado,Domingo', 'America/Argentina/Buenos_Aires', 'abogados,derecho laboral,derecho comercial,asesoramiento,derecho de familia,violencia de genero,derecho penal,denuncias,querellas,sucesiones'),
(22, 9163, NULL, '09:00:00', '18:00:00', NULL, 'America/Argentina/Buenos_Aires', NULL),
(23, 9164, 'Teatro para niños', '19:00:00', '21:00:00', 'Lunes,Martes,Miércoles,Jueves,Viernes,Domingo', 'America/Argentina/Buenos_Aires', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `commercial_sectors`
--

CREATE TABLE `commercial_sectors` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `type` enum('retail','servicios','gastronomia','tecnologia','salud','educacion','finanzas','transporte','turismo','otro') NOT NULL,
  `subtype` varchar(100) DEFAULT NULL,
  `status` enum('proyecto','activo','potencial') NOT NULL DEFAULT 'potencial',
  `jurisdiction` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `radar_enabled` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1 = Radar Legal habilitado',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `commercial_sectors`
--

INSERT INTO `commercial_sectors` (`id`, `name`, `type`, `subtype`, `status`, `jurisdiction`, `description`, `radar_enabled`, `created_at`, `updated_at`) VALUES
(1, 'Comercio Minorista General', 'retail', 'Indumentaria y calzado', 'activo', 'Nacional', 'Sector de comercio minorista de alcance nacional.', 1, '2026-04-26 19:06:50', NULL),
(2, 'Servicios Financieros', 'finanzas', 'Seguros y banca', 'activo', 'Nacional', 'Sector de servicios financieros y bancarios.', 0, '2026-04-26 19:06:50', NULL),
(3, 'Turismo y Hospitalidad', 'turismo', 'Alojamiento y gastronomia', 'activo', 'Nacional', 'Sector turistico y hotelero.', 1, '2026-04-26 19:06:50', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `competencies`
--

CREATE TABLE `competencies` (
  `id` int(10) UNSIGNED NOT NULL,
  `source_type` enum('chamber','agency') NOT NULL,
  `source_id` int(10) UNSIGNED NOT NULL,
  `role` enum('aprobar','rechazar','controlar','auditar','sancionar','dictamen','emitir','fiscalizar') NOT NULL,
  `organism` varchar(255) NOT NULL,
  `organ` varchar(255) DEFAULT NULL,
  `responsible` varchar(255) DEFAULT NULL,
  `scope` text DEFAULT NULL,
  `legal_basis` varchar(500) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `competencies`
--

INSERT INTO `competencies` (`id`, `source_type`, `source_id`, `role`, `organism`, `organ`, `responsible`, `scope`, `legal_basis`, `created_at`, `updated_at`) VALUES
(1, 'agency', 2, 'aprobar', 'Ministerio de Comercio', 'Direccion de Comercio Exterior', 'Director/a Nacional', 'Aprobacion de licencias de importacion/exportacion', 'Dec. 1299/2010', '2026-04-26 19:06:50', NULL),
(2, 'agency', 2, 'controlar', 'AFIP - Aduana', 'Division de Operaciones', 'Jefe/a de Division', 'Control aduanero de mercancias', 'Codigo Aduanero', '2026-04-26 19:06:50', NULL),
(3, 'chamber', 1, 'dictamen', 'Camara de Comercio', 'Comision de Etica', 'Secretario/a', 'Emision de dictamenes sobre conflictos entre socios', NULL, '2026-04-26 19:06:50', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compras_paquetes`
--

CREATE TABLE `compras_paquetes` (
  `id` int(11) NOT NULL,
  `paquete_id` int(11) NOT NULL,
  `usuario_id` int(11) DEFAULT NULL COMMENT 'ID del usuario comprador (NULL si compró sin login)',
  `business_id` int(11) NOT NULL,
  `nombre_cliente` varchar(150) DEFAULT NULL,
  `email_cliente` varchar(150) DEFAULT NULL,
  `telefono_cliente` varchar(20) DEFAULT NULL,
  `precio_pagado` decimal(10,2) NOT NULL,
  `fecha_compra` timestamp NULL DEFAULT current_timestamp(),
  `fecha_inicio_vigencia` date NOT NULL,
  `fecha_fin_vigencia` date DEFAULT NULL,
  `sesiones_totales` int(11) NOT NULL,
  `sesiones_consumidas` int(11) DEFAULT 0,
  `sesiones_restantes` int(11) GENERATED ALWAYS AS (`sesiones_totales` - `sesiones_consumidas`) STORED COMMENT 'Campo calculado',
  `estado` enum('activo','pausado','completado','expirado','cancelado') DEFAULT 'activo',
  `fecha_pausa` timestamp NULL DEFAULT NULL COMMENT 'Fecha en que se pausó',
  `motivo_pausa` text DEFAULT NULL,
  `fecha_completado` timestamp NULL DEFAULT NULL,
  `fecha_expiracion` timestamp NULL DEFAULT NULL,
  `fecha_cancelacion` timestamp NULL DEFAULT NULL,
  `motivo_cancelacion` text DEFAULT NULL,
  `metodo_pago` enum('efectivo','transferencia','tarjeta','mercadopago','otro') DEFAULT NULL,
  `comprobante_pago` varchar(255) DEFAULT NULL COMMENT 'URL o ID del comprobante',
  `renovacion_automatica` tinyint(1) DEFAULT 0,
  `fecha_proxima_renovacion` date DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Compras de paquetes por clientes';

--
-- Disparadores `compras_paquetes`
--
DELIMITER $$
CREATE TRIGGER `tr_actualizar_estado_paquete` BEFORE UPDATE ON `compras_paquetes` FOR EACH ROW BEGIN
    -- Si se consumieron todas las sesiones, marcar como completado
    IF NEW.sesiones_consumidas >= NEW.sesiones_totales AND OLD.estado = 'activo' THEN
        SET NEW.estado = 'completado';
        SET NEW.fecha_completado = CURRENT_TIMESTAMP;
    END IF;

    -- Si se pasó la fecha de vigencia, marcar como expirado
    IF NEW.fecha_fin_vigencia IS NOT NULL
       AND NEW.fecha_fin_vigencia < CURDATE()
       AND NEW.estado = 'activo' THEN
        SET NEW.estado = 'expirado';
        SET NEW.fecha_expiracion = CURRENT_TIMESTAMP;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `consultas_destinatarios`
--

CREATE TABLE `consultas_destinatarios` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `consulta_id` bigint(20) UNSIGNED NOT NULL,
  `business_id` int(11) NOT NULL,
  `notificado` tinyint(1) NOT NULL DEFAULT 0,
  `leido_en` datetime DEFAULT NULL COMMENT 'Cuándo el propietario del negocio lo leyó',
  `dismissed_at` datetime DEFAULT NULL COMMENT 'Cuándo el destinatario descartó/cerró esta consulta recibida'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `consultas_destinatarios`
--

INSERT INTO `consultas_destinatarios` (`id`, `consulta_id`, `business_id`, `notificado`, `leido_en`, `dismissed_at`) VALUES
(1, 1, 9153, 0, '2026-04-27 00:01:37', NULL),
(2, 2, 9153, 0, NULL, NULL),
(3, 3, 9153, 0, NULL, NULL),
(4, 4, 9153, 0, NULL, NULL),
(5, 5, 9157, 0, NULL, NULL),
(6, 5, 9163, 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `consultas_masivas`
--

CREATE TABLE `consultas_masivas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL COMMENT 'Usuario que origina la consulta',
  `tipo` enum('masiva','general','global_proveedor','envio') NOT NULL COMMENT 'masiva=geo+todos; general=servicios habilitados; global_proveedor=rubro P; envio=transportistas geo',
  `rubro` varchar(100) DEFAULT NULL COMMENT 'Para tipo=global_proveedor: business_type destino',
  `geo_bounds` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '{north,south,east,west} — para masiva y envio' CHECK (json_valid(`geo_bounds`)),
  `texto` varchar(500) NOT NULL COMMENT 'Texto de la consulta enviada',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `status` enum('open','answered','closed','archived') NOT NULL DEFAULT 'open' COMMENT 'Lifecycle: open=activa, answered=respondida, closed=cerrada, archived=archivada',
  `answered_at` datetime DEFAULT NULL COMMENT 'Cuándo fue respondida por primera vez',
  `closed_at` datetime DEFAULT NULL COMMENT 'Cuándo fue cerrada o archivada por el remitente',
  `closed_by` int(11) DEFAULT NULL COMMENT 'user_id que cerró la consulta'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `consultas_masivas`
--

INSERT INTO `consultas_masivas` (`id`, `user_id`, `tipo`, `rubro`, `geo_bounds`, `texto`, `created_at`, `status`, `answered_at`, `closed_at`, `closed_by`) VALUES
(1, 5, 'general', NULL, NULL, 'Hola eres inmobiliaria', '2026-04-27 00:00:51', 'archived', NULL, '2026-04-27 02:20:16', 0),
(2, 5, 'general', NULL, NULL, 'hola', '2026-04-27 19:24:02', 'closed', NULL, '2026-04-27 19:24:15', 5),
(3, 5, 'masiva', NULL, '{\"north\":-30.354320204885127,\"south\":-32.78901387799222,\"east\":-62.57812500000001,\"west\":-65.32470703125001}', 'hola', '2026-04-27 19:25:06', 'closed', NULL, '2026-04-27 19:25:11', 5),
(4, 5, 'general', NULL, NULL, 'hola sos inmobiliaria?', '2026-04-28 21:48:10', 'closed', NULL, '2026-04-28 21:48:27', 5),
(5, 5, 'masiva', NULL, '{\"north\":-31.935708021672593,\"south\":-31.94463418315756,\"east\":-65.18591423851352,\"west\":-65.1970744281306}', 'hola MIGUEL', '2026-05-01 00:37:12', 'archived', NULL, '2026-05-01 01:08:16', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `consultas_respuestas`
--

CREATE TABLE `consultas_respuestas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `consulta_id` bigint(20) UNSIGNED NOT NULL,
  `business_id` int(11) NOT NULL COMMENT 'Negocio que responde',
  `user_id` int(11) NOT NULL COMMENT 'Propietario/responsable que escribe la respuesta',
  `texto` varchar(500) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `consultas_respuestas`
--

INSERT INTO `consultas_respuestas` (`id`, `consulta_id`, `business_id`, `user_id`, `texto`, `created_at`) VALUES
(1, 1, 9153, 5, 'no', '2026-04-27 00:01:42');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `content_reports`
--

CREATE TABLE `content_reports` (
  `id` int(10) UNSIGNED NOT NULL,
  `reporter_user_id` int(11) DEFAULT NULL,
  `reporter_ip` varchar(45) DEFAULT NULL,
  `content_type` varchar(30) NOT NULL COMMENT 'review|business|noticia|evento|oferta|trivia|encuesta|transmision',
  `content_id` int(10) UNSIGNED NOT NULL,
  `reason` varchar(60) NOT NULL COMMENT 'spam|inappropriate|fake|harassment|other',
  `description` text DEFAULT NULL,
  `status` enum('pending','reviewing','resolved','dismissed') NOT NULL DEFAULT 'pending',
  `resolved_by` int(11) DEFAULT NULL COMMENT 'user_id del admin que resolvió',
  `resolved_at` timestamp NULL DEFAULT NULL,
  `resolution_note` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `convocatorias`
--

CREATE TABLE `convocatorias` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `business_id` int(11) NOT NULL COMMENT 'Negocio OBRA DE ARTE convocante',
  `user_id` int(11) NOT NULL COMMENT 'Usuario titular',
  `fecha_inicio` datetime NOT NULL,
  `fecha_fin` datetime NOT NULL,
  `roles_requeridos` text NOT NULL COMMENT 'JSON array de business_type roles',
  `estado` enum('activa','cerrada','cancelada') NOT NULL DEFAULT 'activa',
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `convocatoria_destinatarios`
--

CREATE TABLE `convocatoria_destinatarios` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `convocatoria_id` bigint(20) UNSIGNED NOT NULL,
  `business_id` int(11) NOT NULL COMMENT 'Negocio/servicio convocado',
  `notificado_wt` tinyint(1) NOT NULL DEFAULT 0,
  `notificado_mail` tinyint(1) NOT NULL DEFAULT 0,
  `leido_en` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cursos`
--

CREATE TABLE `cursos` (
  `id` int(11) NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `descripcion` longtext DEFAULT NULL,
  `instructor_id` int(11) DEFAULT NULL,
  `zoom_meeting_id` varchar(255) DEFAULT NULL,
  `zoom_start_time` datetime DEFAULT NULL,
  `zoom_duration_minutes` int(11) DEFAULT NULL,
  `max_participantes` int(11) DEFAULT NULL,
  `estado` enum('programado','en_vivo','finalizado','cancelado') DEFAULT NULL,
  `grabacion_url` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `curso_inscripciones`
--

CREATE TABLE `curso_inscripciones` (
  `id` int(11) NOT NULL,
  `curso_id` int(11) DEFAULT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `estado` enum('inscrito','asistio','certificado','abandono') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `disponibles_items`
--

CREATE TABLE `disponibles_items` (
  `id` int(10) UNSIGNED NOT NULL,
  `business_id` int(11) NOT NULL,
  `precio` decimal(10,2) DEFAULT NULL,
  `precio_a_definir` tinyint(1) NOT NULL DEFAULT 0,
  `cantidad` smallint(5) UNSIGNED DEFAULT NULL,
  `tipo_bien` varchar(30) DEFAULT NULL,
  `disponible_desde` date DEFAULT NULL,
  `disponible_hasta` date DEFAULT NULL,
  `horario_inicio` time DEFAULT NULL,
  `horario_fin` time DEFAULT NULL,
  `servicio` varchar(45) DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT 1,
  `orden` smallint(6) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `disponibles_solicitudes`
--

CREATE TABLE `disponibles_solicitudes` (
  `id` int(10) UNSIGNED NOT NULL,
  `business_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `estado` enum('pendiente','confirmada','desistida') NOT NULL DEFAULT 'pendiente',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `disponibles_solicitud_items`
--

CREATE TABLE `disponibles_solicitud_items` (
  `id` int(10) UNSIGNED NOT NULL,
  `solicitud_id` int(10) UNSIGNED NOT NULL,
  `item_id` int(10) UNSIGNED NOT NULL,
  `seleccionado` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `emoji_favorites`
--

CREATE TABLE `emoji_favorites` (
  `id` int(11) NOT NULL,
  `user_id` varchar(100) NOT NULL,
  `emoji_id` int(11) NOT NULL,
  `added_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `emoji_groups`
--

CREATE TABLE `emoji_groups` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `color` varchar(20) DEFAULT '#3388ff' COMMENT 'Color para visualización del grupo',
  `is_public` tinyint(1) DEFAULT 0 COMMENT 'Indica si el grupo es público',
  `created_by` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `emoji_groups`
--

INSERT INTO `emoji_groups` (`id`, `name`, `description`, `color`, `is_public`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 'Comida', 'Lugares para comer', '#FF5722', 0, 'pablofarias19', '2025-03-18 21:22:53', '2025-03-18 21:22:53'),
(2, 'Educación', 'Instituciones educativas', '#2196F3', 0, 'pablofarias19', '2025-03-18 21:22:53', '2025-03-18 21:22:53'),
(3, 'Recreación', 'Lugares para divertirse', '#4CAF50', 0, 'pablofarias19', '2025-03-18 21:22:53', '2025-03-18 21:22:53');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `emoji_group_members`
--

CREATE TABLE `emoji_group_members` (
  `group_id` int(11) NOT NULL,
  `emoji_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `emoji_history`
--

CREATE TABLE `emoji_history` (
  `id` int(11) NOT NULL,
  `entity_type` enum('emoji','group','relation') NOT NULL,
  `entity_id` int(11) NOT NULL,
  `action` enum('create','update','delete') NOT NULL,
  `data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`data`)),
  `user` varchar(100) DEFAULT NULL,
  `action_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `emoji_images`
--

CREATE TABLE `emoji_images` (
  `id` int(11) NOT NULL,
  `emoji_id` int(11) NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `file_size` int(11) NOT NULL,
  `file_type` varchar(100) NOT NULL,
  `is_primary` tinyint(1) DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `created_by_user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `emoji_markers`
--

CREATE TABLE `emoji_markers` (
  `id` int(11) NOT NULL,
  `symbol` varchar(10) NOT NULL DEFAULT '?',
  `title` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `lat` decimal(10,6) NOT NULL,
  `lng` decimal(10,6) NOT NULL,
  `style` varchar(50) DEFAULT 'sin_fondo',
  `protection` varchar(20) DEFAULT 'public',
  `password` varchar(255) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `price_range` int(1) DEFAULT NULL COMMENT 'Rango de precio: 1-5 (económico a caro)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `emoji_markers`
--

INSERT INTO `emoji_markers` (`id`, `symbol`, `title`, `description`, `lat`, `lng`, `style`, `protection`, `password`, `created_by`, `created_at`, `updated_at`, `price_range`) VALUES
(3, '🏫', 'Universidad', 'Campus universitario', -34.617841, -58.368101, 'luminoso_celeste', 'public', NULL, 'pablofarias19', '2025-03-18 21:24:00', '2025-03-18 21:24:00', NULL),
(4, '🏞️', 'Parque', 'Parque para pasear', -34.606714, -58.391188, 'sin_fondo', 'public', NULL, 'pablofarias19', '2025-03-18 21:24:00', '2025-03-18 21:24:00', NULL),
(5, '📍', '25 de agosto 3828', 'lululull', -34.376312, -58.841743, 'sin_fondo', 'public', NULL, NULL, '2025-03-19 01:20:36', '2025-03-19 01:20:36', NULL),
(6, '📍', 'Zapatos de Vestir', '¿que lindos zapatos?', -34.633208, -58.651886, 'sin_fondo', 'public', NULL, NULL, '2025-03-19 15:33:39', '2025-03-19 15:33:39', NULL),
(7, '📍', 'ACA VIVIA LUCIA', 'LA LUCIA', -34.463117, -58.512111, 'sin_fondo', 'public', NULL, NULL, '2025-03-19 15:35:40', '2025-03-19 15:35:40', NULL),
(8, '😍', 'Emoji 😍', 'Emoji colocado en -34.626428, -59.030914', -34.626428, -59.030914, 'sin_fondo', 'public', NULL, NULL, '2025-03-19 21:44:14', '2025-03-19 21:44:14', NULL),
(9, '📍', 'VENTA CASA BARRIO PANAMERICANO', 'hjhjhk', -31.248911, -64.501419, 'sin_fondo', 'public', NULL, NULL, '2025-03-19 22:22:53', '2025-03-19 22:22:53', NULL),
(10, '📍', 'PRUEBA 2', 'eSTAMOS TRABAJANADO', -31.232472, -64.496269, 'sin_fondo', 'public', NULL, NULL, '2025-03-20 01:37:57', '2025-03-20 01:37:57', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `emoji_relations`
--

CREATE TABLE `emoji_relations` (
  `id` int(11) NOT NULL,
  `from_id` int(11) NOT NULL,
  `to_id` int(11) NOT NULL,
  `group_id` int(11) DEFAULT NULL,
  `label` varchar(100) DEFAULT NULL COMMENT 'Etiqueta descriptiva de la relación',
  `line_style` varchar(50) DEFAULT NULL COMMENT 'Estilo visual para la línea de relación',
  `created_by` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `encuestas`
--

CREATE TABLE `encuestas` (
  `id` int(11) NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `lat` decimal(10,8) NOT NULL COMMENT 'Latitud de la encuesta',
  `lng` decimal(11,8) NOT NULL COMMENT 'Longitud de la encuesta',
  `fecha_creacion` date NOT NULL,
  `fecha_expiracion` date DEFAULT NULL,
  `link` varchar(255) DEFAULT NULL COMMENT 'Link externo a la encuesta',
  `activo` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `detalle_activo` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1 = habilitar panel Detalle con gráficos; 0 = solo popup',
  `graficos_config` varchar(255) NOT NULL DEFAULT 'barras,torta,tendencia' COMMENT 'Lista CSV de tipos de gráfico habilitados: barras, torta, tendencia',
  `youtube_link` varchar(500) DEFAULT NULL COMMENT 'URL de YouTube para video explicativo de la encuesta',
  `localidad` varchar(120) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `encuestas`
--

INSERT INTO `encuestas` (`id`, `titulo`, `descripcion`, `lat`, `lng`, `fecha_creacion`, `fecha_expiracion`, `link`, `activo`, `created_at`, `updated_at`, `detalle_activo`, `graficos_config`, `youtube_link`, `localidad`) VALUES
(7, '¿Qué horario de atención prefieren los vecinos?', 'Mejorar el sistema de comercio para los vecinos de la localidad', -31.94515400, -65.19008200, '2026-05-01', '2026-05-06', NULL, 1, '2026-05-01 01:04:40', '2026-05-01 02:27:26', 1, 'barras,torta,tendencia', NULL, NULL),
(8, '¿Qué servicio público tiene menos respuesta de la Muni?', 'Los vecinos pueden indicar sus problemas a la Municipalidad de Cosquín', -31.23778600, -64.46811700, '2026-05-02', '2026-05-10', NULL, 1, '2026-05-02 15:30:39', '2026-05-02 15:31:59', 1, 'barras,torta,tendencia', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `encuestas_zona`
--

CREATE TABLE `encuestas_zona` (
  `id` int(11) NOT NULL,
  `zona` varchar(100) NOT NULL,
  `lat` decimal(10,6) NOT NULL,
  `lng` decimal(10,6) NOT NULL,
  `radio_m` int(11) DEFAULT 300,
  `pregunta` text NOT NULL,
  `categoria` varchar(50) DEFAULT NULL,
  `link` varchar(255) NOT NULL,
  `activa` tinyint(1) DEFAULT 1,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `encuesta_participaciones`
--

CREATE TABLE `encuesta_participaciones` (
  `id` int(11) NOT NULL,
  `encuesta_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `fecha_participacion` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `encuesta_participaciones`
--

INSERT INTO `encuesta_participaciones` (`id`, `encuesta_id`, `user_id`, `fecha_participacion`) VALUES
(6, 7, 5, '2026-05-02 14:26:09'),
(7, 8, 5, '2026-05-02 15:32:14');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `encuesta_questions`
--

CREATE TABLE `encuesta_questions` (
  `id` int(11) NOT NULL,
  `encuesta_id` int(11) NOT NULL,
  `question_text` text NOT NULL,
  `tipo` enum('text','multiple','rating') DEFAULT 'multiple',
  `orden` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `encuesta_responses`
--

CREATE TABLE `encuesta_responses` (
  `id` int(11) NOT NULL,
  `question_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `response_text` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `entidad_relaciones`
--

CREATE TABLE `entidad_relaciones` (
  `id` int(10) UNSIGNED NOT NULL,
  `source_entity_type` varchar(20) NOT NULL,
  `source_entity_id` int(11) NOT NULL,
  `source_mapita_id` varchar(64) DEFAULT NULL,
  `target_entity_type` varchar(20) NOT NULL,
  `target_entity_id` int(11) NOT NULL,
  `target_mapita_id` varchar(64) DEFAULT NULL,
  `relation_type` varchar(50) NOT NULL DEFAULT 'relacionado',
  `descripcion` varchar(255) DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estrategia_optima`
--

CREATE TABLE `estrategia_optima` (
  `id` int(11) NOT NULL,
  `marca_id` int(11) NOT NULL,
  `camino_recomendado` varchar(255) DEFAULT NULL,
  `secuencia_acciones` text DEFAULT NULL,
  `inversion_requerida` varchar(255) DEFAULT NULL,
  `horizonte_temporal` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `eventos`
--

CREATE TABLE `eventos` (
  `id` int(11) NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `hora` time DEFAULT NULL,
  `organizador` varchar(255) DEFAULT NULL,
  `lat` decimal(10,8) NOT NULL COMMENT 'Latitud del evento',
  `lng` decimal(11,8) NOT NULL COMMENT 'Longitud del evento',
  `dest_lat` decimal(10,8) DEFAULT NULL COMMENT 'Latitud del destino (si aplica)',
  `dest_lng` decimal(11,8) DEFAULT NULL COMMENT 'Longitud del destino (si aplica)',
  `activo` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `youtube_link` varchar(255) DEFAULT NULL COMMENT 'URL del video de YouTube para el evento',
  `categoria` varchar(100) DEFAULT 'General',
  `ubicacion` varchar(255) DEFAULT NULL,
  `mapita_id` varchar(64) DEFAULT NULL,
  `link` varchar(500) DEFAULT NULL COMMENT 'URL externa del evento (sitio web, compra de entradas, etc.)',
  `icono` varchar(20) DEFAULT NULL COMMENT 'Emoji o símbolo para el pin en el mapa (ej: ? ?️ ?)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `eventos`
--

INSERT INTO `eventos` (`id`, `titulo`, `descripcion`, `fecha`, `hora`, `organizador`, `lat`, `lng`, `dest_lat`, `dest_lng`, `activo`, `created_at`, `updated_at`, `youtube_link`, `categoria`, `ubicacion`, `mapita_id`, `link`, `icono`) VALUES
(1, 'Feria Gastronómica', 'Gran feria con los mejores platos de la región', '2025-04-15', '10:00:00', 'Asociación de Restaurantes', -34.60414180, -58.38342910, -34.60895600, -58.37522900, 1, '2025-03-30 06:03:45', '2026-04-19 19:29:50', '', 'General', '', NULL, NULL, NULL),
(2, 'Workshop de Marketing Digital', 'Aprende las últimas tendencias en marketing', '2025-04-20', '14:30:00', 'Digital Academy', -34.59895600, -58.37022900, -34.59595600, -58.36522900, 1, '2025-03-30 06:03:45', '2026-04-19 19:30:02', '', 'General', '', NULL, NULL, NULL),
(3, 'Festival Internacional de Cine', 'El cine es arte, es trabajo de equipo y es comunicación. Es además una forma de creación de identidad, tanto individual como colectiva.\nLa generación de nuevos espacios y pantallas en todo el país, es una forma de hacer circular películas,  cortometrajes y demás piezas audiovisuales poniéndolas a disposición de espectadores que, de otra forma, no tendrían un fácil acceso a las mismas.\nAsí, con la creación de esta nueva pantalla, como es el Festival Internacional de Cine Independiente de Cosquín, buscamos llevar a esta región del país las nuevas miradas que año tras año se generan en distintas partes de Argentina y del mundo.\nhttps://cosquinfilmfest.com/', '2026-04-30', '19:00:00', 'Municipalidad', -31.24371450, -64.46451510, -34.60681700, -58.43575100, 1, '2025-03-30 06:03:45', '2026-05-01 02:43:05', 'https://cosquinfilmfest.com/', 'General', 'Centro Cultural Municipal', '', NULL, NULL),
(4, 'Comparza Mari Mari', 'La comparsa Marí Marí nació en 1981 en Gualeguaychú, bajo la dirección de Nelita Bermudez. \nEl nombre Marí Marí significa \"buen día\" o \"el amanecer\". \nFelicita Fouce fue reina de la comparsa Marí Marí y luego fue coronada como soberana del Carnaval del País de Gualeguaychú. Este año estuvo, una vez más, en la localidad de Cosquín, Córdoba.', '2026-04-20', '00:00:00', '', -31.23719050, -64.46409340, -31.23719050, -64.46409340, 1, '2025-04-01 00:48:27', '2026-04-21 02:45:53', 'https://youtu.be/787Alo6PA9w?si=L1ibSN-68V0rFtgF', 'General', '', '', NULL, NULL),
(5, 'Tragico Terremoto en Myanmar', 'La junta militar de Myanmar declaró este lunes 31 de marzo una semana de luto nacional por el terremoto del pasado viernes, cuya cifra de muertos ascendió a 2.065, mientras en Tailandia el número de víctimas mortales aumentó a un total de 19. Las autoridades intensifican los esfuerzos para tratar de hallar sobrevivientes bajo los escombros tras el movimiento telúrico de 7,7 de magnitud.', '2026-05-08', '00:00:00', '', 22.40785460, 96.39404300, 22.40785460, 96.39404300, 0, '2025-04-01 02:30:56', '2026-05-01 02:51:35', 'https://youtu.be/ela97UPTSrY?si=zS9-7Nglktx0-7Tj', 'General', '', '', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `horarios_disponibles`
--

CREATE TABLE `horarios_disponibles` (
  `id` int(11) NOT NULL,
  `business_id` int(11) NOT NULL,
  `dia_semana` tinyint(4) NOT NULL COMMENT '0=domingo, 1=lunes, 2=martes, 3=miércoles, 4=jueves, 5=viernes, 6=sábado',
  `hora_inicio` time NOT NULL,
  `hora_fin` time NOT NULL,
  `tipo_sesion` enum('individual','grupal','taller','evaluacion','clase_prueba') DEFAULT 'individual',
  `cupos_disponibles` int(11) DEFAULT 1 COMMENT 'Cupos totales para este horario',
  `fecha_inicio_vigencia` date DEFAULT NULL COMMENT 'Fecha desde la cual aplica este horario',
  `fecha_fin_vigencia` date DEFAULT NULL COMMENT 'Fecha hasta la cual aplica este horario',
  `activo` tinyint(1) DEFAULT 1,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Horarios disponibles semanales recurrentes';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `hoteles`
--

CREATE TABLE `hoteles` (
  `id` int(11) NOT NULL,
  `business_id` int(11) NOT NULL,
  `numero_habitaciones` int(11) DEFAULT NULL,
  `check_in` time DEFAULT NULL,
  `check_out` time DEFAULT NULL,
  `servicios` text DEFAULT NULL,
  `precio_noche` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `industrial_sectors`
--

CREATE TABLE `industrial_sectors` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `type` enum('mineria','energia','agro','infraestructura','inmobiliario','industrial') NOT NULL,
  `subtype` varchar(100) DEFAULT NULL,
  `geometry` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'GeoJSON (Feature o Geometry)' CHECK (json_valid(`geometry`)),
  `status` enum('proyecto','activo','potencial') NOT NULL DEFAULT 'potencial',
  `investment_level` enum('bajo','medio','alto') NOT NULL DEFAULT 'medio',
  `risk_level` enum('bajo','medio','alto') NOT NULL DEFAULT 'medio',
  `jurisdiction` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `radar_enabled` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1 = Radar Legal habilitado'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `industries`
--

CREATE TABLE `industries` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL COMMENT 'Usuario propietario',
  `industrial_sector_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'FK a industrial_sectors (catálogo)',
  `business_id` int(11) DEFAULT NULL,
  `brand_id` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `website` varchar(500) DEFAULT NULL,
  `contact_email` varchar(255) DEFAULT NULL,
  `contact_phone` varchar(50) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `country_code` char(2) DEFAULT NULL COMMENT 'ISO 3166-1 alpha-2',
  `language_code` char(5) DEFAULT NULL COMMENT 'BCP 47 del idioma principal',
  `currency_code` char(3) DEFAULT NULL COMMENT 'ISO 4217 — moneda de referencia',
  `region` varchar(100) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `employees_range` enum('1-10','11-50','51-200','201-500','500+') DEFAULT NULL COMMENT 'Rango de empleados',
  `annual_revenue` enum('micro','pequeña','mediana','grande','corporación') DEFAULT NULL COMMENT 'Escala de la industria',
  `certifications` text DEFAULT NULL COMMENT 'Certificaciones separadas por coma',
  `naics_code` varchar(20) DEFAULT NULL COMMENT 'Código NAICS (opcional)',
  `isic_code` varchar(20) DEFAULT NULL COMMENT 'Código ISIC (opcional)',
  `nace_code` varchar(20) DEFAULT NULL COMMENT 'Clasificador NACE Rev. 2 (Europa)',
  `ciiu_code` varchar(20) DEFAULT NULL COMMENT 'Clasificador CIIU/ISIC Rev. 4 (OIT/LATAM)',
  `lat` decimal(10,7) DEFAULT NULL COMMENT 'Latitud geográfica',
  `lng` decimal(10,7) DEFAULT NULL COMMENT 'Longitud geográfica',
  `status` enum('borrador','activa','archivada') NOT NULL DEFAULT 'borrador',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `encuestas_permitidas` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1 = la industria puede crear encuestas; 0 = no puede',
  `noticias_permitidas` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1 = la industria puede publicar noticias; 0 = no puede',
  `eventos_permitidos` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1 = la industria puede publicar eventos; 0 = no puede'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `industry_images`
--

CREATE TABLE `industry_images` (
  `id` int(10) UNSIGNED NOT NULL,
  `industry_id` int(10) UNSIGNED NOT NULL COMMENT 'FK a industries',
  `file_path` varchar(500) NOT NULL COMMENT 'Ruta relativa: uploads/industries/{id}/...',
  `mime_type` varchar(30) DEFAULT NULL COMMENT 'MIME real validado al subir',
  `size_bytes` int(10) UNSIGNED DEFAULT NULL COMMENT 'Tamaño en bytes al momento de la subida',
  `uploaded_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Imágenes de industrias. Máx 2 por industria, ≤ 120 KB cada una.';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inmobiliarias`
--

CREATE TABLE `inmobiliarias` (
  `id` int(11) NOT NULL,
  `business_id` int(11) NOT NULL,
  `tipos_propiedades` text DEFAULT NULL,
  `zonas_operacion` text DEFAULT NULL,
  `comision` decimal(5,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inmuebles`
--

CREATE TABLE `inmuebles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `business_id` int(11) NOT NULL COMMENT 'ID de la inmobiliaria',
  `operacion` enum('venta','alquiler') NOT NULL DEFAULT 'venta',
  `titulo` varchar(255) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `precio` decimal(15,2) DEFAULT NULL,
  `moneda` varchar(10) NOT NULL DEFAULT 'ARS',
  `direccion` varchar(500) DEFAULT NULL,
  `lat` decimal(10,7) DEFAULT NULL,
  `lng` decimal(10,7) DEFAULT NULL,
  `foto_url` varchar(500) DEFAULT NULL,
  `contacto` varchar(255) DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `tipo` enum('casa','departamento','lote','proyecto','local','oficina') NOT NULL DEFAULT 'casa' COMMENT 'Subcategoría del inmueble',
  `financiado` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1 = acepta financiación',
  `ambientes` tinyint(3) UNSIGNED DEFAULT NULL COMMENT 'Cantidad de ambientes (NULL = no aplica)',
  `superficie_m2` decimal(10,2) UNSIGNED DEFAULT NULL COMMENT 'Superficie en m²',
  `web_url` varchar(500) DEFAULT NULL COMMENT 'URL externa del inmueble en la web de la inmobiliaria'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `inmuebles`
--

INSERT INTO `inmuebles` (`id`, `business_id`, `operacion`, `titulo`, `descripcion`, `precio`, `moneda`, `direccion`, `lat`, `lng`, `foto_url`, `contacto`, `activo`, `created_at`, `updated_at`, `tipo`, `financiado`, `ambientes`, `superficie_m2`, `web_url`) VALUES
(1, 9153, 'venta', 'Casa 2 habitaciones', NULL, 70000.00, 'USD', 'Tristán de Tejeda y Juan de Burgos', -31.3634965, -64.1938905, '/uploads/inmuebles/1/cover.png?t=1777611926', 'martilleracelestortiz@gmail.com', 1, '2026-04-26 20:31:11', '2026-05-01 05:05:26', 'casa', 0, 2, 431.00, 'https://mariacelesteortiz.com.ar/compartir_propiedades.php?id=31');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inmueble_adjuntos`
--

CREATE TABLE `inmueble_adjuntos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `inmueble_id` bigint(20) UNSIGNED NOT NULL,
  `tipo_adjunto` enum('plano','proyecto','foto') NOT NULL DEFAULT 'foto' COMMENT 'Tipo de archivo adjunto',
  `url` varchar(500) NOT NULL COMMENT 'Ruta relativa o URL del archivo',
  `nombre` varchar(255) DEFAULT NULL COMMENT 'Nombre descriptivo del adjunto',
  `mime_type` varchar(100) DEFAULT NULL,
  `file_size` int(10) UNSIGNED DEFAULT NULL COMMENT 'Tamaño en bytes',
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Adjuntos (planos, proyectos) por inmueble';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `job_applications`
--

CREATE TABLE `job_applications` (
  `id` int(10) UNSIGNED NOT NULL,
  `business_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL COMMENT 'Login obligatorio — NOT NULL',
  `applicant_name` varchar(255) NOT NULL,
  `applicant_email` varchar(255) NOT NULL,
  `applicant_phone` varchar(50) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `estado` enum('pendiente','vista','aceptada','rechazada') NOT NULL DEFAULT 'pendiente',
  `consent` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mapita_settings`
--

CREATE TABLE `mapita_settings` (
  `setting_key` varchar(100) NOT NULL COMMENT 'Clave única de la configuración',
  `setting_value` text NOT NULL DEFAULT '' COMMENT 'Valor de la configuración (se convierte al tipo necesario en código)',
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Configuraciones globales del sistema administradas desde el panel admin';

--
-- Volcado de datos para la tabla `mapita_settings`
--

INSERT INTO `mapita_settings` (`setting_key`, `setting_value`, `updated_at`) VALUES
('global_icon_boost', '1.0', '2026-04-26 21:39:56');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `marcadores`
--

CREATE TABLE `marcadores` (
  `id` int(11) NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `lat` decimal(10,6) NOT NULL,
  `lng` decimal(10,6) NOT NULL,
  `created_at` datetime NOT NULL,
  `created_by` varchar(100) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `marcadores`
--

INSERT INTO `marcadores` (`id`, `titulo`, `descripcion`, `lat`, `lng`, `created_at`, `created_by`, `updated_at`, `updated_by`) VALUES
(1, 'Casa de Lulu', 'Muy linda casa', -34.611312, -58.407784, '2025-03-18 19:58:31', 'pablofarias19', NULL, NULL),
(2, 'VENTA CASA BARRIO PANAMERICANO', '456', -34.573440, -58.452415, '2025-03-18 19:58:31', 'pablofarias19', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `marcas`
--

CREATE TABLE `marcas` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `rubro` varchar(255) DEFAULT NULL,
  `ubicacion` varchar(255) DEFAULT NULL,
  `estado` enum('IDEA','EN USO','REGISTRADA') NOT NULL,
  `scope` varchar(100) DEFAULT NULL,
  `channels` varchar(255) DEFAULT NULL,
  `annual_revenue` varchar(50) DEFAULT NULL,
  `founded_year` int(11) DEFAULT NULL,
  `extended_description` longtext DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `lat` decimal(10,8) DEFAULT NULL,
  `lng` decimal(11,8) DEFAULT NULL,
  `tiene_zona` tinyint(1) NOT NULL DEFAULT 0,
  `zona_radius_km` int(11) DEFAULT 10,
  `tiene_licencia` tinyint(1) NOT NULL DEFAULT 0,
  `licencia_detalle` varchar(255) DEFAULT NULL,
  `es_franquicia` tinyint(1) NOT NULL DEFAULT 0,
  `franchise_details` varchar(255) DEFAULT NULL,
  `zona_exclusiva` tinyint(1) NOT NULL DEFAULT 0,
  `zona_exclusiva_radius_km` int(11) DEFAULT 2,
  `logo_url` varchar(255) DEFAULT NULL COMMENT 'Ruta pública del logo del mapa',
  `mapita_id` varchar(64) DEFAULT NULL,
  `og_image_url` varchar(255) DEFAULT NULL COMMENT 'URL pública de la imagen Open Graph de la marca'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `modelos_negocio`
--

CREATE TABLE `modelos_negocio` (
  `id` int(11) NOT NULL,
  `marca_id` int(11) NOT NULL,
  `tipo` enum('EXPLOTACION_DIRECTA','LICENCIAMIENTO','FRANQUICIA','MARCA_BLANCA','ACTIVO_DIGITAL') DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `monetizacion`
--

CREATE TABLE `monetizacion` (
  `id` int(11) NOT NULL,
  `marca_id` int(11) NOT NULL,
  `fuentes_ingresos` text DEFAULT NULL,
  `escalabilidad` varchar(255) DEFAULT NULL,
  `margen_potencial` varchar(255) DEFAULT NULL,
  `valor_activo` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `negocios_radio_operacion`
--

CREATE TABLE `negocios_radio_operacion` (
  `id` int(11) NOT NULL,
  `negocio_id` int(11) NOT NULL COMMENT 'ID del negocio relacionado',
  `categoria_servicio` enum('transporte','reparto','servicios','comercio') NOT NULL DEFAULT 'transporte',
  `radio_operacion` int(11) NOT NULL COMMENT 'Radio de operación en metros',
  `centro_lat` decimal(10,8) NOT NULL,
  `centro_lng` decimal(11,8) NOT NULL,
  `disponible` tinyint(1) DEFAULT 1,
  `horas_operacion` varchar(100) DEFAULT NULL COMMENT 'Formato: "L-V: 9-18, S: 10-14"',
  `capacidad_maxima` int(11) DEFAULT 1,
  `carga_trabajo_actual` int(11) DEFAULT 0,
  `acepta_multiples_paradas` tinyint(1) DEFAULT 0,
  `acepta_rutas_programadas` tinyint(1) DEFAULT 0,
  `precio_base` decimal(10,2) DEFAULT 0.00,
  `precio_por_km` decimal(10,2) DEFAULT 0.00,
  `config_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'Configuraciones adicionales en formato JSON' CHECK (json_valid(`config_json`)),
  `fecha_creacion` timestamp NULL DEFAULT current_timestamp(),
  `fecha_actualizacion` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `activo` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `negocios_radio_operacion`
--

INSERT INTO `negocios_radio_operacion` (`id`, `negocio_id`, `categoria_servicio`, `radio_operacion`, `centro_lat`, `centro_lng`, `disponible`, `horas_operacion`, `capacidad_maxima`, `carga_trabajo_actual`, `acepta_multiples_paradas`, `acepta_rutas_programadas`, `precio_base`, `precio_por_km`, `config_json`, `fecha_creacion`, `fecha_actualizacion`, `activo`) VALUES
(1, 1234, 'transporte', 100, -31.42010000, -64.50040000, 1, 'L-D: 8-22', 4, 0, 1, 1, 500.00, 120.00, '{\"vehiculo\": \"Sedan\", \"patente\": \"AB123CD\", \"servicios_adicionales\": [\"aire_acondicionado\", \"wifi\"]}', '2025-04-11 20:24:50', '2025-04-12 05:40:16', 1),
(2, 5678, 'reparto', 80, -31.24440000, -64.46190000, 1, 'L-S: 9-20, D: 10-16', 10, 0, 1, 0, 300.00, 80.00, '{\"tipo_vehiculo\": \"Moto\", \"tiempo_estimado_por_km\": 2, \"tamanio_maximo_paquete\": \"mediano\"}', '2025-04-11 20:25:01', '2025-04-12 05:39:54', 1),
(3, 9101, 'transporte', 15, -31.08740000, -64.47960000, 1, 'L-V: 6-23, S-D: 8-21', 6, 0, 1, 1, 600.00, 130.00, '{\"vehiculo\": \"Combi\", \"patente\": \"XY789ZW\", \"servicios_adicionales\": [\"aire_acondicionado\", \"asientos_reclinables\", \"espacio_equipaje\"]}', '2025-04-11 20:25:18', '2025-04-12 05:39:31', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `noticias`
--

CREATE TABLE `noticias` (
  `id` int(11) NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `contenido` longtext NOT NULL,
  `imagen` varchar(255) DEFAULT NULL,
  `categoria` varchar(100) DEFAULT 'General',
  `user_id` int(11) DEFAULT NULL,
  `vistas` int(11) DEFAULT 0,
  `activa` tinyint(1) DEFAULT 1,
  `fecha_publicacion` datetime DEFAULT current_timestamp(),
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `lat` decimal(10,6) DEFAULT NULL COMMENT 'Latitud de la noticia',
  `lng` decimal(10,6) DEFAULT NULL COMMENT 'Longitud de la noticia',
  `ubicacion` varchar(255) DEFAULT NULL COMMENT 'Lugar al que refiere la noticia',
  `link` varchar(500) DEFAULT NULL COMMENT 'URL a la noticia completa',
  `resumen_popup` text DEFAULT NULL COMMENT 'Resumen breve para mostrar en popup del mapa',
  `tags` varchar(500) DEFAULT NULL COMMENT 'Etiquetas separadas por comas',
  `youtube_link` varchar(500) DEFAULT NULL COMMENT 'URL de YouTube para video vinculado a la noticia'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `noticias`
--

INSERT INTO `noticias` (`id`, `titulo`, `contenido`, `imagen`, `categoria`, `user_id`, `vistas`, `activa`, `fecha_publicacion`, `created_at`, `updated_at`, `lat`, `lng`, `ubicacion`, `link`, `resumen_popup`, `tags`, `youtube_link`) VALUES
(1, 'El futuro de la Hidrovía Paraná-Paraguay: ¿Dragado estatal o peaje privado?', 'La Hidrovía Paraná-Paraguay, una vía fluvial clave para el comercio en Sudamérica, se encuentra en un momento de transición. Tras décadas de concesión privada, el gobierno argentino ha asumido la administración del dragado y mantenimiento de la vía navegable. Sin embargo, el futuro modelo de gestión aún no está definido, generando debates sobre el rol del Estado y la participación privada. 📌 Importancia estratégica Transporte clave: La Hidrovía es fundamental para el transporte de granos, minera', NULL, 'Comercio Internacional', 5, 14, 1, '2026-05-01 01:12:36', '2026-05-01 01:12:36', '2026-05-02 14:32:05', -34.100744, -58.291255, 'Hidrovia Parana Paraguay', 'https://mariacelesteortiz.com.ar/noticia.php?url=el-futuro-de-la-hidrov%C3%ADa-paran%C3%A1-paraguay:-%C2%BFdragado-estatal-o-peaje-privado?', 'La Hidrovía Paraná-Paraguay, una vía fluvial clave para el comercio en Sudamérica, se encuentra en un momento de transición. Tras décadas de concesión privada, el gobierno argentino ha asumido la admi', 'economia, transporte fluvial', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ofertas`
--

CREATE TABLE `ofertas` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `precio_normal` decimal(10,2) DEFAULT NULL,
  `precio_oferta` decimal(10,2) DEFAULT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_expiracion` date DEFAULT NULL,
  `imagen_url` varchar(255) DEFAULT NULL,
  `lat` decimal(10,8) NOT NULL COMMENT 'Latitud de la oferta',
  `lng` decimal(11,8) NOT NULL COMMENT 'Longitud de la oferta',
  `business_id` int(11) DEFAULT NULL COMMENT 'ID del negocio relacionado (si aplica)',
  `activo` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `es_destacada` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `ofertas`
--

INSERT INTO `ofertas` (`id`, `nombre`, `descripcion`, `precio_normal`, `precio_oferta`, `fecha_inicio`, `fecha_expiracion`, `imagen_url`, `lat`, `lng`, `business_id`, `activo`, `created_at`, `updated_at`, `es_destacada`) VALUES
(1, '2x1 en Pizzas', 'Todos los martes, lleva 2 pizzas grandes por el precio de 1', 1200.00, 600.00, '2025-03-01', '2025-04-30', NULL, -31.24038680, -64.47176460, 11, 1, '2025-03-30 06:04:15', '2025-04-03 01:37:56', 0),
(2, 'Descuento en Laptop', 'Notebooks con 30% de descuento', 150000.00, 105000.00, '2025-03-15', '2025-04-15', NULL, -34.59895600, -58.37022900, NULL, 1, '2025-03-30 06:04:15', '2025-03-30 06:04:15', 0),
(3, 'Happy Hour extendido', 'Happy hour de 18 a 21hs todos los días', 800.00, 400.00, '2025-03-10', '2025-05-10', NULL, -34.60681700, -58.43575100, NULL, 1, '2025-03-30 06:04:15', '2025-03-30 06:04:15', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ownership_transfers`
--

CREATE TABLE `ownership_transfers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `entity_type` enum('business','brand') NOT NULL,
  `entity_id` int(11) NOT NULL,
  `from_user_id` int(11) NOT NULL,
  `to_user_id` int(11) NOT NULL,
  `status` enum('pending','accepted','rejected') NOT NULL DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `accepted_at` datetime DEFAULT NULL,
  `rejected_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `paquetes_servicios`
--

CREATE TABLE `paquetes_servicios` (
  `id` int(11) NOT NULL,
  `business_id` int(11) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `tipo` enum('sesiones','mensualidad','trimestral','semestral','anual','curso_completo') NOT NULL,
  `cantidad_sesiones` int(11) DEFAULT NULL COMMENT 'Número de sesiones incluidas (para tipo sesiones)',
  `duracion_dias` int(11) DEFAULT NULL COMMENT 'Duración en días (para membresías: 30, 90, 180, 365)',
  `sesiones_por_semana` int(11) DEFAULT NULL COMMENT 'Límite semanal de sesiones',
  `precio` decimal(10,2) NOT NULL,
  `precio_descuento` decimal(10,2) DEFAULT NULL COMMENT 'Precio con descuento si hay promoción',
  `descuento_porcentaje` int(11) DEFAULT NULL COMMENT 'Porcentaje de descuento aplicado',
  `fecha_inicio` date DEFAULT NULL COMMENT 'Fecha desde la cual se puede comprar',
  `fecha_expiracion` date DEFAULT NULL COMMENT 'Fecha límite para comprar',
  `nivel_requerido` enum('principiante','intermedio','avanzado','profesional') DEFAULT NULL COMMENT 'Nivel mínimo requerido',
  `edad_minima` int(11) DEFAULT NULL,
  `edad_maxima` int(11) DEFAULT NULL,
  `evaluacion_inicial_incluida` tinyint(1) DEFAULT 0,
  `materiales_incluidos` tinyint(1) DEFAULT 0,
  `certificado_final` tinyint(1) DEFAULT 0,
  `clase_prueba_previa` tinyint(1) DEFAULT 0,
  `cupos_disponibles` int(11) DEFAULT NULL COMMENT 'Cupos totales disponibles (NULL = ilimitado)',
  `cupos_vendidos` int(11) DEFAULT 0,
  `destacado` tinyint(1) DEFAULT 0 COMMENT 'Mostrar como destacado en el frontend',
  `orden` int(11) DEFAULT 0 COMMENT 'Orden de visualización',
  `activo` tinyint(1) DEFAULT 1,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Paquetes y planes de servicios';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `policy_lines`
--

CREATE TABLE `policy_lines` (
  `id` int(10) UNSIGNED NOT NULL,
  `source_type` enum('chamber','agency') NOT NULL,
  `source_id` int(10) UNSIGNED NOT NULL,
  `title` varchar(500) NOT NULL,
  `summary` text DEFAULT NULL,
  `line_type` enum('propia','gobierno') NOT NULL DEFAULT 'propia',
  `jurisdiction` varchar(255) DEFAULT NULL,
  `source_link` varchar(1000) DEFAULT NULL,
  `published_at` date DEFAULT NULL,
  `valid_from` date DEFAULT NULL,
  `valid_until` date DEFAULT NULL,
  `tags` varchar(500) DEFAULT NULL,
  `area` varchar(150) DEFAULT NULL,
  `status` enum('vigente','vencida','derogada') NOT NULL DEFAULT 'vigente',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `policy_lines`
--

INSERT INTO `policy_lines` (`id`, `source_type`, `source_id`, `title`, `summary`, `line_type`, `jurisdiction`, `source_link`, `published_at`, `valid_from`, `valid_until`, `tags`, `area`, `status`, `created_at`, `updated_at`) VALUES
(1, 'chamber', 1, 'Codigo de Etica Comercial', 'Normas de conducta para socios.', 'propia', 'Nacional', NULL, '2023-01-01', '2023-01-01', NULL, NULL, 'comercio', 'vigente', '2026-04-26 19:06:50', NULL),
(2, 'chamber', 2, 'Reg. de Licencias de Importacion', 'Resolucion 123/2023 sobre LNA.', 'gobierno', 'Nacional', NULL, '2023-06-01', '2023-07-01', NULL, NULL, 'comercio_exterior', 'vigente', '2026-04-26 19:06:50', NULL),
(3, 'agency', 2, 'Marco Legal de Exportaciones', 'Ley 24.425 - OMC - Regimen general.', 'gobierno', 'Nacional', NULL, '1995-01-01', '1995-01-01', NULL, NULL, 'comercio_exterior', 'vigente', '2026-04-26 19:06:50', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `polygons`
--

CREATE TABLE `polygons` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `coordinates` longtext NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `polygons`
--

INSERT INTO `polygons` (`id`, `name`, `coordinates`, `created_at`, `updated_at`) VALUES
(1, 'Area de Reparto Centro', '[[-31.409033152571638,-64.2008399963379],[-31.426026495288117,-64.200496673584],[-31.42675889774461,-64.17268753051759],[-31.409619181152895,-64.1704559326172],[-31.409033152571638,-64.2008399963379]]', '2025-04-12 19:56:22', '2025-04-12 19:56:22'),
(2, 'Zona del abasto', '[[-31.381046028549964,-64.17114257812501],[-31.415332768002248,-64.16170120239259],[-31.409765687726317,-64.1100311279297],[-31.377968401176226,-64.11981582641603],[-31.381046028549964,-64.17114257812501]]', '2025-04-13 00:27:05', '2025-04-13 00:27:05'),
(3, 'transporte carlitos', '[[-31.43129966528685,-64.25457000732423],[-31.460443225497368,-64.24787521362306],[-31.45297513680278,-64.2030715942383],[-31.425440569204103,-64.21646118164064],[-31.43129966528685,-64.25457000732423]]', '2025-04-13 00:27:20', '2025-04-13 00:27:20'),
(4, 'Transporte Ricardito', '[[-31.368881484505586,-64.28890228271486],[-31.359940273455518,-64.21903610229494],[-31.3829511759192,-64.21766281127931],[-31.40141444796409,-64.27963256835939],[-31.368881484505586,-64.28890228271486]]', '2025-04-13 00:28:09', '2025-04-13 00:28:09'),
(5, 'transporte carlitos 2', '[[-31.376356270408557,-64.1865921020508],[-31.393941656166795,-64.167537689209],[-31.39921662977518,-64.22401428222658],[-31.376356270408557,-64.1865921020508]]', '2025-04-13 01:08:01', '2025-04-13 01:08:01'),
(6, 'transporte carlitos 3', '[[-31.407861084429,-64.26881790161134],[-31.409912194070973,-64.23465728759767],[-31.434668479738775,-64.24581527709962],[-31.43217849811961,-64.28529739379884],[-31.407861084429,-64.26881790161134]]', '2025-04-13 01:17:38', '2025-04-13 01:17:38'),
(7, 'transporte carlitos 5', '[[-31.419288124288357,-64.11037445068361],[-31.394381248621443,-64.11037445068361],[-31.394381248621443,-64.05853271484376],[-31.419288124288357,-64.05853271484376],[-31.419288124288357,-64.11037445068361]]', '2025-04-13 01:27:29', '2025-04-13 01:27:29');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `portfolio_trabajos`
--

CREATE TABLE `portfolio_trabajos` (
  `id` int(11) NOT NULL,
  `business_id` int(11) NOT NULL,
  `titulo` varchar(200) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `categoria` varchar(100) DEFAULT NULL COMMENT 'Tipo de trabajo/proyecto',
  `fecha_realizacion` date DEFAULT NULL,
  `cliente_anonimo` varchar(150) DEFAULT NULL COMMENT 'Nombre genérico sin identificar: Empresa X, Cliente Y',
  `ubicacion` varchar(150) DEFAULT NULL COMMENT 'Dónde se realizó el trabajo',
  `imagen_principal` varchar(255) DEFAULT NULL,
  `imagenes_adicionales` text DEFAULT NULL COMMENT 'JSON array de URLs de imágenes',
  `video_url` varchar(255) DEFAULT NULL COMMENT 'Link a video (YouTube, Vimeo, etc)',
  `resultado_cuantificable` varchar(200) DEFAULT NULL COMMENT 'Ej: Incremento 30% eficiencia, Reducción 20% costos',
  `antes_despues` tinyint(1) DEFAULT 0 COMMENT 'Si tiene fotos antes/después',
  `tecnologias_utilizadas` text DEFAULT NULL COMMENT 'JSON array',
  `duracion_dias` int(11) DEFAULT NULL COMMENT 'Cuántos días tomó el proyecto',
  `destacado` tinyint(1) DEFAULT 0,
  `publico` tinyint(1) DEFAULT 1 COMMENT 'Si es visible públicamente',
  `orden` int(11) DEFAULT 0 COMMENT 'Orden de visualización',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Portfolio de trabajos y casos de éxito';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `preguntas_encuesta`
--

CREATE TABLE `preguntas_encuesta` (
  `id` int(11) NOT NULL,
  `encuesta_id` int(11) DEFAULT NULL,
  `texto_pregunta` text DEFAULT NULL,
  `tipo` enum('opcion_multiple','si_no','escala','escala_10','texto') NOT NULL DEFAULT 'opcion_multiple',
  `opciones` text DEFAULT NULL,
  `orden` int(11) DEFAULT NULL,
  `requerida` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1 = respuesta obligatoria para enviar el formulario'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `preguntas_encuesta`
--

INSERT INTO `preguntas_encuesta` (`id`, `encuesta_id`, `texto_pregunta`, `tipo`, `opciones`, `orden`, `requerida`) VALUES
(15, 7, 'Horario de atención por la mañana', 'opcion_multiple', '08:00 a 13:00 hs,09:00 a 14:00', 1, 0),
(16, 7, 'Horario de atención por la tarde', 'opcion_multiple', '15:00 a 19:00 hs,16:00 a 20:00 hs', 2, 0),
(17, 7, 'Horarios de corrido 09:00 a 18:00', 'opcion_multiple', 'si,no', 3, 0),
(19, 8, '¿Qué servicios son menos atendidos por la Muni?', 'opcion_multiple', 'Agua,Luz,Estado de calles,Iluminación,Residuos,Falta de espacios verdes', 1, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id` int(11) NOT NULL,
  `business_id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `precio` decimal(10,2) NOT NULL,
  `stock` int(11) DEFAULT 0,
  `imagen` varchar(255) DEFAULT NULL,
  `categoria` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `profesionales`
--

CREATE TABLE `profesionales` (
  `id` int(11) NOT NULL,
  `business_id` int(11) NOT NULL,
  `profesion` varchar(100) DEFAULT NULL,
  `especialidad` varchar(100) DEFAULT NULL,
  `matricula` varchar(50) DEFAULT NULL,
  `horario_atencion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `promociones`
--

CREATE TABLE `promociones` (
  `id` int(11) NOT NULL,
  `business_id` int(11) NOT NULL,
  `titulo` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `descuento` varchar(50) DEFAULT NULL,
  `fecha_inicio` date DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL,
  `imagen` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `radar_contract_types`
--

CREATE TABLE `radar_contract_types` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `category` enum('compraventa','llave_en_mano','agencia','distribucion','inversion_activos','inversion_financiera','joint_venture','otro') NOT NULL,
  `description` text DEFAULT NULL,
  `key_points` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `radar_contract_types`
--

INSERT INTO `radar_contract_types` (`id`, `name`, `category`, `description`, `key_points`, `created_at`) VALUES
(1, 'Compraventa Internacional', 'compraventa', 'Contrato regido por la CISG o derecho local', 'Incoterms, forma de pago, entrega, inspeccion', '2026-04-26 19:06:50'),
(2, 'Contrato Llave en Mano', 'llave_en_mano', 'El proveedor entrega la obra terminada y en funcionamiento', 'Precio global, plazo, penalidades, transferencia tecnologica', '2026-04-26 19:06:50'),
(3, 'Contrato de Agencia Internacional', 'agencia', 'Representacion comercial internacional', 'Exclusividad, territorio, comisiones, resolucion', '2026-04-26 19:06:50'),
(4, 'Inversion en Activos (FDI)', 'inversion_activos', 'Adquisicion de bienes o empresas en el extranjero', 'Marco cambiario, giro de utilidades, proteccion de inversion', '2026-04-26 19:06:50'),
(5, 'Inversion Financiera Internacional', 'inversion_financiera', 'Participacion en instrumentos financieros extranjeros', 'Regimen cambiario, tratados, riesgos de volatilidad', '2026-04-26 19:06:50'),
(6, 'Joint Venture Internacional', 'joint_venture', 'Empresa conjunta con socios extranjeros', 'Aporte de capital, gobierno, exit, derecho aplicable', '2026-04-26 19:06:50');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `radar_destinations`
--

CREATE TABLE `radar_destinations` (
  `id` int(10) UNSIGNED NOT NULL,
  `direction` enum('importacion','exportacion') NOT NULL,
  `name` varchar(255) NOT NULL,
  `code` varchar(20) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `radar_destinations`
--

INSERT INTO `radar_destinations` (`id`, `direction`, `name`, `code`, `description`, `created_at`) VALUES
(1, 'importacion', 'Despacho a plaza', 'IM4', 'Importacion definitiva a consumo', '2026-04-26 19:06:50'),
(2, 'importacion', 'Importacion temporal', 'IM5', 'Admision temporaria para perfeccionamiento activo', '2026-04-26 19:06:50'),
(3, 'exportacion', 'Exportacion definitiva', 'EX1', 'Exportacion definitiva para consumo', '2026-04-26 19:06:50'),
(4, 'exportacion', 'Exportacion temporaria', 'EX2', 'Exportacion temporal con reimportacion prevista', '2026-04-26 19:06:50');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `radar_disputes`
--

CREATE TABLE `radar_disputes` (
  `id` int(10) UNSIGNED NOT NULL,
  `dispute_type` enum('infraccion_aduanera','incumplimiento_normativo','delito_aduanero','otro') NOT NULL,
  `name` varchar(255) NOT NULL,
  `legal_basis` varchar(500) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `sanction_range` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `radar_ports`
--

CREATE TABLE `radar_ports` (
  `id` int(10) UNSIGNED NOT NULL,
  `transport_mode_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `country` varchar(100) DEFAULT NULL,
  `un_locode` varchar(10) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `radar_ports`
--

INSERT INTO `radar_ports` (`id`, `transport_mode_id`, `name`, `country`, `un_locode`, `notes`, `created_at`) VALUES
(1, 1, 'Puerto de Buenos Aires', 'Argentina', 'ARBUE', NULL, '2026-04-26 19:06:50'),
(2, 1, 'Puerto de Rosario', 'Argentina', 'ARROS', NULL, '2026-04-26 19:06:50'),
(3, 1, 'Puerto de Bahia Blanca', 'Argentina', 'ARBHI', NULL, '2026-04-26 19:06:50'),
(4, 1, 'Puerto de Santos', 'Brasil', 'BRSSZ', NULL, '2026-04-26 19:06:50'),
(5, 1, 'Puerto de Valparaiso', 'Chile', 'CLVAP', NULL, '2026-04-26 19:06:50');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `radar_restrictions`
--

CREATE TABLE `radar_restrictions` (
  `id` int(10) UNSIGNED NOT NULL,
  `restriction_type` enum('prohibicion','dumping','licencia_automatica','licencia_no_automatica','cuota','otro') NOT NULL,
  `name` varchar(255) NOT NULL,
  `destination_id` int(10) UNSIGNED DEFAULT NULL,
  `legal_basis` varchar(500) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `valid_from` date DEFAULT NULL,
  `valid_until` date DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `radar_restrictions`
--

INSERT INTO `radar_restrictions` (`id`, `restriction_type`, `name`, `destination_id`, `legal_basis`, `description`, `valid_from`, `valid_until`, `created_at`) VALUES
(1, 'licencia_no_automatica', 'Licencias No Automaticas de Importacion', NULL, 'Res. 5/2015 MINCETUR', 'Requieren aprobacion previa segun producto y origen.', NULL, NULL, '2026-04-26 19:06:50'),
(2, 'dumping', 'Derecho Antidumping', NULL, 'Ley 24.425', 'Proteccion contra importacion a precios inferiores al costo.', NULL, NULL, '2026-04-26 19:06:50'),
(3, 'prohibicion', 'Prohibicion de importacion (lista roja)', NULL, 'Decreto 509/2007', 'Lista de productos con prohibicion de ingreso al territorio.', NULL, NULL, '2026-04-26 19:06:50');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `radar_transport_modes`
--

CREATE TABLE `radar_transport_modes` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `mode` enum('maritimo','aereo','terrestre','multimodal') NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `radar_transport_modes`
--

INSERT INTO `radar_transport_modes` (`id`, `name`, `mode`, `description`, `created_at`) VALUES
(1, 'Maritimo', 'maritimo', 'Transporte de carga por via maritima', '2026-04-26 19:06:50'),
(2, 'Aereo', 'aereo', 'Transporte de carga por via aerea', '2026-04-26 19:06:50'),
(3, 'Terrestre', 'terrestre', 'Transporte de carga por via terrestre', '2026-04-26 19:06:50'),
(4, 'Multimodal', 'multimodal', 'Combinacion de dos o mas modos de transporte', '2026-04-26 19:06:50');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rate_limit_log`
--

CREATE TABLE `rate_limit_log` (
  `id` int(10) UNSIGNED NOT NULL,
  `ip` varchar(45) NOT NULL,
  `endpoint` varchar(100) NOT NULL,
  `hit_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `rate_limit_log`
--

INSERT INTO `rate_limit_log` (`id`, `ip`, `endpoint`, `hit_at`) VALUES
(23, '181.105.137.31', 'login', '2026-04-29 23:26:29'),
(24, '181.105.137.31', 'login', '2026-04-29 23:38:01'),
(25, '181.105.137.31', 'login', '2026-04-29 23:38:08'),
(26, '181.105.137.31', 'login', '2026-04-29 23:38:12'),
(27, '181.105.137.31', 'login', '2026-04-29 23:38:18'),
(28, '181.105.137.31', 'login', '2026-04-29 23:38:37'),
(29, '181.105.137.31', 'login', '2026-04-29 23:38:43'),
(38, '181.105.137.31', 'login', '2026-05-01 12:52:59'),
(39, '181.105.137.31', 'login', '2026-05-01 12:53:11'),
(40, '181.105.137.31', 'login', '2026-05-01 12:53:15'),
(6, '181.9.226.160', 'login', '2026-04-24 21:33:07'),
(21, '190.210.36.18', 'login', '2026-04-29 17:35:22'),
(12, '201.235.95.238', 'consulta_reply', '2026-04-27 00:01:42'),
(11, '201.235.95.238', 'consulta_send', '2026-04-27 00:00:51'),
(13, '201.235.95.238', 'consulta_send', '2026-04-27 19:24:02'),
(14, '201.235.95.238', 'consulta_send', '2026-04-27 19:25:06'),
(16, '201.235.95.238', 'consulta_send', '2026-04-28 21:48:10'),
(36, '201.235.95.238', 'consulta_send', '2026-05-01 00:37:12'),
(5, '201.235.95.238', 'login', '2026-04-24 18:43:46'),
(7, '201.235.95.238', 'login', '2026-04-25 02:49:30'),
(8, '201.235.95.238', 'login', '2026-04-25 12:35:38'),
(9, '201.235.95.238', 'login', '2026-04-25 17:30:01'),
(10, '201.235.95.238', 'login', '2026-04-25 23:48:12'),
(15, '201.235.95.238', 'login', '2026-04-28 21:43:16'),
(17, '201.235.95.238', 'login', '2026-04-29 00:08:33'),
(18, '201.235.95.238', 'login', '2026-04-29 00:21:43'),
(19, '201.235.95.238', 'login', '2026-04-29 09:58:27'),
(20, '201.235.95.238', 'login', '2026-04-29 17:03:51'),
(30, '201.235.95.238', 'login', '2026-04-30 02:51:53'),
(32, '201.235.95.238', 'login', '2026-04-30 12:36:50'),
(33, '201.235.95.238', 'login', '2026-04-30 20:47:42'),
(34, '201.235.95.238', 'login', '2026-04-30 22:45:12'),
(37, '201.235.95.238', 'login', '2026-05-01 01:00:38'),
(41, '201.235.95.238', 'login', '2026-05-02 13:56:27'),
(42, '201.235.95.238', 'login', '2026-05-02 14:55:23'),
(43, '201.235.95.238', 'login', '2026-05-02 14:56:48'),
(44, '201.235.95.238', 'login', '2026-05-02 15:25:39'),
(45, '201.235.95.238', 'login', '2026-05-02 15:26:56'),
(22, '2800:40:76:b6ce:d0a0:e727:6f3:9f28', 'review_post', '2026-04-29 18:48:41'),
(35, '2803:68e0:213:3d00:98a7:fc40:b451:5262', 'login', '2026-05-01 00:13:16'),
(31, '2803:9800:9881:b4ba:45e3:9fe3:8cd2:c857', 'login', '2026-04-30 04:16:24');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `remates`
--

CREATE TABLE `remates` (
  `id` int(10) UNSIGNED NOT NULL,
  `business_id` int(11) NOT NULL,
  `titulo` varchar(255) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `fecha_inicio` datetime NOT NULL,
  `fecha_fin` datetime DEFAULT NULL,
  `fecha_cierre` datetime DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reservas`
--

CREATE TABLE `reservas` (
  `id` int(11) NOT NULL,
  `business_id` int(11) NOT NULL,
  `usuario_id` int(11) DEFAULT NULL COMMENT 'NULL si es reserva sin login',
  `nombre_cliente` varchar(150) DEFAULT NULL,
  `email_cliente` varchar(150) DEFAULT NULL,
  `telefono_cliente` varchar(20) DEFAULT NULL,
  `fecha_reserva` date NOT NULL,
  `hora_inicio` time NOT NULL,
  `hora_fin` time NOT NULL,
  `duracion_minutos` int(11) DEFAULT NULL COMMENT 'Duración calculada',
  `tipo_sesion` enum('individual','grupal','taller','evaluacion','clase_prueba') DEFAULT 'individual',
  `nivel` enum('principiante','intermedio','avanzado','profesional') DEFAULT NULL,
  `modalidad` enum('presencial','online','domicilio') DEFAULT 'presencial',
  `direccion_servicio` varchar(255) DEFAULT NULL,
  `lat_servicio` decimal(10,8) DEFAULT NULL,
  `lng_servicio` decimal(11,8) DEFAULT NULL,
  `paquete_id` int(11) DEFAULT NULL COMMENT 'FK a compras_paquetes si la reserva consume de un paquete',
  `sesion_numero` int(11) DEFAULT NULL COMMENT 'Número de sesión dentro del paquete',
  `estado` enum('pendiente','confirmada','en_proceso','completada','cancelada','no_asistio') DEFAULT 'pendiente',
  `confirmada_por_proveedor` tinyint(1) DEFAULT 0,
  `fecha_confirmacion` timestamp NULL DEFAULT NULL,
  `precio_acordado` decimal(10,2) DEFAULT NULL,
  `pagado` tinyint(1) DEFAULT 0,
  `metodo_pago` enum('efectivo','transferencia','tarjeta','mercadopago','otro') DEFAULT NULL,
  `fecha_pago` timestamp NULL DEFAULT NULL,
  `notas_cliente` text DEFAULT NULL COMMENT 'Notas/comentarios del cliente al reservar',
  `notas_proveedor` text DEFAULT NULL COMMENT 'Notas internas del proveedor',
  `motivo_cancelacion` text DEFAULT NULL,
  `fecha_cancelacion` timestamp NULL DEFAULT NULL,
  `cancelado_por` enum('cliente','proveedor','sistema') DEFAULT NULL,
  `recordatorio_enviado` tinyint(1) DEFAULT 0,
  `fecha_recordatorio` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Reservas y citas de servicios';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `respuestas_encuesta`
--

CREATE TABLE `respuestas_encuesta` (
  `id` int(11) NOT NULL,
  `encuesta_id` int(11) DEFAULT NULL,
  `pregunta_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `respuesta` text DEFAULT NULL,
  `fecha_respuesta` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `respuestas_encuesta`
--

INSERT INTO `respuestas_encuesta` (`id`, `encuesta_id`, `pregunta_id`, `user_id`, `respuesta`, `fecha_respuesta`) VALUES
(7, 7, 15, 5, '08:00 a 13:00 hs', '2026-05-02 14:26:09'),
(8, 7, 16, 5, '15:00 a 19:00 hs', '2026-05-02 14:26:09'),
(9, 7, 17, 5, 'si', '2026-05-02 14:26:09'),
(10, 8, 19, 5, 'Estado de calles', '2026-05-02 15:32:14');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `restaurantes`
--

CREATE TABLE `restaurantes` (
  `id` int(11) NOT NULL,
  `business_id` int(11) NOT NULL,
  `mesas` int(11) DEFAULT NULL,
  `carta` text DEFAULT NULL,
  `horario_apertura` time DEFAULT NULL,
  `horario_cierre` time DEFAULT NULL,
  `dias_cierre` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reviews`
--

CREATE TABLE `reviews` (
  `id` int(11) NOT NULL,
  `business_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `rating` tinyint(4) NOT NULL,
  `comment` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ;

--
-- Volcado de datos para la tabla `reviews`
--

INSERT INTO `reviews` (`id`, `business_id`, `user_id`, `rating`, `comment`, `created_at`) VALUES
(2, 9162, 8, 5, 'Que loco este sitio, permite auto reseñas... Me quiero mucho jaja, te invito a probar como te puedo ayudar', '2026-04-29 18:48:41');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `riesgo_legal`
--

CREATE TABLE `riesgo_legal` (
  `id` int(11) NOT NULL,
  `marca_id` int(11) NOT NULL,
  `riesgo_oposicion` text DEFAULT NULL,
  `riesgo_nulidad` text DEFAULT NULL,
  `riesgo_infraccion` text DEFAULT NULL,
  `estrategias_defensivas` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sector_radar_settings`
--

CREATE TABLE `sector_radar_settings` (
  `id` int(10) UNSIGNED NOT NULL,
  `sector_type` enum('industrial','commercial') NOT NULL,
  `sector_id` int(10) UNSIGNED NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `notes` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `servicios_profesionales`
--

CREATE TABLE `servicios_profesionales` (
  `id` int(11) NOT NULL,
  `business_id` int(11) NOT NULL,
  `categoria_servicio` enum('educativo','deportivo','industrial','tecnico') NOT NULL,
  `subcategoria` varchar(100) DEFAULT NULL COMMENT 'Ej: clases_particulares, entrenamiento_personal, mantenimiento',
  `modalidad_presencial` tinyint(1) DEFAULT 1,
  `modalidad_online` tinyint(1) DEFAULT 0,
  `modalidad_hibrido` tinyint(1) DEFAULT 0,
  `modalidad_domicilio` tinyint(1) DEFAULT 0,
  `capacidad_maxima_simultanea` int(11) DEFAULT NULL COMMENT 'Cupos por sesión',
  `duracion_sesion_minutos` int(11) DEFAULT NULL COMMENT 'Duración estándar de una sesión',
  `acepta_reservas` tinyint(1) DEFAULT 1,
  `requiere_reserva_previa` tinyint(1) DEFAULT 0,
  `anticipacion_minima_horas` int(11) DEFAULT 24 COMMENT 'Horas de anticipación mínima para reservar',
  `nivel_principiante` tinyint(1) DEFAULT 1,
  `nivel_intermedio` tinyint(1) DEFAULT 1,
  `nivel_avanzado` tinyint(1) DEFAULT 1,
  `nivel_profesional` tinyint(1) DEFAULT 0,
  `precio_sesion_individual` decimal(10,2) DEFAULT NULL COMMENT 'Precio por sesión individual',
  `precio_sesion_grupal` decimal(10,2) DEFAULT NULL COMMENT 'Precio por sesión grupal',
  `precio_paquete_5_sesiones` decimal(10,2) DEFAULT NULL,
  `precio_paquete_10_sesiones` decimal(10,2) DEFAULT NULL,
  `precio_mensualidad` decimal(10,2) DEFAULT NULL,
  `precio_trimestral` decimal(10,2) DEFAULT NULL,
  `precio_anual` decimal(10,2) DEFAULT NULL,
  `precio_evaluacion_inicial` decimal(10,2) DEFAULT NULL COMMENT 'Para servicios industriales/evaluaciones',
  `precio_clase_prueba` decimal(10,2) DEFAULT 0.00 COMMENT 'Clase de prueba, puede ser gratis (0)',
  `equipamiento_incluido` text DEFAULT NULL COMMENT 'JSON array: ["pesas", "colchonetas", "etc"]',
  `instalaciones_disponibles` text DEFAULT NULL COMMENT 'JSON array: ["vestuarios", "ducha", "estacionamiento"]',
  `certificaciones` text DEFAULT NULL COMMENT 'JSON array de certificados',
  `anios_experiencia` int(11) DEFAULT 0 COMMENT 'Años de experiencia del profesional',
  `formacion_academica` text DEFAULT NULL COMMENT 'Descripción de formación',
  `politica_cancelacion` text DEFAULT NULL COMMENT 'Política de cancelación del servicio',
  `requisitos_previos` text DEFAULT NULL COMMENT 'Requisitos previos del cliente',
  `materiales_incluidos` text DEFAULT NULL COMMENT 'JSON array de materiales incluidos',
  `ofrece_certificado` tinyint(1) DEFAULT 0 COMMENT 'Si entrega certificado al finalizar',
  `duracion_curso_completo` int(11) DEFAULT NULL COMMENT 'Duración total en días si es un curso',
  `activo` tinyint(1) DEFAULT 1,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Información específica de servicios profesionales';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `share_tokens`
--

CREATE TABLE `share_tokens` (
  `id` int(11) NOT NULL,
  `token` varchar(64) NOT NULL,
  `encuesta_id` int(11) NOT NULL,
  `evento_id` int(11) DEFAULT NULL,
  `oferta_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `expiry_date` datetime NOT NULL DEFAULT (current_timestamp() + interval 48 hour)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `share_tokens`
--

INSERT INTO `share_tokens` (`id`, `token`, `encuesta_id`, `evento_id`, `oferta_id`, `user_id`, `created_at`, `expiry_date`) VALUES
(7, 'bf6bb9958ad9df65f27e4a3b23ec4311', 3, NULL, NULL, 2, '2025-04-06 02:50:08', '2025-04-08 02:50:08'),
(8, '57eb8066047f886eb808158f7efb0fa1', 0, NULL, 3, 2, '2025-04-06 02:50:20', '2025-04-08 02:50:20'),
(9, 'd5e0367a2bf1d2003f20cbd7839c0214', 5, NULL, NULL, 2, '2025-04-07 02:40:08', '2025-04-09 02:40:08'),
(11, 'c8c757119e089325eb7c392f24cf3b3e', 0, 1, NULL, 2, '2025-04-11 13:25:09', '2025-04-13 13:25:09'),
(12, 'eb09f1bfdf9cb643be92dfb827026753', 0, NULL, 1, 2, '2025-04-12 02:44:52', '2025-04-14 02:44:52'),
(14, '490fb6eee9c090877a3038991cf45fb0', 4, NULL, NULL, 2, '2025-10-08 00:59:16', '2025-10-10 00:59:16'),
(15, 'e459164ce9007049021b33952075c819', 0, 4, NULL, 2, '2025-10-25 18:03:53', '2025-10-27 18:03:53'),
(16, '017f195dd53fc49a7287a10dd4490a72', 0, 4, NULL, 5, '2026-04-10 19:06:07', '2026-04-12 19:06:07');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `subcategories`
--

CREATE TABLE `subcategories` (
  `id` int(11) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `slug` varchar(100) DEFAULT NULL,
  `icon` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `subcategories`
--

INSERT INTO `subcategories` (`id`, `category_id`, `name`, `slug`, `icon`) VALUES
(1, 1, 'Comercio', 'comercio', '🛍️'),
(2, 1, 'Hotel', 'hotel', '🏨'),
(3, 1, 'Restaurante', 'restaurante', '🍽️'),
(4, 1, 'Inmobiliaria', 'inmobiliaria', '🏠'),
(5, 1, 'Farmacia', 'farmacia', '💊'),
(6, 2, 'Cafetería', 'cafeteria', '☕️'),
(7, 2, 'Heladería', 'heladeria', '🍦'),
(8, 2, 'Pastelería', 'pasteleria', '🍰'),
(9, 2, 'Bar', 'bar', '🍹'),
(10, 2, 'Comida Rápida', 'comida_rapida', '🍔'),
(11, 3, 'Gimnasio', 'gimnasio', '🏋️‍♂️'),
(12, 3, 'Spa', 'spa', '🧖‍♀️'),
(13, 3, 'Peluquería', 'peluqueria', '💇‍♀️'),
(14, 3, 'Barbería', 'barberia', '💈'),
(15, 3, 'Estética', 'estetica', '💅'),
(16, 4, 'Abogacía', 'abogacia', '⚖️'),
(17, 4, 'Escribanía', 'escribania', '📜'),
(18, 4, 'Contabilidad', 'contabilidad', '📊'),
(19, 4, 'Diseño Gráfico', 'diseno_grafico', '🎨'),
(20, 4, 'Informática', 'informatica', '💻'),
(21, 5, 'Clínica', 'clinica', '🏥'),
(22, 5, 'Laboratorio', 'laboratorio', '🔬'),
(23, 5, 'Veterinaria', 'veterinaria', '🐶'),
(24, 5, 'Dentista', 'dentista', '🦷'),
(25, 5, 'Óptica', 'optica', '👓'),
(26, 6, 'Decoración', 'decoracion', '🛋️'),
(27, 6, 'Jardinería', 'jardineria', '🌳'),
(28, 6, 'Ferretería', 'ferreteria', '🛠️'),
(29, 6, 'Electricidad', 'electricidad', '💡'),
(30, 6, 'Plomería', 'plomeria', '🚿'),
(31, 7, 'Cine', 'cine', '🎬'),
(32, 7, 'Teatro', 'teatro', '🎭'),
(33, 7, 'Discoteca', 'discoteca', '💃'),
(34, 7, 'Karaoke', 'karaoke', '🎤'),
(35, 7, 'Juegos', 'juegos', '🎲'),
(36, 1, 'comercio', NULL, '🛍️'),
(37, 1, 'hotel', NULL, '🏨'),
(38, 1, 'restaurante', NULL, '🍽️'),
(39, 1, 'inmobiliaria', NULL, '🏠'),
(40, 1, 'farmacia', NULL, '💊'),
(41, 2, 'cafeteria', NULL, '☕️'),
(42, 2, 'heladeria', NULL, '🍦'),
(43, 2, 'pasteleria', NULL, '🍰'),
(44, 2, 'bar', NULL, '🍹'),
(45, 2, 'comida_rapida', NULL, '🍔'),
(46, 3, 'gimnasio', NULL, '🏋️‍♂️'),
(47, 3, 'spa', NULL, '🧖‍♀️'),
(48, 3, 'peluqueria', NULL, '💇‍♀️'),
(49, 3, 'barberia', NULL, '💈'),
(50, 3, 'estetica', NULL, '💅'),
(51, 4, 'abogacia', NULL, '⚖️'),
(52, 4, 'escribania', NULL, '📜'),
(53, 4, 'contabilidad', NULL, '📊'),
(54, 4, 'diseno_grafico', NULL, '🎨'),
(55, 4, 'informatica', NULL, '💻'),
(56, 5, 'clinica', NULL, '🏥'),
(57, 5, 'laboratorio', NULL, '🔬'),
(58, 5, 'veterinaria', NULL, '🐶'),
(59, 5, 'dentista', NULL, '🦷'),
(60, 5, 'optica', NULL, '👓'),
(61, 6, 'decoracion', NULL, '🛋️'),
(62, 6, 'jardineria', NULL, '🌳'),
(63, 6, 'ferreteria', NULL, '🛠️'),
(64, 6, 'electricidad', NULL, '💡'),
(65, 6, 'plomeria', NULL, '🚰'),
(66, 7, 'cine', NULL, '🎬'),
(67, 7, 'teatro', NULL, '🎭'),
(68, 7, 'discoteca', NULL, '💃'),
(69, 7, 'karaoke', NULL, '🎤'),
(70, 7, 'juegos', NULL, '🎲');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `system_config`
--

CREATE TABLE `system_config` (
  `id` int(11) NOT NULL,
  `config_key` varchar(100) NOT NULL,
  `config_value` text NOT NULL,
  `config_description` varchar(255) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `system_config`
--

INSERT INTO `system_config` (`id`, `config_key`, `config_value`, `config_description`, `updated_at`) VALUES
(1, 'upload_max_size', '1000000', 'Tamaño máximo para subidas de archivos (en bytes)', '2025-03-19 20:50:49'),
(2, 'upload_images_path', 'uploads/images', 'Ruta para subidas de imágenes', '2025-03-19 20:50:49'),
(3, 'upload_files_path', 'uploads/files', 'Ruta para subidas de archivos generales', '2025-03-19 20:50:49'),
(4, 'max_images_business', '2', 'Número máximo de imágenes por negocio', '2025-03-19 20:50:49'),
(5, 'max_images_emoji', '10', 'Número máximo de imágenes por emoji', '2025-03-19 20:50:49'),
(6, 'optimize_images', '1', 'Optimizar imágenes automáticamente (1=sí, 0=no)', '2025-03-19 20:50:49'),
(7, 'optimize_threshold', '500000', 'Umbral de tamaño para optimización de imágenes (en bytes)', '2025-03-19 20:50:49'),
(8, 'site_name', 'Mapita', 'Nombre del sitio', '2025-03-19 20:50:49'),
(9, 'admin_email', 'admin@mapita.com.ar', 'Email de administración', '2025-03-19 20:50:49');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `transmisiones`
--

CREATE TABLE `transmisiones` (
  `id` int(11) NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `tipo` enum('youtube_live','youtube_video','radio_stream','audio_stream','video_stream') NOT NULL DEFAULT 'youtube_live' COMMENT 'youtube_live=YouTube en vivo, youtube_video=YouTube grabado, radio_stream=radio online (Icecast/Shoutcast), audio_stream=audio generico, video_stream=HLS/RTMP',
  `stream_url` varchar(500) DEFAULT NULL,
  `lat` decimal(10,8) DEFAULT NULL,
  `lng` decimal(11,8) DEFAULT NULL,
  `business_id` int(11) DEFAULT NULL,
  `evento_id` int(11) DEFAULT NULL,
  `en_vivo` tinyint(1) NOT NULL DEFAULT 0,
  `activo` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fecha_inicio` datetime DEFAULT NULL COMMENT 'Fecha y hora de inicio programada de la transmisión',
  `fecha_fin` datetime DEFAULT NULL COMMENT 'Fecha y hora de fin programada de la transmisión'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `transmisiones`
--

INSERT INTO `transmisiones` (`id`, `titulo`, `descripcion`, `tipo`, `stream_url`, `lat`, `lng`, `business_id`, `evento_id`, `en_vivo`, `activo`, `created_at`, `updated_at`, `fecha_inicio`, `fecha_fin`) VALUES
(3, 'Historia de Paris - Francia', 'Historia de Francia - desde 259 A.C hasta hoy.', 'youtube_live', 'https://youtu.be/PP8XsbBThC0?si=IwqHZCBZywjQnYal', 48.84854120, 2.34839780, NULL, NULL, 1, 0, '2026-04-26 01:15:57', '2026-04-26 01:20:47', NULL, NULL),
(4, 'Historia de Paris', 'Historia de la ciudad de Paris desde 258 AC hasta hoy. Canal: Momentos Históricos.', 'youtube_video', 'https://youtu.be/PP8XsbBThC0?si=yStUJhscgtpEopJ-', 48.84827010, 2.34155660, NULL, NULL, 0, 1, '2026-04-26 01:59:24', '2026-04-26 01:59:24', NULL, NULL),
(5, 'Radio Juntos - FM 94.1', 'Empresa productora de medios y radiodifusión', 'radio_stream', 'https://www.radiojuntos.com.ar/', -31.94279630, -65.18589030, NULL, NULL, 0, 1, '2026-04-29 01:01:21', '2026-04-29 01:01:21', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `transmisiones_vivo`
--

CREATE TABLE `transmisiones_vivo` (
  `id` int(11) NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `tipo` enum('youtube','audio_streaming','zoom_publico') DEFAULT NULL,
  `youtube_stream_url` text DEFAULT NULL,
  `audio_provider` varchar(100) DEFAULT NULL,
  `audio_stream_url` text DEFAULT NULL,
  `organizador_id` int(11) DEFAULT NULL,
  `fecha_inicio` datetime DEFAULT NULL,
  `fecha_fin` datetime DEFAULT NULL,
  `estado` enum('programada','en_vivo','finalizada','cancelada') DEFAULT NULL,
  `visitas` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `transmision_participantes`
--

CREATE TABLE `transmision_participantes` (
  `id` int(11) NOT NULL,
  `transmision_id` int(11) DEFAULT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `fecha_union` timestamp NULL DEFAULT NULL,
  `duracion_minutos` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `transporte`
--

CREATE TABLE `transporte` (
  `id` int(11) NOT NULL,
  `business_id` int(11) NOT NULL,
  `tipo_unidad` varchar(50) DEFAULT NULL,
  `rutas` text DEFAULT NULL,
  `horarios` text DEFAULT NULL,
  `capacidad` int(11) DEFAULT NULL,
  `precio_base` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `transporte_asignaciones`
--

CREATE TABLE `transporte_asignaciones` (
  `id` int(11) NOT NULL,
  `transportista_nombre` varchar(255) NOT NULL COMMENT 'Nombre del transportista asignado',
  `negocio_id` int(11) NOT NULL COMMENT 'ID del negocio asignado (FK a tabla negocios)',
  `negocio_nombre` varchar(255) NOT NULL COMMENT 'Nombre del negocio asignado',
  `fecha_asignacion` datetime NOT NULL COMMENT 'Fecha y hora de la asignación',
  `creado_en` timestamp NULL DEFAULT current_timestamp(),
  `actualizado_en` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `nombre_zona` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `transporte_asignaciones`
--

INSERT INTO `transporte_asignaciones` (`id`, `transportista_nombre`, `negocio_id`, `negocio_nombre`, `fecha_asignacion`, `creado_en`, `actualizado_en`, `nombre_zona`) VALUES
(1, 'Prueba Transportista', 1, 'Negocio de Prueba', '2025-04-12 15:00:00', '2025-04-13 01:21:53', '2025-04-13 01:21:53', NULL),
(2, 'Transportista Ejemplo', 2, '🥩 Carnicería El Gaucho', '2025-04-13 02:04:33', '2025-04-13 02:04:38', '2025-04-13 02:04:38', NULL),
(3, 'Transportista Ejemplo', 1, '🛒 Supermercado Central', '2025-04-13 02:08:36', '2025-04-13 02:08:42', '2025-04-13 02:08:42', 'ruta3'),
(4, 'Transportista Ejemplo', 2, '🥩 Carnicería El Gaucho', '2025-04-13 02:08:36', '2025-04-13 02:08:42', '2025-04-13 02:08:42', 'ruta3');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `trivias`
--

CREATE TABLE `trivias` (
  `id` int(11) NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `dificultad` enum('facil','medio','dificil') NOT NULL DEFAULT 'medio',
  `tiempo_limite` int(11) NOT NULL DEFAULT 30,
  `activa` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `lat` decimal(10,6) DEFAULT NULL COMMENT 'Latitud donde se realiza la trivia',
  `lng` decimal(10,6) DEFAULT NULL COMMENT 'Longitud donde se realiza la trivia',
  `ubicacion` varchar(255) DEFAULT NULL COMMENT 'Nombre del lugar',
  `business_id` int(11) DEFAULT NULL COMMENT 'Negocio que la organiza',
  `svg` varchar(500) DEFAULT NULL COMMENT 'URL o path a imagen SVG ilustrativa',
  `referencia` varchar(255) DEFAULT NULL COMMENT 'Referencia del juego',
  `tipo` varchar(100) DEFAULT NULL COMMENT 'Tipo de juego',
  `edad` varchar(50) DEFAULT NULL COMMENT 'Edad recomendada',
  `emojis` varchar(255) DEFAULT NULL COMMENT 'Emojis decorativos del popup',
  `app_path` varchar(500) DEFAULT NULL COMMENT 'Path relativo del archivo PHP de la app (dentro de apps/trivias/)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `trivia_games`
--

CREATE TABLE `trivia_games` (
  `game_id` varchar(32) NOT NULL,
  `question_order` text NOT NULL,
  `current_question_ptr` int(11) NOT NULL,
  `score` int(11) NOT NULL DEFAULT 0,
  `errors` int(11) NOT NULL DEFAULT 0,
  `game_active` tinyint(1) NOT NULL DEFAULT 1,
  `feedback` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `trivia_games`
--

INSERT INTO `trivia_games` (`game_id`, `question_order`, `current_question_ptr`, `score`, `errors`, `game_active`, `feedback`, `created_at`, `updated_at`) VALUES
('0531179206c7b18612b41f6521e3c039', '[5,24,28,27,22,6,19,15,23,14,26,20,12,16,9,1,13,4,0,3,21,8,11,25,17,2,18,7,29,10]', 0, 0, 0, 1, NULL, '2025-04-03 02:53:29', '2025-04-03 02:53:29'),
('1af8c1e2301ad97cbdd84f91b71cb563', '[23,9,5,29,20,14,28,8,26,10,2,7,15,27,17,19,1,24,0,12,11,13,22,16,4,21,18,6,3,25]', 0, 0, 0, 1, NULL, '2025-10-25 18:02:51', '2025-10-25 18:02:51'),
('48d26e5fef6083a31467441d5600f432', '[24,23,7,28,22,20,15,13,26,8,9,6,18,27,21,2,19,3,11,17,16,0,14,4,1,5,29,25,10,12]', 16, 64, 0, 0, '<p class=\'feedback correct\'>¡Correcto! 👍 +4 puntos.</p>', '2025-04-03 18:06:28', '2025-04-03 18:08:12'),
('4fa9ab3793f67f025e0cb54c27982c5c', '[6,11,12,2,9,14,1,7,19,28,5,17,13,4,20,0,27,22,16,23,18,29,21,3,24,8,15,26,10,25]', 16, 52, 3, 0, '<p class=\'feedback incorrect\'>¡Incorrecto! 👎 La respuesta correcta era: <strong>A) Verdadero</strong>.</p>', '2025-04-03 03:30:11', '2025-04-03 03:32:48'),
('6bcb86e5e77c4ccab24a0d518ac7f10e', '[9,21,29,22,23,11,2,16,24,10,28,8,13,17,20,4,12,25,15,5,7,14,19,18,6,1,3,27,0,26]', 16, 64, 0, 0, '<p class=\'feedback correct\'>¡Correcto! 👍 +4 puntos.</p>', '2025-04-03 17:45:14', '2025-04-03 17:47:24'),
('77324139d50675bfed59c49bae08830c', '[1,27,9,23,22,4,13,29,2,15,19,14,20,11,25,5,21,3,24,6,12,10,28,0,26,17,18,8,16,7]', 16, 64, 0, 0, '<p class=\'feedback correct\'>¡Correcto! 👍 +4 puntos.</p>', '2025-04-03 02:53:43', '2025-04-03 03:17:53'),
('7d43ea85a6566b8ad952e0a46b2da802', '[12,18,4,6,2,22,7,20,29,15,14,13,16,17,23,1,21,10,25,9,26,27,11,8,5,28,24,3,19,0]', 12, 36, 3, 0, '<p class=\'feedback incorrect\'>¡Incorrecto! 👎 La respuesta correcta era: <strong>A) Cierto</strong>.</p>', '2025-04-08 11:12:04', '2025-04-08 11:16:50'),
('89aebef64c99651681160eb601b7f788', '[15,29,24,27,10,7,8,12,17,4,26,23,1,13,3,19,16,20,6,21,25,14,11,22,5,18,28,2,0,9]', 0, 0, 0, 1, NULL, '2025-04-04 15:33:59', '2025-04-04 15:33:59');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `trivia_scores`
--

CREATE TABLE `trivia_scores` (
  `id` int(11) NOT NULL,
  `trivia_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `puntos` int(11) NOT NULL DEFAULT 0,
  `respuestas_correctas` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `trivia_stats`
--

CREATE TABLE `trivia_stats` (
  `stat_id` int(11) NOT NULL,
  `game_id` varchar(32) NOT NULL,
  `total_score` int(11) NOT NULL DEFAULT 0,
  `total_questions` int(11) NOT NULL DEFAULT 0,
  `correct_answers` int(11) NOT NULL DEFAULT 0,
  `is_win` tinyint(1) DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `trivia_stats`
--

INSERT INTO `trivia_stats` (`stat_id`, `game_id`, `total_score`, `total_questions`, `correct_answers`, `is_win`, `created_at`) VALUES
(1, '77324139d50675bfed59c49bae08830c', 64, 16, 16, 1, '2025-04-03 03:17:53'),
(2, '4fa9ab3793f67f025e0cb54c27982c5c', 52, 16, 13, 0, '2025-04-03 03:32:48'),
(3, '6bcb86e5e77c4ccab24a0d518ac7f10e', 64, 16, 16, 1, '2025-04-03 17:47:24'),
(4, '48d26e5fef6083a31467441d5600f432', 64, 16, 16, 1, '2025-04-03 18:08:12'),
(5, '7d43ea85a6566b8ad952e0a46b2da802', 36, 12, 9, 0, '2025-04-08 11:16:50');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `turnos`
--

CREATE TABLE `turnos` (
  `id` int(11) NOT NULL,
  `business_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `duracion` int(11) DEFAULT NULL,
  `estado` enum('pendiente','confirmado','cancelado','completado') DEFAULT 'pendiente',
  `notas` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `email_verified` tinyint(1) NOT NULL DEFAULT 0,
  `email_verification_token` varchar(64) DEFAULT NULL,
  `email_token_expiry` datetime DEFAULT NULL,
  `is_admin` tinyint(1) DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `reset_token` varchar(64) DEFAULT NULL,
  `reset_token_expiry` datetime DEFAULT NULL,
  `first_name` varchar(100) DEFAULT NULL COMMENT 'Nombre del titular de la cuenta',
  `last_name` varchar(100) DEFAULT NULL COMMENT 'Apellido del titular de la cuenta'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `email`, `phone`, `email_verified`, `email_verification_token`, `email_token_expiry`, `is_admin`, `created_at`, `updated_at`, `reset_token`, `reset_token_expiry`, `first_name`, `last_name`) VALUES
(1, 'admin', '$2y$10$GRQo0c/b0kLku/I9NRURE.kdOSbePXx7ao28Khb8qYymED3lHD6ri', NULL, NULL, 1, NULL, NULL, 1, '2025-03-19 00:00:05', '2026-04-20 15:00:02', NULL, NULL, NULL, NULL),
(4, 'martilleracelesteortiz@gmail.com', '$2y$10$ZiXMPysIFxGcgWWAxhzmSOD.2woxXw5vJxi8o5ejgrrB9wOk8YxbS', NULL, NULL, 1, NULL, NULL, 0, '2025-04-01 03:44:07', '2026-04-20 15:00:02', NULL, NULL, NULL, NULL),
(5, 'Pablo_Farias', '$2y$10$2/lTT0OjnVkUVMaJt6i4Yuw40uhT4v2focifLJUYnb9GDrRKTLb1S', 'pablofarias19@gmail.com', NULL, 0, NULL, NULL, 1, '2026-04-10 16:06:07', '2026-05-02 15:26:56', NULL, NULL, NULL, NULL),
(7, 'Celeste_Ortiz_22', '$2y$10$DPi7s1/KfM9uZv5fsHY5Pu2tqcoU3ipCjHdniVa./OsMFavn2KJW2', 'martilleracelesteortiz@gmail.com', '+5491166311985', 0, NULL, NULL, 0, '2026-04-28 21:43:00', '2026-05-02 14:55:23', NULL, NULL, NULL, NULL),
(8, 'GoldfarbHabasyAsociados', '$2y$10$zfDxfSZoEkSlLZdrssbyC.GEmnXBozUBz5xpT7HX.gV/cfqzLKnLy', 'ghaboga2@gmail.com', '+541153316661', 0, NULL, NULL, 0, '2026-04-29 17:35:08', '2026-04-29 17:35:22', NULL, NULL, NULL, NULL),
(9, 'Cecilia10', '$2y$10$mmmVV1nIS32r4UII/1DoA.u8kLM9gbHCa2egYEO9puWQ3hf.tex0S', 'ceciliagnunez@yahoo.com', '1124746666', 0, NULL, NULL, 0, '2026-04-29 21:50:07', '2026-04-29 21:50:07', NULL, NULL, NULL, NULL),
(10, 'Luisvillegas', '$2y$10$0ZaGLZ1LDB.XVtNNr09NS.wkVsufN5UOlXHn67AlriEPcp3uEn7Ne', 'luisvillegas89@hotmail.com', '+54(351) 875 - 8283', 0, NULL, NULL, 0, '2026-04-30 04:15:25', '2026-04-30 04:16:24', NULL, NULL, NULL, NULL),
(11, 'MIGUEL', '$2y$10$DgIW7/sS/ZkgcaNaegPYAOd2gYxUI61umTuWlsTQqswOOFGaWMH7C', 'sanregali@gmail.com', '543516664830', 0, NULL, NULL, 0, '2026-05-01 00:10:52', '2026-05-01 00:13:16', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user_presence`
--

CREATE TABLE `user_presence` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `visitor_id` varchar(64) DEFAULT NULL,
  `session_id` varchar(128) DEFAULT NULL,
  `current_path` varchar(255) DEFAULT NULL,
  `last_seen_at` datetime NOT NULL,
  `ip` varchar(45) DEFAULT NULL,
  `user_agent` varchar(512) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `user_presence`
--

INSERT INTO `user_presence` (`id`, `user_id`, `visitor_id`, `session_id`, `current_path`, `last_seen_at`, `ip`, `user_agent`) VALUES
(1, 5, '67670c2421f4da3bdde95e7d5c2e6d27', 'pi83r9pklca17k8kct1ubjf5al', '/', '2026-04-28 20:47:35', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(2, NULL, '1a23bdce895e0a59983e0b216a906b1d', 'eg4gjq3nslo0ahud5oefqqccn3', '/login.php', '2026-04-28 18:43:09', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(3, NULL, '66a3841edb47c096458508bcceb1a5c5', '7k5l3bsffhimkr60a48a0ha8ae', '/', '2026-05-01 02:10:53', '201.235.95.238', 'Mozilla/5.0 (Linux; Android 13; SM-A226BR Build/TP1A.220624.014; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/147.0.7727.111 Mobile Safari/537.36'),
(4, NULL, '0625fc06335d1ae10c96cc4cc85e3efd', 'bmce5td0ueh7eedclnleqi5c98', '/submapita/views/business/map.php', '2026-04-26 23:27:26', '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(5, NULL, '0625fc06335d1ae10c96cc4cc85e3efd', 'sjluqd5rfnl8qo86s1sklddhiu', '/submapita/views/business/map.php', '2026-04-27 01:58:07', '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(6, NULL, '0625fc06335d1ae10c96cc4cc85e3efd', 'pcd0b2ru5lo4jfo501eeig6ame', '/', '2026-04-27 02:09:45', '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(7, NULL, '0625fc06335d1ae10c96cc4cc85e3efd', '2jegc7c0vspeid6tg4511m08t3', '/submapita/views/business/map.php', '2026-04-27 09:55:37', '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(8, NULL, '0625fc06335d1ae10c96cc4cc85e3efd', '77pfh1fh6bjrbfn8bmk6f4s1mm', '/', '2026-04-27 10:08:06', '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(9, NULL, '18ec00c2934a5228e7866b4a09477416', 'p56olmpbvl01ipc9pet3012tlt', '/', '2026-04-27 11:08:11', '2800:2505:42:68c8:18a8:4dbe:a0f5:f16d', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(10, NULL, '0625fc06335d1ae10c96cc4cc85e3efd', '86s7ohra600h61pk63krtrmu28', '/submapita/views/business/map.php', '2026-04-28 00:40:09', '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(11, NULL, '0625fc06335d1ae10c96cc4cc85e3efd', 'to8qituckip4678gu2etsmi923', '/submapita/views/business/map.php', '2026-04-28 00:40:39', '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(12, NULL, '0625fc06335d1ae10c96cc4cc85e3efd', '41vvb08ng4p7ifm9buhcngouqq', '/', '2026-04-28 00:44:40', '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(13, NULL, '0625fc06335d1ae10c96cc4cc85e3efd', '8u25dlc0fhls092btd8teg51ci', '/', '2026-04-28 00:49:33', '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(14, NULL, '0625fc06335d1ae10c96cc4cc85e3efd', 'c7i2hver5bgqlbcabc240drtqo', '/', '2026-04-28 00:51:46', '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(15, NULL, 'fb917d383fa3db601c8189d9c8d870dd', 'vp26k0b23i9ublnbekpv8ge7jm', '/', '2026-04-28 03:36:49', '202.8.42.91', 'Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)'),
(16, NULL, 'f411ffa78f93e3d18ed24b26ec1ca4c6', '9n7h8ut8a8lrh6ckiijo3v3dr4', '/', '2026-04-28 08:41:33', '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(17, NULL, '0625fc06335d1ae10c96cc4cc85e3efd', 'p4k34puhhslvm096i97b6rg373', '/', '2026-04-28 12:42:26', '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(18, NULL, '0625fc06335d1ae10c96cc4cc85e3efd', '0d66hp0vn9pv5kbm4v5oc2a4sg', '/', '2026-04-28 12:53:38', '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(19, NULL, '0625fc06335d1ae10c96cc4cc85e3efd', 'g46oo2o4jko2atblf9qupc0d4b', '/', '2026-04-28 12:57:23', '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(20, NULL, 'f411ffa78f93e3d18ed24b26ec1ca4c6', '3j1cd3a2gsnm8qagc59uu3lh69', '/', '2026-04-28 12:58:49', '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(21, NULL, 'f411ffa78f93e3d18ed24b26ec1ca4c6', 'qlkcouotik396qh58j1j4pm8ih', '/', '2026-04-28 13:10:18', '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(22, NULL, '0625fc06335d1ae10c96cc4cc85e3efd', 'kc6ea7agr46h85lj1admuf8t8o', '/', '2026-04-28 14:04:48', '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(23, NULL, '6fbd712d99773daf892b9611d2250f74', 'qj7qv1t3dvib52uvr8o7k1ffja', '/', '2026-04-28 13:37:11', '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(24, NULL, 'a164cd6723885c79426741ee21f13c46', '71dvj3j916i673qc5adi9783hv', '/login.php', '2026-04-28 18:43:15', '181.199.158.7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36'),
(25, NULL, '1a23bdce895e0a59983e0b216a906b1d', 'jv1k2hqa0d3gke3toa5lh9a0es', '/', '2026-04-29 14:03:21', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(26, NULL, '7f7a6d160244d3a6a27b884454f353bb', 'ii3189etntkirbgesv2vouq25i', '/index.php', '2026-04-28 20:22:59', '45.189.77.134', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(27, NULL, '45043175a4873ffdddaf7d2c90455122', '35cnv0p6nvg3m5drlnvufuaa0o', '/', '2026-04-28 19:59:27', '190.94.160.196', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36'),
(28, NULL, '70313f824dd8f969d92e897c02f23b49', 'cfjgkfod0vrj9rgugli6nmvhqt', '/index.php', '2026-04-28 20:09:49', '190.94.160.196', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36'),
(29, NULL, '67670c2421f4da3bdde95e7d5c2e6d27', 'cj1kctlm7vuer2nfdef02gbrs5', '/index.php', '2026-04-28 20:50:31', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(30, NULL, '67670c2421f4da3bdde95e7d5c2e6d27', '23oatdc2jk5qj8pqsi0llou0q5', '/', '2026-04-28 20:53:22', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(31, NULL, '67670c2421f4da3bdde95e7d5c2e6d27', 'oppkd91e7j4jklu20dut5sr49q', '/', '2026-04-28 21:04:27', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(32, NULL, '67670c2421f4da3bdde95e7d5c2e6d27', '9fcepr9lfvusj3vp6q9gf0vgqc', '/', '2026-04-28 21:08:24', '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(33, 5, '67670c2421f4da3bdde95e7d5c2e6d27', '3hscqs8lso9mnu5hab7pqa233d', '/', '2026-04-28 21:20:23', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(34, NULL, '67670c2421f4da3bdde95e7d5c2e6d27', 'aiea0ab3rco1vm9rr325ttqg5b', '/', '2026-04-28 21:21:34', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(35, NULL, '67670c2421f4da3bdde95e7d5c2e6d27', '31f33a623unbb2niqlffc66aj8', '/', '2026-04-29 06:58:19', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(36, NULL, '0540aa486d77f9740e6354feb620114b', 'v0sp8kq0moj4jcij1ijn1nbb7s', '/', '2026-04-28 21:52:54', '201.251.56.18', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(37, NULL, 'bff02008fe0640b9efd0f9036bc8a99e', 'qv4qogiiodv09ahaiurk2joie6', '/', '2026-04-29 19:32:06', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(38, NULL, 'a48533fca88c659f7ae0ee2f8adc272e', 'hkn6cmun4235lbs25aa0bi8fa7', '/', '2026-04-29 00:48:43', '186.13.125.128', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(39, NULL, '0625fc06335d1ae10c96cc4cc85e3efd', 'c02ml3ld892mr5k78d475127bs', '/', '2026-04-29 01:48:08', '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(40, NULL, '0625fc06335d1ae10c96cc4cc85e3efd', 'fufoetr0jpq7euemhscup464np', '/', '2026-04-29 01:53:32', '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(41, NULL, '28c28d10bea8ea77ae4770fc05f86bb9', 'hms7q37loflsgdohdjof8lk5ch', '/', '2026-04-29 06:18:16', '2a01:599:143:51fc:d503:9b58:eab5:3395', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36'),
(42, 5, '67670c2421f4da3bdde95e7d5c2e6d27', 'v2sjqkcvs6fkil69cer2881shf', '/', '2026-04-29 18:49:47', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(43, NULL, '52adfc541a46bfb33060d53b9ff83e7d', '1c8scja14fcukomkon4qnh0ccn', '/', '2026-04-29 10:12:03', '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(44, NULL, 'd1c614e24f92528bba6062492cf63334', 'aor6vb1r41ogcvj85jc72lig0t', '/', '2026-04-29 10:23:19', '181.15.96.135', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36'),
(45, NULL, 'e60f729993e0c8142f607e06ceeaa83b', '3r1d490bqpef8eah0degeuf524', '/', '2026-04-29 12:07:24', '181.98.147.7', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/29.0 Chrome/136.0.0.0 Mobile Safari/537.36'),
(46, NULL, '00caf085d4466b25a000d47985529c8c', 'n2t7e4qcv7tdtvkillec9l9vpi', '/', '2026-04-29 12:09:45', '148.227.121.163', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(47, NULL, '1d4aacf9d9ed74f5fe7864cce8228a21', 'v0j07ns267urcgto2i8mfqd0k7', '/', '2026-04-29 15:26:15', '200.81.152.23', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(48, NULL, '274dee19fe29222d8bd7a13f00c6dc0f', 'nesirv9offmb9qhua8jnu5gjoa', '/', '2026-04-29 12:51:24', '200.110.188.101', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36'),
(49, NULL, '44518ee075a735c7c8203865547b21ac', '1rffrs2dev1ptih5uk483do06n', '/', '2026-04-29 12:52:13', '204.199.71.86', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(50, NULL, '57a54bcad3efdb06e6c0d2034062df5c', '8u4f7fkcrj051sraelvdhrtofp', '/', '2026-04-29 12:54:19', '209.170.91.200', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.75 Safari/537.36'),
(51, NULL, '32a2e486e2af6091503993f98490b5f9', 'tr0sm9lf0khnka72f087093kov', '/', '2026-04-29 12:57:05', '200.105.110.35', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(52, NULL, '1b90459e8d269529a42a1738ac3f3175', '0q6aruo530bd7fh8lgm2mvtlg1', '/', '2026-04-29 12:58:40', '190.234.82.156', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(53, NULL, 'f4ca573e6bdb6a2afddecd10bef7deea', 'kga5eci0e23lvc9k607bpq9dto', '/', '2026-04-29 12:58:46', '177.91.255.68', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Mobile Safari/537.36'),
(54, NULL, '5291d0741086c80657048d073d5b776f', 'acnj0kpjh6tlhqqn31e6bu1muq', '/', '2026-04-29 15:43:17', '50.172.72.26', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(55, NULL, '1baf5362e03e841b0e4e2ec52d0daa6e', 'o9ruf3h1fheldkbemn19hj9voa', '/', '2026-04-29 13:24:45', '24.232.22.114', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(56, NULL, '6b72a3d3ed9dac89f0c49b695b067f3a', 'b2r4pi13l3c701e45imepjsd4c', '/', '2026-04-29 13:42:33', '170.233.68.221', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.3 Mobile/15E148 Safari/604.1'),
(57, NULL, '8e7a0f25f1423ba01c25fdd3772a1e4d', 's0o4drnkhqg24tdf4od9cb5dfv', '/', '2026-04-29 13:54:41', '181.239.16.57', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(58, NULL, '1a23bdce895e0a59983e0b216a906b1d', 'cnjf5mnubjovm8dr2l7tkr0sv6', '/', '2026-05-02 11:54:57', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(59, NULL, '2e524cc32ee44232ebd00e0e5d262bbd', '20funhee48vs4e5jeof6clcfki', '/', '2026-04-29 14:23:09', '45.189.187.204', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(60, NULL, '1e65a693b95d060f32bfc2264385a5f5', 'op4eguli0e044934vk7c651bqn', '/login.php', '2026-04-29 14:35:14', '190.210.36.18', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(61, NULL, '0625fc06335d1ae10c96cc4cc85e3efd', 'jn0qksc0v6jipv87f9ln4ost2a', '/', '2026-04-29 15:27:14', '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(62, 8, '1e65a693b95d060f32bfc2264385a5f5', 'js17ppidgkqvcag8sgllqk8dtn', '/', '2026-04-29 15:54:37', '2800:40:76:b6ce:d0a0:e727:6f3:9f28', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(63, NULL, '1baf5362e03e841b0e4e2ec52d0daa6e', '9u3jtkqgd0rtjoq54uiib3qsbn', '/', '2026-04-29 15:52:34', '2803:9800:9888:54be:e5a0:40b0:c9c0:633c', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(64, NULL, 'dfa86cf6c3401d7af39523b905e489d7', 'ofsh2cqrl7r1pc8t8t72rr8q93', '/', '2026-04-29 15:55:51', '201.213.22.43', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(65, NULL, 'f6f3710e9e84b79e12d814227e9cdcb5', 'u64pgn05833n96ccmdgqkuku5m', '/', '2026-04-29 16:29:48', '190.139.199.204', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.4 Mobile/15E148 Safari/604.1'),
(66, NULL, 'cfd8bec533f7e9a3d4acd21826d6ef8d', '4iafd5ii6h5isksvaplcupad4g', '/', '2026-04-29 17:27:55', '45.186.208.99', 'Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36'),
(67, NULL, '20e391ac3e53d76804289e62806a662e', '9vhhrqir42oqg6jfijhi8l25pa', '/', '2026-04-29 17:43:52', '2800:2505:71:4573:487c:cbe5:19cd:e209', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(68, NULL, '529b8527868bc53948be63d2c5f5b755', 'poamrt83dfg9vrs047b5nigmgb', '/', '2026-04-29 17:44:22', '186.138.44.9', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(69, NULL, '8039581612fc76d2334df13926aa2a37', 't5h7dgj0ovn01didgdffguvoru', '/', '2026-04-29 17:47:59', '2800:af0:1088:8db:f54c:4f0f:62be:e4e3', 'Mozilla/5.0 (iPhone; CPU iPhone OS 26_4_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/147.0.7727.99 Mobile/15E148 Safari/604.1'),
(70, NULL, '2c2d22b04b79c3df7979e516ca9571af', 'jciui2olp60c57pvrmvf3pje7p', '/', '2026-04-29 17:55:15', '2800:810:503:26f:491a:1f8f:21be:6105', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.3 Mobile/15E148 Safari/604.1'),
(71, NULL, 'a20286d7cda6a9349f0efd9c89219fca', 'dsnr3v7d05uq00lv16uij0mgn4', '/', '2026-04-29 17:54:53', '2800:810:503:26f:491a:1f8f:21be:6105', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.3 Mobile/15E148 Safari/604.1'),
(72, NULL, '3050d47f058ec7308e32a33ecfa64219', 'r3pi5sqpqp4h8n9r8bl640aego', '/', '2026-04-29 17:57:22', '179.60.243.100', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36'),
(73, NULL, '8039581612fc76d2334df13926aa2a37', 'sbj32jbvi7e2lfhmittfj3ljrm', '/', '2026-04-29 18:00:34', '2800:af0:1088:8db:f54c:4f0f:62be:e4e3', 'Mozilla/5.0 (iPhone; CPU iPhone OS 26_4_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/147.0.7727.99 Mobile/15E148 Safari/604.1'),
(74, NULL, '9c42b6e43f7d55a069e32c7c9a66406d', 'jde693lvbplis2i2e9ganrr5u6', '/', '2026-04-29 18:11:24', '38.41.42.235', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 OPR/130.0.0.0'),
(75, NULL, '919df20f56bf3742d227328043f82486', 'pqilb3o5gor44linh0v75u57ms', '/', '2026-04-29 18:39:01', '2802:8010:10a:b600:d930:1a3d:37dc:d3e3', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/29.0 Chrome/136.0.0.0 Mobile Safari/537.36'),
(76, NULL, 'e44835f01150cb7f49a115f28ac4b864', '970dev49k4dhk3crufveot69b8', '/', '2026-04-29 18:50:30', '2800:810:503:26f:491a:1f8f:21be:6105', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.3 Mobile/15E148 Safari/604.1'),
(77, NULL, '5a320b583166348b57b11ac1b6b6b981', 'abbu2rtlc4f8h9f0ab9s83hmte', '/', '2026-04-29 18:47:36', '2800:810:503:26f:491a:1f8f:21be:6105', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.3 Mobile/15E148 Safari/604.1'),
(78, NULL, 'dedd6c0edd04bc8ba7cbdbc6bc3d42c9', 'osgfs9a2ctqvphtl6a7h9r73f5', '/', '2026-04-29 18:50:30', '2800:810:503:26f:491a:1f8f:21be:6105', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.3 Mobile/15E148 Safari/604.1'),
(79, NULL, '0625fc06335d1ae10c96cc4cc85e3efd', 'pueadelag636ipk0h286rj54th', '/', '2026-04-29 18:46:20', '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(80, NULL, '9a17189c68315e02e5b9c3433aec75e2', 'suc9qq0p749i5fclkg4dqf301c', '/', '2026-04-29 19:15:58', '108.77.84.128', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(81, NULL, '18ec00c2934a5228e7866b4a09477416', '93b4qjmln9o43qsd0thr30ojd3', '/', '2026-04-29 19:21:21', '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(82, NULL, '567ab49c39856a4e69ab3ea97eda4799', 'l1qfv1c9i19dtdsipbdfag1jjv', '/', '2026-04-29 19:33:49', '2803:9800:9888:41a5:b597:a8db:1d0e:49c0', 'Mozilla/5.0 (iPhone; CPU iPhone OS 26_3_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/147.0.7727.99 Mobile/15E148 Safari/604.1'),
(83, NULL, '9337b14fc4e404abba4bcdf6524d3b29', 'jggle1ur7o4vek66uiamfejb6s', '/', '2026-04-29 19:35:07', '2803:9800:9888:41a5:6545:6c79:fdb1:78c0', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(84, NULL, '5f9faace2acb8ccab373550023e84676', 'qf15u38tppo92gpan5hvuprub9', '/', '2026-04-29 19:41:46', '186.157.168.56', 'Mozilla/5.0 (iPhone; CPU iPhone OS 26_3_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/147.0.7727.47 Mobile/15E148 Safari/604.1'),
(85, NULL, '0e3b7f04688822ddd8b35be4f047c8e7', 'ko50pi1kq548n2s2sg6thdfl68', '/', '2026-04-29 19:43:05', '181.31.41.43', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(86, NULL, '91dd34608fc59b501b8516386292498f', 'ki7su4vrcqrl8m87hi3tk7ndqo', '/', '2026-04-29 19:48:04', '190.18.237.29', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(87, NULL, 'dfa86cf6c3401d7af39523b905e489d7', 'mr5jbh3ebna7kecq2mdftv4rvh', '/', '2026-04-29 19:49:34', '201.213.22.43', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(88, NULL, 'c1de2a1c7689af22332ffc01a42f71bc', '9slo9dcjptbl4mc6706qcjbp11', '/', '2026-04-29 20:45:07', '181.105.137.31', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(89, NULL, '567ab49c39856a4e69ab3ea97eda4799', '7rkdcda508as1eao3rd0r1pfmf', '/', '2026-04-29 20:19:48', '2803:9800:9888:41a5:b597:a8db:1d0e:49c0', 'Mozilla/5.0 (iPhone; CPU iPhone OS 26_3_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/147.0.7727.99 Mobile/15E148 Safari/604.1'),
(90, NULL, 'cdb2e64b1a917653b610e1d88d0a3081', '6pdbft45lgjcrk7mb1e5n4gojm', '/', '2026-04-29 22:03:07', '181.2.166.7', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.3 Mobile/15E148 Safari/604.1'),
(91, NULL, '0625fc06335d1ae10c96cc4cc85e3efd', 'svopq2dk38arg1nekqdq6ahrjp', '/submapita/views/business/map.php', '2026-04-29 21:10:33', '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(92, NULL, '24e663fa05d5d807f383ea1abb894020', 'kft97nmkq30e8jkd9fm8krvtj1', '/', '2026-04-29 21:46:43', '201.212.24.32', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(93, NULL, '18ec00c2934a5228e7866b4a09477416', '2cs35c3k185aimhlcl9p39ao4q', '/', '2026-04-29 22:19:48', '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(94, NULL, '0625fc06335d1ae10c96cc4cc85e3efd', '742n0cafkgi4djnlrll4c5peac', '/submapita/views/business/map.php', '2026-04-29 23:51:19', '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(95, 5, '0625fc06335d1ae10c96cc4cc85e3efd', 'h023jmtuv16eugq3kmb9hrfr7a', '/', '2026-04-29 23:53:46', '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(96, NULL, 'cf3d60cc2853c4b43730a3cf65389fc9', 'lf7nrvrgclmn9vj87d2k7nvk30', '/', '2026-04-29 23:53:54', '2806:250:1504:bff8:7157:22f8:f525:2407', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Mobile Safari/537.36'),
(97, NULL, '8039581612fc76d2334df13926aa2a37', 'qt78v351ets4ai5kjvv0s5kqtc', '/', '2026-04-30 00:30:18', '190.105.123.81', 'Mozilla/5.0 (iPhone; CPU iPhone OS 26_4_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/147.0.7727.99 Mobile/15E148 Safari/604.1'),
(98, NULL, '8039581612fc76d2334df13926aa2a37', '9joph8sa75p8s6iv72vbv2nv87', '/', '2026-04-30 00:31:42', '2800:af0:1088:8db:498d:2024:ca45:96e3', 'Mozilla/5.0 (iPhone; CPU iPhone OS 26_4_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/147.0.7727.99 Mobile/15E148 Safari/604.1'),
(99, NULL, '4965f735bbe596186f2bb70187216854', 'h0bnq5oqsfraru4l0dpmui7a2b', '/', '2026-04-30 01:13:10', '181.117.26.182', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(100, NULL, '8e7a0f25f1423ba01c25fdd3772a1e4d', 'q0l9ego28h0g914qglr5lvqbaf', '/', '2026-04-30 01:16:15', '2803:9800:9881:b4ba:45e3:9fe3:8cd2:c857', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(101, 10, '8e7a0f25f1423ba01c25fdd3772a1e4d', 'qk08jvr0oth81of7b9r76ouv5q', '/', '2026-04-30 01:34:33', '2803:9800:9881:b4ba:45e3:9fe3:8cd2:c857', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(102, NULL, '67670c2421f4da3bdde95e7d5c2e6d27', '73o7b9lra39k4q934u1uqnc4nu', '/', '2026-04-30 09:36:43', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(103, 5, '67670c2421f4da3bdde95e7d5c2e6d27', 'lrejec4uprc0uhsj6c73m9ge07', '/', '2026-04-30 21:50:59', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(104, NULL, '8039581612fc76d2334df13926aa2a37', 'qf49j82ppo0gth41hv24qss8go', '/', '2026-04-30 13:56:17', '2800:af0:1088:8db:b5b8:782e:c0de:591c', 'Mozilla/5.0 (iPhone; CPU iPhone OS 26_4_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/147.0.7727.99 Mobile/15E148 Safari/604.1'),
(105, NULL, '18ec00c2934a5228e7866b4a09477416', '676p227etbb001pegakl9e9tmg', '/', '2026-04-30 16:57:12', '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(106, NULL, '6fbd712d99773daf892b9611d2250f74', 'i1g6rqp00igtp82e8ls5e5ep6f', '/', '2026-04-30 16:57:41', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(107, NULL, '0d24a9fc76e4eefd0b7cda9a9fb9e3f1', 'anhuv44k0gn2baejiaft28lv1f', '/', '2026-04-30 17:41:04', '190.175.38.176', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(108, NULL, '0625fc06335d1ae10c96cc4cc85e3efd', '8sl8o5h2a740hl22946t43bfak', '/submapita/views/business/map.php', '2026-04-30 17:07:28', '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(109, NULL, 'c2515b5f11ada31cabd7f03ec8f35e40', '9nid209q7kgraqdjtht94uddvf', '/', '2026-04-30 17:23:11', '179.41.5.40', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(110, NULL, '18ec00c2934a5228e7866b4a09477416', 'pg40fpnh7hmgrnsqr0h640lgh5', '/', '2026-04-30 17:39:21', '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(111, NULL, '18ec00c2934a5228e7866b4a09477416', '7biu3g8q505515ejumcnuhtj0c', '/', '2026-04-30 17:47:31', '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(112, 7, '18ec00c2934a5228e7866b4a09477416', 'n5mv6ed622jgucikut3c33pp6b', '/', '2026-04-30 17:50:49', '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(113, NULL, 'f7e1298e5303132a90e3f743c0e5a2f7', '9jdfh6o7fpish1gfdksp1camb5', '/', '2026-04-30 18:52:30', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(114, NULL, '84dc0dd3d07de0cb21b9832a2cf622e4', '7a9l7gk6clhk5o7bfbrrh5a6nc', '/', '2026-04-30 19:03:57', '2802:8010:d0b4:e401:63d4:4236:614e:2d6b', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/29.0 Chrome/136.0.0.0 Mobile Safari/537.36'),
(115, NULL, '594b298f2b15ae8c38b088eb7003fb60', '3gf1rvdig1g4jsmqk03cpnrkc8', '/', '2026-04-30 21:12:54', '2803:68e0:213:3d00:98a7:fc40:b451:5262', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(116, 11, '594b298f2b15ae8c38b088eb7003fb60', 'agbp8k1v8ckpf8or5u4ui5h9lk', '/', '2026-04-30 21:57:33', '2803:68e0:213:3d00:98a7:fc40:b451:5262', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(117, NULL, '67670c2421f4da3bdde95e7d5c2e6d27', 'lqr2m5vgq21e05ir2k6bolkava', '/', '2026-04-30 22:00:31', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(118, NULL, '67670c2421f4da3bdde95e7d5c2e6d27', 'qh5mq209bmleq3boqc139o2gsu', '/', '2026-05-02 10:45:10', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(119, NULL, '59a98a0dc3db9960e6c9183ef43bb0c0', '5roavoe4cn6gtcecav41500cqd', '/', '2026-04-30 22:27:25', '209.170.91.202', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.75 Safari/537.36'),
(120, NULL, '0625fc06335d1ae10c96cc4cc85e3efd', 'viefq0h34k63signm0d2u36qfo', '/submapita/views/business/map.php', '2026-05-01 02:11:20', '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(121, NULL, '0625fc06335d1ae10c96cc4cc85e3efd', 'brr3jnct4af3mesv784ajmsljn', '/', '2026-05-01 02:13:38', '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(122, NULL, '0625fc06335d1ae10c96cc4cc85e3efd', '2j0frk2erts4mn54uufiu64jis', '/submapita/views/business/map.php', '2026-05-01 03:40:59', '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(123, NULL, 'c1de2a1c7689af22332ffc01a42f71bc', '2btla39254p2bv9me0voj4hrap', '/', '2026-05-01 09:53:59', '181.105.137.31', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(124, NULL, 'fdcb0b441b6406b4fa2839299c89137d', '4sugct63ees3k2q4rtubi2h6a0', '/', '2026-05-01 15:25:25', '181.9.206.193', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(125, NULL, 'c3be5796f54ec31a60f47c9b5e09f6e8', 'q71fp8f94clfhittqljr6nnbsh', '/', '2026-05-01 16:16:59', '190.16.133.183', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(126, NULL, '18ec00c2934a5228e7866b4a09477416', 'q3g0hq1tsjshphr13ie5qmd446', '/', '2026-05-01 17:01:43', '201.235.95.238', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(127, NULL, 'f6f3710e9e84b79e12d814227e9cdcb5', '8avhq706tdo3r6ff85lfgcisoj', '/', '2026-05-01 19:34:20', '190.139.199.204', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.4 Mobile/15E148 Safari/604.1'),
(128, NULL, 'cf33b6516a00163d12ebcdf1a76863d2', 'nrlu591k5fk3mb4ipbk5cmkjnd', '/', '2026-05-01 21:43:40', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 AVG/146.0.34394.179'),
(129, NULL, '67670c2421f4da3bdde95e7d5c2e6d27', 'ej89imbbepch051nghd9bah2sg', '/', '2026-05-02 10:56:08', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(130, 5, '67670c2421f4da3bdde95e7d5c2e6d27', 'uvn6rhibi4rpapudvkj2dnn2b7', '/', '2026-05-02 11:29:17', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(131, NULL, '67670c2421f4da3bdde95e7d5c2e6d27', '0pk6sdqsla22lg5b1c6a8ecbii', '/', '2026-05-02 11:56:32', '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(132, 7, '1a23bdce895e0a59983e0b216a906b1d', '0l3dto58nvkimnv12hitausdul', '/encuesta', '2026-05-02 13:03:29', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(133, 5, '67670c2421f4da3bdde95e7d5c2e6d27', 'qs1pddt31rs28u1pm8kq8b3upt', '/', '2026-05-02 11:58:22', '201.235.95.238', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Mobile Safari/537.36'),
(134, NULL, '67670c2421f4da3bdde95e7d5c2e6d27', 'qko60p6aob1lu8iqtpk2hmk7e6', '/', '2026-05-02 12:06:40', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(135, NULL, '67670c2421f4da3bdde95e7d5c2e6d27', '17cg15amjm5gnv7p0l1fh0lfjk', '/', '2026-05-02 12:25:10', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(136, 5, '67670c2421f4da3bdde95e7d5c2e6d27', 'qg2ngjvselvftgq975cq3fruhl', '/', '2026-05-02 12:26:31', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(137, 5, '67670c2421f4da3bdde95e7d5c2e6d27', 'hm4vgmod48end9igrp0ptd26ft', '/', '2026-05-02 12:58:15', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36'),
(138, NULL, '67670c2421f4da3bdde95e7d5c2e6d27', '1qh9femgla7b7h9nvl63urcce0', '/', '2026-05-02 13:03:32', '201.235.95.238', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `valoraciones_servicios`
--

CREATE TABLE `valoraciones_servicios` (
  `id` int(11) NOT NULL,
  `business_id` int(11) NOT NULL,
  `reserva_id` int(11) DEFAULT NULL COMMENT 'Para validar que realmente usó el servicio',
  `usuario_id` int(11) DEFAULT NULL,
  `calificacion_general` tinyint(4) NOT NULL CHECK (`calificacion_general` between 1 and 5),
  `calificacion_puntualidad` tinyint(4) DEFAULT NULL CHECK (`calificacion_puntualidad` between 1 and 5),
  `calificacion_profesionalismo` tinyint(4) DEFAULT NULL CHECK (`calificacion_profesionalismo` between 1 and 5),
  `calificacion_comunicacion` tinyint(4) DEFAULT NULL CHECK (`calificacion_comunicacion` between 1 and 5),
  `calificacion_precio_calidad` tinyint(4) DEFAULT NULL CHECK (`calificacion_precio_calidad` between 1 and 5),
  `calificacion_resultados` tinyint(4) DEFAULT NULL CHECK (`calificacion_resultados` between 1 and 5),
  `calificacion_instalaciones` tinyint(4) DEFAULT NULL CHECK (`calificacion_instalaciones` between 1 and 5),
  `calificacion_higiene` tinyint(4) DEFAULT NULL CHECK (`calificacion_higiene` between 1 and 5),
  `calificacion_didactica` tinyint(4) DEFAULT NULL CHECK (`calificacion_didactica` between 1 and 5),
  `calificacion_material_apoyo` tinyint(4) DEFAULT NULL CHECK (`calificacion_material_apoyo` between 1 and 5),
  `calificacion_atencion_personalizada` tinyint(4) DEFAULT NULL CHECK (`calificacion_atencion_personalizada` between 1 and 5),
  `calificacion_calidad_trabajo` tinyint(4) DEFAULT NULL CHECK (`calificacion_calidad_trabajo` between 1 and 5),
  `calificacion_limpieza_post_trabajo` tinyint(4) DEFAULT NULL CHECK (`calificacion_limpieza_post_trabajo` between 1 and 5),
  `calificacion_equipamiento` tinyint(4) DEFAULT NULL CHECK (`calificacion_equipamiento` between 1 and 5),
  `titulo_review` varchar(150) DEFAULT NULL,
  `comentario` text DEFAULT NULL,
  `lo_recomendaria` tinyint(1) DEFAULT NULL,
  `volveria_contratar` tinyint(1) DEFAULT NULL,
  `servicio_utilizado` varchar(100) DEFAULT NULL COMMENT 'Qué servicio específico',
  `nivel_servicio` enum('principiante','intermedio','avanzado','profesional') DEFAULT NULL,
  `modalidad_recibida` enum('presencial','online','domicilio') DEFAULT NULL,
  `verificada` tinyint(1) DEFAULT 0 COMMENT 'Si se validó que es cliente real',
  `fecha_verificacion` timestamp NULL DEFAULT NULL,
  `respuesta_proveedor` text DEFAULT NULL,
  `fecha_respuesta` timestamp NULL DEFAULT NULL,
  `util_count` int(11) DEFAULT 0 COMMENT 'Cuántos usuarios marcaron como útil',
  `no_util_count` int(11) DEFAULT 0,
  `reportada` tinyint(1) DEFAULT 0,
  `motivo_reporte` text DEFAULT NULL,
  `aprobada` tinyint(1) DEFAULT 1,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Valoraciones y reviews de servicios';

--
-- Disparadores `valoraciones_servicios`
--
DELIMITER $$
CREATE TRIGGER `tr_actualizar_promedio_calificacion` AFTER INSERT ON `valoraciones_servicios` FOR EACH ROW BEGIN
    -- Trigger "no-op" (deja el esqueleto listo). Si querés que haga algo real,
    -- reemplazá este SET por el UPDATE que corresponda.
    SET @noop := 1;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vehiculos_venta`
--

CREATE TABLE `vehiculos_venta` (
  `id` int(10) UNSIGNED NOT NULL,
  `business_id` int(11) NOT NULL,
  `tipo_vehiculo` varchar(30) DEFAULT NULL,
  `marca` varchar(100) DEFAULT NULL,
  `modelo` varchar(120) DEFAULT NULL,
  `anio` smallint(6) DEFAULT NULL,
  `km` int(11) DEFAULT NULL,
  `precio` decimal(14,2) DEFAULT NULL,
  `contacto` varchar(255) DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `v_businesses_with_icons`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `v_businesses_with_icons` (
`id` int(11)
,`user_id` int(11)
,`name` varchar(255)
,`address` varchar(255)
,`lat` decimal(10,6)
,`lng` decimal(10,6)
,`phone` varchar(50)
,`email` varchar(100)
,`website` varchar(255)
,`business_type` varchar(50)
,`visible` tinyint(1)
,`status` enum('active','inactive','pending')
,`created_at` timestamp
,`updated_at` timestamp
,`price_range` int(1)
,`description` text
,`subcategory_id` int(11)
,`emoji` varchar(10)
,`icon_class` varchar(100)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wt_messages`
--

CREATE TABLE `wt_messages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `entity_type` enum('negocio','marca','evento','encuesta') NOT NULL,
  `entity_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `user_name` varchar(80) NOT NULL DEFAULT 'Invitado',
  `sender_key` varchar(120) NOT NULL,
  `message` varchar(140) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wt_presence`
--

CREATE TABLE `wt_presence` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `entity_type` enum('negocio','marca','evento','encuesta') NOT NULL,
  `entity_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `user_name` varchar(80) NOT NULL DEFAULT 'Invitado',
  `sender_key` varchar(120) NOT NULL,
  `last_seen` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `wt_presence`
--

INSERT INTO `wt_presence` (`id`, `entity_type`, `entity_id`, `user_id`, `user_name`, `sender_key`, `last_seen`, `updated_at`) VALUES
(1, 'negocio', 9142, 5, 'Pablo_Farias', 'uid:5', '2026-04-20 19:46:33', '2026-04-20 19:46:33'),
(12, 'negocio', 9146, 5, 'Pablo_Farias', 'uid:5', '2026-04-20 18:24:33', '2026-04-20 18:24:33'),
(15, 'negocio', 9143, 5, 'Pablo_Farias', 'uid:5', '2026-04-21 18:22:23', '2026-04-21 18:22:23'),
(72, 'negocio', 9145, 5, 'Pablo_Farias', 'uid:5', '2026-04-21 15:49:16', '2026-04-21 15:49:16'),
(163, 'negocio', 9148, 5, 'Pablo_Farias', 'uid:5', '2026-04-20 21:57:02', '2026-04-20 21:57:02'),
(205, 'negocio', 9144, 5, 'Pablo_Farias', 'uid:5', '2026-04-21 02:44:33', '2026-04-21 02:44:33'),
(218, 'negocio', 9145, NULL, 'Invitado', 'sid:e0e1b39a232e638e79f8938ebb6d210fb2d2de3e', '2026-04-20 01:07:59', '2026-04-20 01:07:59'),
(220, 'negocio', 9144, NULL, 'Invitado', 'sid:e0e1b39a232e638e79f8938ebb6d210fb2d2de3e', '2026-04-20 01:07:51', '2026-04-20 01:07:51'),
(221, 'negocio', 9146, NULL, 'Invitado', 'sid:e0e1b39a232e638e79f8938ebb6d210fb2d2de3e', '2026-04-20 01:07:38', '2026-04-20 01:07:38'),
(227, 'negocio', 9148, NULL, 'Invitado', 'sid:e0e1b39a232e638e79f8938ebb6d210fb2d2de3e', '2026-04-20 01:07:45', '2026-04-20 01:07:45'),
(387, 'negocio', 9148, NULL, 'Invitado', 'sid:444f8825ce2281b52deea490043af7ab23c703e1', '2026-04-20 06:13:45', '2026-04-20 06:13:45'),
(390, 'negocio', 9145, NULL, 'Invitado', 'sid:444f8825ce2281b52deea490043af7ab23c703e1', '2026-04-20 06:13:05', '2026-04-20 06:13:05'),
(403, 'negocio', 9148, 6, 'Nicolas_FO', 'uid:6', '2026-04-21 11:11:32', '2026-04-21 11:11:32'),
(406, 'negocio', 9149, 6, 'Nicolas_FO', 'uid:6', '2026-04-21 02:47:40', '2026-04-21 02:47:40'),
(410, 'negocio', 9149, 5, 'Pablo_Farias', 'uid:5', '2026-04-23 22:31:34', '2026-04-23 22:31:34'),
(763, 'negocio', 9149, NULL, 'Invitado', 'sid:4ba5d14a4b4aa99f127d17e4d3c805dddd206881', '2026-04-20 14:20:43', '2026-04-20 14:20:43'),
(1442, 'marca', 3, 5, 'Pablo_Farias', 'uid:5', '2026-04-24 14:13:22', '2026-04-24 14:13:22'),
(1955, 'negocio', 9147, 5, 'Pablo_Farias', 'uid:5', '2026-04-20 21:57:00', '2026-04-20 21:57:00'),
(2536, 'marca', 4, 5, 'Pablo_Farias', 'uid:5', '2026-04-24 21:44:16', '2026-04-24 21:44:16'),
(2921, 'evento', 4, 5, 'Pablo_Farias', 'uid:5', '2026-04-21 18:22:33', '2026-04-21 18:22:33'),
(3248, 'negocio', 9147, 6, 'Nicolas_FO', 'uid:6', '2026-04-21 11:19:04', '2026-04-21 11:19:04'),
(3295, 'evento', 4, 6, 'Nicolas_FO', 'uid:6', '2026-04-21 11:19:11', '2026-04-21 11:19:11'),
(3396, 'negocio', 9144, NULL, 'Invitado', 'sid:2c67c3481eae76e457aa0805f105f86a20645535', '2026-04-21 16:47:06', '2026-04-21 16:47:06'),
(3400, 'evento', 4, NULL, 'Invitado', 'sid:2c67c3481eae76e457aa0805f105f86a20645535', '2026-04-21 15:16:47', '2026-04-21 15:16:47'),
(3408, 'negocio', 9149, NULL, 'Invitado', 'sid:2c67c3481eae76e457aa0805f105f86a20645535', '2026-04-21 15:16:29', '2026-04-21 15:16:29'),
(3430, 'negocio', 9142, NULL, 'Invitado', 'sid:2c67c3481eae76e457aa0805f105f86a20645535', '2026-04-21 16:47:06', '2026-04-21 16:47:06'),
(3446, 'negocio', 9149, NULL, 'Invitado', 'sid:db6aa0a2537a6fe242faa943cd62d44c180c7287', '2026-04-21 13:43:07', '2026-04-21 13:43:07'),
(4357, 'negocio', 9146, NULL, 'Invitado', 'sid:4a7c1c6f13af0ec3e9ae91c6a5a25dbb6f93deca', '2026-04-21 15:38:50', '2026-04-21 15:38:50'),
(4523, 'negocio', 9142, NULL, 'Invitado', 'sid:f99c50632d21e07636168111b7f8a6c507f86e1a', '2026-04-21 18:18:53', '2026-04-21 18:18:53'),
(4673, 'marca', 2, NULL, 'Invitado', 'sid:f99c50632d21e07636168111b7f8a6c507f86e1a', '2026-04-21 18:18:57', '2026-04-21 18:18:57'),
(4689, 'negocio', 9145, NULL, 'Invitado', 'sid:a6f4c201e4968d9a2d8e9fffe392b226536dbb63', '2026-04-22 03:06:27', '2026-04-22 03:06:27'),
(4694, 'negocio', 9149, NULL, 'Invitado', 'sid:a6f4c201e4968d9a2d8e9fffe392b226536dbb63', '2026-04-22 03:06:17', '2026-04-22 03:06:17'),
(4703, 'negocio', 9149, NULL, 'Invitado', 'sid:546cd793bdfd4072daa9314248c9bbc1f80abe43', '2026-04-22 18:53:47', '2026-04-22 18:53:47'),
(5165, 'negocio', 9145, NULL, 'Invitado', 'sid:0e045fcdd76a5012ca840622bc92c7046e4425aa', '2026-04-23 00:48:56', '2026-04-23 00:48:56'),
(5169, 'negocio', 9149, NULL, 'Invitado', 'sid:0e045fcdd76a5012ca840622bc92c7046e4425aa', '2026-04-23 00:12:42', '2026-04-23 00:12:42'),
(5187, 'negocio', 9144, NULL, 'Invitado', 'sid:0e045fcdd76a5012ca840622bc92c7046e4425aa', '2026-04-23 00:12:34', '2026-04-23 00:12:34'),
(5200, 'negocio', 9148, NULL, 'Invitado', 'sid:0e045fcdd76a5012ca840622bc92c7046e4425aa', '2026-04-23 00:12:45', '2026-04-23 00:12:45'),
(5206, 'marca', 4, NULL, 'Invitado', 'sid:0e045fcdd76a5012ca840622bc92c7046e4425aa', '2026-04-23 01:45:58', '2026-04-23 01:45:58'),
(5211, 'marca', 2, NULL, 'Invitado', 'sid:0e045fcdd76a5012ca840622bc92c7046e4425aa', '2026-04-23 00:57:25', '2026-04-23 00:57:25'),
(5214, 'marca', 3, NULL, 'Invitado', 'sid:0e045fcdd76a5012ca840622bc92c7046e4425aa', '2026-04-23 20:32:18', '2026-04-23 20:32:18'),
(5442, 'marca', 5, NULL, 'Invitado', 'sid:0e045fcdd76a5012ca840622bc92c7046e4425aa', '2026-04-23 00:52:16', '2026-04-23 00:52:16'),
(5565, 'marca', 5, NULL, 'Invitado', 'sid:ece1ef09c8a7429f581df5c027502faafbf24c5a', '2026-04-23 01:50:19', '2026-04-23 01:50:19'),
(5567, 'marca', 2, NULL, 'Invitado', 'sid:ece1ef09c8a7429f581df5c027502faafbf24c5a', '2026-04-23 01:50:16', '2026-04-23 01:50:16'),
(5852, 'negocio', 9149, NULL, 'Invitado', 'sid:441d8adadf3dc88d478292ce66a48fbacd431c93', '2026-04-23 12:15:56', '2026-04-23 12:15:56'),
(5856, 'marca', 3, NULL, 'Invitado', 'sid:441d8adadf3dc88d478292ce66a48fbacd431c93', '2026-04-23 12:15:50', '2026-04-23 12:15:50'),
(5880, 'negocio', 9145, NULL, 'Invitado', 'sid:441d8adadf3dc88d478292ce66a48fbacd431c93', '2026-04-23 12:30:29', '2026-04-23 12:30:29'),
(6860, 'negocio', 9149, NULL, 'Invitado', 'sid:c896563784d3f3052962f76cb3a2c1be0a7ebdeb', '2026-04-24 01:01:19', '2026-04-24 01:01:19'),
(6868, 'marca', 4, NULL, 'Invitado', 'sid:c896563784d3f3052962f76cb3a2c1be0a7ebdeb', '2026-04-24 01:01:31', '2026-04-24 01:01:31'),
(6883, 'marca', 5, 5, 'Pablo_Farias', 'uid:5', '2026-04-27 20:57:16', '2026-04-27 20:57:16'),
(6895, 'negocio', 9150, 5, 'Pablo_Farias', 'uid:5', '2026-04-25 02:48:41', '2026-04-25 02:48:41'),
(7203, 'marca', 5, NULL, 'Invitado', 'sid:f7745405d69a680e05a01b6efba70616ccd02599', '2026-04-25 21:52:24', '2026-04-25 21:52:24'),
(7451, 'negocio', 9151, 5, 'Pablo_Farias', 'uid:5', '2026-04-26 15:55:37', '2026-04-26 15:55:37'),
(7463, 'negocio', 9152, 5, 'Pablo_Farias', 'uid:5', '2026-04-26 19:03:26', '2026-04-26 19:03:26'),
(7601, 'encuesta', 6, 5, 'Pablo_Farias', 'uid:5', '2026-04-26 18:11:21', '2026-04-26 18:11:21'),
(7931, 'negocio', 9153, 5, 'Pablo_Farias', 'uid:5', '2026-05-01 05:59:59', '2026-05-01 05:59:59'),
(7941, 'negocio', 9153, NULL, 'Invitado', 'sid:f7745405d69a680e05a01b6efba70616ccd02599', '2026-05-01 05:10:56', '2026-05-01 05:10:56'),
(7959, 'negocio', 9153, NULL, 'Invitado', 'sid:eee948fcfdc0f71c04ae0dea8bf969e1c190aa37', '2026-04-27 02:27:42', '2026-04-27 02:27:42'),
(9533, 'negocio', 9153, NULL, 'Invitado', 'sid:06e2a286bae4809b044030fb4b69952cb357f926', '2026-04-27 04:58:33', '2026-04-27 04:58:33'),
(9540, 'negocio', 9153, NULL, 'Invitado', 'sid:22fe38bab2f14a6c0b6378ccd2c8086a168a9237', '2026-04-27 05:04:16', '2026-04-27 05:04:16'),
(9623, 'negocio', 9153, NULL, 'Invitado', 'sid:439d3dec844826912779ee5e0bee8321d861ecfa', '2026-04-27 13:08:17', '2026-04-27 13:08:17'),
(9838, 'negocio', 9153, NULL, 'Invitado', 'sid:79cd313bcdd425fbed00d0bd5444887cf324f6f0', '2026-04-27 14:08:19', '2026-04-27 14:08:19'),
(11531, 'marca', 6, 5, 'Pablo_Farias', 'uid:5', '2026-04-29 19:55:54', '2026-04-29 19:55:54'),
(11642, 'negocio', 9154, 5, 'Pablo_Farias', 'uid:5', '2026-04-28 17:49:53', '2026-04-28 17:49:53'),
(12276, 'negocio', 9153, NULL, 'Invitado', 'sid:0b0b5a76b4945ac77e1c2181649cf88293d9b470', '2026-04-28 03:40:19', '2026-04-28 03:40:19'),
(12279, 'negocio', 9153, NULL, 'Invitado', 'sid:f9beeb8f44a83341d71edaafc9b5cbcd606d2510', '2026-04-28 03:40:39', '2026-04-28 03:40:39'),
(12283, 'negocio', 9153, NULL, 'Invitado', 'sid:217f77af9d2f6c3d0a9195e62e83e5446a6d3744', '2026-04-28 03:44:50', '2026-04-28 03:44:50'),
(12318, 'negocio', 9153, NULL, 'Invitado', 'sid:1370b85b301fb1e471cc40dbea5af56ff566750f', '2026-04-28 03:49:56', '2026-04-28 03:49:56'),
(12358, 'negocio', 9153, NULL, 'Invitado', 'sid:f57b66916b511082afece66f268ab42f435ae369', '2026-04-28 03:51:46', '2026-04-28 03:51:46'),
(12768, 'negocio', 9153, NULL, 'Invitado', 'sid:a4c5bd00d5a8715ce17ce52f803e18b4feeaa4c8', '2026-04-28 19:43:41', '2026-04-28 19:43:41'),
(12902, 'negocio', 9153, NULL, 'Invitado', 'sid:16b33e89fb228aed93f5a6d76cb259546b905c92', '2026-04-28 11:41:18', '2026-04-28 11:41:18'),
(12917, 'negocio', 9154, NULL, 'Invitado', 'sid:16b33e89fb228aed93f5a6d76cb259546b905c92', '2026-04-28 11:41:34', '2026-04-28 11:41:34'),
(14188, 'negocio', 9153, NULL, 'Invitado', 'sid:0a322da6590b868e0537de6d8f05d2c9da1b0e79', '2026-04-28 15:42:24', '2026-04-28 15:42:24'),
(14235, 'marca', 6, NULL, 'Invitado', 'sid:0a322da6590b868e0537de6d8f05d2c9da1b0e79', '2026-04-28 15:42:25', '2026-04-28 15:42:25'),
(14598, 'negocio', 9153, NULL, 'Invitado', 'sid:40f1d6beb0a7481e3f05be4a61e18b20613c8d16', '2026-04-28 15:53:36', '2026-04-28 15:53:36'),
(14622, 'negocio', 9154, NULL, 'Invitado', 'sid:f7745405d69a680e05a01b6efba70616ccd02599', '2026-04-28 15:55:27', '2026-04-28 15:55:27'),
(14663, 'negocio', 9153, NULL, 'Invitado', 'sid:8325269556c6911ec43cf7f2bd6722b574d6b915', '2026-04-28 15:57:21', '2026-04-28 15:57:21'),
(14672, 'negocio', 9153, NULL, 'Invitado', 'sid:84b8c3b994ff14d6ebdbf570db057a21caa530f7', '2026-04-28 15:58:57', '2026-04-28 15:58:57'),
(14716, 'negocio', 9153, NULL, 'Invitado', 'sid:07bdbc97efeb16d42107ee59d0b3ca138916a089', '2026-04-28 16:10:29', '2026-04-28 16:10:29'),
(14725, 'negocio', 9153, NULL, 'Invitado', 'sid:2c85c51b9dfa30c3d569fd033422628ce0b5f42b', '2026-04-28 17:04:47', '2026-04-28 17:04:47'),
(14791, 'negocio', 9154, NULL, 'Invitado', 'sid:2c85c51b9dfa30c3d569fd033422628ce0b5f42b', '2026-04-28 16:20:28', '2026-04-28 16:20:28'),
(14796, 'marca', 6, NULL, 'Invitado', 'sid:2c85c51b9dfa30c3d569fd033422628ce0b5f42b', '2026-04-28 16:17:28', '2026-04-28 16:17:28'),
(14882, 'negocio', 9153, NULL, 'Invitado', 'sid:2d2d30ac3266736e4c2242b71716d2d38602787d', '2026-04-28 16:37:00', '2026-04-28 16:37:00'),
(15409, 'negocio', 9155, 5, 'Pablo_Farias', 'uid:5', '2026-04-28 18:31:58', '2026-04-28 18:31:58'),
(15997, 'negocio', 9153, 7, 'Celeste_Ortiz_22', 'uid:7', '2026-04-28 23:29:20', '2026-04-28 23:29:20'),
(16146, 'negocio', 9153, NULL, 'Invitado', 'sid:fb83d4cb2ea1ffa3c200804341ece2597dfd87cd', '2026-04-28 23:23:01', '2026-04-28 23:23:01'),
(16151, 'marca', 6, NULL, 'Invitado', 'sid:fb83d4cb2ea1ffa3c200804341ece2597dfd87cd', '2026-04-28 23:05:10', '2026-04-28 23:05:10'),
(16277, 'negocio', 9153, NULL, 'Invitado', 'sid:3d2af6eed59492797053b35a8a9e4555fe6a29db', '2026-04-29 00:04:38', '2026-04-29 00:04:38'),
(16278, 'negocio', 9153, NULL, 'Invitado', 'sid:c67358b6723fe374c5ae3b9a04b29943de0d8239', '2026-04-29 00:08:21', '2026-04-29 00:08:21'),
(16289, 'negocio', 9156, 5, 'Pablo_Farias', 'uid:5', '2026-04-29 00:55:46', '2026-04-29 00:55:46'),
(16354, 'negocio', 9156, NULL, 'Invitado', 'sid:4c8c96695a74f1de68098ff6e1d11a70b24800d3', '2026-04-29 00:21:33', '2026-04-29 00:21:33'),
(16355, 'negocio', 9153, NULL, 'Invitado', 'sid:4c8c96695a74f1de68098ff6e1d11a70b24800d3', '2026-04-29 00:21:29', '2026-04-29 00:21:29'),
(16407, 'negocio', 9157, 5, 'Pablo_Farias', 'uid:5', '2026-05-01 00:51:08', '2026-05-01 00:51:08'),
(16441, 'negocio', 9158, 5, 'Pablo_Farias', 'uid:5', '2026-05-01 04:51:32', '2026-05-01 04:51:32'),
(16459, 'negocio', 9159, 5, 'Pablo_Farias', 'uid:5', '2026-04-29 03:04:23', '2026-04-29 03:04:23'),
(16475, 'negocio', 9160, 5, 'Pablo_Farias', 'uid:5', '2026-04-29 02:09:47', '2026-04-29 02:09:47'),
(16535, 'negocio', 9159, NULL, 'Invitado', 'sid:bd6d5f8cdde579637e52ed9894cb4c6e4d2e9c37', '2026-04-29 03:48:53', '2026-04-29 03:48:53'),
(16538, 'marca', 6, NULL, 'Invitado', 'sid:bd6d5f8cdde579637e52ed9894cb4c6e4d2e9c37', '2026-04-29 03:48:41', '2026-04-29 03:48:41'),
(16540, 'marca', 9, 5, 'Pablo_Farias', 'uid:5', '2026-05-01 04:51:35', '2026-05-01 04:51:35'),
(16566, 'marca', 8, 5, 'Pablo_Farias', 'uid:5', '2026-04-29 19:56:10', '2026-04-29 19:56:10'),
(16567, 'negocio', 9156, NULL, 'Invitado', 'sid:6c1f2867362e74f610e7bb8a25d578f83ba61924', '2026-04-29 13:12:09', '2026-04-29 13:12:09'),
(16569, 'negocio', 9158, NULL, 'Invitado', 'sid:6c1f2867362e74f610e7bb8a25d578f83ba61924', '2026-04-29 13:12:15', '2026-04-29 13:12:15'),
(16570, 'negocio', 9153, NULL, 'Invitado', 'sid:6c1f2867362e74f610e7bb8a25d578f83ba61924', '2026-04-29 13:12:21', '2026-04-29 13:12:21'),
(16571, 'negocio', 9157, NULL, 'Invitado', 'sid:9e023fc63c687123432a76447022955a61334024', '2026-04-29 17:01:18', '2026-04-29 17:01:18'),
(16573, 'marca', 9, NULL, 'Invitado', 'sid:9e023fc63c687123432a76447022955a61334024', '2026-04-29 17:01:18', '2026-04-29 17:01:18'),
(16646, 'negocio', 9161, 5, 'Pablo_Farias', 'uid:5', '2026-05-01 04:25:50', '2026-05-01 04:25:50'),
(17134, 'negocio', 9162, 8, 'GoldfarbHabasyAsociados', 'uid:8', '2026-04-29 18:54:37', '2026-04-29 18:54:37'),
(17149, 'negocio', 9162, NULL, 'Invitado', 'sid:f316db9157852318a8c94faa4ef14263759e9334', '2026-04-29 18:52:27', '2026-04-29 18:52:27'),
(17212, 'negocio', 9162, 5, 'Pablo_Farias', 'uid:5', '2026-05-01 04:51:21', '2026-05-01 04:51:21'),
(17231, 'negocio', 9162, 7, 'Celeste_Ortiz_22', 'uid:7', '2026-04-29 20:12:21', '2026-04-29 20:12:21'),
(17257, 'negocio', 9158, 7, 'Celeste_Ortiz_22', 'uid:7', '2026-04-29 20:12:30', '2026-04-29 20:12:30'),
(17426, 'negocio', 9160, 7, 'Celeste_Ortiz_22', 'uid:7', '2026-04-29 21:56:52', '2026-04-29 21:56:52'),
(17428, 'negocio', 9160, NULL, 'Invitado', 'sid:a3171830baaed03dde9797cf08269e3d0e1a5091', '2026-04-29 22:15:58', '2026-04-29 22:15:58'),
(17429, 'marca', 9, NULL, 'Invitado', 'sid:a3171830baaed03dde9797cf08269e3d0e1a5091', '2026-04-29 22:16:00', '2026-04-29 22:16:00'),
(17430, 'negocio', 9158, NULL, 'Invitado', 'sid:a3171830baaed03dde9797cf08269e3d0e1a5091', '2026-04-29 22:16:05', '2026-04-29 22:16:05'),
(17431, 'negocio', 9161, NULL, 'Invitado', 'sid:088085472a772b5943b7fcd7eaa0adb1a59c2835', '2026-04-29 23:36:37', '2026-04-29 23:36:37'),
(17432, 'negocio', 9162, NULL, 'Invitado', 'sid:6f5aa781e9568516be7aca763a219b9396945d2b', '2026-04-30 01:03:07', '2026-04-30 01:03:07'),
(17433, 'negocio', 9159, NULL, 'Invitado', 'sid:6f5aa781e9568516be7aca763a219b9396945d2b', '2026-04-30 01:03:07', '2026-04-30 01:03:07'),
(17436, 'negocio', 9159, NULL, 'Invitado', 'sid:088085472a772b5943b7fcd7eaa0adb1a59c2835', '2026-04-29 23:27:30', '2026-04-29 23:27:30'),
(17437, 'negocio', 9157, NULL, 'Invitado', 'sid:088085472a772b5943b7fcd7eaa0adb1a59c2835', '2026-04-29 23:28:33', '2026-04-29 23:28:33'),
(17439, 'negocio', 9156, NULL, 'Invitado', 'sid:088085472a772b5943b7fcd7eaa0adb1a59c2835', '2026-04-29 23:28:50', '2026-04-29 23:28:50'),
(17446, 'marca', 8, NULL, 'Invitado', 'sid:088085472a772b5943b7fcd7eaa0adb1a59c2835', '2026-04-29 23:45:09', '2026-04-29 23:45:09'),
(17452, 'negocio', 9162, NULL, 'Invitado', 'sid:4598db64e4de9056dfe2ae8aedcd8bdbea04fe29', '2026-04-30 00:10:47', '2026-04-30 00:10:47'),
(17458, 'negocio', 9162, NULL, 'Invitado', 'sid:57965cace64262b3f8fc1fdaa670b7ae8aee551a', '2026-04-30 02:51:28', '2026-04-30 02:51:28'),
(17459, 'marca', 9, NULL, 'Invitado', 'sid:b99e826904a258d7fdfc6c00ca8c56c8cd9a1ac8', '2026-04-30 04:13:08', '2026-04-30 04:13:08'),
(17460, 'negocio', 9153, NULL, 'Invitado', 'sid:b99e826904a258d7fdfc6c00ca8c56c8cd9a1ac8', '2026-04-30 04:13:20', '2026-04-30 04:13:20'),
(17461, 'negocio', 9153, 10, 'Luisvillegas', 'uid:10', '2026-04-30 04:34:33', '2026-04-30 04:34:33'),
(17473, 'marca', 9, NULL, 'Invitado', 'sid:073b8e979b572108e423e7d10ba90f24092f88af', '2026-04-30 19:57:47', '2026-04-30 19:57:47'),
(17476, 'marca', 7, NULL, 'Invitado', 'sid:073b8e979b572108e423e7d10ba90f24092f88af', '2026-04-30 19:57:44', '2026-04-30 19:57:44'),
(17478, 'negocio', 9160, NULL, 'Invitado', 'sid:073b8e979b572108e423e7d10ba90f24092f88af', '2026-04-30 19:57:47', '2026-04-30 19:57:47'),
(17479, 'negocio', 9156, NULL, 'Invitado', 'sid:073b8e979b572108e423e7d10ba90f24092f88af', '2026-04-30 19:57:33', '2026-04-30 19:57:33'),
(17480, 'negocio', 9161, NULL, 'Invitado', 'sid:073b8e979b572108e423e7d10ba90f24092f88af', '2026-04-30 19:57:40', '2026-04-30 19:57:40'),
(17483, 'negocio', 9162, NULL, 'Invitado', 'sid:073b8e979b572108e423e7d10ba90f24092f88af', '2026-04-30 19:57:49', '2026-04-30 19:57:49'),
(17491, 'negocio', 9159, NULL, 'Invitado', 'sid:073b8e979b572108e423e7d10ba90f24092f88af', '2026-04-30 19:57:47', '2026-04-30 19:57:47'),
(17499, 'negocio', 9153, NULL, 'Invitado', 'sid:073b8e979b572108e423e7d10ba90f24092f88af', '2026-04-30 19:57:44', '2026-04-30 19:57:44'),
(17506, 'negocio', 9160, NULL, 'Invitado', 'sid:67939fdeca358230c66bf084a7ea91000f924e11', '2026-04-30 20:39:08', '2026-04-30 20:39:08'),
(17507, 'negocio', 9158, NULL, 'Invitado', 'sid:67939fdeca358230c66bf084a7ea91000f924e11', '2026-04-30 20:39:20', '2026-04-30 20:39:20'),
(17720, 'negocio', 9163, 5, 'Pablo_Farias', 'uid:5', '2026-05-01 00:51:07', '2026-05-01 00:51:07'),
(17799, 'negocio', 9163, 11, 'MIGUEL', 'uid:11', '2026-05-01 00:57:36', '2026-05-01 00:57:36'),
(18068, 'encuesta', 7, 5, 'Pablo_Farias', 'uid:5', '2026-05-02 14:58:25', '2026-05-02 14:58:25'),
(18164, 'evento', 3, 5, 'Pablo_Farias', 'uid:5', '2026-05-01 17:26:49', '2026-05-01 17:26:49'),
(18191, 'evento', 5, 5, 'Pablo_Farias', 'uid:5', '2026-05-01 02:51:08', '2026-05-01 02:51:08'),
(18298, 'negocio', 9164, 5, 'Pablo_Farias', 'uid:5', '2026-05-01 20:56:42', '2026-05-01 20:56:42'),
(18992, 'negocio', 9162, NULL, 'Invitado', 'sid:f7745405d69a680e05a01b6efba70616ccd02599', '2026-05-01 05:10:56', '2026-05-01 05:10:56'),
(19031, 'negocio', 9153, NULL, 'Invitado', 'sid:18c8423be0d179ecc832cccb56a3e08529478148', '2026-05-01 05:11:41', '2026-05-01 05:11:41'),
(19048, 'negocio', 9153, NULL, 'Invitado', 'sid:5f9104201d06b48b30a092a14015a4473d8a1960', '2026-05-01 05:13:39', '2026-05-01 05:13:39'),
(19065, 'encuesta', 7, NULL, 'Invitado', 'sid:5f9104201d06b48b30a092a14015a4473d8a1960', '2026-05-01 05:13:41', '2026-05-01 05:13:41'),
(19963, 'evento', 3, NULL, 'Invitado', 'sid:d5a30533f214b2ad92168bd900a3ed371a88dbc0', '2026-05-01 20:01:45', '2026-05-01 20:01:45'),
(19967, 'marca', 7, NULL, 'Invitado', 'sid:d5a30533f214b2ad92168bd900a3ed371a88dbc0', '2026-05-01 20:01:37', '2026-05-01 20:01:37'),
(19972, 'negocio', 9164, NULL, 'Invitado', 'sid:d5a30533f214b2ad92168bd900a3ed371a88dbc0', '2026-05-01 20:01:39', '2026-05-01 20:01:39'),
(19976, 'evento', 3, NULL, 'Invitado', 'sid:56f622cae4fe12b115c740f8c18dd6eb2e19d0f8', '2026-05-02 14:54:22', '2026-05-02 14:54:22'),
(20434, 'negocio', 9164, NULL, 'Invitado', 'sid:677f7a8d92fa55438285b7ac2359ab61b15ad077', '2026-05-02 13:45:10', '2026-05-02 13:45:10'),
(20436, 'encuesta', 7, NULL, 'Invitado', 'sid:2f166b2715a277975ff433789960c862f7f50ce8', '2026-05-02 13:56:17', '2026-05-02 13:56:17'),
(20516, 'encuesta', 7, NULL, 'Invitado', 'sid:e669b4edcc53a01675300ae91a7c151fcf192466', '2026-05-02 14:56:32', '2026-05-02 14:56:32'),
(20688, 'encuesta', 7, NULL, 'Invitado', 'sid:f6a581ee5ec97de602f0d2db5ab2bcd0d50da290', '2026-05-02 15:25:26', '2026-05-02 15:25:26'),
(20707, 'encuesta', 8, 5, 'Pablo_Farias', 'uid:5', '2026-05-02 15:58:32', '2026-05-02 15:58:32'),
(20711, 'encuesta', 8, 7, 'Celeste_Ortiz_22', 'uid:7', '2026-05-02 16:03:29', '2026-05-02 16:03:29'),
(20785, 'encuesta', 8, NULL, 'Invitado', 'sid:388370f0101e05fe1217dc595f7b42d2e3e06a46', '2026-05-02 16:03:32', '2026-05-02 16:03:32');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wt_user_areas`
--

CREATE TABLE `wt_user_areas` (
  `user_id` int(11) NOT NULL,
  `area_slug` varchar(64) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wt_user_blocks`
--

CREATE TABLE `wt_user_blocks` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `blocker_user_id` int(11) NOT NULL,
  `blocked_user_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `wt_user_preferences`
--

CREATE TABLE `wt_user_preferences` (
  `user_id` int(11) NOT NULL,
  `wt_mode` enum('open','selective','closed') NOT NULL DEFAULT 'open',
  `areas` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'Array de slugs de áreas, usado cuando wt_mode=selective' CHECK (json_valid(`areas`)),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `agencies`
--
ALTER TABLE `agencies`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_ag_status` (`status`);

--
-- Indices de la tabla `agency_sector`
--
ALTER TABLE `agency_sector`
  ADD PRIMARY KEY (`agency_id`,`sector_type`,`sector_id`),
  ADD KEY `idx_asec_sid` (`sector_type`,`sector_id`);

--
-- Indices de la tabla `analisis_marcario`
--
ALTER TABLE `analisis_marcario`
  ADD PRIMARY KEY (`id`),
  ADD KEY `marca_id` (`marca_id`);

--
-- Indices de la tabla `analytics_events`
--
ALTER TABLE `analytics_events`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_ae_created_at` (`created_at`),
  ADD KEY `idx_ae_event_type` (`event_type`),
  ADD KEY `idx_ae_user_id` (`user_id`),
  ADD KEY `idx_ae_business_id` (`business_id`),
  ADD KEY `idx_ae_visitor_id` (`visitor_id`);

--
-- Indices de la tabla `articulos`
--
ALTER TABLE `articulos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `autor_id` (`autor_id`);

--
-- Indices de la tabla `attachments`
--
ALTER TABLE `attachments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `business_id` (`business_id`),
  ADD KEY `brand_id` (`brand_id`);

--
-- Indices de la tabla `audit_log`
--
ALTER TABLE `audit_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_audit_user` (`user_id`),
  ADD KEY `idx_audit_action` (`action`),
  ADD KEY `idx_audit_entity` (`entity_type`,`entity_id`),
  ADD KEY `idx_audit_created` (`created_at`);

--
-- Indices de la tabla `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `visible` (`visible`),
  ADD KEY `idx_scope` (`scope`),
  ADD KEY `idx_founded` (`founded_year`),
  ADD KEY `idx_brands_country_code` (`country_code`),
  ADD KEY `idx_brands_crear_franquicia` (`crear_franquicia`);

--
-- Indices de la tabla `brand_delegations`
--
ALTER TABLE `brand_delegations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_brand_delegate` (`brand_id`,`user_id`),
  ADD KEY `idx_brand_delegations_brand` (`brand_id`),
  ADD KEY `idx_brand_delegations_user` (`user_id`),
  ADD KEY `fk_brand_delegations_created_by` (`created_by`);

--
-- Indices de la tabla `brand_gallery`
--
ALTER TABLE `brand_gallery`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_brand` (`brand_id`),
  ADD KEY `idx_principal` (`es_principal`),
  ADD KEY `idx_brand_gallery_brand_id` (`brand_id`);

--
-- Indices de la tabla `brand_gallery_v2`
--
ALTER TABLE `brand_gallery_v2`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_bgv2_brand` (`brand_id`),
  ADD KEY `idx_bgv2_principal` (`es_principal`);

--
-- Indices de la tabla `businesses`
--
ALTER TABLE `businesses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `idx_business_price_range` (`price_range`),
  ADD KEY `fk_subcategory` (`subcategory_id`),
  ADD KEY `idx_verified` (`verified`),
  ADD KEY `idx_has_delivery` (`has_delivery`),
  ADD KEY `idx_instagram` (`instagram`),
  ADD KEY `idx_business_oferta_activa` (`oferta_activa_id`),
  ADD KEY `idx_businesses_country_code` (`country_code`),
  ADD KEY `idx_businesses_ofertas_permitidas` (`ofertas_permitidas`),
  ADD KEY `idx_businesses_visibility_zoom` (`visibility_min_zoom`),
  ADD KEY `idx_businesses_premium` (`is_premium`),
  ADD KEY `idx_businesses_inm_dest` (`inmuebles_destacado`);
ALTER TABLE `businesses` ADD FULLTEXT KEY `ft_influence_zones` (`influence_zones`);

--
-- Indices de la tabla `business_categories`
--
ALTER TABLE `business_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `business_delegations`
--
ALTER TABLE `business_delegations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_business_delegate` (`business_id`,`user_id`),
  ADD KEY `idx_business_delegations_business` (`business_id`),
  ADD KEY `idx_business_delegations_user` (`user_id`),
  ADD KEY `fk_business_delegations_created_by` (`created_by`);

--
-- Indices de la tabla `business_emoji_groups`
--
ALTER TABLE `business_emoji_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_business_group` (`business_id`,`group_id`),
  ADD KEY `group_id` (`group_id`);

--
-- Indices de la tabla `business_emoji_links`
--
ALTER TABLE `business_emoji_links`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_business_emoji` (`business_id`,`emoji_id`),
  ADD KEY `emoji_id` (`emoji_id`);

--
-- Indices de la tabla `business_icons`
--
ALTER TABLE `business_icons`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `business_type` (`business_type`);

--
-- Indices de la tabla `business_images`
--
ALTER TABLE `business_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `business_id` (`business_id`);

--
-- Indices de la tabla `business_subcategories`
--
ALTER TABLE `business_subcategories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`),
  ADD KEY `category_id` (`category_id`);

--
-- Indices de la tabla `business_type_limits`
--
ALTER TABLE `business_type_limits`
  ADD PRIMARY KEY (`business_type`);

--
-- Indices de la tabla `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `certificaciones_profesionales`
--
ALTER TABLE `certificaciones_profesionales`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_business` (`business_id`),
  ADD KEY `idx_tipo` (`tipo`),
  ADD KEY `idx_verificado` (`verificado`),
  ADD KEY `idx_destacada` (`destacada`);

--
-- Indices de la tabla `chambers`
--
ALTER TABLE `chambers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_ch_status` (`status`);

--
-- Indices de la tabla `chamber_sector`
--
ALTER TABLE `chamber_sector`
  ADD PRIMARY KEY (`chamber_id`,`sector_type`,`sector_id`),
  ADD KEY `idx_csec_sid` (`sector_type`,`sector_id`);

--
-- Indices de la tabla `clasificacion_niza`
--
ALTER TABLE `clasificacion_niza`
  ADD PRIMARY KEY (`id`),
  ADD KEY `marca_id` (`marca_id`);

--
-- Indices de la tabla `comercios`
--
ALTER TABLE `comercios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `business_id` (`business_id`);

--
-- Indices de la tabla `commercial_sectors`
--
ALTER TABLE `commercial_sectors`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_cs_type` (`type`),
  ADD KEY `idx_cs_status` (`status`);

--
-- Indices de la tabla `competencies`
--
ALTER TABLE `competencies`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_comp_source` (`source_type`,`source_id`),
  ADD KEY `idx_comp_role` (`role`);

--
-- Indices de la tabla `compras_paquetes`
--
ALTER TABLE `compras_paquetes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `paquete_id` (`paquete_id`),
  ADD KEY `idx_usuario` (`usuario_id`),
  ADD KEY `idx_email` (`email_cliente`),
  ADD KEY `idx_business` (`business_id`),
  ADD KEY `idx_estado` (`estado`),
  ADD KEY `idx_vigencia` (`fecha_inicio_vigencia`,`fecha_fin_vigencia`),
  ADD KEY `idx_usuario_estado` (`usuario_id`,`estado`);

--
-- Indices de la tabla `consultas_destinatarios`
--
ALTER TABLE `consultas_destinatarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_cd_consulta_negocio` (`consulta_id`,`business_id`),
  ADD KEY `idx_cd_negocio` (`business_id`),
  ADD KEY `idx_cd_dismissed_at` (`dismissed_at`);

--
-- Indices de la tabla `consultas_masivas`
--
ALTER TABLE `consultas_masivas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_cm_user` (`user_id`),
  ADD KEY `idx_cm_tipo` (`tipo`),
  ADD KEY `idx_cm_created_at` (`created_at`),
  ADD KEY `idx_cm_status` (`status`);

--
-- Indices de la tabla `consultas_respuestas`
--
ALTER TABLE `consultas_respuestas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_cr_consulta` (`consulta_id`),
  ADD KEY `idx_cr_business` (`business_id`),
  ADD KEY `idx_cr_created_at` (`created_at`);

--
-- Indices de la tabla `content_reports`
--
ALTER TABLE `content_reports`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_reports_status` (`status`),
  ADD KEY `idx_reports_content` (`content_type`,`content_id`),
  ADD KEY `idx_reports_reporter` (`reporter_user_id`),
  ADD KEY `idx_reports_created` (`created_at`);

--
-- Indices de la tabla `convocatorias`
--
ALTER TABLE `convocatorias`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_conv_business` (`business_id`),
  ADD KEY `idx_conv_user` (`user_id`),
  ADD KEY `idx_conv_estado` (`estado`);

--
-- Indices de la tabla `convocatoria_destinatarios`
--
ALTER TABLE `convocatoria_destinatarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_conv_dest` (`convocatoria_id`,`business_id`),
  ADD KEY `idx_cd_business` (`business_id`);

--
-- Indices de la tabla `cursos`
--
ALTER TABLE `cursos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `instructor_id` (`instructor_id`);

--
-- Indices de la tabla `curso_inscripciones`
--
ALTER TABLE `curso_inscripciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `curso_id` (`curso_id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Indices de la tabla `disponibles_items`
--
ALTER TABLE `disponibles_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_disp_business` (`business_id`),
  ADD KEY `idx_disp_activo` (`business_id`,`activo`);

--
-- Indices de la tabla `disponibles_solicitudes`
--
ALTER TABLE `disponibles_solicitudes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_dispsol_business` (`business_id`),
  ADD KEY `idx_dispsol_user` (`user_id`),
  ADD KEY `idx_dispsol_estado` (`business_id`,`estado`);

--
-- Indices de la tabla `disponibles_solicitud_items`
--
ALTER TABLE `disponibles_solicitud_items`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_sol_item` (`solicitud_id`,`item_id`),
  ADD KEY `idx_dispsolitem_item` (`item_id`);

--
-- Indices de la tabla `emoji_favorites`
--
ALTER TABLE `emoji_favorites`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`,`emoji_id`),
  ADD KEY `user_id_2` (`user_id`),
  ADD KEY `emoji_id` (`emoji_id`);

--
-- Indices de la tabla `emoji_groups`
--
ALTER TABLE `emoji_groups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `created_by` (`created_by`);

--
-- Indices de la tabla `emoji_group_members`
--
ALTER TABLE `emoji_group_members`
  ADD PRIMARY KEY (`group_id`,`emoji_id`),
  ADD KEY `emoji_id` (`emoji_id`);

--
-- Indices de la tabla `emoji_history`
--
ALTER TABLE `emoji_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `entity_type` (`entity_type`,`entity_id`),
  ADD KEY `user` (`user`),
  ADD KEY `action_at` (`action_at`);

--
-- Indices de la tabla `emoji_images`
--
ALTER TABLE `emoji_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `emoji_id` (`emoji_id`),
  ADD KEY `created_by_user_id` (`created_by_user_id`);

--
-- Indices de la tabla `emoji_markers`
--
ALTER TABLE `emoji_markers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `lat` (`lat`,`lng`),
  ADD KEY `idx_emoji_price_range` (`price_range`);

--
-- Indices de la tabla `emoji_relations`
--
ALTER TABLE `emoji_relations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `from_id` (`from_id`),
  ADD KEY `to_id` (`to_id`),
  ADD KEY `group_id` (`group_id`),
  ADD KEY `created_by` (`created_by`);

--
-- Indices de la tabla `encuestas`
--
ALTER TABLE `encuestas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_encuestas_coords` (`lat`,`lng`),
  ADD KEY `idx_encuestas_fechas` (`fecha_creacion`,`fecha_expiracion`),
  ADD KEY `idx_enc_coords` (`lat`,`lng`);

--
-- Indices de la tabla `encuestas_zona`
--
ALTER TABLE `encuestas_zona`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `encuesta_participaciones`
--
ALTER TABLE `encuesta_participaciones`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `idx_unica_participacion` (`encuesta_id`,`user_id`),
  ADD UNIQUE KEY `uq_participacion` (`encuesta_id`,`user_id`),
  ADD KEY `idx_encuesta_id` (`encuesta_id`),
  ADD KEY `idx_user_id` (`user_id`);

--
-- Indices de la tabla `encuesta_questions`
--
ALTER TABLE `encuesta_questions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_question_encuesta` (`encuesta_id`);

--
-- Indices de la tabla `encuesta_responses`
--
ALTER TABLE `encuesta_responses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_response_question` (`question_id`),
  ADD KEY `fk_response_user` (`user_id`);

--
-- Indices de la tabla `entidad_relaciones`
--
ALTER TABLE `entidad_relaciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_rel_source` (`source_entity_type`,`source_entity_id`),
  ADD KEY `idx_rel_target` (`target_entity_type`,`target_entity_id`),
  ADD KEY `idx_rel_source_mapita` (`source_mapita_id`),
  ADD KEY `idx_rel_target_mapita` (`target_mapita_id`);

--
-- Indices de la tabla `estrategia_optima`
--
ALTER TABLE `estrategia_optima`
  ADD PRIMARY KEY (`id`),
  ADD KEY `marca_id` (`marca_id`);

--
-- Indices de la tabla `eventos`
--
ALTER TABLE `eventos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_eventos_coords` (`lat`,`lng`),
  ADD KEY `idx_eventos_fecha` (`fecha`),
  ADD KEY `idx_coords` (`lat`,`lng`);

--
-- Indices de la tabla `horarios_disponibles`
--
ALTER TABLE `horarios_disponibles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_horario` (`business_id`,`dia_semana`,`hora_inicio`,`tipo_sesion`),
  ADD KEY `idx_business_dia` (`business_id`,`dia_semana`),
  ADD KEY `idx_dia_hora` (`dia_semana`,`hora_inicio`),
  ADD KEY `idx_tipo_sesion` (`tipo_sesion`),
  ADD KEY `idx_activo` (`activo`);

--
-- Indices de la tabla `hoteles`
--
ALTER TABLE `hoteles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `business_id` (`business_id`);

--
-- Indices de la tabla `industrial_sectors`
--
ALTER TABLE `industrial_sectors`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_is_type` (`type`),
  ADD KEY `idx_is_status` (`status`);

--
-- Indices de la tabla `industries`
--
ALTER TABLE `industries`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_ind_user_id` (`user_id`),
  ADD KEY `idx_ind_industrial_sector_id` (`industrial_sector_id`),
  ADD KEY `idx_ind_name` (`name`),
  ADD KEY `idx_ind_status` (`status`),
  ADD KEY `idx_industries_country_code` (`country_code`),
  ADD KEY `idx_industries_business_id` (`business_id`),
  ADD KEY `idx_industries_brand_id` (`brand_id`);

--
-- Indices de la tabla `industry_images`
--
ALTER TABLE `industry_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_ind_images_industry` (`industry_id`);

--
-- Indices de la tabla `inmobiliarias`
--
ALTER TABLE `inmobiliarias`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `business_id` (`business_id`);

--
-- Indices de la tabla `inmuebles`
--
ALTER TABLE `inmuebles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_inm_business` (`business_id`),
  ADD KEY `idx_inm_operacion` (`operacion`),
  ADD KEY `idx_inm_activo` (`activo`),
  ADD KEY `idx_inm_tipo` (`tipo`),
  ADD KEY `idx_inm_lat_lng` (`lat`,`lng`);

--
-- Indices de la tabla `inmueble_adjuntos`
--
ALTER TABLE `inmueble_adjuntos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_ia_inmueble` (`inmueble_id`),
  ADD KEY `idx_ia_tipo` (`tipo_adjunto`);

--
-- Indices de la tabla `job_applications`
--
ALTER TABLE `job_applications`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_jobapp_user_biz` (`business_id`,`user_id`),
  ADD KEY `idx_jobapp_business` (`business_id`),
  ADD KEY `idx_jobapp_user` (`user_id`),
  ADD KEY `idx_jobapp_estado` (`business_id`,`estado`);

--
-- Indices de la tabla `mapita_settings`
--
ALTER TABLE `mapita_settings`
  ADD PRIMARY KEY (`setting_key`);

--
-- Indices de la tabla `marcadores`
--
ALTER TABLE `marcadores`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_created_at` (`created_at`),
  ADD KEY `idx_created_by` (`created_by`);

--
-- Indices de la tabla `marcas`
--
ALTER TABLE `marcas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`),
  ADD KEY `idx_scope` (`scope`),
  ADD KEY `idx_founded` (`founded_year`);

--
-- Indices de la tabla `modelos_negocio`
--
ALTER TABLE `modelos_negocio`
  ADD PRIMARY KEY (`id`),
  ADD KEY `marca_id` (`marca_id`);

--
-- Indices de la tabla `monetizacion`
--
ALTER TABLE `monetizacion`
  ADD PRIMARY KEY (`id`),
  ADD KEY `marca_id` (`marca_id`);

--
-- Indices de la tabla `negocios_radio_operacion`
--
ALTER TABLE `negocios_radio_operacion`
  ADD PRIMARY KEY (`id`),
  ADD KEY `negocio_id` (`negocio_id`),
  ADD KEY `categoria_servicio` (`categoria_servicio`),
  ADD KEY `centro_lat` (`centro_lat`,`centro_lng`),
  ADD KEY `disponible` (`disponible`,`activo`);

--
-- Indices de la tabla `noticias`
--
ALTER TABLE `noticias`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_activa` (`activa`),
  ADD KEY `idx_fecha` (`fecha_publicacion`),
  ADD KEY `idx_categoria` (`categoria`),
  ADD KEY `idx_user` (`user_id`),
  ADD KEY `idx_not_coords` (`lat`,`lng`);

--
-- Indices de la tabla `ofertas`
--
ALTER TABLE `ofertas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_ofertas_coords` (`lat`,`lng`),
  ADD KEY `idx_ofertas_fechas` (`fecha_inicio`,`fecha_expiracion`),
  ADD KEY `fk_ofertas_business` (`business_id`),
  ADD KEY `idx_ofertas_destacada` (`business_id`,`activo`,`es_destacada`);

--
-- Indices de la tabla `ownership_transfers`
--
ALTER TABLE `ownership_transfers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_ownership_transfers_entity` (`entity_type`,`entity_id`),
  ADD KEY `idx_ownership_transfers_status` (`status`),
  ADD KEY `idx_ownership_transfers_to_user` (`to_user_id`,`status`),
  ADD KEY `fk_ownership_transfers_from_user` (`from_user_id`);

--
-- Indices de la tabla `paquetes_servicios`
--
ALTER TABLE `paquetes_servicios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_business` (`business_id`),
  ADD KEY `idx_tipo` (`tipo`),
  ADD KEY `idx_destacado` (`destacado`,`orden`),
  ADD KEY `idx_activo` (`activo`),
  ADD KEY `idx_vigencia` (`fecha_inicio`,`fecha_expiracion`);

--
-- Indices de la tabla `policy_lines`
--
ALTER TABLE `policy_lines`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_pl_source` (`source_type`,`source_id`),
  ADD KEY `idx_pl_type` (`line_type`),
  ADD KEY `idx_pl_status` (`status`);

--
-- Indices de la tabla `polygons`
--
ALTER TABLE `polygons`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_polygon_name` (`name`);

--
-- Indices de la tabla `portfolio_trabajos`
--
ALTER TABLE `portfolio_trabajos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_business` (`business_id`),
  ADD KEY `idx_categoria` (`categoria`),
  ADD KEY `idx_destacado` (`destacado`,`orden`),
  ADD KEY `idx_publico` (`publico`);

--
-- Indices de la tabla `preguntas_encuesta`
--
ALTER TABLE `preguntas_encuesta`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `business_id` (`business_id`);

--
-- Indices de la tabla `profesionales`
--
ALTER TABLE `profesionales`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `business_id` (`business_id`);

--
-- Indices de la tabla `promociones`
--
ALTER TABLE `promociones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `business_id` (`business_id`);

--
-- Indices de la tabla `radar_contract_types`
--
ALTER TABLE `radar_contract_types`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_rct_cat` (`category`);

--
-- Indices de la tabla `radar_destinations`
--
ALTER TABLE `radar_destinations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_rd_dir` (`direction`);

--
-- Indices de la tabla `radar_disputes`
--
ALTER TABLE `radar_disputes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_rdis_type` (`dispute_type`);

--
-- Indices de la tabla `radar_ports`
--
ALTER TABLE `radar_ports`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_rp_mode` (`transport_mode_id`);

--
-- Indices de la tabla `radar_restrictions`
--
ALTER TABLE `radar_restrictions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_rr_type` (`restriction_type`);

--
-- Indices de la tabla `radar_transport_modes`
--
ALTER TABLE `radar_transport_modes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_rtm_mode` (`mode`);

--
-- Indices de la tabla `rate_limit_log`
--
ALTER TABLE `rate_limit_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_rl_ip_endpoint` (`ip`,`endpoint`,`hit_at`);

--
-- Indices de la tabla `remates`
--
ALTER TABLE `remates`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_remates_business` (`business_id`),
  ADD KEY `idx_remates_activo_fechas` (`activo`,`fecha_inicio`,`fecha_fin`,`fecha_cierre`);

--
-- Indices de la tabla `reservas`
--
ALTER TABLE `reservas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_reserva` (`business_id`,`fecha_reserva`,`hora_inicio`,`modalidad`),
  ADD KEY `idx_business_fecha` (`business_id`,`fecha_reserva`),
  ADD KEY `idx_fecha` (`fecha_reserva`),
  ADD KEY `idx_estado` (`estado`),
  ADD KEY `idx_usuario` (`usuario_id`),
  ADD KEY `idx_email` (`email_cliente`),
  ADD KEY `idx_confirmada` (`confirmada_por_proveedor`,`fecha_reserva`);

--
-- Indices de la tabla `respuestas_encuesta`
--
ALTER TABLE `respuestas_encuesta`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `idx_unica_respuesta_usuario` (`encuesta_id`,`pregunta_id`,`user_id`),
  ADD KEY `idx_user_id` (`user_id`);

--
-- Indices de la tabla `restaurantes`
--
ALTER TABLE `restaurantes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `business_id` (`business_id`);

--
-- Indices de la tabla `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_review` (`business_id`,`user_id`),
  ADD KEY `fk_review_user` (`user_id`);

--
-- Indices de la tabla `riesgo_legal`
--
ALTER TABLE `riesgo_legal`
  ADD PRIMARY KEY (`id`),
  ADD KEY `marca_id` (`marca_id`);

--
-- Indices de la tabla `sector_radar_settings`
--
ALTER TABLE `sector_radar_settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_srs` (`sector_type`,`sector_id`);

--
-- Indices de la tabla `servicios_profesionales`
--
ALTER TABLE `servicios_profesionales`
  ADD PRIMARY KEY (`id`),
  ADD KEY `business_id` (`business_id`),
  ADD KEY `idx_categoria` (`categoria_servicio`),
  ADD KEY `idx_modalidad_presencial` (`modalidad_presencial`),
  ADD KEY `idx_modalidad_online` (`modalidad_online`),
  ADD KEY `idx_modalidad_domicilio` (`modalidad_domicilio`),
  ADD KEY `idx_activo` (`activo`);

--
-- Indices de la tabla `share_tokens`
--
ALTER TABLE `share_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `token_unique` (`token`),
  ADD KEY `encuesta_id_idx` (`encuesta_id`),
  ADD KEY `user_id_idx` (`user_id`);

--
-- Indices de la tabla `subcategories`
--
ALTER TABLE `subcategories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `category_id` (`category_id`);

--
-- Indices de la tabla `system_config`
--
ALTER TABLE `system_config`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `config_key` (`config_key`);

--
-- Indices de la tabla `transmisiones`
--
ALTER TABLE `transmisiones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_activo` (`activo`),
  ADD KEY `idx_en_vivo` (`en_vivo`),
  ADD KEY `idx_coords` (`lat`,`lng`),
  ADD KEY `idx_tipo` (`tipo`),
  ADD KEY `idx_trans_ventana` (`activo`,`fecha_inicio`,`fecha_fin`);

--
-- Indices de la tabla `transmisiones_vivo`
--
ALTER TABLE `transmisiones_vivo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `organizador_id` (`organizador_id`);

--
-- Indices de la tabla `transmision_participantes`
--
ALTER TABLE `transmision_participantes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transmision_id` (`transmision_id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Indices de la tabla `transporte`
--
ALTER TABLE `transporte`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `business_id` (`business_id`);

--
-- Indices de la tabla `transporte_asignaciones`
--
ALTER TABLE `transporte_asignaciones`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `trivias`
--
ALTER TABLE `trivias`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_activa` (`activa`),
  ADD KEY `idx_tri_coords` (`lat`,`lng`);

--
-- Indices de la tabla `trivia_games`
--
ALTER TABLE `trivia_games`
  ADD PRIMARY KEY (`game_id`);

--
-- Indices de la tabla `trivia_scores`
--
ALTER TABLE `trivia_scores`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_trivia` (`trivia_id`),
  ADD KEY `idx_user` (`user_id`),
  ADD KEY `idx_puntos` (`puntos`);

--
-- Indices de la tabla `trivia_stats`
--
ALTER TABLE `trivia_stats`
  ADD PRIMARY KEY (`stat_id`),
  ADD KEY `game_id` (`game_id`);

--
-- Indices de la tabla `turnos`
--
ALTER TABLE `turnos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `business_id` (`business_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `idx_users_first_name` (`first_name`),
  ADD KEY `idx_users_last_name` (`last_name`);

--
-- Indices de la tabla `user_presence`
--
ALTER TABLE `user_presence`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_up_user_id` (`user_id`),
  ADD KEY `idx_up_visitor_id` (`visitor_id`),
  ADD KEY `idx_up_session_id` (`session_id`),
  ADD KEY `idx_up_last_seen_at` (`last_seen_at`);

--
-- Indices de la tabla `valoraciones_servicios`
--
ALTER TABLE `valoraciones_servicios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `reserva_id` (`reserva_id`),
  ADD KEY `idx_business` (`business_id`),
  ADD KEY `idx_calificacion` (`calificacion_general`),
  ADD KEY `idx_verificada` (`verificada`),
  ADD KEY `idx_aprobada` (`aprobada`),
  ADD KEY `idx_created` (`created_at` DESC);

--
-- Indices de la tabla `vehiculos_venta`
--
ALTER TABLE `vehiculos_venta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_vehiculos_business` (`business_id`),
  ADD KEY `idx_vehiculos_tipo` (`tipo_vehiculo`);

--
-- Indices de la tabla `wt_messages`
--
ALTER TABLE `wt_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_wt_entity_time` (`entity_type`,`entity_id`,`created_at`),
  ADD KEY `idx_wt_sender_time` (`sender_key`,`created_at`);

--
-- Indices de la tabla `wt_presence`
--
ALTER TABLE `wt_presence`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_wt_presence` (`entity_type`,`entity_id`,`sender_key`),
  ADD KEY `idx_wt_presence_seen` (`entity_type`,`entity_id`,`last_seen`);

--
-- Indices de la tabla `wt_user_areas`
--
ALTER TABLE `wt_user_areas`
  ADD PRIMARY KEY (`user_id`,`area_slug`),
  ADD KEY `idx_wt_area_slug_user` (`area_slug`,`user_id`);

--
-- Indices de la tabla `wt_user_blocks`
--
ALTER TABLE `wt_user_blocks`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_wt_block` (`blocker_user_id`,`blocked_user_id`),
  ADD KEY `idx_wt_block_blocker` (`blocker_user_id`),
  ADD KEY `idx_wt_block_blocked` (`blocked_user_id`),
  ADD KEY `idx_wt_block_blocked_blocker` (`blocked_user_id`,`blocker_user_id`);

--
-- Indices de la tabla `wt_user_preferences`
--
ALTER TABLE `wt_user_preferences`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `agencies`
--
ALTER TABLE `agencies`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `analisis_marcario`
--
ALTER TABLE `analisis_marcario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `analytics_events`
--
ALTER TABLE `analytics_events`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1237;

--
-- AUTO_INCREMENT de la tabla `articulos`
--
ALTER TABLE `articulos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `attachments`
--
ALTER TABLE `attachments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `audit_log`
--
ALTER TABLE `audit_log`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT de la tabla `brands`
--
ALTER TABLE `brands`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `brand_delegations`
--
ALTER TABLE `brand_delegations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `brand_gallery`
--
ALTER TABLE `brand_gallery`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `brand_gallery_v2`
--
ALTER TABLE `brand_gallery_v2`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `businesses`
--
ALTER TABLE `businesses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9165;

--
-- AUTO_INCREMENT de la tabla `business_categories`
--
ALTER TABLE `business_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `business_delegations`
--
ALTER TABLE `business_delegations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `business_emoji_groups`
--
ALTER TABLE `business_emoji_groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `business_emoji_links`
--
ALTER TABLE `business_emoji_links`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `business_icons`
--
ALTER TABLE `business_icons`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;

--
-- AUTO_INCREMENT de la tabla `business_images`
--
ALTER TABLE `business_images`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `business_subcategories`
--
ALTER TABLE `business_subcategories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `certificaciones_profesionales`
--
ALTER TABLE `certificaciones_profesionales`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `chambers`
--
ALTER TABLE `chambers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `clasificacion_niza`
--
ALTER TABLE `clasificacion_niza`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `comercios`
--
ALTER TABLE `comercios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT de la tabla `commercial_sectors`
--
ALTER TABLE `commercial_sectors`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `competencies`
--
ALTER TABLE `competencies`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `compras_paquetes`
--
ALTER TABLE `compras_paquetes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `consultas_destinatarios`
--
ALTER TABLE `consultas_destinatarios`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `consultas_masivas`
--
ALTER TABLE `consultas_masivas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `consultas_respuestas`
--
ALTER TABLE `consultas_respuestas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `content_reports`
--
ALTER TABLE `content_reports`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `convocatorias`
--
ALTER TABLE `convocatorias`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `convocatoria_destinatarios`
--
ALTER TABLE `convocatoria_destinatarios`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cursos`
--
ALTER TABLE `cursos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `curso_inscripciones`
--
ALTER TABLE `curso_inscripciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `disponibles_items`
--
ALTER TABLE `disponibles_items`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `disponibles_solicitudes`
--
ALTER TABLE `disponibles_solicitudes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `disponibles_solicitud_items`
--
ALTER TABLE `disponibles_solicitud_items`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `emoji_favorites`
--
ALTER TABLE `emoji_favorites`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `emoji_groups`
--
ALTER TABLE `emoji_groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `emoji_history`
--
ALTER TABLE `emoji_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `emoji_images`
--
ALTER TABLE `emoji_images`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `emoji_markers`
--
ALTER TABLE `emoji_markers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `emoji_relations`
--
ALTER TABLE `emoji_relations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `encuestas`
--
ALTER TABLE `encuestas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `encuestas_zona`
--
ALTER TABLE `encuestas_zona`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `encuesta_participaciones`
--
ALTER TABLE `encuesta_participaciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `encuesta_questions`
--
ALTER TABLE `encuesta_questions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `encuesta_responses`
--
ALTER TABLE `encuesta_responses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `entidad_relaciones`
--
ALTER TABLE `entidad_relaciones`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `estrategia_optima`
--
ALTER TABLE `estrategia_optima`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `eventos`
--
ALTER TABLE `eventos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `horarios_disponibles`
--
ALTER TABLE `horarios_disponibles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;

--
-- AUTO_INCREMENT de la tabla `hoteles`
--
ALTER TABLE `hoteles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `industrial_sectors`
--
ALTER TABLE `industrial_sectors`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `industries`
--
ALTER TABLE `industries`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `industry_images`
--
ALTER TABLE `industry_images`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `inmobiliarias`
--
ALTER TABLE `inmobiliarias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `inmuebles`
--
ALTER TABLE `inmuebles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `inmueble_adjuntos`
--
ALTER TABLE `inmueble_adjuntos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `job_applications`
--
ALTER TABLE `job_applications`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `marcadores`
--
ALTER TABLE `marcadores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `marcas`
--
ALTER TABLE `marcas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `modelos_negocio`
--
ALTER TABLE `modelos_negocio`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `monetizacion`
--
ALTER TABLE `monetizacion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `negocios_radio_operacion`
--
ALTER TABLE `negocios_radio_operacion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `noticias`
--
ALTER TABLE `noticias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `ofertas`
--
ALTER TABLE `ofertas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `ownership_transfers`
--
ALTER TABLE `ownership_transfers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `paquetes_servicios`
--
ALTER TABLE `paquetes_servicios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `policy_lines`
--
ALTER TABLE `policy_lines`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `polygons`
--
ALTER TABLE `polygons`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `portfolio_trabajos`
--
ALTER TABLE `portfolio_trabajos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `preguntas_encuesta`
--
ALTER TABLE `preguntas_encuesta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `profesionales`
--
ALTER TABLE `profesionales`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `promociones`
--
ALTER TABLE `promociones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `radar_contract_types`
--
ALTER TABLE `radar_contract_types`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `radar_destinations`
--
ALTER TABLE `radar_destinations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `radar_disputes`
--
ALTER TABLE `radar_disputes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `radar_ports`
--
ALTER TABLE `radar_ports`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `radar_restrictions`
--
ALTER TABLE `radar_restrictions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `radar_transport_modes`
--
ALTER TABLE `radar_transport_modes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `rate_limit_log`
--
ALTER TABLE `rate_limit_log`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT de la tabla `remates`
--
ALTER TABLE `remates`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `reservas`
--
ALTER TABLE `reservas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `respuestas_encuesta`
--
ALTER TABLE `respuestas_encuesta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `restaurantes`
--
ALTER TABLE `restaurantes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `riesgo_legal`
--
ALTER TABLE `riesgo_legal`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `sector_radar_settings`
--
ALTER TABLE `sector_radar_settings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `servicios_profesionales`
--
ALTER TABLE `servicios_profesionales`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de la tabla `share_tokens`
--
ALTER TABLE `share_tokens`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `subcategories`
--
ALTER TABLE `subcategories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

--
-- AUTO_INCREMENT de la tabla `system_config`
--
ALTER TABLE `system_config`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT de la tabla `transmisiones`
--
ALTER TABLE `transmisiones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `transmisiones_vivo`
--
ALTER TABLE `transmisiones_vivo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `transmision_participantes`
--
ALTER TABLE `transmision_participantes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `transporte`
--
ALTER TABLE `transporte`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `transporte_asignaciones`
--
ALTER TABLE `transporte_asignaciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `trivias`
--
ALTER TABLE `trivias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `trivia_scores`
--
ALTER TABLE `trivia_scores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `trivia_stats`
--
ALTER TABLE `trivia_stats`
  MODIFY `stat_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `turnos`
--
ALTER TABLE `turnos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `user_presence`
--
ALTER TABLE `user_presence`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=139;

--
-- AUTO_INCREMENT de la tabla `valoraciones_servicios`
--
ALTER TABLE `valoraciones_servicios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `vehiculos_venta`
--
ALTER TABLE `vehiculos_venta`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `wt_messages`
--
ALTER TABLE `wt_messages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `wt_presence`
--
ALTER TABLE `wt_presence`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20802;

--
-- AUTO_INCREMENT de la tabla `wt_user_blocks`
--
ALTER TABLE `wt_user_blocks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

-- --------------------------------------------------------

--
-- Estructura para la vista `v_businesses_with_icons`
--
DROP TABLE IF EXISTS `v_businesses_with_icons`;

CREATE ALGORITHM=UNDEFINED DEFINER=`u580580751_mapita`@`127.0.0.1` SQL SECURITY DEFINER VIEW `v_businesses_with_icons`  AS SELECT `b`.`id` AS `id`, `b`.`user_id` AS `user_id`, `b`.`name` AS `name`, `b`.`address` AS `address`, `b`.`lat` AS `lat`, `b`.`lng` AS `lng`, `b`.`phone` AS `phone`, `b`.`email` AS `email`, `b`.`website` AS `website`, `b`.`business_type` AS `business_type`, `b`.`visible` AS `visible`, `b`.`status` AS `status`, `b`.`created_at` AS `created_at`, `b`.`updated_at` AS `updated_at`, `b`.`price_range` AS `price_range`, `b`.`description` AS `description`, `b`.`subcategory_id` AS `subcategory_id`, coalesce(`bi`.`emoji`,'📍') AS `emoji`, `bi`.`icon_class` AS `icon_class` FROM (`businesses` `b` left join `business_icons` `bi` on(`b`.`business_type` = `bi`.`business_type`)) ;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `agency_sector`
--
ALTER TABLE `agency_sector`
  ADD CONSTRAINT `fk_as_agency` FOREIGN KEY (`agency_id`) REFERENCES `agencies` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `analisis_marcario`
--
ALTER TABLE `analisis_marcario`
  ADD CONSTRAINT `analisis_marcario_ibfk_1` FOREIGN KEY (`marca_id`) REFERENCES `marcas` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `articulos`
--
ALTER TABLE `articulos`
  ADD CONSTRAINT `articulos_ibfk_1` FOREIGN KEY (`autor_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `attachments`
--
ALTER TABLE `attachments`
  ADD CONSTRAINT `attachments_ibfk_1` FOREIGN KEY (`business_id`) REFERENCES `businesses` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `attachments_ibfk_2` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `brand_delegations`
--
ALTER TABLE `brand_delegations`
  ADD CONSTRAINT `fk_brand_delegations_brand` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_brand_delegations_created_by` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_brand_delegations_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `brand_gallery`
--
ALTER TABLE `brand_gallery`
  ADD CONSTRAINT `fk_gallery_brand` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `brand_gallery_v2`
--
ALTER TABLE `brand_gallery_v2`
  ADD CONSTRAINT `fk_bgv2_brand` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `businesses`
--
ALTER TABLE `businesses`
  ADD CONSTRAINT `businesses_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_subcategory` FOREIGN KEY (`subcategory_id`) REFERENCES `business_subcategories` (`id`);

--
-- Filtros para la tabla `business_delegations`
--
ALTER TABLE `business_delegations`
  ADD CONSTRAINT `fk_business_delegations_business` FOREIGN KEY (`business_id`) REFERENCES `businesses` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_business_delegations_created_by` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_business_delegations_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `business_emoji_groups`
--
ALTER TABLE `business_emoji_groups`
  ADD CONSTRAINT `business_emoji_groups_ibfk_1` FOREIGN KEY (`business_id`) REFERENCES `businesses` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `business_emoji_groups_ibfk_2` FOREIGN KEY (`group_id`) REFERENCES `emoji_groups` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `business_emoji_links`
--
ALTER TABLE `business_emoji_links`
  ADD CONSTRAINT `business_emoji_links_ibfk_1` FOREIGN KEY (`business_id`) REFERENCES `businesses` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `business_emoji_links_ibfk_2` FOREIGN KEY (`emoji_id`) REFERENCES `emoji_markers` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `business_images`
--
ALTER TABLE `business_images`
  ADD CONSTRAINT `business_images_ibfk_1` FOREIGN KEY (`business_id`) REFERENCES `businesses` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `business_subcategories`
--
ALTER TABLE `business_subcategories`
  ADD CONSTRAINT `business_subcategories_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `business_categories` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `certificaciones_profesionales`
--
ALTER TABLE `certificaciones_profesionales`
  ADD CONSTRAINT `certificaciones_profesionales_ibfk_1` FOREIGN KEY (`business_id`) REFERENCES `businesses` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `chamber_sector`
--
ALTER TABLE `chamber_sector`
  ADD CONSTRAINT `fk_cs_chamber` FOREIGN KEY (`chamber_id`) REFERENCES `chambers` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `clasificacion_niza`
--
ALTER TABLE `clasificacion_niza`
  ADD CONSTRAINT `clasificacion_niza_ibfk_1` FOREIGN KEY (`marca_id`) REFERENCES `marcas` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `comercios`
--
ALTER TABLE `comercios`
  ADD CONSTRAINT `comercios_ibfk_1` FOREIGN KEY (`business_id`) REFERENCES `businesses` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `compras_paquetes`
--
ALTER TABLE `compras_paquetes`
  ADD CONSTRAINT `compras_paquetes_ibfk_1` FOREIGN KEY (`paquete_id`) REFERENCES `paquetes_servicios` (`id`),
  ADD CONSTRAINT `compras_paquetes_ibfk_2` FOREIGN KEY (`business_id`) REFERENCES `businesses` (`id`);

--
-- Filtros para la tabla `consultas_destinatarios`
--
ALTER TABLE `consultas_destinatarios`
  ADD CONSTRAINT `fk_cd_consulta` FOREIGN KEY (`consulta_id`) REFERENCES `consultas_masivas` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_cd_negocio` FOREIGN KEY (`business_id`) REFERENCES `businesses` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `consultas_masivas`
--
ALTER TABLE `consultas_masivas`
  ADD CONSTRAINT `fk_cm_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `consultas_respuestas`
--
ALTER TABLE `consultas_respuestas`
  ADD CONSTRAINT `fk_cr_consulta` FOREIGN KEY (`consulta_id`) REFERENCES `consultas_masivas` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `convocatorias`
--
ALTER TABLE `convocatorias`
  ADD CONSTRAINT `fk_conv_business` FOREIGN KEY (`business_id`) REFERENCES `businesses` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_conv_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `convocatoria_destinatarios`
--
ALTER TABLE `convocatoria_destinatarios`
  ADD CONSTRAINT `fk_cd_business` FOREIGN KEY (`business_id`) REFERENCES `businesses` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_cd_conv` FOREIGN KEY (`convocatoria_id`) REFERENCES `convocatorias` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `cursos`
--
ALTER TABLE `cursos`
  ADD CONSTRAINT `cursos_ibfk_1` FOREIGN KEY (`instructor_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `curso_inscripciones`
--
ALTER TABLE `curso_inscripciones`
  ADD CONSTRAINT `curso_inscripciones_ibfk_1` FOREIGN KEY (`curso_id`) REFERENCES `cursos` (`id`),
  ADD CONSTRAINT `curso_inscripciones_ibfk_2` FOREIGN KEY (`usuario_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `disponibles_items`
--
ALTER TABLE `disponibles_items`
  ADD CONSTRAINT `fk_dispitems_business` FOREIGN KEY (`business_id`) REFERENCES `businesses` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `disponibles_solicitudes`
--
ALTER TABLE `disponibles_solicitudes`
  ADD CONSTRAINT `fk_dispsol_business` FOREIGN KEY (`business_id`) REFERENCES `businesses` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `disponibles_solicitud_items`
--
ALTER TABLE `disponibles_solicitud_items`
  ADD CONSTRAINT `fk_dispsolitem_item` FOREIGN KEY (`item_id`) REFERENCES `disponibles_items` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_dispsolitem_sol` FOREIGN KEY (`solicitud_id`) REFERENCES `disponibles_solicitudes` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `emoji_favorites`
--
ALTER TABLE `emoji_favorites`
  ADD CONSTRAINT `emoji_favorites_ibfk_1` FOREIGN KEY (`emoji_id`) REFERENCES `emoji_markers` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `emoji_group_members`
--
ALTER TABLE `emoji_group_members`
  ADD CONSTRAINT `emoji_group_members_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `emoji_groups` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `emoji_group_members_ibfk_2` FOREIGN KEY (`emoji_id`) REFERENCES `emoji_markers` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `emoji_images`
--
ALTER TABLE `emoji_images`
  ADD CONSTRAINT `emoji_images_ibfk_1` FOREIGN KEY (`emoji_id`) REFERENCES `emoji_markers` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `emoji_images_ibfk_2` FOREIGN KEY (`created_by_user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `emoji_relations`
--
ALTER TABLE `emoji_relations`
  ADD CONSTRAINT `emoji_relations_ibfk_1` FOREIGN KEY (`from_id`) REFERENCES `emoji_markers` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `emoji_relations_ibfk_2` FOREIGN KEY (`to_id`) REFERENCES `emoji_markers` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `emoji_relations_ibfk_3` FOREIGN KEY (`group_id`) REFERENCES `emoji_groups` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `encuesta_participaciones`
--
ALTER TABLE `encuesta_participaciones`
  ADD CONSTRAINT `fk_participacion_encuesta` FOREIGN KEY (`encuesta_id`) REFERENCES `encuestas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_participacion_usuario` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `encuesta_questions`
--
ALTER TABLE `encuesta_questions`
  ADD CONSTRAINT `fk_question_encuesta` FOREIGN KEY (`encuesta_id`) REFERENCES `encuestas` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `encuesta_responses`
--
ALTER TABLE `encuesta_responses`
  ADD CONSTRAINT `fk_response_question` FOREIGN KEY (`question_id`) REFERENCES `encuesta_questions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_response_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `estrategia_optima`
--
ALTER TABLE `estrategia_optima`
  ADD CONSTRAINT `estrategia_optima_ibfk_1` FOREIGN KEY (`marca_id`) REFERENCES `marcas` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `horarios_disponibles`
--
ALTER TABLE `horarios_disponibles`
  ADD CONSTRAINT `horarios_disponibles_ibfk_1` FOREIGN KEY (`business_id`) REFERENCES `businesses` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `hoteles`
--
ALTER TABLE `hoteles`
  ADD CONSTRAINT `hoteles_ibfk_1` FOREIGN KEY (`business_id`) REFERENCES `businesses` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `industries`
--
ALTER TABLE `industries`
  ADD CONSTRAINT `fk_industries_brand` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_industries_business` FOREIGN KEY (`business_id`) REFERENCES `businesses` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Filtros para la tabla `industry_images`
--
ALTER TABLE `industry_images`
  ADD CONSTRAINT `fk_ind_images_industry` FOREIGN KEY (`industry_id`) REFERENCES `industries` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `inmobiliarias`
--
ALTER TABLE `inmobiliarias`
  ADD CONSTRAINT `inmobiliarias_ibfk_1` FOREIGN KEY (`business_id`) REFERENCES `businesses` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `inmuebles`
--
ALTER TABLE `inmuebles`
  ADD CONSTRAINT `fk_inm_business` FOREIGN KEY (`business_id`) REFERENCES `businesses` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `inmueble_adjuntos`
--
ALTER TABLE `inmueble_adjuntos`
  ADD CONSTRAINT `fk_ia_inmueble` FOREIGN KEY (`inmueble_id`) REFERENCES `inmuebles` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `job_applications`
--
ALTER TABLE `job_applications`
  ADD CONSTRAINT `fk_jobapp_business` FOREIGN KEY (`business_id`) REFERENCES `businesses` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `marcas`
--
ALTER TABLE `marcas`
  ADD CONSTRAINT `marcas_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `modelos_negocio`
--
ALTER TABLE `modelos_negocio`
  ADD CONSTRAINT `modelos_negocio_ibfk_1` FOREIGN KEY (`marca_id`) REFERENCES `marcas` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `monetizacion`
--
ALTER TABLE `monetizacion`
  ADD CONSTRAINT `monetizacion_ibfk_1` FOREIGN KEY (`marca_id`) REFERENCES `marcas` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `noticias`
--
ALTER TABLE `noticias`
  ADD CONSTRAINT `noticias_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `ownership_transfers`
--
ALTER TABLE `ownership_transfers`
  ADD CONSTRAINT `fk_ownership_transfers_from_user` FOREIGN KEY (`from_user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_ownership_transfers_to_user` FOREIGN KEY (`to_user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `paquetes_servicios`
--
ALTER TABLE `paquetes_servicios`
  ADD CONSTRAINT `paquetes_servicios_ibfk_1` FOREIGN KEY (`business_id`) REFERENCES `businesses` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `portfolio_trabajos`
--
ALTER TABLE `portfolio_trabajos`
  ADD CONSTRAINT `portfolio_trabajos_ibfk_1` FOREIGN KEY (`business_id`) REFERENCES `businesses` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`business_id`) REFERENCES `businesses` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `profesionales`
--
ALTER TABLE `profesionales`
  ADD CONSTRAINT `profesionales_ibfk_1` FOREIGN KEY (`business_id`) REFERENCES `businesses` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `promociones`
--
ALTER TABLE `promociones`
  ADD CONSTRAINT `promociones_ibfk_1` FOREIGN KEY (`business_id`) REFERENCES `businesses` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `radar_ports`
--
ALTER TABLE `radar_ports`
  ADD CONSTRAINT `fk_rp_mode` FOREIGN KEY (`transport_mode_id`) REFERENCES `radar_transport_modes` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `remates`
--
ALTER TABLE `remates`
  ADD CONSTRAINT `fk_remates_business` FOREIGN KEY (`business_id`) REFERENCES `businesses` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `reservas`
--
ALTER TABLE `reservas`
  ADD CONSTRAINT `reservas_ibfk_1` FOREIGN KEY (`business_id`) REFERENCES `businesses` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `respuestas_encuesta`
--
ALTER TABLE `respuestas_encuesta`
  ADD CONSTRAINT `fk_respuesta_usuario` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Filtros para la tabla `restaurantes`
--
ALTER TABLE `restaurantes`
  ADD CONSTRAINT `restaurantes_ibfk_1` FOREIGN KEY (`business_id`) REFERENCES `businesses` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `fk_review_business` FOREIGN KEY (`business_id`) REFERENCES `businesses` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_review_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `riesgo_legal`
--
ALTER TABLE `riesgo_legal`
  ADD CONSTRAINT `riesgo_legal_ibfk_1` FOREIGN KEY (`marca_id`) REFERENCES `marcas` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `servicios_profesionales`
--
ALTER TABLE `servicios_profesionales`
  ADD CONSTRAINT `servicios_profesionales_ibfk_1` FOREIGN KEY (`business_id`) REFERENCES `businesses` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `subcategories`
--
ALTER TABLE `subcategories`
  ADD CONSTRAINT `subcategories_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`);

--
-- Filtros para la tabla `transmisiones_vivo`
--
ALTER TABLE `transmisiones_vivo`
  ADD CONSTRAINT `transmisiones_vivo_ibfk_1` FOREIGN KEY (`organizador_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `transmision_participantes`
--
ALTER TABLE `transmision_participantes`
  ADD CONSTRAINT `transmision_participantes_ibfk_1` FOREIGN KEY (`transmision_id`) REFERENCES `transmisiones_vivo` (`id`),
  ADD CONSTRAINT `transmision_participantes_ibfk_2` FOREIGN KEY (`usuario_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `transporte`
--
ALTER TABLE `transporte`
  ADD CONSTRAINT `transporte_ibfk_1` FOREIGN KEY (`business_id`) REFERENCES `businesses` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `trivia_scores`
--
ALTER TABLE `trivia_scores`
  ADD CONSTRAINT `fk_score_trivia` FOREIGN KEY (`trivia_id`) REFERENCES `trivias` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_score_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `trivia_stats`
--
ALTER TABLE `trivia_stats`
  ADD CONSTRAINT `trivia_stats_ibfk_1` FOREIGN KEY (`game_id`) REFERENCES `trivia_games` (`game_id`);

--
-- Filtros para la tabla `turnos`
--
ALTER TABLE `turnos`
  ADD CONSTRAINT `turnos_ibfk_1` FOREIGN KEY (`business_id`) REFERENCES `businesses` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `turnos_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `valoraciones_servicios`
--
ALTER TABLE `valoraciones_servicios`
  ADD CONSTRAINT `valoraciones_servicios_ibfk_1` FOREIGN KEY (`business_id`) REFERENCES `businesses` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `valoraciones_servicios_ibfk_2` FOREIGN KEY (`reserva_id`) REFERENCES `reservas` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `vehiculos_venta`
--
ALTER TABLE `vehiculos_venta`
  ADD CONSTRAINT `fk_vehiculos_business` FOREIGN KEY (`business_id`) REFERENCES `businesses` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `wt_user_areas`
--
ALTER TABLE `wt_user_areas`
  ADD CONSTRAINT `fk_wt_user_areas_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `wt_user_blocks`
--
ALTER TABLE `wt_user_blocks`
  ADD CONSTRAINT `fk_wt_block_blocked` FOREIGN KEY (`blocked_user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_wt_block_blocker` FOREIGN KEY (`blocker_user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `wt_user_preferences`
--
ALTER TABLE `wt_user_preferences`
  ADD CONSTRAINT `fk_wt_prefs_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

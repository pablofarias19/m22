<?php
/**
 * API Encuestas v2 - OBSOLETO
 *
 * Este archivo usaba la columna `activa` que ya no existe en la tabla encuestas.
 * La columna correcta es `activo` (migración 037).
 * Todo el tráfico se redirige permanentemente a la API principal /api/encuestas.php.
 */
header('Location: /api/encuestas.php' . (isset($_SERVER['QUERY_STRING']) && $_SERVER['QUERY_STRING'] !== '' ? '?' . $_SERVER['QUERY_STRING'] : ''), true, 301);
exit;

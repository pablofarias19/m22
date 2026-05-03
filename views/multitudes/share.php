<?php
/**
 * Share / OG landing page — Multitud
 * URL interna: /?multitudes=N  (ruta al mapa con panel de Multitudes abierto)
 *
 * - Si el visitante es un bot (WhatsApp, Facebook, etc.): devuelve HTML con OG tags.
 * - Si es un humano: redirige inmediatamente al mapa (?multitudes=N) que abre el panel.
 */
ini_set('display_errors', 0);
error_reporting(0);

// ── Bot detection ─────────────────────────────────────────────────────────────
$userAgent = $_SERVER['HTTP_USER_AGENT'] ?? '';
$isBot = (bool)preg_match(
    '/facebookexternalhit|Facebot|WhatsApp|Twitterbot|LinkedInBot/i',
    $userAgent
);

// ── ID de la Multitud ─────────────────────────────────────────────────────────
// El parámetro llega como ?multitudes=N desde index.php
$id = (int)($_GET['multitudes'] ?? 0);
if ($id <= 0) {
    header('Location: /');
    exit;
}

// ── Humanos: redirect inmediato al mapa ───────────────────────────────────────
if (!$isBot) {
    header('Location: /?multitudes=' . $id);
    exit;
}

// ── Cargar datos de la Multitud desde BD ──────────────────────────────────────
$multitud = null;
$totalItems = 0;
try {
    require_once __DIR__ . '/../../includes/db_helper.php';
    $db   = getDbConnection();
    $stmt = $db->prepare("SELECT * FROM multitudes WHERE id = ? AND activo = 1 LIMIT 1");
    $stmt->execute([$id]);
    $multitud = $stmt->fetch(PDO::FETCH_ASSOC) ?: null;

    if ($multitud) {
        $stmtC = $db->prepare("SELECT COUNT(*) FROM multitud_items WHERE multitud_id = ? AND activo = 1");
        $stmtC->execute([$id]);
        $totalItems = (int)$stmtC->fetchColumn();
    }
} catch (Exception $e) {
    // Continuar con defaults
}

// ── OG variables ─────────────────────────────────────────────────────────────
$scheme = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off') ? 'https' : 'http';
$host   = $_SERVER['HTTP_HOST'] ?? 'mapita.com.ar';

// Título
$nombre     = $multitud['nombre']      ?? null;
$descripcion = $multitud['descripcion'] ?? null;

$og_title = $nombre
    ? '👥 MULTITUDES · ' . $nombre
    : 'Multitudes en Mapita';

// Descripción
$og_desc_parts = [];
if ($nombre) $og_desc_parts[] = $nombre;
if ($totalItems > 0) {
    $og_desc_parts[] = $totalItems . ($totalItems === 1 ? ' transmisión' : ' transmisiones');
}
$og_desc_body = $descripcion
    ? mb_substr(strip_tags($descripcion), 0, 130)
    : 'Explorá datos en tiempo real en Mapita';
$og_description = $og_desc_parts
    ? implode(' · ', $og_desc_parts) . ' — ' . $og_desc_body
    : $og_desc_body;

// URL canónica (la misma que se comparte)
$og_url  = $scheme . '://' . $host . '/?multitudes=' . $id;

// Imagen OG dinámica
$og_image = $scheme . '://' . $host . '/api/og_image.php?type=multitud&id=' . $id;

$og_type      = 'article';
$og_site_name = 'Mapita — Mapa de Marcas y Negocios';
$twitter_card = 'summary_large_image';

// URL del mapa que abre esta multitud (para el botón CTA)
$mapUrl = '/?multitudes=' . $id;
?>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title><?= htmlspecialchars($og_title) ?> · Mapita</title>
<?php include __DIR__ . '/../../includes/meta_og.php'; ?>
<style>
*,*::before,*::after{box-sizing:border-box;margin:0;padding:0}
html{scroll-behavior:smooth}
body{font-family:-apple-system,BlinkMacSystemFont,'Segoe UI',Roboto,sans-serif;
  background:#f0f2f5;color:#1a1a2e;min-height:100vh}
a{text-decoration:none;color:inherit}

.top-bar{
  position:fixed;top:0;left:0;right:0;z-index:100;
  height:50px;background:rgba(255,255,255,.95);
  backdrop-filter:blur(12px);-webkit-backdrop-filter:blur(12px);
  border-bottom:1px solid rgba(0,0,0,.07);
  display:flex;align-items:center;padding:0 18px;gap:12px;
}
.top-bar .logo{font-size:.85em;font-weight:900;color:#1B3B6F;letter-spacing:-.02em}
.top-bar .logo em{color:#4f46e5;font-style:normal}
.top-bar .back{
  margin-left:auto;display:flex;align-items:center;gap:5px;
  font-size:.78em;font-weight:700;color:#1B3B6F;
  padding:5px 12px;border-radius:20px;background:#eff6ff;border:1px solid #bfdbfe;
}

.hero{
  margin-top:50px;padding:40px 20px 32px;
  background:linear-gradient(135deg,#4f46e5 0%,#7c3aed 100%);
  color:#fff;text-align:center;
}
.hero .tipo{font-size:.75em;font-weight:800;letter-spacing:.12em;opacity:.85;margin-bottom:10px;}
.hero h1{font-size:clamp(1.4em,4vw,2.2em);font-weight:900;line-height:1.2;margin-bottom:12px;}
.hero .desc{font-size:.93em;opacity:.88;max-width:520px;margin:0 auto 18px;line-height:1.5;}
.hero .meta{font-size:.78em;opacity:.7;margin-bottom:24px;}

.cta-btn{
  display:inline-block;padding:13px 32px;
  background:#fff;color:#4f46e5;
  border-radius:28px;font-weight:800;font-size:1em;
  box-shadow:0 4px 18px rgba(0,0,0,.18);
  transition:transform .15s,box-shadow .15s;
}
.cta-btn:hover{transform:translateY(-2px);box-shadow:0 6px 24px rgba(0,0,0,.22);}

.og-img-wrap{
  max-width:600px;margin:24px auto 0;border-radius:12px;overflow:hidden;
  box-shadow:0 8px 32px rgba(0,0,0,.22);
}
.og-img-wrap img{width:100%;display:block;aspect-ratio:1200/630;object-fit:cover;}

.content{max-width:640px;margin:0 auto;padding:28px 20px 40px;}
.card{background:#fff;border-radius:14px;padding:22px;margin-bottom:18px;
  box-shadow:0 2px 10px rgba(0,0,0,.06);}
.card h2{font-size:1em;font-weight:800;color:#1a1a2e;margin-bottom:8px;}
.card p{font-size:.88em;color:#555;line-height:1.55;}
</style>
</head>
<body>

<!-- ── Top bar ─────────────────────────────────────────────────────────────── -->
<nav class="top-bar">
  <div class="logo">MAP<em>ITA</em></div>
  <a class="back" href="<?= htmlspecialchars($mapUrl) ?>">🗺️ Ver en el mapa →</a>
</nav>

<!-- ── Hero ───────────────────────────────────────────────────────────────── -->
<header class="hero">
  <div class="tipo">👥 MULTITUDES</div>
  <h1><?= htmlspecialchars($nombre ?? 'Multitudes en Mapita') ?></h1>
  <?php if ($descripcion): ?>
  <p class="desc"><?= htmlspecialchars(mb_substr(strip_tags($descripcion), 0, 180)) ?></p>
  <?php endif; ?>
  <?php if ($totalItems > 0): ?>
  <p class="meta"><?= $totalItems ?> <?= $totalItems === 1 ? 'transmisión' : 'transmisiones' ?></p>
  <?php endif; ?>
  <a class="cta-btn" href="<?= htmlspecialchars($mapUrl) ?>">Abrir en Mapita 🗺️</a>

  <div class="og-img-wrap">
    <img src="<?= htmlspecialchars($og_image) ?>"
         alt="<?= htmlspecialchars($og_title) ?>"
         loading="lazy">
  </div>
</header>

<!-- ── Contenido ──────────────────────────────────────────────────────────── -->
<main class="content">
  <div class="card">
    <h2>¿Qué son las Multitudes?</h2>
    <p>Las Multitudes agrupan transmisiones en vivo, links de YouTube y otros streams bajo un único ícono en el mapa. Al hacer clic se abre un panel con todos los enlaces disponibles.</p>
  </div>
  <div class="card">
    <h2>🗺️ Ver en Mapita</h2>
    <p>Abrí el mapa interactivo para explorar esta y otras Multitudes, negocios, eventos y noticias cerca tuyo.</p>
    <br>
    <a href="<?= htmlspecialchars($mapUrl) ?>" style="display:inline-block;padding:10px 24px;background:#4f46e5;color:#fff;border-radius:20px;font-weight:700;font-size:.9em;">
      Abrir Mapita →
    </a>
  </div>
</main>

</body>
</html>

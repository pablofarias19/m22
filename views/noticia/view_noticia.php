<?php
/**
 * Landing page pública — Noticia
 * URL: /noticia?id=X
 */
session_start();
ini_set('display_errors', 0);
error_reporting(0);

require_once __DIR__ . '/../../includes/db_helper.php';

$id = isset($_GET['id']) ? (int)$_GET['id'] : 0;
if ($id <= 0) { header("Location: /"); exit(); }

$db   = getDbConnection();
$stmt = $db->prepare("SELECT * FROM noticias WHERE id = ? AND activa = 1");
$stmt->execute([$id]);
$noticia = $stmt->fetch(PDO::FETCH_ASSOC);
if (!$noticia) { header("Location: /"); exit(); }

// Incrementar vistas
try { $db->prepare("UPDATE noticias SET vistas = COALESCE(vistas,0)+1 WHERE id=?")->execute([$id]); } catch(Exception $e){}

// ── Fecha ─────────────────────────────────────────────────────────────────────
$fechaFmt = '';
if (!empty($noticia['fecha_publicacion'])) {
    try {
        $dt = new DateTime($noticia['fecha_publicacion']);
        $meses = ['','Enero','Febrero','Marzo','Abril','Mayo','Junio',
                  'Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre'];
        $fechaFmt = $dt->format('j') . ' de ' . $meses[(int)$dt->format('n')] . ' de ' . $dt->format('Y');
    } catch(Exception $e){ $fechaFmt = $noticia['fecha_publicacion']; }
}

// ── Imagen ────────────────────────────────────────────────────────────────────
$imgUrl = null;
if (!empty($noticia['imagen'])) {
    $imgUrl = '/uploads/noticias/' . $noticia['imagen'];
}

// ── Color por categoría ───────────────────────────────────────────────────────
$catThemes = [
    'local'       => ['#e17055','#fd9a7a','📰'],
    'economia'    => ['#0984e3','#4a9ff5','💰'],
    'cultura'     => ['#6c5ce7','#a29bfe','🎭'],
    'deportes'    => ['#00b894','#00cec9','⚽'],
    'tecnologia'  => ['#2d3436','#636e72','💻'],
    'salud'       => ['#27ae60','#2ecc71','🏥'],
    'educacion'   => ['#f39c12','#f9ca24','📚'],
    'politica'    => ['#c0392b','#e74c3c','🏛️'],
    'turismo'     => ['#00b894','#55efc4','✈️'],
    'negocios'    => ['#1B3B6F','#2E5FA3','💼'],
];
$cat   = strtolower(trim($noticia['categoria'] ?? ''));
$theme = $catThemes[$cat] ?? ['#1B3B6F','#2E5FA3','📰'];
$color1 = $theme[0]; $color2 = $theme[1]; $catIcon = $theme[2];

// ── OG / Meta ─────────────────────────────────────────────────────────────────
$scheme   = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off') ? 'https' : 'http';
$host     = $_SERVER['HTTP_HOST'] ?? 'mapita.com.ar';

// Título enriquecido: etiqueta + título + fecha
$og_title_parts = ['📰 NOTICIA'];
$og_title_parts[] = $noticia['titulo'];
if (!empty($fechaFmt)) $og_title_parts[] = $fechaFmt;
$og_title = implode(' · ', $og_title_parts);

// Descripción estructurada
$og_desc_parts = [];
if (!empty($noticia['categoria'])) $og_desc_parts[] = '🏷️ ' . ucfirst($noticia['categoria']);
if (!empty($fechaFmt))             $og_desc_parts[] = '📅 ' . $fechaFmt;
if (!empty($noticia['fuente']))    $og_desc_parts[] = '🗞️ ' . $noticia['fuente'];
$og_desc_header = implode(' · ', $og_desc_parts);
$og_desc_body   = !empty($noticia['contenido'])
    ? mb_substr(strip_tags($noticia['contenido']), 0, 130)
    : 'Leé la nota completa en Mapita.';
$og_desc = $og_desc_header ? $og_desc_header . ' — ' . $og_desc_body : $og_desc_body;

// Imagen: preferir imagen real, sino og_image generado
$og_image = $imgUrl
    ? $scheme . '://' . $host . $imgUrl
    : $scheme . '://' . $host . '/api/og_image.php?type=noticia&id=' . $id;
$og_url   = $scheme . '://' . $host . '/noticia?id=' . $id;
$shareText = urlencode('📰 ' . $noticia['titulo'] . (!empty($fechaFmt) ? ' · ' . $fechaFmt : '') . ' · Mapita Noticias');
?>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title><?= htmlspecialchars($noticia['titulo']) ?><?= !empty($fechaFmt) ? ' · ' . htmlspecialchars($fechaFmt) : '' ?> · Mapita Noticias</title>
<meta name="description" content="<?= htmlspecialchars($og_desc) ?>">
<meta property="og:type"        content="article">
<meta property="og:site_name"   content="Mapita — Noticias">
<meta property="og:title"       content="<?= htmlspecialchars($og_title) ?>">
<meta property="og:description" content="<?= htmlspecialchars($og_desc) ?>">
<meta property="og:image"       content="<?= htmlspecialchars($og_image) ?>">
<meta property="og:image:width" content="1200">
<meta property="og:image:height"content="630">
<meta property="og:url"         content="<?= htmlspecialchars($og_url) ?>">
<meta name="twitter:card"        content="summary_large_image">
<meta name="twitter:title"       content="<?= htmlspecialchars($og_title) ?>">
<meta name="twitter:description" content="<?= htmlspecialchars($og_desc) ?>">
<meta name="twitter:image"       content="<?= htmlspecialchars($og_image) ?>">
<link rel="canonical" href="<?= htmlspecialchars($og_url) ?>">
<?php if (!empty($noticia['lat']) && !empty($noticia['lng'])): ?>
<link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css"/>
<script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
<?php endif; ?>
<style>
*,*::before,*::after{box-sizing:border-box;margin:0;padding:0}
html{scroll-behavior:smooth}
body{font-family:-apple-system,BlinkMacSystemFont,'Segoe UI',Roboto,sans-serif;
  background:#f0f2f5;color:#1a1a2e;min-height:100vh}
a{text-decoration:none;color:inherit}

/* ── TOP BAR ── */
.top-bar{
  position:fixed;top:0;left:0;right:0;z-index:100;height:50px;
  background:rgba(255,255,255,.95);backdrop-filter:blur(12px);-webkit-backdrop-filter:blur(12px);
  border-bottom:1px solid rgba(0,0,0,.07);
  display:flex;align-items:center;padding:0 18px;gap:12px;
}
.top-bar .logo{font-size:.85em;font-weight:900;color:#1B3B6F;letter-spacing:-.02em}
.top-bar .logo span{color:<?= $color1 ?>}
.top-bar .back{
  margin-left:auto;display:flex;align-items:center;gap:5px;
  font-size:.78em;font-weight:700;color:#1B3B6F;
  padding:5px 12px;border-radius:20px;background:#eff6ff;border:1px solid #bfdbfe;
}
.top-bar .back:hover{background:#dbeafe}

/* ── HERO ── */
.hero{
  margin-top:50px;position:relative;
  min-height:320px;overflow:hidden;
  background:linear-gradient(150deg,<?= $color1 ?> 0%,<?= $color2 ?> 100%);
  display:flex;flex-direction:column;justify-content:flex-end;
}
@media(min-width:600px){.hero{min-height:400px}}
.hero-img{position:absolute;inset:0;width:100%;height:100%;object-fit:cover}
.hero-overlay{
  position:absolute;inset:0;
  background:linear-gradient(to bottom,rgba(0,0,0,.08) 0%,rgba(0,0,0,.72) 100%);
}
.hero-inner{
  position:relative;z-index:1;
  max-width:700px;width:100%;margin:0 auto;
  padding:20px 20px 0;
}
.hero-cat-badge{
  display:inline-flex;align-items:center;gap:6px;
  background:<?= $color1 ?>;border:1px solid rgba(255,255,255,.25);
  color:#fff;padding:5px 14px;border-radius:20px;
  font-size:.72em;font-weight:700;letter-spacing:.06em;text-transform:uppercase;
  margin-bottom:14px;
}
.hero-title{
  font-size:clamp(1.5rem,4.5vw,2.4rem);font-weight:900;color:#fff;
  line-height:1.2;letter-spacing:-.02em;
  text-shadow:0 2px 16px rgba(0,0,0,.4);margin-bottom:14px;
}
.hero-meta{
  display:flex;align-items:center;gap:14px;
  font-size:.8em;color:rgba(255,255,255,.8);font-weight:600;
  margin-bottom:28px;flex-wrap:wrap;
}
.hero-meta span{display:flex;align-items:center;gap:4px}
.hero-card-bump{
  background:#fff;border-radius:20px 20px 0 0;
  padding:4px 0 0;margin:0 -20px;
  box-shadow:0 -8px 32px rgba(0,0,0,.12);
}
@media(min-width:700px){.hero-card-bump{margin:0;border-radius:20px 20px 0 0}}

/* ── CONTENT ── */
.content-wrap{max-width:700px;margin:0 auto;padding:0 20px 60px}
.card-main{
  background:#fff;border-radius:0 0 20px 20px;
  box-shadow:0 2px 16px rgba(0,0,0,.07);
  border:1px solid rgba(0,0,0,.04);border-top:none;
}
.section-card{
  background:#fff;border-radius:20px;
  box-shadow:0 2px 16px rgba(0,0,0,.07);
  border:1px solid rgba(0,0,0,.04);
  overflow:hidden;margin-top:16px;
}
.section-head{
  display:flex;align-items:center;gap:10px;
  padding:14px 20px 12px;border-bottom:1px solid #f3f4f6;
}
.section-icon{
  width:32px;height:32px;border-radius:10px;
  display:flex;align-items:center;justify-content:center;font-size:1rem;
}
.section-title{font-size:.82em;font-weight:800;color:#111;text-transform:uppercase;letter-spacing:.06em}

/* ── CONTENIDO NOTICIA ── */
.news-content{
  padding:22px 20px;
  color:#374151;font-size:.95em;line-height:1.85;
}
.news-content p{margin-bottom:1.1em}
.news-content h2,.news-content h3{
  font-weight:800;color:#1e293b;
  margin:1.4em 0 .6em;line-height:1.3;
}
.news-content h2{font-size:1.2em}
.news-content h3{font-size:1.05em}
.news-content a{color:<?= $color1 ?>;text-decoration:underline}
.news-content img{max-width:100%;border-radius:12px;margin:12px 0}
.news-content blockquote{
  border-left:3px solid <?= $color1 ?>;padding-left:16px;
  color:#64748b;font-style:italic;margin:16px 0;
}
.news-content ul,.news-content ol{padding-left:22px;margin-bottom:1em}
.news-content li{margin-bottom:.4em}

/* ── VIDEO ── */
.video-wrap{
  position:relative;width:100%;padding-top:56.25%;
  background:#000;overflow:hidden;
}
.video-wrap iframe{position:absolute;inset:0;width:100%;height:100%;border:none}

/* ── STATS ── */
.stats-row{
  display:flex;gap:16px;align-items:center;
  padding:14px 20px;border-top:1px solid #f3f4f6;
}
.stat-chip{
  display:inline-flex;align-items:center;gap:5px;
  font-size:.78em;color:#94a3b8;font-weight:600;
}

/* ── SHARE ── */
.share-block{padding:18px 20px}
.share-label{font-size:.72em;font-weight:800;color:#94a3b8;text-transform:uppercase;letter-spacing:.08em;margin-bottom:10px;display:block}
.share-row{display:flex;gap:8px;flex-wrap:wrap}
.share-btn{
  display:inline-flex;align-items:center;gap:7px;
  padding:9px 16px;border-radius:20px;font-size:.8em;font-weight:700;
  border:none;cursor:pointer;font-family:inherit;text-decoration:none;
  transition:opacity .15s,transform .15s;-webkit-tap-highlight-color:transparent;
}
.share-btn:hover{opacity:.88;transform:translateY(-1px)}
.share-btn:active{transform:scale(.96)}
.s-wa{background:#25D366;color:#fff}
.s-tg{background:#0088cc;color:#fff}
.s-tw{background:#1DA1F2;color:#fff}
.s-fb{background:#1877f2;color:#fff}
.s-cp{background:#f1f5f9;color:#475569;border:1px solid #e2e8f0}
.share-btn svg{width:15px;height:15px;fill:currentColor;flex-shrink:0}

/* ── CTA MAP ── */
.cta-map{
  display:flex;align-items:center;justify-content:space-between;gap:12px;
  padding:16px 20px;background:linear-gradient(135deg,#eff6ff,#f0fdf4);
  border-top:1px solid #e2e8f0;flex-wrap:wrap;
}
.cta-map-text{font-size:.84em;color:#475569;font-weight:600}
.cta-map-btn{
  display:inline-flex;align-items:center;gap:7px;
  padding:10px 18px;border-radius:14px;font-size:.82em;font-weight:800;
  background:#1B3B6F;color:#fff;text-decoration:none;
  box-shadow:0 3px 12px rgba(27,59,111,.25);transition:all .15s;white-space:nowrap;
}
.cta-map-btn:hover{background:#0f2444;transform:translateY(-1px)}

/* ── MAP ── */
#not-map{height:200px}

/* ── LINK EXTERNO ── */
.ext-link{
  display:flex;align-items:center;justify-content:center;gap:8px;
  padding:14px 20px;margin:0 20px 20px;border-radius:14px;
  background:#f8fafc;border:1.5px solid #e2e8f0;
  color:#1B3B6F;font-weight:700;font-size:.86em;
  text-decoration:none;transition:all .15s;
}
.ext-link:hover{background:#eff6ff;border-color:#bfdbfe;transform:translateY(-1px)}

/* ── FOOTER ── */
.page-footer{text-align:center;padding:24px 20px;font-size:.78em;color:#94a3b8}
.mapita-badge{
  display:inline-flex;align-items:center;gap:8px;
  background:#fff;border:1px solid #e2e8f0;border-radius:20px;
  padding:8px 18px;margin-bottom:10px;font-weight:700;color:#1B3B6F;
  box-shadow:0 2px 8px rgba(0,0,0,.06);
}
#copy-toast{
  position:fixed;bottom:24px;left:50%;transform:translateX(-50%) translateY(20px);
  background:#1e293b;color:#fff;padding:10px 22px;border-radius:24px;
  font-size:.84em;font-weight:700;pointer-events:none;
  opacity:0;transition:opacity .25s,transform .25s;z-index:200;
}
#copy-toast.show{opacity:1;transform:translateX(-50%) translateY(0)}

@media(max-width:480px){
  .hero-title{font-size:1.5rem}
  .cta-map{flex-direction:column;align-items:flex-start}
}
</style>
</head>
<body>

<!-- ── TOP BAR ── -->
<nav class="top-bar">
  <span class="logo">🗺 <span>Mapita</span> <span style="color:#94a3b8;font-weight:500">Noticias</span></span>
  <a href="/" class="back">← Ver mapa</a>
</nav>

<!-- ── HERO ── -->
<div class="hero">
  <?php if ($imgUrl): ?>
    <img class="hero-img" src="<?= htmlspecialchars($imgUrl) ?>" alt="<?= htmlspecialchars($noticia['titulo']) ?>">
  <?php endif; ?>
  <div class="hero-overlay"></div>
  <div class="hero-inner">
    <?php if (!empty($noticia['categoria'])): ?>
    <div class="hero-cat-badge"><?= $catIcon ?> <?= htmlspecialchars(ucfirst($noticia['categoria'])) ?></div>
    <?php endif; ?>
    <h1 class="hero-title"><?= htmlspecialchars($noticia['titulo']) ?></h1>
    <div class="hero-meta">
      <?php if ($fechaFmt): ?><span>📅 <?= htmlspecialchars($fechaFmt) ?></span><?php endif; ?>
      <?php if (!empty($noticia['vistas'])): ?><span>👁 <?= number_format((int)$noticia['vistas']) ?> vistas</span><?php endif; ?>
      <?php if (!empty($noticia['ubicacion'])): ?><span>📍 <?= htmlspecialchars($noticia['ubicacion']) ?></span><?php endif; ?>
    </div>
    <div class="hero-card-bump"></div>
  </div>
</div>

<!-- ── CONTENT ── -->
<div class="content-wrap">

  <div class="card-main">
    <!-- Video YouTube si existe -->
    <?php if (!empty($noticia['youtube_link'])):
      $ytId = '';
      if (preg_match('/(?:v=|youtu\.be\/)([a-zA-Z0-9_-]{11})/', $noticia['youtube_link'], $m)) $ytId = $m[1];
      if ($ytId): ?>
    <div class="video-wrap">
      <iframe src="https://www.youtube.com/embed/<?= htmlspecialchars($ytId) ?>" allowfullscreen loading="lazy"></iframe>
    </div>
    <?php endif; endif; ?>

    <!-- Contenido -->
    <?php if (!empty($noticia['contenido'])): ?>
    <div class="news-content">
      <?= $noticia['contenido'] /* contenido ya sanitizado en BD */ ?>
    </div>
    <?php endif; ?>

    <!-- Link externo -->
    <?php if (!empty($noticia['link'])): ?>
    <a href="<?= htmlspecialchars($noticia['link']) ?>" target="_blank" rel="noopener" class="ext-link">
      🔗 Leer nota completa en la fuente original ↗
    </a>
    <?php endif; ?>

    <!-- Stats + share -->
    <div class="stats-row">
      <?php if ($fechaFmt): ?><span class="stat-chip">📅 <?= htmlspecialchars($fechaFmt) ?></span><?php endif; ?>
      <?php if (!empty($noticia['vistas'])): ?><span class="stat-chip">👁 <?= number_format((int)$noticia['vistas']) ?> lecturas</span><?php endif; ?>
    </div>

    <div class="share-block">
      <span class="share-label">Compartir esta noticia</span>
      <div class="share-row">
        <a class="share-btn s-wa" href="https://api.whatsapp.com/send?text=<?= $shareText ?>%20<?= urlencode($og_url) ?>" target="_blank" rel="noopener">
          <svg viewBox="0 0 24 24"><path d="M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51-.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347m-5.421 7.403h-.004a9.87 9.87 0 01-5.031-1.378l-.361-.214-3.741.982.998-3.648-.235-.374a9.86 9.86 0 01-1.51-5.26c.001-5.45 4.436-9.884 9.888-9.884 2.64 0 5.122 1.03 6.988 2.898a9.825 9.825 0 012.893 6.994c-.003 5.45-4.437 9.884-9.885 9.884m8.413-18.297A11.815 11.815 0 0012.05 0C5.495 0 .16 5.335.157 11.892c0 2.096.547 4.142 1.588 5.945L.057 24l6.305-1.654a11.882 11.882 0 005.683 1.448h.005c6.554 0 11.89-5.335 11.893-11.893a11.821 11.821 0 00-3.48-8.413z"/></svg>
          WhatsApp
        </a>
        <a class="share-btn s-tg" href="https://t.me/share/url?url=<?= urlencode($og_url) ?>&text=<?= $shareText ?>" target="_blank" rel="noopener">
          <svg viewBox="0 0 24 24"><path d="M11.944 0A12 12 0 0 0 0 12a12 12 0 0 0 12 12 12 12 0 0 0 12-12A12 12 0 0 0 12 0a12 12 0 0 0-.056 0zm4.962 7.224c.1-.002.321.023.465.14a.506.506 0 0 1 .171.325c.016.093.036.306.02.472-.18 1.898-.962 6.502-1.36 8.627-.168.9-.499 1.201-.82 1.23-.696.065-1.225-.46-1.9-.902-1.056-.693-1.653-1.124-2.678-1.8-1.185-.78-.417-1.21.258-1.91.177-.184 3.247-2.977 3.307-3.23.007-.032.014-.15-.056-.212s-.174-.041-.249-.024c-.106.024-1.793 1.14-5.061 3.345-.48.33-.913.49-1.302.48-.428-.008-1.252-.241-1.865-.44-.752-.245-1.349-.374-1.297-.789.027-.216.325-.437.893-.663 3.498-1.524 5.83-2.529 6.998-3.014 3.332-1.386 4.025-1.627 4.476-1.635z"/></svg>
          Telegram
        </a>
        <a class="share-btn s-tw" href="https://twitter.com/intent/tweet?text=<?= $shareText ?>&url=<?= urlencode($og_url) ?>" target="_blank" rel="noopener">
          <svg viewBox="0 0 24 24"><path d="M18.244 2.25h3.308l-7.227 8.26 8.502 11.24H16.17l-4.714-6.231-5.401 6.231H2.744l7.73-8.835L1.254 2.25H8.08l4.253 5.622zm-1.161 17.52h1.833L7.084 4.126H5.117z"/></svg>
          Twitter / X
        </a>
        <a class="share-btn s-fb" href="https://www.facebook.com/sharer/sharer.php?u=<?= urlencode($og_url) ?>" target="_blank" rel="noopener">
          <svg viewBox="0 0 24 24"><path d="M24 12.073c0-6.627-5.373-12-12-12s-12 5.373-12 12c0 5.99 4.388 10.954 10.125 11.854v-8.385H7.078v-3.47h3.047V9.43c0-3.007 1.792-4.669 4.533-4.669 1.312 0 2.686.235 2.686.235v2.953H15.83c-1.491 0-1.956.925-1.956 1.874v2.25h3.328l-.532 3.47h-2.796v8.385C19.612 23.027 24 18.062 24 12.073z"/></svg>
          Facebook
        </a>
        <button class="share-btn s-cp" onclick="copyLink('<?= htmlspecialchars($og_url) ?>')">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="9" y="9" width="13" height="13" rx="2"/><path d="M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1"/></svg>
          Copiar enlace
        </button>
      </div>
    </div>

    <!-- CTA Mapa -->
    <div class="cta-map">
      <span class="cta-map-text">¿Querés ver más noticias y eventos cerca tuyo?</span>
      <a href="/" class="cta-map-btn">🗺️ Abrir Mapita</a>
    </div>
  </div>

  <!-- Mapa si tiene ubicación -->
  <?php if (!empty($noticia['lat']) && !empty($noticia['lng'])): ?>
  <div class="section-card">
    <div class="section-head">
      <div class="section-icon" style="background:#eff6ff">📍</div>
      <span class="section-title">Ubicación de la noticia</span>
    </div>
    <div id="not-map"></div>
    <div style="padding:10px 20px;font-size:.82em;color:#64748b;border-top:1px solid #f3f4f6;display:flex;justify-content:space-between">
      <span><?= htmlspecialchars($noticia['ubicacion'] ?? '') ?></span>
      <a href="https://www.google.com/maps/dir/?api=1&destination=<?= $noticia['lat'] ?>,<?= $noticia['lng'] ?>" target="_blank" rel="noopener" style="color:#1B3B6F;font-weight:800;margin-left:10px">Ver en Google Maps →</a>
    </div>
  </div>
  <?php endif; ?>

  <!-- Footer -->
  <div class="page-footer" style="margin-top:16px">
    <div><a href="/" class="mapita-badge">🗺️ Ver el mapa completo en Mapita</a></div>
    <p>© Mapita · Noticias y eventos de tu ciudad</p>
  </div>

</div><!-- /content-wrap -->

<div id="copy-toast">✓ Enlace copiado</div>

<?php if (!empty($noticia['lat']) && !empty($noticia['lng'])): ?>
<script>
(function(){
  var lat=<?= (float)$noticia['lat'] ?>,lng=<?= (float)$noticia['lng'] ?>;
  var map=L.map('not-map',{zoomControl:false,dragging:false,scrollWheelZoom:false,doubleClickZoom:false}).setView([lat,lng],14);
  L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png').addTo(map);
  var icon=L.divIcon({
    html:'<div style="background:<?= $color1 ?>;color:#fff;width:38px;height:38px;border-radius:50%;display:flex;align-items:center;justify-content:center;font-size:18px;box-shadow:0 3px 12px rgba(0,0,0,.3);border:3px solid #fff;"><?= $catIcon ?></div>',
    className:'',iconSize:[38,38],iconAnchor:[19,19]
  });
  L.marker([lat,lng],{icon}).addTo(map);
})();
</script>
<?php endif; ?>
<script>
function copyLink(url){
  navigator.clipboard?.writeText(url).then(function(){
    var t=document.getElementById('copy-toast');
    t.classList.add('show');
    setTimeout(function(){t.classList.remove('show')},2000);
  });
}
</script>
</body>
</html>

<?php
/**
 * Landing page pública — Evento
 * URL: /evento?id=X
 */
session_start();
ini_set('display_errors', 0);
error_reporting(0);

require_once __DIR__ . '/../../includes/db_helper.php';

$id = isset($_GET['id']) ? (int)$_GET['id'] : 0;
if ($id <= 0) { header("Location: /"); exit(); }

$db   = getDbConnection();
$stmt = $db->prepare("SELECT * FROM eventos WHERE id = ? AND activo = 1");
$stmt->execute([$id]);
$evento = $stmt->fetch(PDO::FETCH_ASSOC);
if (!$evento) { header("Location: /"); exit(); }

// ── Fecha formateada ──────────────────────────────────────────────────────────
$fechaFmt   = '';
$fechaShort = '';
$diaSemana  = '';
if (!empty($evento['fecha'])) {
    try {
        $dt = new DateTime($evento['fecha']);
        $meses = ['','Enero','Febrero','Marzo','Abril','Mayo','Junio',
                  'Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre'];
        $dias  = ['Domingo','Lunes','Martes','Miércoles','Jueves','Viernes','Sábado'];
        $diaSemana  = $dias[(int)$dt->format('w')];
        $fechaFmt   = $diaSemana . ', ' . $dt->format('j') . ' de ' . $meses[(int)$dt->format('n')] . ' de ' . $dt->format('Y');
        $fechaShort = $dt->format('d') . '/' . $dt->format('m');
    } catch(Exception $e) { $fechaFmt = $evento['fecha']; }
}

// ── Color por categoría ───────────────────────────────────────────────────────
$catColors = [
    'musica'      => ['#6c5ce7','#a29bfe','🎵'],
    'teatro'      => ['#e17055','#fd9a7a','🎭'],
    'arte'        => ['#00b894','#00cec9','🎨'],
    'deporte'     => ['#0984e3','#4a9ff5','⚽'],
    'gastronomia' => ['#e84393','#fd79a8','🍽️'],
    'educacion'   => ['#f39c12','#f9ca24','📚'],
    'tecnologia'  => ['#2d3436','#636e72','💻'],
    'salud'       => ['#00b894','#55efc4','🏥'],
    'negocios'    => ['#1B3B6F','#2E5FA3','💼'],
    'cultura'     => ['#6c5ce7','#a29bfe','🏛️'],
];
$cat    = strtolower(trim($evento['categoria'] ?? ''));
$theme  = $catColors[$cat] ?? ['#1B3B6F','#2E5FA3','📅'];
$color1 = $theme[0];
$color2 = $theme[1];
$emoji  = $evento['icono'] ?? $theme[2];

// ── OG / Meta ─────────────────────────────────────────────────────────────────
$scheme    = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off') ? 'https' : 'http';
$host      = $_SERVER['HTTP_HOST'] ?? 'mapita.com.ar';

// Título enriquecido: etiqueta + título + ubicación
$og_title_parts = ['📅 EVENTO'];
$og_title_parts[] = $evento['titulo'];
if (!empty($evento['ubicacion'])) $og_title_parts[] = '📍 ' . $evento['ubicacion'];
$og_title = implode(' · ', $og_title_parts);

// Descripción estructurada
$og_desc_parts = [];
if (!empty($evento['categoria'])) $og_desc_parts[] = '🏷️ ' . ucfirst($evento['categoria']);
if (!empty($fechaFmt))            $og_desc_parts[] = '📅 ' . $fechaFmt;
if (!empty($evento['hora']))      $og_desc_parts[] = '🕐 ' . $evento['hora'];
if (!empty($evento['ubicacion'])) $og_desc_parts[] = '📍 ' . $evento['ubicacion'];
if (!empty($evento['organizador'])) $og_desc_parts[] = '👤 ' . $evento['organizador'];
$og_desc_header = implode(' · ', $og_desc_parts);
$og_desc_body   = !empty($evento['descripcion'])
    ? mb_substr(strip_tags($evento['descripcion']), 0, 120)
    : '¡No te lo pierdas! Consultá todos los detalles en Mapita.';
$og_desc = $og_desc_header ? $og_desc_header . ' — ' . $og_desc_body : $og_desc_body;

$og_image  = $scheme . '://' . $host . '/api/og_image.php?type=evento&id=' . $id;
$og_url    = $scheme . '://' . $host . '/evento?id=' . $id;
$shareText = urlencode('📅 ' . $evento['titulo'] . ($fechaFmt ? ' — ' . $fechaFmt : '') . (!empty($evento['ubicacion']) ? ' · ' . $evento['ubicacion'] : '') . ' · Mapita');
?>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title><?= htmlspecialchars($evento['titulo']) ?><?= !empty($evento['ubicacion']) ? ' · ' . htmlspecialchars($evento['ubicacion']) : '' ?> · Mapita Eventos</title>
<meta name="description" content="<?= htmlspecialchars($og_desc) ?>">
<!-- Open Graph -->
<meta property="og:type"        content="article">
<meta property="og:site_name"   content="Mapita — Eventos">
<meta property="og:title"       content="<?= htmlspecialchars($og_title) ?>">
<meta property="og:description" content="<?= htmlspecialchars($og_desc) ?>">
<meta property="og:image"       content="<?= htmlspecialchars($og_image) ?>">
<meta property="og:image:width" content="1200">
<meta property="og:image:height"content="630">
<meta property="og:url"         content="<?= htmlspecialchars($og_url) ?>">
<!-- Twitter Card -->
<meta name="twitter:card"        content="summary_large_image">
<meta name="twitter:title"       content="<?= htmlspecialchars($og_title) ?>">
<meta name="twitter:description" content="<?= htmlspecialchars($og_desc) ?>">
<meta name="twitter:image"       content="<?= htmlspecialchars($og_image) ?>">
<link rel="canonical" href="<?= htmlspecialchars($og_url) ?>">
<?php if ($evento['lat'] && $evento['lng']): ?>
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
  position:fixed;top:0;left:0;right:0;z-index:100;
  height:50px;background:rgba(255,255,255,.95);
  backdrop-filter:blur(12px);-webkit-backdrop-filter:blur(12px);
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
  margin-top:50px;
  background:linear-gradient(150deg,<?= $color1 ?> 0%,<?= $color2 ?> 100%);
  padding:54px 20px 0;
  position:relative;overflow:hidden;
}
.hero::before{
  content:'';position:absolute;inset:0;
  background:url("data:image/svg+xml,%3Csvg width='60' height='60' viewBox='0 0 60 60' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='none' fill-rule='evenodd'%3E%3Cg fill='%23ffffff' fill-opacity='0.04'%3E%3Cpath d='M36 34v-4h-2v4h-4v2h4v4h2v-4h4v-2h-4zm0-30V0h-2v4h-4v2h4v4h2V6h4V4h-4zM6 34v-4H4v4H0v2h4v4h2v-4h4v-2H6zM6 4V0H4v4H0v2h4v4h2V6h4V4H6z'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E");
}
.hero-inner{
  max-width:700px;margin:0 auto;
  position:relative;z-index:1;
}
.hero-cat-badge{
  display:inline-flex;align-items:center;gap:6px;
  background:rgba(255,255,255,.18);border:1px solid rgba(255,255,255,.3);
  color:#fff;padding:5px 14px;border-radius:20px;
  font-size:.75em;font-weight:700;letter-spacing:.06em;text-transform:uppercase;
  margin-bottom:18px;backdrop-filter:blur(4px);
}
.hero-emoji{
  font-size:4rem;line-height:1;margin-bottom:14px;
  filter:drop-shadow(0 4px 12px rgba(0,0,0,.3));
}
.hero-title{
  font-size:clamp(1.7rem,5vw,2.8rem);font-weight:900;color:#fff;
  line-height:1.15;letter-spacing:-.02em;
  text-shadow:0 2px 16px rgba(0,0,0,.3);margin-bottom:12px;
}
.hero-meta{
  display:flex;flex-wrap:wrap;gap:10px;margin-bottom:28px;
}
.hero-meta-pill{
  display:inline-flex;align-items:center;gap:6px;
  background:rgba(255,255,255,.15);border:1px solid rgba(255,255,255,.25);
  color:#fff;padding:6px 14px;border-radius:20px;font-size:.83em;font-weight:600;
  backdrop-filter:blur(4px);
}
.hero-card-bump{
  background:#fff;border-radius:20px 20px 0 0;
  padding:22px 24px 0;margin:0 -20px;margin-top:28px;
  box-shadow:0 -8px 32px rgba(0,0,0,.12);
}
@media(min-width:600px){.hero-card-bump{margin:28px 0 0;border-radius:20px 20px 0 0}}

/* ── CONTENT ── */
.content-wrap{max-width:700px;margin:0 auto;padding:0 20px 60px}
.card{
  background:#fff;border-radius:0 0 20px 20px;
  box-shadow:0 2px 16px rgba(0,0,0,.07);
  padding:0 24px 24px;margin-bottom:16px;
  border:1px solid rgba(0,0,0,.04);border-top:none;
}
.section-card{
  background:#fff;border-radius:20px;
  box-shadow:0 2px 16px rgba(0,0,0,.07);
  border:1px solid rgba(0,0,0,.04);
  overflow:hidden;margin-bottom:16px;
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
.section-body{padding:16px 20px}

/* ── INFO ROWS ── */
.irow{display:flex;align-items:flex-start;gap:14px;padding:11px 0;border-bottom:1px solid #f3f4f6}
.irow:last-child{border-bottom:none}
.iico{
  width:34px;height:34px;border-radius:10px;
  background:#f8fafc;border:1px solid #e2e8f0;
  display:flex;align-items:center;justify-content:center;font-size:1rem;flex-shrink:0;
}
.ilabel{font-size:.66em;color:#94a3b8;font-weight:800;text-transform:uppercase;letter-spacing:.08em;margin-bottom:2px}
.ival{font-size:.88em;color:#1e293b;font-weight:500;line-height:1.5}

/* ── DESCRIPCIÓN ── */
.desc-text{
  color:#475569;line-height:1.8;font-size:.93em;
  font-style:italic;padding-left:14px;
  border-left:3px solid <?= $color1 ?>;
}

/* ── MAP ── */
#evt-map{height:200px}
@media(min-width:600px){#evt-map{height:240px}}

/* ── DATE WIDGET ── */
.date-widget{
  display:flex;align-items:center;gap:16px;
  padding:18px 20px;
}
.date-box{
  width:64px;height:64px;border-radius:16px;
  background:linear-gradient(145deg,<?= $color1 ?>,<?= $color2 ?>);
  display:flex;flex-direction:column;align-items:center;justify-content:center;
  color:#fff;flex-shrink:0;box-shadow:0 4px 14px rgba(0,0,0,.2);
}
.date-box-day{font-size:1.6em;font-weight:900;line-height:1}
.date-box-mon{font-size:.62em;font-weight:700;text-transform:uppercase;letter-spacing:.06em;opacity:.85}
.date-info{flex:1}
.date-full{font-size:.92em;font-weight:700;color:#1e293b}
.date-hora{font-size:.82em;color:#64748b;margin-top:3px}

/* ── CTAs ── */
.cta-block{padding:20px;display:flex;flex-direction:column;gap:10px}
.btn-primary{
  display:flex;align-items:center;justify-content:center;gap:10px;
  padding:16px 24px;border-radius:16px;font-size:.92em;font-weight:800;
  text-decoration:none;border:none;cursor:pointer;font-family:inherit;
  background:linear-gradient(145deg,<?= $color1 ?>,<?= $color2 ?>);
  color:#fff;box-shadow:0 4px 18px rgba(0,0,0,.2);
  transition:transform .15s,box-shadow .15s;
}
.btn-primary:hover{transform:translateY(-1px);box-shadow:0 6px 24px rgba(0,0,0,.28)}
.btn-secondary{
  display:flex;align-items:center;justify-content:center;gap:8px;
  padding:13px 20px;border-radius:14px;font-size:.85em;font-weight:700;
  border:1.5px solid #e2e8f0;background:#f8fafc;color:#475569;
  text-decoration:none;transition:all .15s;
}
.btn-secondary:hover{background:#eff6ff;border-color:#bfdbfe;color:#1B3B6F}

/* ── SHARE ── */
.share-row{
  display:flex;gap:10px;align-items:center;
  padding:16px 20px;border-top:1px solid #f3f4f6;flex-wrap:wrap;
}
.share-label{font-size:.72em;font-weight:800;color:#94a3b8;text-transform:uppercase;letter-spacing:.08em;flex-basis:100%}
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

/* ── FOOTER ── */
.page-footer{
  text-align:center;padding:24px 20px;font-size:.78em;color:#94a3b8;
}
.page-footer a{color:#1B3B6F;font-weight:700}
.page-footer .mapita-badge{
  display:inline-flex;align-items:center;gap:8px;
  background:#fff;border:1px solid #e2e8f0;border-radius:20px;
  padding:8px 18px;margin-bottom:10px;font-weight:700;color:#1B3B6F;font-size:.95em;
  box-shadow:0 2px 8px rgba(0,0,0,.06);
}

/* ── MOBILE ── */
@media(max-width:480px){
  .hero{padding-top:42px}
  .hero-title{font-size:1.7rem}
  .card,.section-card{border-radius:16px}
}

/* ── COPY TOAST ── */
#copy-toast{
  position:fixed;bottom:24px;left:50%;transform:translateX(-50%) translateY(20px);
  background:#1e293b;color:#fff;padding:10px 22px;border-radius:24px;
  font-size:.84em;font-weight:700;pointer-events:none;
  opacity:0;transition:opacity .25s,transform .25s;z-index:200;
}
#copy-toast.show{opacity:1;transform:translateX(-50%) translateY(0)}
</style>
</head>
<body>

<!-- ── TOP BAR ── -->
<nav class="top-bar">
  <span class="logo">🗺 <span>Mapita</span></span>
  <a href="/" class="back">← Ver en el mapa</a>
</nav>

<!-- ── HERO ── -->
<div class="hero">
  <div class="hero-inner">
    <?php if (!empty($evento['categoria'])): ?>
    <div class="hero-cat-badge"><?= $emoji ?> <?= htmlspecialchars(ucfirst($evento['categoria'])) ?></div>
    <?php endif; ?>
    <div class="hero-emoji"><?= $emoji ?></div>
    <h1 class="hero-title"><?= htmlspecialchars($evento['titulo']) ?></h1>
    <div class="hero-meta">
      <?php if ($fechaFmt): ?>
        <span class="hero-meta-pill">📅 <?= htmlspecialchars($fechaFmt) ?></span>
      <?php endif; ?>
      <?php if (!empty($evento['hora'])): ?>
        <span class="hero-meta-pill">🕐 <?= htmlspecialchars($evento['hora']) ?> hs</span>
      <?php endif; ?>
      <?php if (!empty($evento['ubicacion'])): ?>
        <span class="hero-meta-pill">📍 <?= htmlspecialchars($evento['ubicacion']) ?></span>
      <?php endif; ?>
    </div>
    <div class="hero-card-bump"></div>
  </div>
</div>

<!-- ── CONTENT ── -->
<div class="content-wrap">

  <!-- Fecha destacada + CTA principal -->
  <div class="card">
    <div class="date-widget">
      <?php if (!empty($evento['fecha'])): ?>
        <?php $dtBox = new DateTime($evento['fecha']); ?>
        <div class="date-box">
          <div class="date-box-day"><?= $dtBox->format('d') ?></div>
          <div class="date-box-mon"><?= ['Ene','Feb','Mar','Abr','May','Jun','Jul','Ago','Sep','Oct','Nov','Dic'][(int)$dtBox->format('m')-1] ?></div>
        </div>
        <div class="date-info">
          <div class="date-full"><?= htmlspecialchars($diaSemana . ', ' . $dtBox->format('j')) . ' de ' . ['','Enero','Febrero','Marzo','Abril','Mayo','Junio','Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre'][(int)$dtBox->format('m')] ?></div>
          <?php if (!empty($evento['hora'])): ?>
            <div class="date-hora">🕐 <?= htmlspecialchars($evento['hora']) ?> hs</div>
          <?php endif; ?>
        </div>
      <?php endif; ?>
    </div>

    <div class="cta-block">
      <a href="/?ver=evento&id=<?= $id ?>" class="btn-primary">
        🗺️ Ver este evento en el mapa
      </a>
      <?php if (!empty($evento['youtube_link'])): ?>
        <a href="<?= htmlspecialchars($evento['youtube_link']) ?>" target="_blank" rel="noopener" class="btn-secondary">
          ▶️ Ver video del evento
        </a>
      <?php endif; ?>
    </div>

    <!-- Share -->
    <div class="share-row">
      <span class="share-label">Compartir este evento</span>
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
        Twitter
      </a>
      <button class="share-btn s-cp" onclick="copyLink('<?= htmlspecialchars($og_url) ?>')">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="9" y="9" width="13" height="13" rx="2"/><path d="M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1"/></svg>
        Copiar enlace
      </button>
    </div>
  </div>

  <!-- Descripción -->
  <?php if (!empty($evento['descripcion'])): ?>
  <div class="section-card">
    <div class="section-head">
      <div class="section-icon" style="background:#f0fdf4">📝</div>
      <span class="section-title">Sobre el evento</span>
    </div>
    <div class="section-body">
      <p class="desc-text"><?= nl2br(htmlspecialchars($evento['descripcion'])) ?></p>
    </div>
  </div>
  <?php endif; ?>

  <!-- Info del evento -->
  <div class="section-card">
    <div class="section-head">
      <div class="section-icon" style="background:#eff6ff">📋</div>
      <span class="section-title">Detalles</span>
    </div>
    <div class="section-body">
      <?php if (!empty($evento['organizador'])): ?>
      <div class="irow">
        <div class="iico">👤</div>
        <div>
          <div class="ilabel">Organizador</div>
          <div class="ival"><?= htmlspecialchars($evento['organizador']) ?></div>
        </div>
      </div>
      <?php endif; ?>
      <?php if (!empty($evento['ubicacion'])): ?>
      <div class="irow">
        <div class="iico">📍</div>
        <div>
          <div class="ilabel">Lugar</div>
          <div class="ival"><?= htmlspecialchars($evento['ubicacion']) ?></div>
        </div>
      </div>
      <?php endif; ?>
      <?php if ($fechaFmt): ?>
      <div class="irow">
        <div class="iico">📅</div>
        <div>
          <div class="ilabel">Fecha y hora</div>
          <div class="ival"><?= htmlspecialchars($fechaFmt) ?><?= !empty($evento['hora']) ? ' · ' . htmlspecialchars($evento['hora']) . ' hs' : '' ?></div>
        </div>
      </div>
      <?php endif; ?>
      <?php if (!empty($evento['categoria'])): ?>
      <div class="irow">
        <div class="iico">🏷️</div>
        <div>
          <div class="ilabel">Categoría</div>
          <div class="ival"><?= htmlspecialchars(ucfirst($evento['categoria'])) ?></div>
        </div>
      </div>
      <?php endif; ?>
    </div>
  </div>

  <!-- Mapa -->
  <?php if (!empty($evento['lat']) && !empty($evento['lng'])): ?>
  <div class="section-card">
    <div class="section-head">
      <div class="section-icon" style="background:#eff6ff">📍</div>
      <span class="section-title">Ubicación</span>
    </div>
    <div id="evt-map"></div>
    <div style="padding:10px 20px;display:flex;align-items:center;justify-content:space-between;font-size:.82em;color:#64748b;border-top:1px solid #f3f4f6">
      <span><?= htmlspecialchars($evento['ubicacion'] ?? '') ?></span>
      <a href="https://www.google.com/maps/dir/?api=1&destination=<?= $evento['lat'] ?>,<?= $evento['lng'] ?>" target="_blank" rel="noopener" style="color:#1B3B6F;font-weight:800;white-space:nowrap;margin-left:10px">Cómo llegar →</a>
    </div>
  </div>
  <?php endif; ?>

  <!-- Footer badge -->
  <div class="page-footer">
    <div>
      <a href="/" class="mapita-badge">🗺️ Abrí el mapa completo en Mapita</a>
    </div>
    <p>© Mapita · Tu mapa de negocios y eventos locales</p>
  </div>

</div><!-- /content-wrap -->

<div id="copy-toast">✓ Enlace copiado</div>

<?php if (!empty($evento['lat']) && !empty($evento['lng'])): ?>
<script>
(function(){
  var lat=<?= (float)$evento['lat'] ?>,lng=<?= (float)$evento['lng'] ?>;
  var map=L.map('evt-map',{zoomControl:false,dragging:false,scrollWheelZoom:false,doubleClickZoom:false}).setView([lat,lng],15);
  L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png').addTo(map);
  var icon=L.divIcon({
    html:'<div style="background:<?= $color1 ?>;color:#fff;width:40px;height:40px;border-radius:50%;display:flex;align-items:center;justify-content:center;font-size:20px;box-shadow:0 3px 12px rgba(0,0,0,.35);border:3px solid #fff;"><?= $emoji ?></div>',
    className:'',iconSize:[40,40],iconAnchor:[20,20]
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

<?php
/**
 * Landing page pública — Encuesta
 * URL: /encuesta?id=X
 */
session_start();
ini_set('display_errors', 0);
error_reporting(0);

require_once __DIR__ . '/../../includes/db_helper.php';

$id = isset($_GET['id']) ? (int)$_GET['id'] : 0;
if ($id <= 0) { header("Location: /"); exit(); }

$db   = getDbConnection();
$stmt = $db->prepare("SELECT * FROM encuestas WHERE id = ? AND activo = 1");
$stmt->execute([$id]);
$encuesta = $stmt->fetch(PDO::FETCH_ASSOC);
if (!$encuesta) { header("Location: /"); exit(); }

// ── Preguntas (todas, sin LIMIT) ──────────────────────────────────────────────
$stmtP = $db->prepare("SELECT * FROM preguntas_encuesta WHERE encuesta_id = ? ORDER BY orden ASC, id ASC");
$stmtP->execute([$id]);
$preguntas = $stmtP->fetchAll(PDO::FETCH_ASSOC);

// ── Total participantes ───────────────────────────────────────────────────────
$totalPart = 0;
try {
    $stmtT = $db->prepare("SELECT COUNT(DISTINCT user_id) as total FROM encuesta_participaciones WHERE encuesta_id = ?");
    $stmtT->execute([$id]);
    $totalPart = (int)($stmtT->fetchColumn() ?: 0);
} catch(Exception $e){}

// ── Sesión y ya respondió ─────────────────────────────────────────────────────
$userId     = isset($_SESSION['user_id']) ? (int)$_SESSION['user_id'] : null;
$yaRespondio = false;
if ($userId) {
    try {
        $stmtR = $db->prepare("SELECT 1 FROM encuesta_participaciones WHERE encuesta_id = ? AND user_id = ? LIMIT 1");
        $stmtR->execute([$id, $userId]);
        $yaRespondio = (bool)$stmtR->fetch();
    } catch(Exception $e){}
}

// ── Expiración ────────────────────────────────────────────────────────────────
$expirada = false;
$diasRestantes = null;
if (!empty($encuesta['fecha_expiracion'])) {
    try {
        $exp = new DateTime($encuesta['fecha_expiracion']);
        $now = new DateTime();
        $diff = $now->diff($exp);
        if ($now > $exp) {
            $expirada = true;
        } else {
            $diasRestantes = (int)$diff->days;
        }
    } catch(Exception $e){}
}

// ── Localidad via campo DB o reverse geocoding (usa lat/lng de la encuesta) ────
$localidad = $encuesta['localidad'] ?? '';
if (empty($localidad) && !empty($encuesta['lat']) && !empty($encuesta['lng'])
    && $encuesta['lat'] != 0 && $encuesta['lng'] != 0) {
    try {
        $geoUrl = 'https://nominatim.openstreetmap.org/reverse?format=json'
                . '&lat=' . urlencode($encuesta['lat'])
                . '&lon=' . urlencode($encuesta['lng'])
                . '&zoom=10&addressdetails=1&accept-language=es';
        $ctx = stream_context_create(['http' => [
            'timeout' => 3,
            'header'  => "User-Agent: Mapita/1.0\r\n"
        ]]);
        $geoJson = @file_get_contents($geoUrl, false, $ctx);
        if ($geoJson) {
            $geo  = json_decode($geoJson, true);
            $addr = $geo['address'] ?? [];
            $localidad = $addr['city'] ?? $addr['town'] ?? $addr['village']
                      ?? $addr['municipality'] ?? $addr['county'] ?? '';
            // Guardar localidad en DB para no repetir geocoding en futuros accesos
            if ($localidad) {
                try {
                    $stmtLoc = $db->prepare("UPDATE encuestas SET localidad = ? WHERE id = ? AND (localidad IS NULL OR localidad = '')");
                    $stmtLoc->execute([$localidad, $id]);
                } catch(Exception $eDb){}
            }
        }
    } catch(Exception $e){}
}

// ── OG / Meta ─────────────────────────────────────────────────────────────────
$scheme   = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off') ? 'https' : 'http';
$host     = $_SERVER['HTTP_HOST'] ?? 'mapita.com.ar';
$nPreg    = count($preguntas);

// Título enriquecido
$og_title_parts = ['📊 ENCUESTA'];
$og_title_parts[] = $encuesta['titulo'];
if ($localidad)   $og_title_parts[] = 'en ' . $localidad;
if ($totalPart > 0) $og_title_parts[] = $totalPart . ' ' . ($totalPart == 1 ? 'participante' : 'participantes');
$og_title = implode(' · ', $og_title_parts);

// Descripción estructurada
$og_desc_parts = [];
$og_desc_parts[] = $nPreg . ' ' . ($nPreg == 1 ? 'pregunta' : 'preguntas');
if ($totalPart > 0) $og_desc_parts[] = $totalPart . ' ' . ($totalPart == 1 ? 'persona respondió' : 'personas respondieron');
if ($localidad)     $og_desc_parts[] = '📍 ' . $localidad;
if (!$expirada && $diasRestantes !== null) {
    $og_desc_parts[] = $diasRestantes == 0 ? 'cierra hoy' : 'cierra en ' . $diasRestantes . ' ' . ($diasRestantes == 1 ? 'día' : 'días');
} elseif ($expirada) {
    $og_desc_parts[] = 'encuesta cerrada';
}
$og_desc_header = '📊 ' . implode(' · ', $og_desc_parts);
$og_desc_body   = !empty($encuesta['descripcion'])
    ? mb_substr(strip_tags($encuesta['descripcion']), 0, 120)
    : '¡Tu opinión importa! Participá ahora en Mapita.';
$og_desc = $og_desc_header . ' — ' . $og_desc_body;

$og_image = !empty($encuesta['imagen']) && preg_match('/^[\w\-]+\.(jpg|jpeg|png|gif|webp)$/i', $encuesta['imagen'])
    ? $scheme . '://' . $host . '/uploads/encuestas/' . rawurlencode($encuesta['imagen'])
    : $scheme . '://' . $host . '/api/og_image.php?type=encuesta&id=' . $id;
$og_url         = $scheme . '://' . $host . '/encuesta?id=' . $id;
$og_description = $og_desc;
$og_site_name   = 'Mapita — Encuestas';
$og_type        = 'website';
$twitter_card   = 'summary_large_image';
$mapUrl    = '/?ver=encuesta&id=' . $id;
$shareText = urlencode('📊 ' . $encuesta['titulo']
    . ($localidad ? ' — ' . $localidad : '')
    . ' · ' . $nPreg . ' preguntas'
    . ($totalPart > 0 ? ' · ' . $totalPart . ' participantes' : '')
    . ' — Mapita');
?>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title><?= htmlspecialchars($encuesta['titulo']) ?><?= $localidad ? ' en ' . htmlspecialchars($localidad) : '' ?> · Mapita Encuestas</title>
<?php include __DIR__ . '/../../includes/meta_og.php'; ?>
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
.top-bar .logo em{color:#6c5ce7;font-style:normal}
.top-bar .back{
  margin-left:auto;display:flex;align-items:center;gap:5px;
  font-size:.78em;font-weight:700;color:#1B3B6F;
  padding:5px 12px;border-radius:20px;background:#eff6ff;border:1px solid #bfdbfe;
}
.top-bar .back:hover{background:#dbeafe}

/* ── HERO ── */
.hero{
  margin-top:50px;
  background:linear-gradient(150deg,#5f27cd 0%,#6c5ce7 50%,#a29bfe 100%);
  padding:50px 20px 0;position:relative;overflow:hidden;
}
.hero::before{
  content:'';position:absolute;inset:0;
  background:radial-gradient(circle at 70% 30%,rgba(255,255,255,.08) 0%,transparent 60%);
}
.hero-inner{max-width:680px;margin:0 auto;position:relative;z-index:1}
.hero-badge{
  display:inline-flex;align-items:center;gap:6px;
  background:rgba(255,255,255,.18);border:1px solid rgba(255,255,255,.3);
  color:#fff;padding:5px 14px;border-radius:20px;
  font-size:.72em;font-weight:700;letter-spacing:.06em;text-transform:uppercase;
  margin-bottom:16px;
}
.hero-icon{font-size:3.5rem;line-height:1;margin-bottom:14px}
.hero-title{
  font-size:clamp(1.6rem,4.5vw,2.5rem);font-weight:900;color:#fff;
  line-height:1.2;letter-spacing:-.02em;
  text-shadow:0 2px 16px rgba(0,0,0,.25);margin-bottom:12px;
}
.hero-localidad{
  display:inline-flex;align-items:center;gap:5px;
  background:rgba(255,255,255,.18);border:1px solid rgba(255,255,255,.25);
  color:#fff;padding:4px 12px;border-radius:14px;
  font-size:.8em;font-weight:700;margin-bottom:10px;
}
.hero-desc{
  font-size:.9em;color:#fff;line-height:1.7;margin-bottom:20px;
  max-width:560px;
}
.stats-strip{
  display:flex;gap:20px;margin-bottom:28px;flex-wrap:wrap;
}
.stat-pill{
  display:flex;align-items:center;gap:8px;
  background:rgba(255,255,255,.28);border:1px solid rgba(255,255,255,.38);
  color:#fff;padding:8px 16px;border-radius:20px;font-size:.82em;font-weight:700;
  backdrop-filter:blur(4px);text-shadow:0 1px 3px rgba(0,0,0,.35);
}
.stat-pill-num{font-size:1.15em;font-weight:900}
.hero-card-bump{
  background:#fff;border-radius:20px 20px 0 0;
  padding:4px 0 0;margin:0 -20px;
  box-shadow:0 -8px 32px rgba(0,0,0,.14);
}

/* ── CONTENT ── */
.content-wrap{max-width:680px;margin:0 auto;padding:0 20px 60px}
.card-main{
  background:#fff;border-radius:0 0 20px 20px;
  box-shadow:0 2px 16px rgba(0,0,0,.08);
  border:1px solid rgba(0,0,0,.04);border-top:none;
  overflow:hidden;
}
.section-card{
  background:#fff;border-radius:20px;
  box-shadow:0 2px 16px rgba(0,0,0,.07);
  border:1px solid rgba(0,0,0,.04);
  overflow:hidden;margin-top:14px;
}

/* ── FORMULARIO INLINE ── */
.form-section{padding:24px 24px 10px}
.form-section-title{
  font-size:.72em;font-weight:800;color:#6c5ce7;
  text-transform:uppercase;letter-spacing:.08em;margin-bottom:18px;
}
.question-block{margin-bottom:22px;padding-bottom:22px;border-bottom:1px solid #f3f4f6}
.question-block:last-child{border-bottom:none}
.question-label{
  font-size:.93em;font-weight:700;color:#1a1a2e;line-height:1.4;margin-bottom:12px;
  display:flex;gap:10px;align-items:flex-start;
}
.question-num{
  min-width:24px;height:24px;border-radius:50%;
  background:linear-gradient(145deg,#5f27cd,#6c5ce7);
  color:#fff;font-size:.7em;font-weight:900;
  display:flex;align-items:center;justify-content:center;flex-shrink:0;margin-top:1px;
}
/* Opciones múltiples */
.options-grid{display:flex;flex-direction:column;gap:8px}
.opt-btn{
  padding:10px 14px;border:2px solid #e5e7eb;border-radius:12px;
  background:#fff;cursor:pointer;text-align:left;font-size:.87em;font-weight:600;
  color:#374151;transition:all .15s;font-family:inherit;
}
.opt-btn:hover{border-color:#6c5ce7;background:#faf5ff;color:#5f27cd}
.opt-btn.selected{border-color:#6c5ce7;background:#f5f3ff;color:#5f27cd}
/* Sí/No */
.sino-grid{display:flex;gap:10px}
.sino-btn{
  flex:1;padding:13px;border:2px solid #e5e7eb;border-radius:14px;
  background:#fff;cursor:pointer;font-size:1em;font-weight:800;
  text-align:center;transition:all .15s;font-family:inherit;
}
.sino-btn:hover{transform:translateY(-1px);box-shadow:0 4px 12px rgba(0,0,0,.1)}
.sino-btn.si.selected{background:#d1fae5;border-color:#10b981;color:#065f46}
.sino-btn.no.selected{background:#fee2e2;border-color:#ef4444;color:#991b1b}
/* Escala 1-5 */
.escala-grid{display:flex;gap:8px}
.escala-btn{
  flex:1;padding:10px 4px;border:2px solid #e5e7eb;border-radius:12px;
  background:#fff;cursor:pointer;font-size:1.3em;text-align:center;
  transition:all .15s;font-family:inherit;
}
.escala-btn:hover,.escala-btn.selected{
  border-color:#f59e0b;background:#fffbeb;transform:scale(1.08);
}
/* Escala 1-10 */
.escala10-grid{display:flex;gap:5px;flex-wrap:wrap}
.escala10-btn{
  width:42px;height:42px;border:2px solid #e5e7eb;border-radius:10px;
  background:#fff;cursor:pointer;font-size:.9em;font-weight:800;
  display:flex;align-items:center;justify-content:center;
  transition:all .15s;font-family:inherit;
}
.escala10-btn:hover,.escala10-btn.selected{color:#fff;border-color:transparent;transform:scale(1.1)}
/* focus-visible para accesibilidad de teclado */
button:focus-visible,.opt-btn:focus-visible,.sino-btn:focus-visible,
.escala-btn:focus-visible,.escala10-btn:focus-visible,.btn-enviar:focus-visible,
.btn-login:focus-visible,.share-btn:focus-visible{
  outline:3px solid #6c5ce7;outline-offset:2px;
}
/* Texto libre */
.texto-input{
  width:100%;padding:12px 14px;border:2px solid #e5e7eb;border-radius:12px;
  font-size:.87em;font-family:inherit;resize:vertical;min-height:90px;
  transition:border-color .15s;outline:none;
}
.texto-input:focus{border-color:#6c5ce7}

/* ── BOTÓN ENVIAR ── */
.btn-enviar{
  width:100%;padding:16px;margin:10px 0 20px;
  background:linear-gradient(145deg,#5f27cd,#6c5ce7);
  color:#fff;border:none;border-radius:16px;
  font-size:1em;font-weight:900;cursor:pointer;font-family:inherit;
  box-shadow:0 6px 20px rgba(108,92,231,.4);
  transition:all .15s;
}
.btn-enviar:hover:not(:disabled){transform:translateY(-2px);box-shadow:0 10px 28px rgba(108,92,231,.5)}
.btn-enviar:disabled{opacity:.5;cursor:not-allowed}

/* ── LINK CTA (modo link externo sin login) ── */
.link-cta-block{
  padding:28px 24px;text-align:center;
  background:linear-gradient(180deg,#fff 0%,#eff6ff 100%);
  border-bottom:1px solid #f3f4f6;
}
.btn-link-externo{
  display:inline-flex;align-items:center;gap:10px;
  padding:16px 32px;border-radius:16px;font-size:1em;font-weight:800;
  background:linear-gradient(145deg,#1B3B6F,#2563eb);
  color:#fff;box-shadow:0 4px 16px rgba(37,99,235,.35);
  text-decoration:none;transition:all .15s;
}
.btn-link-externo:hover{transform:translateY(-2px);box-shadow:0 8px 24px rgba(37,99,235,.45)}

/* ── LOGIN REQUIRED ── */
.login-required{
  padding:28px 24px;text-align:center;
  background:linear-gradient(180deg,#fff 0%,#f5f3ff 100%);
  border-bottom:1px solid #f3f4f6;
}
.btn-login{
  display:inline-flex;align-items:center;gap:8px;
  padding:14px 30px;border-radius:16px;font-size:.95em;font-weight:800;
  background:linear-gradient(145deg,#5f27cd,#6c5ce7);
  color:#fff;box-shadow:0 4px 16px rgba(108,92,231,.4);
  transition:all .15s;
}
.btn-login:hover{transform:translateY(-1px);box-shadow:0 8px 24px rgba(108,92,231,.5)}

/* ── RESULTADOS ── */
.results-section{padding:24px}
.results-title{font-size:.72em;font-weight:800;color:#10b981;text-transform:uppercase;letter-spacing:.08em;margin-bottom:18px}
.result-q{margin-bottom:20px}
.result-q-label{font-size:.88em;font-weight:700;color:#374151;margin-bottom:10px}
.result-bar-row{display:flex;align-items:center;gap:10px;margin-bottom:7px}
.result-bar-label{font-size:.8em;color:#6b7280;font-weight:600;min-width:100px;max-width:160px;word-break:break-word}
.result-bar-wrap{flex:1;background:#f1f5f9;border-radius:20px;height:18px;overflow:hidden}
.result-bar-fill{height:100%;border-radius:20px;background:linear-gradient(90deg,#5f27cd,#a29bfe);transition:width .6s ease}
.result-bar-pct{font-size:.8em;font-weight:800;color:#5f27cd;min-width:38px;text-align:right}

/* ── EXPIRADA ── */
.expired-banner{
  margin:20px 24px;padding:14px 18px;border-radius:14px;
  background:#fef2f2;border:1px solid #fecaca;
  color:#991b1b;font-size:.86em;font-weight:700;
  display:flex;align-items:center;gap:10px;
}

/* ── SHARE ── */
.share-block{padding:18px 24px;border-top:1px solid #f3f4f6}
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

/* ── FOOTER ── */
.page-footer{text-align:center;padding:20px;font-size:.78em;color:#94a3b8}
.mapita-badge{
  display:inline-flex;align-items:center;gap:8px;
  background:#fff;border:1px solid #e2e8f0;border-radius:20px;
  padding:8px 18px;margin-bottom:8px;font-weight:700;color:#1B3B6F;
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
  .hero-title{font-size:1.55rem}
  .stats-strip{gap:10px}
  .escala-grid{gap:4px}
  .escala10-btn{width:36px;height:36px;font-size:.82em}
  .sino-btn{padding:10px}
}
</style>
</head>
<body>

<!-- ── TOP BAR ── -->
<nav class="top-bar">
  <span class="logo">🗺 <em>Mapita</em> <span style="color:#94a3b8;font-weight:500">Encuestas</span></span>
  <a href="<?= htmlspecialchars($mapUrl) ?>" class="back">← Ver mapa</a>
</nav>

<!-- ── HERO ── -->
<div class="hero">
  <div class="hero-inner">
    <div class="hero-badge">📊 Encuesta comunitaria</div>
    <h1 class="hero-title"><?= htmlspecialchars($encuesta['titulo']) ?></h1>
    <?php if ($localidad): ?>
    <div class="hero-localidad">📍 <?= htmlspecialchars($localidad) ?></div>
    <?php endif; ?>
    <?php if (!empty($encuesta['descripcion'])): ?>
    <p class="hero-desc"><?= htmlspecialchars(mb_substr($encuesta['descripcion'], 0, 160)) ?><?= mb_strlen($encuesta['descripcion']) > 160 ? '…' : '' ?></p>
    <?php endif; ?>
    <div class="stats-strip">
      <div class="stat-pill">
        <span>👥</span>
        <span><span class="stat-pill-num"><?= $totalPart ?></span> <?= $totalPart === 1 ? 'participante' : 'participantes' ?></span>
      </div>
      <div class="stat-pill">
        <span>❓</span>
        <span><span class="stat-pill-num"><?= $nPreg ?></span> <?= $nPreg === 1 ? 'pregunta' : 'preguntas' ?></span>
      </div>
      <?php if ($diasRestantes !== null): ?>
      <div class="stat-pill">
        <span>⏳</span>
        <span><span class="stat-pill-num"><?= $diasRestantes ?></span> días restantes</span>
      </div>
      <?php endif; ?>
    </div>
    <?php if (!empty($encuesta['imagen']) && preg_match('/^[\w\-]+\.(jpg|jpeg|png|gif|webp)$/i', $encuesta['imagen'])): ?>
    <div style="margin:0 -20px -1px;max-height:240px;overflow:hidden;border-radius:0;">
      <img src="/uploads/encuestas/<?= rawurlencode($encuesta['imagen']) ?>"
           alt="<?= htmlspecialchars($encuesta['titulo']) ?>"
           style="width:100%;object-fit:cover;max-height:240px;display:block;"
           loading="lazy"
           onerror="this.parentElement.style.display='none'">
    </div>
    <?php endif; ?>
    <div class="hero-card-bump"></div>
  </div>
</div>

<!-- ── CONTENT ── -->
<div class="content-wrap">
  <div class="card-main">

    <?php if ($expirada): ?>
    <div class="expired-banner">⛔ Esta encuesta ha cerrado. Ya no acepta respuestas.</div>

    <?php elseif (!empty($encuesta['link'])): ?>
    <!-- Modo link externo: mostrar CTA directo sin requerir login -->
    <div class="link-cta-block">
      <div style="font-size:2.2rem;margin-bottom:12px">📋</div>
      <p style="font-weight:700;font-size:1em;color:#1a1a2e;margin-bottom:6px">Esta encuesta se realiza en un sitio externo</p>
      <p style="font-size:.84em;color:#6b7280;margin-bottom:20px">Hacé clic para participar. Se abrirá en una nueva pestaña.</p>
      <a href="<?= htmlspecialchars($encuesta['link']) ?>" target="_blank" rel="noopener noreferrer"
         class="btn-link-externo" title="Se abre en una nueva pestaña">
        Ir a la encuesta ↗
      </a>
    </div>

    <?php elseif (!$userId): ?>
    <!-- No logueado: invitar a iniciar sesión -->
    <div class="login-required">
      <div style="font-size:2rem;margin-bottom:10px">🔐</div>
      <p style="font-weight:700;font-size:1em;color:#1a1a2e;margin-bottom:6px">Iniciá sesión para participar</p>
      <p style="font-size:.84em;color:#6b7280;margin-bottom:18px">Tu opinión es importante para la comunidad.</p>
      <a href="/login?redirect=<?= urlencode($og_url) ?>" class="btn-login">Iniciar sesión →</a>
      <p style="margin-top:10px;font-size:.78em;color:#94a3b8">¿No tenés cuenta? <a href="/register" style="color:#6c5ce7;font-weight:700">Registrate gratis</a></p>
    </div>

    <?php elseif ($yaRespondio): ?>
    <!-- Ya respondió: mostrar resultados directamente -->
    <div id="results-container">
      <div class="results-section">
        <div class="results-title">✅ Ya participaste — Resultados actuales</div>
        <div id="results-inner"><div style="text-align:center;padding:20px;color:#94a3b8">Cargando resultados…</div></div>
      </div>
    </div>

    <?php else: ?>
    <!-- Logueado y no respondió: mostrar formulario inline -->
    <div id="form-container">
      <div class="form-section">
        <div class="form-section-title">✏️ Respondé las preguntas</div>
        <?php foreach ($preguntas as $idx => $pq):
            $pid  = (int)$pq['id'];
            $tipo = $pq['tipo'] ?? 'opcion_multiple';
            $opts = [];
            if (!empty($pq['opciones'])) {
                $dec = json_decode($pq['opciones'], true);
                if (is_array($dec)) $opts = $dec;
            }
        ?>
        <div class="question-block" data-pid="<?= $pid ?>" data-tipo="<?= htmlspecialchars($tipo) ?>">
          <div class="question-label">
            <span class="question-num"><?= $idx + 1 ?></span>
            <span><?= htmlspecialchars($pq['pregunta']) ?></span>
          </div>

          <?php if ($tipo === 'si_no'): ?>
          <div class="sino-grid" role="group" aria-label="Sí o No">
            <button type="button" class="sino-btn si" aria-pressed="false" onclick="selOpcion(<?= $pid ?>,'Sí',this)">✅ Sí</button>
            <button type="button" class="sino-btn no" aria-pressed="false" onclick="selOpcion(<?= $pid ?>,'No',this)">❌ No</button>
          </div>

          <?php elseif ($tipo === 'escala'): ?>
          <div class="escala-grid" role="group" aria-label="Escala del 1 al 5">
            <?php for ($s = 1; $s <= 5; $s++): ?>
            <button type="button" class="escala-btn" aria-pressed="false" aria-label="<?= $s ?> de 5" onclick="selOpcion(<?= $pid ?>,'<?= $s ?>',this)">
              <?= str_repeat('★', $s) . str_repeat('☆', 5-$s) ?>
            </button>
            <?php endfor; ?>
          </div>

          <?php elseif ($tipo === 'escala_10'): ?>
          <div class="escala10-grid" role="group" aria-label="Escala del 1 al 10">
            <?php
            $colors = ['#ef4444','#f97316','#f97316','#f59e0b','#f59e0b','#84cc16','#84cc16','#22c55e','#10b981','#059669'];
            for ($s = 1; $s <= 10; $s++):
            ?>
            <button type="button" class="escala10-btn"
              data-color="<?= $colors[$s-1] ?>"
              aria-pressed="false" aria-label="<?= $s ?> de 10"
              onclick="selOpcion(<?= $pid ?>,'<?= $s ?>',this)"><?= $s ?></button>
            <?php endfor; ?>
          </div>

          <?php elseif ($tipo === 'texto'): ?>
          <textarea class="texto-input" placeholder="Escribí tu respuesta aquí…"
            oninput="selTexto(<?= $pid ?>,this.value)"></textarea>

          <?php else: /* opcion_multiple */ ?>
          <div class="options-grid" role="group" aria-label="Opciones">
            <?php foreach ($opts as $opt): ?>
            <button type="button" class="opt-btn" aria-pressed="false"
              onclick="selOpcion(<?= $pid ?>,<?= json_encode($opt) ?>,this)"><?= htmlspecialchars($opt) ?></button>
            <?php endforeach; ?>
          </div>
          <?php endif; ?>
        </div>
        <?php endforeach; ?>

        <button type="button" class="btn-enviar" id="btn-enviar" onclick="enviarEncuesta()">
          📊 Enviar mis respuestas
        </button>
        <div id="form-error" style="color:#ef4444;font-size:.84em;text-align:center;padding-bottom:12px;display:none"></div>
      </div>
    </div>
    <?php endif; ?>

    <!-- Share -->
    <div class="share-block">
      <span class="share-label">Compartir esta encuesta</span>
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

  </div><!-- /.card-main -->

  <!-- Footer -->
  <div class="page-footer" style="margin-top:14px">
    <div><a href="<?= htmlspecialchars($mapUrl) ?>" class="mapita-badge">🗺️ Ver más encuestas y eventos en Mapita</a></div>
    <p>© Mapita · La voz de tu comunidad en el mapa</p>
  </div>
</div>

<div id="copy-toast">✓ Enlace copiado</div>

<script>
var respuestas = {};
var encuestaId = <?= $id ?>;

// Seleccionar opción de cualquier tipo
function selOpcion(pid, valor, btn) {
    respuestas[pid] = valor;
    // Limpiar selección previa en el mismo bloque
    var bloque = btn.closest('.question-block');
    bloque.querySelectorAll('button').forEach(function(b){
        b.classList.remove('selected');
        b.setAttribute('aria-pressed', 'false');
        // Escala 10: restablecer color de fondo
        if (b.classList.contains('escala10-btn')) {
            b.style.background = '';
            b.style.color = '';
            b.style.borderColor = '';
        }
    });
    btn.classList.add('selected');
    btn.setAttribute('aria-pressed', 'true');
    // Escala 10: color dinámico usando data-color (compatible con todos los browsers)
    if (btn.classList.contains('escala10-btn')) {
        var c = btn.dataset.color || '#6c5ce7';
        btn.style.background = c;
        btn.style.borderColor = c;
        btn.style.color = '#fff';
    }
}

function selTexto(pid, val) {
    respuestas[pid] = val;
}

function enviarEncuesta() {
    var btn = document.getElementById('btn-enviar');
    var errDiv = document.getElementById('form-error');
    errDiv.style.display = 'none';

    // Recopilar textareas pendientes
    document.querySelectorAll('.question-block').forEach(function(bloque) {
        var pid  = bloque.dataset.pid;
        var tipo = bloque.dataset.tipo;
        if (tipo === 'texto') {
            var ta = bloque.querySelector('textarea');
            if (ta && ta.value.trim()) respuestas[pid] = ta.value.trim();
        }
    });

    // Validar que todas estén respondidas
    var bloques = document.querySelectorAll('.question-block');
    for (var i = 0; i < bloques.length; i++) {
        var pid = bloques[i].dataset.pid;
        if (!respuestas[pid] || respuestas[pid].toString().trim() === '') {
            errDiv.textContent = 'Por favor respondé la pregunta ' + (i + 1) + ' antes de continuar.';
            errDiv.style.display = 'block';
            bloques[i].scrollIntoView({ behavior: 'smooth', block: 'center' });
            return;
        }
    }

    btn.disabled = true;
    btn.textContent = '⏳ Enviando…';

    var payload = { encuesta_id: encuestaId, respuestas: respuestas };

    fetch('/api/encuestas.php?action=respond', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(payload)
    })
    .then(function(r){ return r.json().then(function(d){ d._status = r.status; return d; }); })
    .then(function(data) {
        if (data._status === 200 && (data.success || !data.error)) {
            // Éxito: mostrar resultados
            document.getElementById('form-container').innerHTML =
                '<div style="text-align:center;padding:24px 20px 10px">'
                + '<div style="font-size:2.5rem;margin-bottom:8px">🎉</div>'
                + '<p style="font-weight:800;font-size:1.1em;color:#10b981;margin-bottom:4px">¡Gracias por participar!</p>'
                + '<p style="font-size:.85em;color:#6b7280">Tu respuesta fue registrada.</p>'
                + '</div>';
            cargarResultados();
        } else if (data._status === 409 || (data.error && data.error.indexOf('Ya respondiste') !== -1)) {
            document.getElementById('form-container').innerHTML =
                '<div style="text-align:center;padding:20px;color:#f59e0b;font-weight:700">Ya habías respondido esta encuesta.</div>';
            cargarResultados();
        } else {
            btn.disabled = false;
            btn.textContent = '📊 Enviar mis respuestas';
            errDiv.textContent = data.error || 'No se pudo enviar. Intentá de nuevo.';
            errDiv.style.display = 'block';
        }
    })
    .catch(function() {
        btn.disabled = false;
        btn.textContent = '📊 Enviar mis respuestas';
        errDiv.textContent = 'Error de conexión. Intentá de nuevo.';
        errDiv.style.display = 'block';
    });
}

function cargarResultados() {
    fetch('/api/encuestas.php?action=resultados&id=' + encuestaId)
    .then(function(r){ return r.json(); })
    .then(function(data) {
        if (!data.success || !data.data) return;
        var res = data.data;
        var totalP = res.total_participantes || 0;
        var html = '<div class="results-section">'
            + '<div class="results-title">📊 Resultados — ' + totalP + ' ' + (totalP === 1 ? 'participante' : 'participantes') + '</div>';

        (res.preguntas || []).forEach(function(pq) {
            html += '<div class="result-q">'
                  + '<div class="result-q-label">' + escHtml(pq.pregunta) + '</div>';
            (pq.datos || []).forEach(function(d) {
                var pct = Math.round(d.porcentaje || 0);
                html += '<div class="result-bar-row">'
                      + '<div class="result-bar-label">' + escHtml(d.respuesta) + '</div>'
                      + '<div class="result-bar-wrap"><div class="result-bar-fill" style="width:' + pct + '%"></div></div>'
                      + '<div class="result-bar-pct">' + pct + '%</div>'
                      + '</div>';
            });
            html += '</div>';
        });
        html += '</div>';

        var cont = document.getElementById('results-container') || document.getElementById('form-container');
        if (cont) {
            var existing = cont.querySelector('.results-section');
            if (existing) {
                existing.outerHTML = html;
            } else {
                cont.insertAdjacentHTML('beforeend', html);
            }
        }
        var ri = document.getElementById('results-inner');
        if (ri) ri.outerHTML = html;
    })
    .catch(function(){});
}

function escHtml(str) {
    return String(str || '')
        .replace(/&/g,'&amp;').replace(/</g,'&lt;')
        .replace(/>/g,'&gt;').replace(/"/g,'&quot;');
}

function copyLink(url){
    navigator.clipboard?.writeText(url).then(function(){
        var t=document.getElementById('copy-toast');
        t.classList.add('show');
        setTimeout(function(){t.classList.remove('show')},2000);
    });
}

<?php if ($yaRespondio): ?>
// Ya respondió: cargar resultados al inicio
document.addEventListener('DOMContentLoaded', cargarResultados);
<?php endif; ?>
</script>
</body>
</html>

<?php
/**
 * Vista pública de negocio — diseño profesional v2
 */
session_start();
ini_set('display_errors', 0);
error_reporting(0);

require_once __DIR__ . '/../core/helpers.php';
require_once __DIR__ . '/../includes/db_helper.php';
require_once __DIR__ . '/../business/process_business.php';

setSecurityHeaders();

$businessId = isset($_GET['id']) ? (int)$_GET['id'] : 0;
if ($businessId <= 0) { header("Location: /"); exit(); }

$db   = getDbConnection();
$stmt = $db->prepare("SELECT * FROM businesses WHERE id = ? AND visible = 1");
$stmt->execute([$businessId]);
$business = $stmt->fetch();

if (!$business && isset($_SESSION['user_id'])) {
    $stmt2 = $db->prepare("SELECT * FROM businesses WHERE id = ?");
    $stmt2->execute([$businessId]);
    $business = $stmt2->fetch();
    if ($business && (int)$business['user_id'] !== (int)$_SESSION['user_id'] && empty($_SESSION['is_admin'])) {
        $business = null;
    }
}
if (!$business) { header("Location: /"); exit(); }

$comercioData = getComercioData($businessId);

// ── Galería ─────────────────────────────────────────────────────────────────
$uploadDir = __DIR__ . '/../uploads/businesses/' . $businessId . '/';
$galleryPhotos = [];
if (is_dir($uploadDir)) {
    foreach (glob($uploadDir . 'gallery_*.{jpg,jpeg,png,webp}', GLOB_BRACE) as $f) {
        $fname = basename($f);
        $galleryPhotos[] = '/uploads/businesses/' . $businessId . '/' . $fname . '?t=' . filemtime($f);
    }
    usort($galleryPhotos, fn($a, $b) => strcmp($a, $b));
}

// ── OG Cover ────────────────────────────────────────────────────────────────
$ogCoverUrl = null;
foreach (['jpg','jpeg','png','webp'] as $ext) {
    $f = $uploadDir . 'og_cover.' . $ext;
    if (file_exists($f)) {
        $ogCoverUrl = '/uploads/businesses/' . $businessId . '/og_cover.' . $ext . '?t=' . filemtime($f);
        break;
    }
}

// ── Servicios extra ──────────────────────────────────────────────────────────
$svcFlags = [
    'WiFi'             => ['📶','blue'],
    'Estacionamiento'  => ['🅿️','blue'],
    'Acceso universal' => ['♿','blue'],
    'Reservas online'  => ['📱','blue'],
    'Factura fiscal'   => ['🧾','amber'],
    'Retiro en local'  => ['🛍️','amber'],
    'Mercado Pago'     => ['💙','blue'],
];
$certStr = $business['certifications'] ?? '';
$extraServices = [];
foreach ($svcFlags as $label => [$em, $cls]) {
    if (str_contains($certStr, $label)) $extraServices[] = [$em, $label, $cls];
}
$certDisplay = preg_replace('/\s*\|\s*(WiFi|Estacionamiento|Acceso universal|Reservas online|Factura fiscal|Retiro en local|Mercado Pago)(,\s*[^|]*)?/', '', $certStr);
$certDisplay = trim(preg_replace('/^\s*\|\s*/', '', $certDisplay));

$tags = array_filter(array_map('trim', explode(',', $comercioData['categorias_productos'] ?? '')));

// ── Tipo → icono y color ────────────────────────────────────────────────────
$typeIcons = [
    'restaurante'=>'🍽️','cafeteria'=>'☕','bar'=>'🍺','panaderia'=>'🥐',
    'heladeria'=>'🍦','pizzeria'=>'🍕','supermercado'=>'🛒','comercio'=>'🛍️',
    'indumentaria'=>'👕','verduleria'=>'🥦','carniceria'=>'🥩','pastas'=>'🍝',
    'ferreteria'=>'🔧','electronica'=>'📱','muebleria'=>'🛋️','floristeria'=>'💐',
    'libreria'=>'📖','productora_audiovisual'=>'🎥','escuela_musicos'=>'🎼',
    'taller_artes'=>'🎨','biodecodificacion'=>'🧬','libreria_cristiana'=>'📚',
    'kiosco'=>'🏪','joyeria'=>'💍','optica'=>'👓','farmacia'=>'💊',
    'hospital'=>'🏥','medico_pediatra'=>'🧒','medico_traumatologo'=>'🦴',
    'laboratorio'=>'🧪','odontologia'=>'🦷','veterinaria'=>'🐾',
    'psicologo'=>'🧠','psicopedagogo'=>'📚','fonoaudiologo'=>'🗣️','grafologo'=>'✍️',
    'salon_belleza'=>'💇','barberia'=>'💈','spa'=>'💆','gimnasio'=>'💪','danza'=>'💃',
    'banco'=>'🏦','inmobiliaria'=>'🏠','seguros'=>'🛡️','abogado'=>'⚖️','contador'=>'📊',
    'ingenieria_civil'=>'🏗️','electricista'=>'💡','gasista'=>'🔥','gas_en_garrafa'=>'🛢️',
    'seguridad'=>'🛡️','grafica'=>'🖨️','astrologo'=>'🔮','zapatero'=>'👞','videojuegos'=>'🎮',
    'maestro_particular'=>'📘','asistencia_ancianos'=>'🧓','enfermeria'=>'🩺',
    'alquiler_mobiliario_fiestas'=>'🪑','propalacion_musica'=>'🔊','animacion_fiestas'=>'🎉',
    'arquitectura'=>'📐','ingenieria'=>'⚙️','taller'=>'🔩','herreria'=>'🔨',
    'carpinteria'=>'🪵','modista'=>'🧵','construccion'=>'🏗️','centro_vecinal'=>'🏘️',
    'academia'=>'🎓','idiomas'=>'🌐','escuela'=>'🏫','hotel'=>'🏨','turismo'=>'✈️',
    'cine'=>'🎬','automotriz'=>'🚗','transporte'=>'🚌','fotografia'=>'📷','eventos'=>'🎉',
    'otros'=>'📍',
];
$icon = $typeIcons[$business['business_type']] ?? '📍';

$typeColors = [
    'restaurante'   =>['#e74c3c','#c0392b'],'cafeteria'    =>['#8B5E3C','#6B3F1F'],
    'bar'           =>['#f39c12','#d68910'],'panaderia'    =>['#e67e22','#ca6f1e'],
    'heladeria'     =>['#3498db','#2980b9'],'pizzeria'     =>['#e74c3c','#922b21'],
    'supermercado'  =>['#27ae60','#1e8449'],'comercio'     =>['#e74c3c','#c0392b'],
    'indumentaria'  =>['#9b59b6','#7d3c98'],'verduleria'   =>['#2ecc71','#27ae60'],
    'carniceria'    =>['#c0392b','#922b21'],'pastas'       =>['#e67e22','#d35400'],
    'ferreteria'    =>['#7f8c8d','#6c7a89'],'electronica'  =>['#2980b9','#1a5276'],
    'productora_audiovisual'=>['#6c5ce7','#4b3fb0'],'escuela_musicos'=>['#8e44ad','#6c3483'],
    'taller_artes'  =>['#e67e22','#ca6f1e'],'biodecodificacion'=>['#16a085','#117864'],
    'libreria_cristiana'=>['#2d6a4f','#1b4332'],
    'farmacia'      =>['#9b59b6','#7d3c98'],'hospital'     =>['#2ecc71','#27ae60'],
    'medico_pediatra'=>['#0ea5e9','#0369a1'],'medico_traumatologo'=>['#2563eb','#1e3a8a'],
    'laboratorio'   =>['#14b8a6','#0f766e'],'odontologia'  =>['#3498db','#2980b9'],
    'veterinaria'   =>['#20c997','#12b886'],'psicologo'    =>['#8e44ad','#7d3c98'],
    'psicopedagogo' =>['#9b59b6','#7d3c98'],'fonoaudiologo'=>['#1abc9c','#16a085'],
    'grafologo'     =>['#7f8c8d','#6c7a89'],'salon_belleza'=>['#e91e63','#c2185b'],
    'barberia'      =>['#c0392b','#922b21'],'spa'          =>['#f06595','#e64980'],
    'gimnasio'      =>['#8e44ad','#7d3c98'],'danza'        =>['#e91e63','#c2185b'],
    'banco'         =>['#2c3e50','#1a252f'],'inmobiliaria' =>['#27ae60','#1e8449'],
    'seguros'       =>['#2980b9','#1a5276'],'abogado'      =>['#34495e','#2c3e50'],
    'contador'      =>['#2c3e50','#1a252f'],'arquitectura' =>['#2980b9','#1a5276'],
    'ingenieria'    =>['#7f8c8d','#6c7a89'],'taller'       =>['#7f8c8d','#6c7a89'],
    'herreria'      =>['#95a5a6','#7f8c8d'],'carpinteria'  =>['#8e6914','#7a5c10'],
    'modista'       =>['#e91e63','#c2185b'],'construccion' =>['#e67e22','#d35400'],
    'ingenieria_civil'=>['#f59e0b','#b45309'],'electricista'=>['#facc15','#ca8a04'],
    'gasista'       =>['#f97316','#c2410c'],'gas_en_garrafa'=>['#0ea5e9','#1d4ed8'],
    'seguridad'     =>['#334155','#1e293b'],'grafica'      =>['#a855f7','#7e22ce'],
    'astrologo'     =>['#6366f1','#4338ca'],'zapatero'     =>['#7c2d12','#451a03'],
    'videojuegos'   =>['#8b5cf6','#6d28d9'],'maestro_particular'=>['#0ea5e9','#075985'],
    'asistencia_ancianos'=>['#14b8a6','#0f766e'],'enfermeria'=>['#0ea5e9','#0369a1'],
    'alquiler_mobiliario_fiestas'=>['#f59e0b','#d97706'],'propalacion_musica'=>['#6366f1','#4338ca'],
    'animacion_fiestas'=>['#ec4899','#be185d'],'centro_vecinal'=>['#27ae60','#1e8449'],
    'academia'      =>['#2980b9','#1a5276'],'idiomas'      =>['#00b4d8','#0077b6'],
    'escuela'       =>['#3498db','#2980b9'],'hotel'        =>['#1B3B6F','#0f2444'],
    'turismo'       =>['#00b4d8','#0077b6'],'cine'         =>['#8e44ad','#7d3c98'],
];
$colors = $typeColors[$business['business_type']] ?? ['#1B3B6F','#0f2444'];

// ── OG / Meta ────────────────────────────────────────────────────────────────
$scheme   = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off') ? 'https' : 'http';
$host     = $_SERVER['HTTP_HOST'] ?? 'mapita.com.ar';
$og_title = $business['name'] . ' — ' . ucfirst($business['business_type'] ?? 'Negocio') . ' en Mapita';
$og_desc  = $business['description'] ? mb_substr($business['description'], 0, 180) : 'Encontrá ' . $business['name'] . ' en el mapa — dirección, horarios, contacto y más en Mapita.';
$og_image = $ogCoverUrl ? ($scheme.'://'.$host.$ogCoverUrl) : ($scheme.'://'.$host.'/api/og_image.php?type=business&id='.$businessId);
$og_url   = $scheme.'://'.$host.'/business/view_business.php?id='.$businessId;
$isOwnerOrAdmin = isset($_SESSION['user_id']) && ((int)$business['user_id'] === (int)$_SESSION['user_id'] || !empty($_SESSION['is_admin']));

// ── Servicios combinados ─────────────────────────────────────────────────────
$allServices = [];
if (!empty($business['has_delivery']))     $allServices[] = ['🚚','Delivery / Envío','green'];
if (!empty($business['has_card_payment'])) $allServices[] = ['💳','Pago con tarjeta','blue'];
if (!empty($business['is_franchise']))     $allServices[] = ['🏷️','Franquicia','purple'];
foreach ($extraServices as [$em,$lbl,$cls]) $allServices[] = [$em,$lbl,$cls];

$typeLabel = ucwords(str_replace('_',' ', $business['business_type'] ?? 'Negocio'));
?>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title><?= htmlspecialchars($business['name']) ?> · Mapita</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="<?= htmlspecialchars($og_desc) ?>">
<meta property="og:title" content="<?= htmlspecialchars($og_title) ?>">
<meta property="og:description" content="<?= htmlspecialchars($og_desc) ?>">
<meta property="og:image" content="<?= htmlspecialchars($og_image) ?>">
<meta property="og:url" content="<?= htmlspecialchars($og_url) ?>">
<meta property="og:type" content="business.business">
<meta name="twitter:card" content="summary_large_image">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css"/>
<script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
<style>
/* ══ RESET & BASE ═══════════════════════════════════════════════════════════ */
*,*::before,*::after{box-sizing:border-box;margin:0;padding:0}
html{scroll-behavior:smooth;-webkit-tap-highlight-color:transparent}
body{
  font-family:'Inter',system-ui,-apple-system,BlinkMacSystemFont,'Segoe UI',Roboto,sans-serif;
  font-feature-settings:'cv05' 1,'cv11' 1;
  -webkit-font-smoothing:antialiased;
  -moz-osx-font-smoothing:grayscale;
  background:#f1f3f6;color:#1a1a2e;min-height:100vh;
  padding-bottom:<?= $isOwnerOrAdmin ? '90px' : '40px' ?>;
}
<?php if (!$isOwnerOrAdmin && !empty($business['phone'])): ?>
@media(max-width:767px){body{padding-bottom:96px}}
<?php endif; ?>
a{text-decoration:none;color:inherit}
img{display:block;max-width:100%}

/* ══ TOP NAV ════════════════════════════════════════════════════════════════ */
.top-nav{
  position:fixed;top:0;left:0;right:0;z-index:900;
  height:52px;
  background:rgba(255,255,255,.97);backdrop-filter:blur(16px);-webkit-backdrop-filter:blur(16px);
  border-bottom:1px solid rgba(0,0,0,.07);
  display:flex;align-items:center;gap:10px;padding:0 14px;
}
.top-nav .back{
  display:flex;align-items:center;gap:5px;
  color:#1B3B6F;font-size:.8em;font-weight:800;
  padding:6px 11px;border-radius:20px;
  background:#eff6ff;border:1px solid #bfdbfe;
  transition:background .15s;white-space:nowrap;
  -webkit-tap-highlight-color:transparent;
}
.top-nav .back:hover{background:#dbeafe}
.top-nav .nav-center{
  flex:1;text-align:center;
  font-size:.8em;font-weight:800;color:#1e293b;
  white-space:nowrap;overflow:hidden;text-overflow:ellipsis;
  padding:0 6px;
}
.top-nav .nav-actions{display:flex;align-items:center;gap:6px;flex-shrink:0}
.nav-icon-btn{
  width:34px;height:34px;border-radius:50%;border:none;cursor:pointer;
  background:#f1f5f9;color:#475569;font-size:1rem;
  display:flex;align-items:center;justify-content:center;
  transition:background .15s,color .15s;
}
.nav-icon-btn:hover{background:#e2e8f0;color:#1B3B6F}
.nav-edit-btn{
  padding:7px 16px;border-radius:20px;border:none;cursor:pointer;
  background:#1B3B6F;color:#fff;font-size:.78em;font-weight:800;
  font-family:inherit;transition:background .15s;white-space:nowrap;
}
.nav-edit-btn:hover{background:#0f2444}

/* ══ HERO ═══════════════════════════════════════════════════════════════════ */
.hero{
  position:relative;margin-top:52px;
  height:260px;overflow:hidden;
  background:linear-gradient(135deg,<?= $colors[0] ?> 0%,<?= $colors[1] ?> 100%);
}
@media(min-width:768px){.hero{height:340px}}
.hero-cover{position:absolute;inset:0;width:100%;height:100%;object-fit:cover}
.hero-overlay{
  position:absolute;inset:0;
  background:linear-gradient(to bottom,rgba(0,0,0,0) 0%,rgba(0,0,0,.78) 100%);
}
.hero-body{
  position:absolute;bottom:0;left:0;right:0;
  padding:20px 22px 22px;
}
.hero-icon-wrap{
  width:58px;height:58px;border-radius:18px;
  background:rgba(255,255,255,.22);border:2px solid rgba(255,255,255,.4);
  display:flex;align-items:center;justify-content:center;
  font-size:1.9rem;margin-bottom:10px;
  backdrop-filter:blur(8px);-webkit-backdrop-filter:blur(8px);
  box-shadow:0 6px 20px rgba(0,0,0,.25);
  transform:rotate(-3deg);
}
@media(max-width:767px){
  .hero-icon-wrap{width:52px;height:52px;font-size:1.7rem;border-radius:16px}
  .hero-body{padding:16px 18px 18px}
  .hero-badges{margin-top:8px;gap:5px}
  .hbadge{font-size:.68em;padding:3px 9px}
}
.hero-name{
  font-size:1.65em;font-weight:900;color:#fff;
  line-height:1.1;text-shadow:0 2px 12px rgba(0,0,0,.5);
  letter-spacing:-.03em;
  font-feature-settings:'cv11' 1;
}
@media(min-width:768px){.hero-name{font-size:2.4em;letter-spacing:-.04em}}
.hero-sub{
  font-size:.82em;color:rgba(255,255,255,.82);font-weight:500;
  margin-top:5px;letter-spacing:.02em;
}
.hero-badges{display:flex;gap:6px;flex-wrap:wrap;margin-top:10px}
.hbadge{
  display:inline-flex;align-items:center;gap:4px;
  padding:3px 11px;border-radius:20px;font-size:.72em;font-weight:700;
  letter-spacing:.02em;
}
.hbadge-type{background:rgba(255,255,255,.18);color:#fff;border:1px solid rgba(255,255,255,.3)}
.hbadge-open{background:#10b981;color:#fff}
.hbadge-closed{background:rgba(239,68,68,.85);color:#fff}
.hbadge-verified{background:#f59e0b;color:#1a1a1a}
.hbadge-hidden{background:#6b7280;color:#fff}
.hbadge-delivery{background:#f59e0b;color:#1a1a1a}
.hbadge-card{background:#6366f1;color:#fff}

/* ══ INFO STRIP (mobile only) ═══════════════════════════════════════════════ */
.info-strip{
  background:#fff;border-bottom:1px solid #f0f0f0;
  padding:9px 16px;
}
.info-strip-item{display:flex;align-items:center;gap:7px}
.info-strip-icon{font-size:.9rem;flex-shrink:0}
.info-strip-text{
  font-size:.8em;color:#64748b;font-weight:500;
  white-space:nowrap;overflow:hidden;text-overflow:ellipsis;
}
@media(min-width:768px){.info-strip{display:none}}

/* ══ QUICK ACTION BAR — grid de acciones (mobile) ═══════════════════════════ */
.quick-bar{
  display:grid;
  grid-template-columns:1fr 1fr;
  gap:10px;padding:16px;
  background:#fff;border-bottom:1px solid #f0f0f0;
}
.qbtn{
  display:flex;flex-direction:column;align-items:center;justify-content:center;
  gap:5px;padding:14px 10px;border-radius:18px;border:none;
  cursor:pointer;font-family:inherit;font-size:.7em;font-weight:800;
  text-transform:uppercase;letter-spacing:.04em;
  transition:transform .12s,box-shadow .12s;
  background:#f3f4f6;color:#374151;text-align:center;
  text-decoration:none;min-height:72px;-webkit-tap-highlight-color:transparent;
}
.qbtn .qi{font-size:1.75rem;line-height:1}
.qbtn:active{transform:scale(.93)}
.qbtn:hover{background:#e8eef6;color:#1B3B6F}
.qbtn.call{
  background:linear-gradient(145deg,#1B3B6F,#0f2444);
  color:#fff;box-shadow:0 4px 16px rgba(27,59,111,.3);
}
.qbtn.wa{
  background:linear-gradient(145deg,#25D366,#128C7E);
  color:#fff;box-shadow:0 4px 16px rgba(37,211,102,.3);
}

/* ══ PAGE LAYOUT ════════════════════════════════════════════════════════════ */
.page-wrap{max-width:1020px;margin:0 auto;padding:18px 14px 10px}
@media(min-width:768px){.page-wrap{padding:24px 20px 10px}}

.page-grid{display:grid;grid-template-columns:1fr;gap:18px}
@media(min-width:768px){
  .page-grid{grid-template-columns:1fr 340px;gap:22px;align-items:start}
}
.col-sidebar{display:flex;flex-direction:column;gap:16px}
@media(min-width:768px){
  .col-sidebar{position:sticky;top:70px}
}

/* ══ CARDS ══════════════════════════════════════════════════════════════════ */
.card{
  background:#fff;border-radius:24px;
  box-shadow:0 1px 4px rgba(0,0,0,.06),0 4px 16px rgba(0,0,0,.04);
  overflow:hidden;
  border:1px solid rgba(0,0,0,.04);
}
.card+.card{margin-top:0}

.card-head{
  display:flex;align-items:center;gap:10px;
  padding:14px 20px 12px;border-bottom:1px solid #f3f4f6;
}
.card-head-icon{
  width:32px;height:32px;border-radius:10px;
  display:flex;align-items:center;justify-content:center;
  font-size:1rem;flex-shrink:0;
}
.card-head-icon.blue{background:#eff6ff}
.card-head-icon.green{background:#f0fdf4}
.card-head-icon.amber{background:#fffbeb}
.card-head-icon.purple{background:#faf5ff}
.card-head-icon.rose{background:#fff1f2}
.card-head-icon.slate{background:#f8fafc}

.card-title{
  font-size:.78em;font-weight:800;color:#374151;
  text-transform:uppercase;letter-spacing:.09em;flex:1;
  font-feature-settings:'cv11' 1;
}
.card-body{padding:18px 20px}
.card-body-tight{padding:12px 20px}

/* ══ DESCRIPTION ════════════════════════════════════════════════════════════ */
.desc-quote{
  color:#4b5563;line-height:1.85;font-size:.96em;
  font-style:italic;position:relative;padding-left:18px;
  border-left:3px solid <?= $colors[0] ?>;
  font-weight:400;
}
.desc-plain{color:#4b5563;line-height:1.82;font-size:.96em;font-weight:400}

/* ══ GALLERY ════════════════════════════════════════════════════════════════ */
.gallery-grid{
  display:grid;
  grid-template-columns:repeat(auto-fill,minmax(120px,1fr));
  gap:8px;padding:0 16px 16px;
}
@media(min-width:500px){.gallery-grid{grid-template-columns:repeat(auto-fill,minmax(150px,1fr))}}
.gthumb{
  aspect-ratio:4/3;border-radius:14px;overflow:hidden;
  cursor:pointer;box-shadow:0 2px 8px rgba(0,0,0,.1);
}
.gthumb img{width:100%;height:100%;object-fit:cover;transition:transform .25s}
.gthumb:hover img{transform:scale(1.06)}

/* ══ INFO ROWS ══════════════════════════════════════════════════════════════ */
.irow{
  display:flex;align-items:flex-start;gap:14px;
  padding:12px 0;border-bottom:1px solid #f3f4f6;
}
.irow:last-child{border-bottom:none}
.iico{
  width:34px;height:34px;border-radius:10px;
  background:#f8fafc;border:1px solid #e2e8f0;
  display:flex;align-items:center;justify-content:center;
  font-size:1rem;flex-shrink:0;
}
.icont{flex:1;min-width:0}
.ilabel{
  font-size:.66em;color:#94a3b8;font-weight:700;
  text-transform:uppercase;letter-spacing:.1em;margin-bottom:2px;
}
.ival{font-size:.9em;color:#1e293b;word-break:break-word;line-height:1.6;font-weight:500}
.ival a{color:#1B3B6F;font-weight:700}
.ival a:hover{text-decoration:underline}

.price-chip{
  display:inline-flex;align-items:center;gap:4px;
  background:#d1fae5;color:#065f46;padding:3px 12px;
  border-radius:20px;font-size:.9em;font-weight:800;
}

/* ══ SERVICE & TAG CHIPS ════════════════════════════════════════════════════ */
.chips-wrap{display:flex;flex-wrap:wrap;gap:8px}
.svc-chip{
  display:inline-flex;align-items:center;gap:6px;
  padding:6px 14px;border-radius:20px;font-size:.78em;font-weight:700;
}
.svc-chip.blue{background:#eff6ff;color:#1d4ed8;border:1px solid #bfdbfe}
.svc-chip.green{background:#f0fdf4;color:#15803d;border:1px solid #bbf7d0}
.svc-chip.amber{background:#fffbeb;color:#92400e;border:1px solid #fde68a}
.svc-chip.purple{background:#faf5ff;color:#7e22ce;border:1px solid #e9d5ff}
.tag-chip{
  padding:5px 14px;border-radius:20px;font-size:.78em;font-weight:600;
  background:#f8fafc;color:#475569;border:1px solid #e2e8f0;
  transition:background .15s,color .15s;cursor:default;
}
.tag-chip:hover{background:#eff6ff;color:#1B3B6F;border-color:#bfdbfe}

/* ══ SOCIAL BUTTONS ═════════════════════════════════════════════════════════ */
.social-list{display:flex;gap:10px;flex-wrap:wrap}
.soc-btn{
  display:inline-flex;align-items:center;gap:8px;
  padding:9px 18px;border-radius:24px;font-size:.82em;font-weight:700;
  transition:opacity .15s,transform .15s;
}
.soc-btn:hover{opacity:.88;transform:translateY(-1px)}
.soc-ig{background:linear-gradient(135deg,#405de6,#5851db,#833ab4,#c13584,#e1306c,#fd1d1d);color:#fff}
.soc-fb{background:#1877f2;color:#fff}
.soc-tt{background:#010101;color:#fff}

/* ══ MAP MINI ════════════════════════════════════════════════════════════════ */
#map-mini{height:220px;isolation:isolate}
@media(min-width:768px){#map-mini{height:260px}}
.map-footer{
  padding:10px 20px;font-size:.82em;color:#64748b;
  display:flex;align-items:center;gap:8px;
  background:#fafafa;border-top:1px solid #f3f4f6;
}
.map-footer a{
  margin-left:auto;color:#1B3B6F;font-weight:800;
  font-size:.9em;white-space:nowrap;
  display:flex;align-items:center;gap:4px;
}
.map-footer a:hover{text-decoration:underline}

/* ══ OPEN/CLOSED STATUS ROW ═════════════════════════════════════════════════ */
.mob-status-row{
  display:flex;align-items:center;justify-content:space-between;
  background:#fff;padding:10px 16px;border-bottom:1px solid #f0f0f0;
  font-size:.82em;
}
.mob-status-badge{
  display:inline-flex;align-items:center;gap:5px;
  padding:4px 12px;border-radius:20px;font-weight:800;font-size:.9em;
}
.mob-status-badge.open{background:#d1fae5;color:#065f46}
.mob-status-badge.closed{background:#fee2e2;color:#991b1b}
.mob-status-horario{color:#94a3b8;font-size:.9em}
@media(min-width:768px){.mob-status-row{display:none}}

/* ══ REVIEWS SECTION (dark) ═════════════════════════════════════════════════ */
.reviews-dark{
  background:#1a1f2e;border-radius:24px;overflow:hidden;
  box-shadow:0 4px 24px rgba(0,0,0,.18);
  border:1px solid rgba(255,255,255,.06);
}
.reviews-dark .card-head{
  border-bottom:1px solid rgba(255,255,255,.08);
  background:transparent;padding:18px 22px 14px;
}
.reviews-dark .card-title{color:#e2e8f0}
.reviews-dark .card-head-icon{background:rgba(255,255,255,.08)}

.rat-summary{
  display:flex;align-items:center;gap:20px;
  padding:16px 22px;border-bottom:1px solid rgba(255,255,255,.08);
}
.rat-score{font-size:3.4em;font-weight:900;color:#f8fafc;line-height:1;letter-spacing:-.04em}
.rat-stars{font-size:1.45em;letter-spacing:2px;color:#f59e0b}
.rat-count{font-size:.76em;color:#64748b;margin-top:5px;font-weight:600;letter-spacing:.02em}

.review-item{
  padding:14px 22px;border-top:1px solid rgba(255,255,255,.06);
}
.rev-author{font-weight:700;font-size:.9em;color:#e2e8f0;letter-spacing:.01em}
.rev-stars{font-size:.95em;margin-left:6px;color:#f59e0b}
.rev-text{color:#94a3b8;font-size:.86em;line-height:1.7;margin:6px 0;font-style:italic;font-weight:400}
.rev-date{font-size:.7em;color:#475569;margin-top:4px;letter-spacing:.03em}

.rev-form{padding:18px 22px;border-top:1px solid rgba(255,255,255,.08)}
.rev-form-label{font-size:.72em;font-weight:800;color:#94a3b8;text-transform:uppercase;letter-spacing:.08em;margin-bottom:8px;display:block}
.star-pick{display:flex;flex-direction:row-reverse;width:fit-content;gap:3px;margin:10px 0}
.star-pick input{display:none}
.star-pick label{font-size:2rem;cursor:pointer;color:rgba(255,255,255,.15);transition:color .1s}
.star-pick input:checked~label,.star-pick label:hover,.star-pick label:hover~label{color:#f59e0b}
.rev-txt{
  width:100%;padding:12px 14px;
  background:rgba(255,255,255,.06);border:1.5px solid rgba(255,255,255,.1);
  border-radius:14px;font-family:inherit;font-size:.88em;color:#e2e8f0;
  resize:vertical;min-height:80px;transition:border-color .2s;
}
.rev-txt::placeholder{color:#475569}
.rev-txt:focus{outline:none;border-color:#3b82f6;box-shadow:0 0 0 3px rgba(59,130,246,.12)}
.btn-rev{
  background:#3b82f6;color:#fff;border:none;
  padding:11px 28px;border-radius:12px;cursor:pointer;
  font-weight:800;font-size:.88em;margin-top:10px;
  font-family:inherit;transition:background .15s;
}
.btn-rev:hover{background:#2563eb}
.no-reviews{
  padding:24px 22px;text-align:center;
  color:#475569;font-size:.86em;font-style:italic;
}

/* ══ SIDEBAR CARDS ══════════════════════════════════════════════════════════ */
.sidebar-cta{
  display:flex;flex-direction:column;gap:10px;
}
.cta-primary{
  display:flex;align-items:center;justify-content:center;gap:10px;
  padding:16px 20px;border-radius:18px;border:none;cursor:pointer;
  font-family:inherit;font-size:.88em;font-weight:800;
  text-decoration:none;transition:all .15s;text-align:center;
}
.cta-call{background:#1B3B6F;color:#fff;box-shadow:0 4px 16px rgba(27,59,111,.25)}
.cta-call:hover{background:#0f2444;transform:translateY(-1px)}
.cta-wa{background:#25D366;color:#fff;box-shadow:0 4px 16px rgba(37,211,102,.25)}
.cta-wa:hover{background:#128C7E;transform:translateY(-1px)}
.cta-web{background:#f8fafc;color:#1e293b;border:1.5px solid #e2e8f0}
.cta-web:hover{background:#f1f5f9;transform:translateY(-1px)}
.cta-directions{background:#4285F4;color:#fff;box-shadow:0 4px 16px rgba(66,133,244,.25)}
.cta-directions:hover{background:#3367d6;transform:translateY(-1px)}
.cta-icon{font-size:1.2rem}

/* Stat rows in sidebar */
.stat-row{
  display:flex;align-items:flex-start;gap:12px;
  padding:11px 0;border-bottom:1px solid #f3f4f6;
}
.stat-row:last-child{border-bottom:none}
.stat-icon{
  width:30px;height:30px;border-radius:8px;
  background:#f8fafc;border:1px solid #f1f5f9;
  display:flex;align-items:center;justify-content:center;
  font-size:.88rem;flex-shrink:0;margin-top:1px;
}
.stat-info{flex:1;min-width:0}
.stat-label{font-size:.66em;color:#94a3b8;font-weight:800;text-transform:uppercase;letter-spacing:.08em;margin-bottom:2px}
.stat-val{font-size:.84em;color:#1e293b;font-weight:600;word-break:break-word;line-height:1.45}
.stat-val a{color:#1B3B6F;font-weight:700}
.stat-val a:hover{text-decoration:underline}

/* ══ OPEN/CLOSED INDICATOR ══════════════════════════════════════════════════ */
.status-indicator{
  display:inline-flex;align-items:center;gap:6px;
  padding:6px 14px;border-radius:20px;font-size:.8em;font-weight:800;
  margin-bottom:14px;
}
.status-open{background:#d1fae5;color:#065f46}
.status-open::before{content:'';width:7px;height:7px;border-radius:50%;background:#10b981;display:inline-block}
.status-closed{background:#fee2e2;color:#991b1b}
.status-closed::before{content:'';width:7px;height:7px;border-radius:50%;background:#ef4444;display:inline-block}

/* ══ FLOATING FOOTER (owner/admin) ══════════════════════════════════════════ */
.floating-footer{
  position:fixed;bottom:0;left:0;right:0;z-index:800;
  padding:10px 14px 14px;
  background:rgba(15,20,35,.92);backdrop-filter:blur(16px);-webkit-backdrop-filter:blur(16px);
  border-top:1px solid rgba(255,255,255,.08);
}
.floating-footer-inner{
  max-width:600px;margin:0 auto;
  display:flex;gap:8px;
}
.ff-btn{
  display:flex;align-items:center;justify-content:center;gap:7px;
  padding:12px 20px;border-radius:16px;border:none;cursor:pointer;
  font-family:inherit;font-size:.8em;font-weight:800;
  text-transform:uppercase;letter-spacing:.05em;
  text-decoration:none;transition:all .15s;
}
.ff-edit{flex:3;background:#3b82f6;color:#fff;box-shadow:0 4px 16px rgba(59,130,246,.3)}
.ff-edit:hover{background:#2563eb}
.ff-icon{flex:1;background:rgba(255,255,255,.1);color:#fff;border:1px solid rgba(255,255,255,.08)}
.ff-icon:hover{background:rgba(255,255,255,.18)}

/* ══ LIGHTBOX ════════════════════════════════════════════════════════════════ */
.lb{display:none;position:fixed;inset:0;z-index:1100;
  background:rgba(0,0,0,.94);align-items:center;justify-content:center}
.lb.open{display:flex}
.lb img{max-width:96vw;max-height:90vh;border-radius:12px;object-fit:contain}
.lb-close{position:absolute;top:16px;right:20px;color:#fff;font-size:2rem;cursor:pointer;opacity:.7}
.lb-close:hover{opacity:1}
.lb-prev,.lb-next{
  position:absolute;top:50%;transform:translateY(-50%);
  color:#fff;font-size:1.8rem;cursor:pointer;padding:12px;
  opacity:.65;background:rgba(0,0,0,.35);border-radius:50%;
  line-height:1;border:none;font-family:inherit;
}
.lb-prev{left:12px}.lb-next{right:12px}
.lb-prev:hover,.lb-next:hover{opacity:1;background:rgba(0,0,0,.65)}

/* ══ EMPTY STATE ═════════════════════════════════════════════════════════════ */
.empty-state{text-align:center;padding:28px 16px;color:#9ca3af;font-size:.86em}
.empty-state .ei{font-size:2.5rem;margin-bottom:10px;opacity:.5}

@media(max-width:767px){
  /* Review items */
  .review-item{padding:12px 16px}
  .rev-form{padding:16px}
  .rat-summary{padding:14px 16px}
  .rat-score{font-size:2.8em}
  .no-reviews{padding:20px 16px}

  /* Mapa */
  #map-mini{height:180px}
  .map-footer{padding:8px 14px;font-size:.78em}

  /* Social */
  .soc-btn{padding:8px 14px;font-size:.8em}

  /* Sidebar en mobile: quitar sticky */
  .col-sidebar{position:static !important}
}

/* ══ STICKY CONTACT BAR (mobile, non-admin) ════════════════════════════════ */
.sticky-contact{
  position:fixed;bottom:0;left:0;right:0;z-index:801;
  padding:10px 16px max(18px,env(safe-area-inset-bottom));
  background:rgba(255,255,255,.97);
  backdrop-filter:blur(16px);-webkit-backdrop-filter:blur(16px);
  border-top:1px solid #e2e8f0;
  display:flex;gap:10px;
  box-shadow:0 -6px 24px rgba(0,0,0,.1);
}
.sticky-btn{
  flex:1;display:flex;align-items:center;justify-content:center;gap:8px;
  padding:14px 16px;border-radius:16px;font-weight:800;font-size:.88em;
  text-decoration:none;border:none;cursor:pointer;font-family:inherit;
  transition:transform .12s,box-shadow .12s;
  -webkit-tap-highlight-color:transparent;
}
.sticky-call{
  background:linear-gradient(145deg,#1B3B6F,#0f2444);
  color:#fff;box-shadow:0 4px 14px rgba(27,59,111,.3);
}
.sticky-call:active{transform:scale(.96)}
.sticky-wa{
  background:linear-gradient(145deg,#25D366,#128C7E);
  color:#fff;box-shadow:0 4px 14px rgba(37,211,102,.3);
}
.sticky-wa:active{transform:scale(.96)}
@media(min-width:768px){.sticky-contact{display:none}}

/* ══ RESPONSIVE TWEAKS ══════════════════════════════════════════════════════ */
@media(max-width:767px){
  /* Sidebar CTAs duplican quick-bar; ocultarlos en mobile */
  .sidebar-desktop-only{display:none}
  .col-sidebar .sidebar-cta{display:none}
  .col-sidebar{gap:12px}

  /* Cards más compactas */
  .card{border-radius:20px}
  .card-body{padding:14px 16px}
  .card-body-tight{padding:10px 16px}
  .card-head{padding:12px 16px 10px;gap:9px}
  .card-title{font-size:.8em}

  /* Gallery: 2 columnas fijas */
  .gallery-grid{grid-template-columns:repeat(2,1fr) !important;gap:8px;padding:0 12px 14px !important}
  .gthumb{border-radius:12px}

  /* Info rows más compactos */
  .irow{padding:10px 0;gap:11px}
  .iico{width:30px;height:30px;font-size:.88rem;border-radius:8px}
  .ilabel{font-size:.65em}
  .ival{font-size:.86em}

  /* Chips más tappables */
  .svc-chip,.tag-chip{padding:7px 14px;font-size:.8em}

  /* Descripción */
  .desc-quote{font-size:.91em;line-height:1.75}

  /* Reseñas */
  .star-pick label{font-size:2.4rem}
  .btn-rev{width:100%;padding:13px;border-radius:14px}

  /* Page wrap: espacio para sticky contact bar */
  .page-wrap{padding:14px 12px 0}
}
@media(min-width:768px){
  .quick-bar{display:none} /* en desktop, acciones en el sidebar */
}
</style>
</head>
<body>

<!-- ── TOP NAV ──────────────────────────────────────────────────────────────── -->
<nav class="top-nav">
  <a href="/" class="back">← Mapa</a>
  <span class="nav-center"><?= htmlspecialchars($business['name']) ?></span>
  <div class="nav-actions">
    <button class="nav-icon-btn" onclick="sharePage()" title="Compartir">📤</button>
    <?php if ($isOwnerOrAdmin): ?>
      <a href="/edit?id=<?= $business['id'] ?>" class="nav-edit-btn">✏️ Editar</a>
    <?php endif; ?>
  </div>
</nav>

<!-- ── HERO ──────────────────────────────────────────────────────────────────── -->
<div class="hero">
  <?php if ($ogCoverUrl): ?>
    <img class="hero-cover" src="<?= htmlspecialchars($ogCoverUrl) ?>" alt="<?= htmlspecialchars($business['name']) ?>">
  <?php endif; ?>
  <div class="hero-overlay"></div>
  <div class="hero-body">
    <div class="hero-icon-wrap"><?= $icon ?></div>
    <div class="hero-name"><?= htmlspecialchars($business['name']) ?></div>
    <div class="hero-sub"><?= htmlspecialchars($typeLabel) ?></div>
    <div class="hero-badges">
      <?php
        // ── Calcular si el negocio está abierto ahora (PHP nativo) ───────────
        $openStatus = null;
        if (!empty($comercioData['horario_apertura']) && !empty($comercioData['horario_cierre'])) {
            try {
                $tz  = new DateTimeZone($comercioData['timezone'] ?? 'America/Argentina/Buenos_Aires');
                $now = new DateTime('now', $tz);

                // Verificar días de cierre
                $diasCierreStr = strtolower($comercioData['dias_cierre'] ?? '');
                $diasMap = ['domingo'=>0,'lunes'=>1,'martes'=>2,'miércoles'=>3,'miercoles'=>3,
                            'jueves'=>4,'viernes'=>5,'sábado'=>6,'sabado'=>6];
                $hoy = (int)$now->format('w'); // 0=Dom … 6=Sáb
                $cierraHoy = false;
                foreach ($diasMap as $nombre => $num) {
                    if ($num === $hoy && mb_strpos($diasCierreStr, $nombre) !== false) {
                        $cierraHoy = true; break;
                    }
                }

                if ($cierraHoy) {
                    $openStatus = false;
                } else {
                    $ap = DateTime::createFromFormat('H:i', $comercioData['horario_apertura'], $tz);
                    $ci = DateTime::createFromFormat('H:i', $comercioData['horario_cierre'],   $tz);
                    if ($ap && $ci) {
                        $nowT = $now->format('H:i');
                        $apT  = $ap->format('H:i');
                        $ciT  = $ci->format('H:i');
                        if ($ciT > $apT) {
                            // Rango normal ej: 09:00–18:00
                            $openStatus = ($nowT >= $apT && $nowT <= $ciT);
                        } else {
                            // Nocturno ej: 20:00–02:00
                            $openStatus = ($nowT >= $apT || $nowT <= $ciT);
                        }
                    }
                }
            } catch (Exception $e) {
                $openStatus = null;
            }
        }
        if ($openStatus === true)  echo '<span class="hbadge hbadge-open">🟢 Abierto ahora</span>';
        if ($openStatus === false) echo '<span class="hbadge hbadge-closed">🔴 Cerrado</span>';
      ?>
      <?php if (!empty($business['verified'])): ?>
        <span class="hbadge hbadge-verified">✓ Verificado</span>
      <?php endif; ?>
      <?php if (!empty($business['has_delivery'])): ?>
        <span class="hbadge hbadge-delivery">🚚 Delivery</span>
      <?php endif; ?>
      <?php if (!empty($business['has_card_payment'])): ?>
        <span class="hbadge hbadge-card">💳 Tarjeta</span>
      <?php endif; ?>
      <?php if (!$business['visible']): ?>
        <span class="hbadge hbadge-hidden">👁 Oculto</span>
      <?php endif; ?>
    </div>
  </div>
</div>

<!-- ── STATUS ROW (mobile only) ─────────────────────────────────────────────── -->
<?php if ($openStatus !== null || !empty($business['verified'])): ?>
<div class="mob-status-row">
  <div>
    <?php if ($openStatus === true): ?>
      <span class="mob-status-badge open">🟢 Abierto ahora</span>
    <?php elseif ($openStatus === false): ?>
      <span class="mob-status-badge closed">🔴 Cerrado</span>
    <?php endif; ?>
    <?php if (!empty($business['verified'])): ?>
      <span class="mob-status-badge" style="background:#fffbeb;color:#92400e;margin-left:6px">✓ Verificado</span>
    <?php endif; ?>
  </div>
  <?php if (!empty($comercioData['horario_apertura']) && !empty($comercioData['horario_cierre'])): ?>
    <span class="mob-status-horario">🕒 <?= htmlspecialchars($comercioData['horario_apertura']) ?>–<?= htmlspecialchars($comercioData['horario_cierre']) ?></span>
  <?php endif; ?>
</div>
<?php endif; ?>

<!-- ── INFO STRIP (mobile only) — solo dirección ─────────────────────────── -->
<?php if (!empty($business['address'])): ?>
<div class="info-strip">
  <div class="info-strip-item">
    <span class="info-strip-icon">📍</span>
    <span class="info-strip-text"><?= htmlspecialchars($business['address']) ?><?= !empty($business['location_city']) ? ' · ' . htmlspecialchars($business['location_city']) : '' ?></span>
  </div>
</div>
<?php endif; ?>

<!-- ── QUICK BAR (mobile only) ──────────────────────────────────────────────── -->
<div class="quick-bar">
  <?php if (!empty($business['phone'])): ?>
    <a href="tel:<?= htmlspecialchars($business['phone']) ?>" class="qbtn call">
      <span class="qi">📞</span>Llamar
    </a>
    <a href="https://wa.me/<?= preg_replace('/\D/', '', $business['phone']) ?>" target="_blank" rel="noopener" class="qbtn wa">
      <span class="qi">💬</span>WhatsApp
    </a>
  <?php endif; ?>
  <?php if (!empty($business['website'])): ?>
    <a href="<?= htmlspecialchars($business['website']) ?>" target="_blank" rel="noopener" class="qbtn">
      <span class="qi">🌐</span>Web
    </a>
  <?php endif; ?>
  <?php if ($business['lat'] && $business['lng']): ?>
    <a href="https://www.google.com/maps/dir/?api=1&destination=<?= $business['lat'] ?>,<?= $business['lng'] ?>" target="_blank" rel="noopener" class="qbtn">
      <span class="qi">🗺️</span>Cómo llegar
    </a>
  <?php endif; ?>
  <?php if (!empty($business['instagram'])): ?>
    <?php $igUrl = str_starts_with($business['instagram'], 'http') ? $business['instagram'] : 'https://instagram.com/' . ltrim($business['instagram'], '@'); ?>
    <a href="<?= htmlspecialchars($igUrl) ?>" target="_blank" rel="noopener" class="qbtn">
      <span class="qi">📸</span>Instagram
    </a>
  <?php endif; ?>
  <button onclick="sharePage()" class="qbtn"><span class="qi">📤</span>Compartir</button>
</div>

<!-- ── MAIN CONTENT ──────────────────────────────────────────────────────────── -->
<div class="page-wrap">
  <div class="page-grid">

    <!-- ── LEFT: CONTENT COLUMN ──────────────────────────────────────────────── -->
    <main style="display:flex;flex-direction:column;gap:16px;">

      <!-- Descripción -->
      <?php if (!empty($business['description'])): ?>
      <div class="card">
        <div class="card-head">
          <div class="card-head-icon blue">📝</div>
          <span class="card-title">Sobre este negocio</span>
        </div>
        <div class="card-body">
          <p class="desc-quote"><?= nl2br(htmlspecialchars($business['description'])) ?></p>
        </div>
      </div>
      <?php endif; ?>

      <!-- Galería -->
      <?php if (!empty($galleryPhotos)): ?>
      <div class="card">
        <div class="card-head">
          <div class="card-head-icon amber">📸</div>
          <span class="card-title">Galería — <?= count($galleryPhotos) ?> foto<?= count($galleryPhotos) > 1 ? 's' : '' ?></span>
        </div>
        <div class="gallery-grid" style="padding:12px 16px 16px">
          <?php foreach ($galleryPhotos as $i => $url): ?>
            <div class="gthumb" onclick="openLb(<?= $i ?>)">
              <img src="<?= htmlspecialchars($url) ?>" alt="Foto <?= $i+1 ?>" loading="lazy">
            </div>
          <?php endforeach; ?>
        </div>
      </div>
      <?php endif; ?>

      <!-- Información (visible solo en mobile; en desktop va en sidebar) -->
      <div class="card" id="info-card-mobile" style="display:block">
        <div class="card-head">
          <div class="card-head-icon slate">📋</div>
          <span class="card-title">Información</span>
        </div>
        <div class="card-body">
          <?php if (!empty($business['address'])): ?>
          <div class="irow">
            <div class="iico">📍</div>
            <div class="icont">
              <div class="ilabel">Dirección</div>
              <div class="ival"><?= htmlspecialchars($business['address']) ?>
                <?php if (!empty($business['location_city'])): ?>
                  <span style="color:#9ca3af"> · <?= htmlspecialchars($business['location_city']) ?></span>
                <?php endif; ?>
              </div>
            </div>
          </div>
          <?php endif; ?>
          <?php if (!empty($comercioData['horario_apertura']) && !empty($comercioData['horario_cierre'])): ?>
          <div class="irow">
            <div class="iico">🕒</div>
            <div class="icont">
              <div class="ilabel">Horario de atención</div>
              <div class="ival">
                <?= formatHorarioLocal($comercioData['horario_apertura'], $comercioData['horario_cierre'], $comercioData['timezone'] ?? 'America/Argentina/Buenos_Aires') ?>
                <?php if (!empty($comercioData['dias_cierre'])): ?>
                  <span style="color:#9ca3af;font-size:.88em"> · Cierra: <?= htmlspecialchars($comercioData['dias_cierre']) ?></span>
                <?php endif; ?>
              </div>
            </div>
          </div>
          <?php endif; ?>
          <?php if (!empty($business['phone'])): ?>
          <div class="irow">
            <div class="iico">📞</div>
            <div class="icont">
              <div class="ilabel">Teléfono / WhatsApp</div>
              <div class="ival"><a href="tel:<?= htmlspecialchars($business['phone']) ?>"><?= htmlspecialchars($business['phone']) ?></a></div>
            </div>
          </div>
          <?php endif; ?>
          <?php if (!empty($business['email'])): ?>
          <div class="irow">
            <div class="iico">📧</div>
            <div class="icont">
              <div class="ilabel">Correo electrónico</div>
              <div class="ival"><a href="mailto:<?= htmlspecialchars($business['email']) ?>"><?= htmlspecialchars($business['email']) ?></a></div>
            </div>
          </div>
          <?php endif; ?>
          <?php if (!empty($business['website'])): ?>
          <div class="irow">
            <div class="iico">🌐</div>
            <div class="icont">
              <div class="ilabel">Sitio web</div>
              <div class="ival"><a href="<?= htmlspecialchars($business['website']) ?>" target="_blank" rel="noopener"><?= htmlspecialchars(preg_replace('/^https?:\/\//', '', $business['website'])) ?> ↗</a></div>
            </div>
          </div>
          <?php endif; ?>
          <?php if (!empty($business['price_range'])): ?>
          <div class="irow">
            <div class="iico">💰</div>
            <div class="icont">
              <div class="ilabel">Rango de precio</div>
              <div class="ival"><span class="price-chip"><?= str_repeat('$', intval($business['price_range'])) ?></span></div>
            </div>
          </div>
          <?php endif; ?>
          <?php if (!empty($certDisplay)): ?>
          <div class="irow">
            <div class="iico">🏆</div>
            <div class="icont">
              <div class="ilabel">Premios y certificaciones</div>
              <div class="ival"><?= htmlspecialchars($certDisplay) ?></div>
            </div>
          </div>
          <?php endif; ?>
        </div>
      </div>

      <!-- Servicios -->
      <?php if (!empty($allServices)): ?>
      <div class="card">
        <div class="card-head">
          <div class="card-head-icon green">✅</div>
          <span class="card-title">Servicios y características</span>
        </div>
        <div class="card-body">
          <div class="chips-wrap">
            <?php foreach ($allServices as [$em,$lbl,$cls]): ?>
              <span class="svc-chip <?= $cls ?>"><?= $em ?> <?= htmlspecialchars($lbl) ?></span>
            <?php endforeach; ?>
          </div>
        </div>
      </div>
      <?php endif; ?>

      <!-- Tags -->
      <?php if (!empty($tags)): ?>
      <div class="card">
        <div class="card-head">
          <div class="card-head-icon rose">🏷️</div>
          <span class="card-title">Productos y servicios</span>
        </div>
        <div class="card-body">
          <div class="chips-wrap">
            <?php foreach ($tags as $tag): ?>
              <span class="tag-chip"><?= htmlspecialchars($tag) ?></span>
            <?php endforeach; ?>
          </div>
        </div>
      </div>
      <?php endif; ?>

      <!-- Redes sociales -->
      <?php $hasSocial = !empty($business['instagram']) || !empty($business['facebook']) || !empty($business['tiktok']); ?>
      <?php if ($hasSocial): ?>
      <div class="card">
        <div class="card-head">
          <div class="card-head-icon purple">📲</div>
          <span class="card-title">Redes sociales</span>
        </div>
        <div class="card-body">
          <div class="social-list">
            <?php if (!empty($business['instagram'])): ?>
              <?php $igUrl = str_starts_with($business['instagram'], 'http') ? $business['instagram'] : 'https://instagram.com/' . ltrim($business['instagram'], '@'); ?>
              <a href="<?= htmlspecialchars($igUrl) ?>" target="_blank" rel="noopener" class="soc-btn soc-ig">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="white"><path d="M12 2.163c3.204 0 3.584.012 4.85.07 3.252.148 4.771 1.691 4.919 4.919.058 1.265.069 1.645.069 4.849 0 3.205-.012 3.584-.069 4.849-.149 3.225-1.664 4.771-4.919 4.919-1.266.058-1.644.07-4.85.07-3.204 0-3.584-.012-4.849-.07-3.26-.149-4.771-1.699-4.919-4.92-.058-1.265-.07-1.644-.07-4.849 0-3.204.013-3.583.07-4.849.149-3.227 1.664-4.771 4.919-4.919 1.266-.057 1.645-.069 4.849-.069zm0-2.163c-3.259 0-3.667.014-4.947.072-4.358.2-6.78 2.618-6.98 6.98-.059 1.281-.073 1.689-.073 4.948 0 3.259.014 3.668.072 4.948.2 4.358 2.618 6.78 6.98 6.98 1.281.058 1.689.072 4.948.072 3.259 0 3.668-.014 4.948-.072 4.354-.2 6.782-2.618 6.979-6.98.059-1.28.073-1.689.073-4.948 0-3.259-.014-3.667-.072-4.947-.196-4.354-2.617-6.78-6.979-6.98-1.281-.059-1.69-.073-4.949-.073zm0 5.838c-3.403 0-6.162 2.759-6.162 6.162s2.759 6.163 6.162 6.163 6.162-2.759 6.162-6.163c0-3.403-2.759-6.162-6.162-6.162zm0 10.162c-2.209 0-4-1.79-4-4 0-2.209 1.791-4 4-4s4 1.791 4 4c0 2.21-1.791 4-4 4zm6.406-11.845c-.796 0-1.441.645-1.441 1.44s.645 1.44 1.441 1.44c.795 0 1.439-.645 1.439-1.44s-.644-1.44-1.439-1.44z"/></svg>
                @<?= htmlspecialchars(ltrim($business['instagram'], '@')) ?>
              </a>
            <?php endif; ?>
            <?php if (!empty($business['facebook'])): ?>
              <?php $fbUrl = str_starts_with($business['facebook'], 'http') ? $business['facebook'] : 'https://facebook.com/' . $business['facebook']; ?>
              <a href="<?= htmlspecialchars($fbUrl) ?>" target="_blank" rel="noopener" class="soc-btn soc-fb">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="white"><path d="M24 12.073c0-6.627-5.373-12-12-12s-12 5.373-12 12c0 5.99 4.388 10.954 10.125 11.854v-8.385H7.078v-3.47h3.047V9.43c0-3.007 1.792-4.669 4.533-4.669 1.312 0 2.686.235 2.686.235v2.953H15.83c-1.491 0-1.956.925-1.956 1.874v2.25h3.328l-.532 3.47h-2.796v8.385C19.612 23.027 24 18.062 24 12.073z"/></svg>
                <?= htmlspecialchars($business['facebook']) ?>
              </a>
            <?php endif; ?>
            <?php if (!empty($business['tiktok'])): ?>
              <?php $ttUrl = str_starts_with($business['tiktok'], 'http') ? $business['tiktok'] : 'https://tiktok.com/@' . ltrim($business['tiktok'], '@'); ?>
              <a href="<?= htmlspecialchars($ttUrl) ?>" target="_blank" rel="noopener" class="soc-btn soc-tt">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="white"><path d="M12.53.02C13.84 0 15.14.01 16.44 0c.08 1.53.63 3.09 1.75 4.17 1.12 1.11 2.7 1.62 4.24 1.79v4.03c-1.44-.05-2.89-.35-4.2-.97-.57-.26-1.1-.59-1.62-.93-.01 2.92.01 5.84-.02 8.75-.08 1.4-.54 2.79-1.35 3.94-1.31 1.92-3.58 3.17-5.91 3.21-1.43.08-2.86-.31-4.08-1.03-2.02-1.19-3.44-3.37-3.65-5.71-.02-.5-.03-1-.01-1.49.18-1.9 1.12-3.72 2.58-4.96 1.66-1.44 3.98-2.13 6.15-1.72.02 1.48-.04 2.96-.04 4.44-.99-.32-2.15-.23-3.02.37-.63.41-1.11 1.04-1.36 1.75-.21.51-.15 1.07-.14 1.61.24 1.64 1.82 3.02 3.5 2.87 1.12-.01 2.19-.66 2.77-1.61.19-.33.4-.67.41-1.06.1-1.79.06-3.57.07-5.36.01-4.03-.01-8.05.02-12.07z"/></svg>
                @<?= htmlspecialchars(ltrim($business['tiktok'], '@')) ?>
              </a>
            <?php endif; ?>
          </div>
        </div>
      </div>
      <?php endif; ?>

      <!-- Mapa -->
      <?php if ($business['lat'] && $business['lng']): ?>
      <div class="card" style="overflow:hidden">
        <div class="card-head">
          <div class="card-head-icon blue">📍</div>
          <span class="card-title">Ubicación</span>
        </div>
        <div id="map-mini"></div>
        <div class="map-footer">
          <span>📍</span>
          <span><?= htmlspecialchars($business['address'] ?: 'Ver en el mapa') ?></span>
          <a href="https://www.google.com/maps/dir/?api=1&destination=<?= $business['lat'] ?>,<?= $business['lng'] ?>" target="_blank" rel="noopener">
            Cómo llegar →
          </a>
        </div>
      </div>
      <?php endif; ?>

      <!-- Reseñas (dark) -->
      <div class="reviews-dark" id="reviews-section">
        <div class="card-head">
          <div class="card-head-icon slate" style="background:rgba(255,255,255,.08)">⭐</div>
          <span class="card-title">Reseñas de clientes</span>
        </div>
        <div id="rat-summary" class="rat-summary" style="display:none">
          <div class="rat-score" id="avg-score">—</div>
          <div>
            <div class="rat-stars" id="avg-stars"></div>
            <div class="rat-count" id="avg-count"></div>
          </div>
        </div>
        <div id="reviews-list"></div>
        <?php if (isset($_SESSION['user_id'])): ?>
        <div class="rev-form">
          <span class="rev-form-label">Tu calificación</span>
          <div class="star-pick">
            <input type="radio" name="star" id="s5" value="5"><label for="s5" title="Excelente">★</label>
            <input type="radio" name="star" id="s4" value="4"><label for="s4" title="Muy bueno">★</label>
            <input type="radio" name="star" id="s3" value="3" checked><label for="s3" title="Regular">★</label>
            <input type="radio" name="star" id="s2" value="2"><label for="s2" title="Malo">★</label>
            <input type="radio" name="star" id="s1" value="1"><label for="s1" title="Muy malo">★</label>
          </div>
          <textarea class="rev-txt" id="review-comment" rows="3" placeholder="Contá tu experiencia (opcional)..."></textarea>
          <button class="btn-rev" id="btn-review">Publicar reseña</button>
          <div id="review-msg" style="margin-top:8px;font-size:.84em;font-weight:600"></div>
        </div>
        <?php else: ?>
        <div style="padding:16px 22px;font-size:.86em;color:#64748b">
          <a href="/login" style="color:#60a5fa;font-weight:700">Iniciá sesión</a> para dejar una reseña.
        </div>
        <?php endif; ?>
      </div>

    </main><!-- /col-content -->

    <!-- ── RIGHT: SIDEBAR ─────────────────────────────────────────────────────── -->
    <aside class="col-sidebar">

      <!-- CTAs de contacto (desktop) -->
      <div class="sidebar-cta">
        <?php if (!empty($business['phone'])): ?>
          <a href="tel:<?= htmlspecialchars($business['phone']) ?>" class="cta-primary cta-call">
            <span class="cta-icon">📞</span> Llamar ahora
          </a>
          <a href="https://wa.me/<?= preg_replace('/\D/', '', $business['phone']) ?>" target="_blank" rel="noopener" class="cta-primary cta-wa">
            <span class="cta-icon">💬</span> WhatsApp
          </a>
        <?php endif; ?>
        <?php if ($business['lat'] && $business['lng']): ?>
          <a href="https://www.google.com/maps/dir/?api=1&destination=<?= $business['lat'] ?>,<?= $business['lng'] ?>" target="_blank" rel="noopener" class="cta-primary cta-directions">
            <span class="cta-icon">🗺️</span> Cómo llegar
          </a>
        <?php endif; ?>
        <?php if (!empty($business['website'])): ?>
          <a href="<?= htmlspecialchars($business['website']) ?>" target="_blank" rel="noopener" class="cta-primary cta-web">
            <span class="cta-icon">🌐</span> Visitar sitio web
          </a>
        <?php endif; ?>
      </div>

      <!-- Detalles técnicos -->
      <div class="card">
        <div class="card-head">
          <div class="card-head-icon slate">📋</div>
          <span class="card-title">Detalles</span>
        </div>
        <div class="card-body" style="padding:14px 18px">
          <?php if (!empty($business['address'])): ?>
          <div class="stat-row">
            <div class="stat-icon">📍</div>
            <div class="stat-info">
              <div class="stat-label">Dirección</div>
              <div class="stat-val"><?= htmlspecialchars($business['address']) ?></div>
            </div>
          </div>
          <?php endif; ?>
          <?php if (!empty($comercioData['horario_apertura']) && !empty($comercioData['horario_cierre'])): ?>
          <div class="stat-row">
            <div class="stat-icon">🕒</div>
            <div class="stat-info">
              <div class="stat-label">Horario</div>
              <div class="stat-val"><?= formatHorarioLocal($comercioData['horario_apertura'], $comercioData['horario_cierre'], $comercioData['timezone'] ?? 'America/Argentina/Buenos_Aires') ?>
                <?php if (!empty($comercioData['dias_cierre'])): ?>
                  <span style="color:#9ca3af;font-size:.9em"> · Cierra: <?= htmlspecialchars($comercioData['dias_cierre']) ?></span>
                <?php endif; ?>
              </div>
            </div>
          </div>
          <?php endif; ?>
          <?php if (!empty($business['phone'])): ?>
          <div class="stat-row">
            <div class="stat-icon">📞</div>
            <div class="stat-info">
              <div class="stat-label">Teléfono</div>
              <div class="stat-val"><a href="tel:<?= htmlspecialchars($business['phone']) ?>"><?= htmlspecialchars($business['phone']) ?></a></div>
            </div>
          </div>
          <?php endif; ?>
          <?php if (!empty($business['email'])): ?>
          <div class="stat-row">
            <div class="stat-icon">📧</div>
            <div class="stat-info">
              <div class="stat-label">Email</div>
              <div class="stat-val"><a href="mailto:<?= htmlspecialchars($business['email']) ?>"><?= htmlspecialchars($business['email']) ?></a></div>
            </div>
          </div>
          <?php endif; ?>
          <?php if (!empty($business['website'])): ?>
          <div class="stat-row">
            <div class="stat-icon">🌐</div>
            <div class="stat-info">
              <div class="stat-label">Sitio web</div>
              <div class="stat-val"><a href="<?= htmlspecialchars($business['website']) ?>" target="_blank" rel="noopener"><?= htmlspecialchars(preg_replace('/^https?:\/\//', '', $business['website'])) ?></a></div>
            </div>
          </div>
          <?php endif; ?>
          <?php if (!empty($business['price_range'])): ?>
          <div class="stat-row">
            <div class="stat-icon">💰</div>
            <div class="stat-info">
              <div class="stat-label">Rango de precio</div>
              <div class="stat-val"><span class="price-chip"><?= str_repeat('$', intval($business['price_range'])) ?></span></div>
            </div>
          </div>
          <?php endif; ?>
          <?php if (!empty($certDisplay)): ?>
          <div class="stat-row">
            <div class="stat-icon">🏆</div>
            <div class="stat-info">
              <div class="stat-label">Certificaciones</div>
              <div class="stat-val"><?= htmlspecialchars($certDisplay) ?></div>
            </div>
          </div>
          <?php endif; ?>
        </div>
      </div>

      <!-- Características (sidebar) -->
      <?php if (!empty($allServices) || !empty($tags)): ?>
      <div class="card">
        <div class="card-head">
          <div class="card-head-icon green">✨</div>
          <span class="card-title">Características</span>
        </div>
        <div class="card-body">
          <?php if (!empty($allServices)): ?>
          <div class="chips-wrap" style="margin-bottom:<?= !empty($tags) ? '12px' : '0' ?>">
            <?php foreach ($allServices as [$em,$lbl,$cls]): ?>
              <span class="svc-chip <?= $cls ?>"><?= $em ?> <?= htmlspecialchars($lbl) ?></span>
            <?php endforeach; ?>
          </div>
          <?php endif; ?>
          <?php if (!empty($tags)): ?>
          <div class="chips-wrap">
            <?php foreach ($tags as $tag): ?>
              <span class="tag-chip"><?= htmlspecialchars($tag) ?></span>
            <?php endforeach; ?>
          </div>
          <?php endif; ?>
        </div>
      </div>
      <?php endif; ?>

      <!-- Compartir -->
      <div class="card">
        <div class="card-head">
          <div class="card-head-icon slate">📤</div>
          <span class="card-title">Compartir</span>
        </div>
        <div class="card-body" style="display:flex;gap:8px;flex-wrap:wrap">
          <button onclick="sharePage()" class="cta-primary cta-web" style="flex:1;min-width:140px;padding:11px 16px;font-size:.8em">
            <span>📤</span> Compartir negocio
          </button>
          <a href="/" class="cta-primary cta-web" style="flex:1;min-width:140px;padding:11px 16px;font-size:.8em">
            <span>🗺️</span> Ver en el mapa
          </a>
        </div>
      </div>

    </aside><!-- /col-sidebar -->
  </div><!-- /page-grid -->
</div><!-- /page-wrap -->

<!-- ── FLOATING FOOTER (owner/admin) ──────────────────────────────────────── -->
<?php if ($isOwnerOrAdmin): ?>
<div class="floating-footer">
  <div class="floating-footer-inner">
    <a href="/edit?id=<?= $business['id'] ?>" class="ff-btn ff-edit">✏️ Editar negocio</a>
    <a href="/" class="ff-btn ff-icon" title="Ver en el mapa">🗺️</a>
    <button onclick="sharePage()" class="ff-btn ff-icon" title="Compartir">📤</button>
  </div>
</div>
<?php endif; ?>

<!-- ── LIGHTBOX ──────────────────────────────────────────────────────────────── -->
<div class="lb" id="lb" onclick="handleLbClick(event)">
  <span class="lb-close" onclick="closeLb()">✕</span>
  <?php if (count($galleryPhotos) > 1): ?>
    <button class="lb-prev" onclick="navLb(-1);event.stopPropagation()">‹</button>
    <button class="lb-next" onclick="navLb(1);event.stopPropagation()">›</button>
  <?php endif; ?>
  <img id="lb-img" src="" alt="">
</div>

<!-- ── STICKY CONTACT BAR (mobile, solo si tiene teléfono y no es admin) ──── -->
<?php if (!$isOwnerOrAdmin && !empty($business['phone'])): ?>
<div class="sticky-contact" id="sticky-contact">
  <a href="tel:<?= htmlspecialchars($business['phone']) ?>" class="sticky-btn sticky-call">
    <span>📞</span> Llamar ahora
  </a>
  <a href="https://wa.me/<?= preg_replace('/\D/', '', $business['phone']) ?>" target="_blank" rel="noopener" class="sticky-btn sticky-wa">
    <span>💬</span> WhatsApp
  </a>
</div>
<?php endif; ?>

<!-- ── SCRIPTS ────────────────────────────────────────────────────────────────── -->
<?php if ($business['lat'] && $business['lng']): ?>
<script>
(function(){
  var lat=<?= (float)$business['lat'] ?>,lng=<?= (float)$business['lng'] ?>;
  var map=L.map('map-mini',{zoomControl:true,dragging:true,scrollWheelZoom:false,doubleClickZoom:true}).setView([lat,lng],16);
  L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',{
    attribution:'© <a href="https://www.openstreetmap.org/copyright">OSM</a>'
  }).addTo(map);
  var icon=L.divIcon({
    html:'<div style="background:<?= $colors[0] ?>;color:#fff;width:44px;height:44px;border-radius:50%;display:flex;align-items:center;justify-content:center;font-size:22px;box-shadow:0 4px 14px rgba(0,0,0,.35);border:3px solid #fff;"><?= $icon ?></div>',
    className:'',iconSize:[44,44],iconAnchor:[22,22]
  });
  L.marker([lat,lng],{icon}).addTo(map)
   .bindPopup('<strong style="font-size:14px"><?= addslashes(htmlspecialchars($business['name'])) ?></strong>')
   .openPopup();
})();
</script>
<?php endif; ?>

<script>
var businessId=<?= (int)$business['id'] ?>;
var galleryUrls=<?= json_encode(array_values($galleryPhotos)) ?>;
var currentLbIdx=0;

// ── Reviews ──────────────────────────────────────────────────────────────────
function loadReviews(){
  fetch('/api/reviews.php?business_id='+businessId)
  .then(r=>r.json()).then(res=>{
    if(!res.success)return;
    const avg=res.data.average, list=res.data.reviews||[];
    if(avg&&avg.total>0){
      document.getElementById('rat-summary').style.display='flex';
      document.getElementById('avg-score').textContent=parseFloat(avg.avg).toFixed(1);
      document.getElementById('avg-stars').textContent='⭐'.repeat(Math.round(avg.avg));
      document.getElementById('avg-count').textContent=avg.total+' reseña'+(avg.total>1?'s':'');
    }
    const c=document.getElementById('reviews-list');
    if(!list.length){
      c.innerHTML='<div class="no-reviews">Sin reseñas aún. ¡Sé el primero en opinar!</div>';
      return;
    }
    c.innerHTML='';
    list.forEach(r=>{
      const d=document.createElement('div');
      d.className='review-item';
      d.innerHTML=`<span class="rev-author">${r.username}</span><span class="rev-stars">${'⭐'.repeat(r.rating)}</span>`
        +(r.comment?`<p class="rev-text">"${r.comment}"</p>`:'')
        +`<div class="rev-date">${r.created_at}</div>`;
      c.appendChild(d);
    });
  }).catch(console.error);
}
loadReviews();

<?php if (isset($_SESSION['user_id'])): ?>
document.getElementById('btn-review').addEventListener('click',function(){
  const rating=document.querySelector('input[name="star"]:checked')?.value||3;
  const comment=document.getElementById('review-comment').value;
  const msg=document.getElementById('review-msg');
  this.disabled=true;
  fetch('/api/reviews.php',{
    method:'POST',
    headers:{'Content-Type':'application/json'},
    body:JSON.stringify({business_id:businessId,rating,comment})
  }).then(r=>r.json()).then(res=>{
    msg.style.color=res.success?'#4ade80':'#f87171';
    msg.textContent=res.message;
    if(res.success){loadReviews();document.getElementById('review-comment').value='';}
    this.disabled=false;
  }).catch(()=>{msg.style.color='#f87171';msg.textContent='Error al enviar.';this.disabled=false;});
});
<?php endif; ?>

// ── Lightbox ──────────────────────────────────────────────────────────────────
function openLb(i){
  currentLbIdx=i;
  document.getElementById('lb-img').src=galleryUrls[i];
  document.getElementById('lb').classList.add('open');
  document.body.style.overflow='hidden';
}
function closeLb(){
  document.getElementById('lb').classList.remove('open');
  document.body.style.overflow='';
}
function navLb(dir){
  currentLbIdx=(currentLbIdx+dir+galleryUrls.length)%galleryUrls.length;
  document.getElementById('lb-img').src=galleryUrls[currentLbIdx];
}
function handleLbClick(e){if(e.target===document.getElementById('lb'))closeLb();}
document.addEventListener('keydown',e=>{
  if(!document.getElementById('lb').classList.contains('open'))return;
  if(e.key==='Escape')closeLb();
  if(e.key==='ArrowLeft')navLb(-1);
  if(e.key==='ArrowRight')navLb(1);
});
// Swipe táctil en lightbox
(function(){
  var lb=document.getElementById('lb');
  var tx=0;
  lb.addEventListener('touchstart',function(e){tx=e.touches[0].clientX},{passive:true});
  lb.addEventListener('touchend',function(e){
    var dx=e.changedTouches[0].clientX-tx;
    if(Math.abs(dx)>50&&galleryUrls.length>1){navLb(dx<0?1:-1);}
  },{passive:true});
})();

// ── Share ─────────────────────────────────────────────────────────────────────
function sharePage(){
  if(navigator.share){
    navigator.share({
      title:'<?= addslashes(htmlspecialchars($business['name'])) ?> en Mapita',
      text:'Mirá este negocio en Mapita',
      url:window.location.href
    }).catch(()=>{});
  }else{
    navigator.clipboard?.writeText(window.location.href).then(()=>{
      alert('¡Enlace copiado al portapapeles!');
    });
  }
}

// ── Ocultar card info en desktop (la info está en el sidebar) ─────────────────
(function(){
  var mq=window.matchMedia('(min-width:768px)');
  function toggle(m){
    var el=document.getElementById('info-card-mobile');
    if(el) el.style.display=m.matches?'none':'block';
  }
  toggle(mq);
  mq.addEventListener('change',toggle);
})();
</script>
</body>
</html>

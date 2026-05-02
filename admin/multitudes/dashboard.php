<?php
/**
 * Panel de administración MULTITUDES
 * Gestión de puntos multi-link geolocalizados (ej: Festival de Viña, partidos de fútbol).
 */
session_start();
ini_set('display_errors', 0);
error_reporting(0);

require_once __DIR__ . '/../../core/helpers.php';
require_once __DIR__ . '/../../includes/db_helper.php';
require_once __DIR__ . '/../../models/Multitud.php';

setSecurityHeaders();

if (!isset($_SESSION['user_id']) || empty($_SESSION['is_admin'])) {
    header('Location: ../../auth/login.php');
    exit();
}

use App\Models\Multitud;

$db          = getDbConnection();
$message     = '';
$messageType = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    verifyCsrfToken();
    $action = $_POST['action'] ?? '';

    // ── Multitudes ─────────────────────────────────────────────────────────
    if ($action === 'create') {
        $nombre = trim($_POST['nombre'] ?? '');
        if (!$nombre) {
            $message = 'El nombre es requerido.'; $messageType = 'error';
        } elseif (Multitud::create([
            'nombre'      => $nombre,
            'descripcion' => $_POST['descripcion'] ?? null,
            'lat'         => $_POST['lat'] ?? '',
            'lng'         => $_POST['lng'] ?? '',
            'activo'      => isset($_POST['activo']) ? 1 : 0,
        ])) {
            $message = 'Multitud creada correctamente.'; $messageType = 'success';
        } else {
            $message = 'Error al crear la multitud.'; $messageType = 'error';
        }
    }

    if ($action === 'delete' && !empty($_POST['id'])) {
        Multitud::delete((int)$_POST['id']);
        $message = 'Multitud eliminada.'; $messageType = 'success';
    }

    if ($action === 'toggle' && !empty($_POST['id'])) {
        $id  = (int)$_POST['id'];
        $row = Multitud::getById($id);
        if ($row) {
            $row['activo'] ? Multitud::deactivate($id) : Multitud::activate($id);
            $message = $row['activo'] ? 'Multitud desactivada.' : 'Multitud activada.';
            $messageType = 'success';
        }
    }

    // ── Items ──────────────────────────────────────────────────────────────
    if ($action === 'create_item') {
        $mid    = (int)($_POST['multitud_id'] ?? 0);
        $titulo = trim($_POST['titulo'] ?? '');
        $url    = trim($_POST['stream_url'] ?? '');
        if (!$mid || !$titulo || !$url) {
            $message = 'Multitud, título y URL son requeridos.'; $messageType = 'error';
        } elseif (Multitud::createItem([
            'multitud_id'       => $mid,
            'titulo'            => $titulo,
            'descripcion_corta' => $_POST['descripcion_corta'] ?? null,
            'stream_url'        => $url,
            'grupo_artista'     => $_POST['grupo_artista'] ?? null,
            'fecha_periodo'     => $_POST['fecha_periodo'] ?? null,
            'orden'             => (int)($_POST['orden'] ?? 0),
            'activo'            => 1,
        ])) {
            $message = 'Ítem agregado.'; $messageType = 'success';
        } else {
            $message = 'Error al agregar ítem.'; $messageType = 'error';
        }
    }

    if ($action === 'delete_item' && !empty($_POST['item_id'])) {
        Multitud::deleteItem((int)$_POST['item_id']);
        $message = 'Ítem eliminado.'; $messageType = 'success';
    }
}

$multitudes = Multitud::getAll();
$stats      = Multitud::getStats();

// Ítem de multitud seleccionado para gestionar
$selectedId    = (int)($_GET['m'] ?? 0);
$selectedMulti = null;
$selectedItems = [];
if ($selectedId > 0) {
    $selectedMulti = Multitud::getById($selectedId);
    if ($selectedMulti) {
        $selectedItems = Multitud::getAllItems($selectedId);
    }
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Panel MULTITUDES - Mapita</title>
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
    <style>
        * { box-sizing: border-box; }
        body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif; margin: 0; background: #f5f6fa; }

        header { background: linear-gradient(135deg, #4f46e5 0%, #3730a3 100%); color: white; padding: 20px 30px; display: flex; justify-content: space-between; align-items: center; box-shadow: 0 4px 12px rgba(0,0,0,.1); }
        header h1 { margin: 0; font-size: 1.5em; }
        header a  { color: rgba(255,255,255,.8); text-decoration: none; font-size: .9em; }
        header a:hover { color: white; }

        .container { max-width: 1200px; margin: 30px auto; padding: 0 20px; }

        .stats { display: grid; grid-template-columns: repeat(auto-fit, minmax(150px, 1fr)); gap: 20px; margin-bottom: 30px; }
        .stat-card { background: white; padding: 22px; border-radius: 12px; box-shadow: 0 2px 8px rgba(0,0,0,.08); border-left: 4px solid #4f46e5; }
        .stat-card .number { font-size: 2.3em; font-weight: bold; color: #4f46e5; }
        .stat-card .label  { color: #666; font-size: .88em; margin-top: 8px; }

        .section { background: white; border-radius: 12px; box-shadow: 0 2px 8px rgba(0,0,0,.08); margin-bottom: 30px; overflow: hidden; }
        .section-header { background: linear-gradient(135deg, #4f46e5 0%, #3730a3 100%); color: white; padding: 20px; font-size: 1.1em; font-weight: 600; }

        .form-group { margin-bottom: 16px; }
        .form-group label { display: block; margin-bottom: 5px; font-weight: 600; color: #333; font-size: .9em; }
        .form-group input, .form-group textarea, .form-group select { width: 100%; padding: 9px 10px; border: 1px solid #e0e0e0; border-radius: 6px; font-family: inherit; font-size: .9em; }
        .form-group textarea { resize: vertical; min-height: 70px; }

        .form-grid { padding: 22px; display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }
        .form-full  { grid-column: 1/-1; }
        .geo-row    { display: grid; grid-template-columns: 1fr 1fr; gap: 10px; }
        #mini-map   { height: 180px; border-radius: 8px; border: 2px solid #e0e0e0; margin-top: 8px; }

        table { width: 100%; border-collapse: collapse; }
        th, td { padding: 11px 14px; text-align: left; border-bottom: 1px solid #f0f0f0; font-size: .85em; }
        th { background: #f8f9fa; font-weight: 600; color: #333; }
        tr:hover { background: #fafbfc; }

        .badge { display: inline-block; padding: 3px 9px; border-radius: 20px; font-size: .78em; font-weight: 600; }
        .badge-active   { background: #d4edda; color: #155724; }
        .badge-inactive { background: #f0f0f0; color: #666; }

        .btn { padding: 7px 12px; border: none; border-radius: 6px; cursor: pointer; font-size: .83em; font-weight: 600; transition: all .2s; }
        .btn-primary  { background: linear-gradient(135deg, #4f46e5 0%, #3730a3 100%); color: white; }
        .btn-primary:hover { opacity: .88; transform: translateY(-1px); }
        .btn-danger   { background: #e74c3c; color: white; }
        .btn-danger:hover { background: #c0392b; }
        .btn-secondary { background: #6c757d; color: white; }
        .btn-secondary:hover { background: #5a6268; }
        .btn-sm { padding: 5px 9px; font-size: .78em; }
        .inline-form { display: inline; }

        .message { padding: 14px 20px; margin-bottom: 20px; border-radius: 6px; }
        .success { background: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .error   { background: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }

        .item-row { background: white; border: 1px solid #e5e7eb; border-radius: 8px; padding: 12px 14px; margin-bottom: 8px; display: flex; justify-content: space-between; align-items: flex-start; gap: 12px; }
        .item-row .item-info { flex: 1; min-width: 0; }
        .item-row .item-title { font-weight: 700; font-size: .92em; color: #1e1b4b; margin-bottom: 3px; }
        .item-row .item-meta  { font-size: .78em; color: #6b7280; display: flex; flex-wrap: wrap; gap: 8px; }
        .item-row .item-url   { font-size: .75em; color: #4f46e5; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; max-width: 280px; }

        @media (max-width: 768px) {
            .form-grid { grid-template-columns: 1fr; }
            th, td { padding: 8px; font-size: .78em; }
            .item-row { flex-direction: column; }
        }
    </style>
</head>
<body>

<header>
    <h1>👥 Panel MULTITUDES</h1>
    <div>
        <span style="margin-right:20px;">Usuario: <?php echo htmlspecialchars($_SESSION['user_name']); ?></span>
        <a href="/">🗺️ Mapa</a> |
        <a href="/admin/dashboard.php">🛡️ Admin</a> |
        <a href="/admin/index.php">📋 Panel</a> |
        <a href="/logout">🚪 Salir</a>
    </div>
</header>

<div class="container">
    <?php if ($message): ?>
        <div class="message <?php echo $messageType; ?>"><?php echo htmlspecialchars($message); ?></div>
    <?php endif; ?>

    <!-- Estadísticas -->
    <div class="stats">
        <div class="stat-card">
            <div class="number"><?php echo $stats['total']; ?></div>
            <div class="label">Total Multitudes</div>
        </div>
        <div class="stat-card">
            <div class="number"><?php echo $stats['activas']; ?></div>
            <div class="label">Activas</div>
        </div>
        <div class="stat-card">
            <div class="number"><?php echo $stats['total_items']; ?></div>
            <div class="label">Ítems totales</div>
        </div>
        <div class="stat-card">
            <div class="number"><?php echo $stats['inactivas']; ?></div>
            <div class="label">Inactivas</div>
        </div>
    </div>

    <!-- ── Gestionar ítems de multitud seleccionada ───────────────────────── -->
    <?php if ($selectedMulti): ?>
    <div class="section">
        <div class="section-header">
            📌 Ítems de: <?php echo htmlspecialchars($selectedMulti['nombre']); ?>
            <a href="/admin/multitudes/dashboard.php" style="float:right;color:rgba(255,255,255,.75);font-size:.82em;font-weight:400;">← Volver a la lista</a>
        </div>
        <div style="padding:22px;">
            <!-- Formulario agregar ítem -->
            <form method="post" style="background:#f8f7ff;border:1px solid #ddd6fe;border-radius:10px;padding:18px;margin-bottom:20px;">
                <?php echo csrfField(); ?>
                <input type="hidden" name="action" value="create_item">
                <input type="hidden" name="multitud_id" value="<?php echo $selectedId; ?>">
                <h4 style="margin:0 0 14px;color:#4f46e5;font-size:.95em;">➕ Agregar nuevo ítem</h4>
                <div style="display:grid;grid-template-columns:1fr 1fr;gap:14px;">
                    <div class="form-group" style="margin:0;">
                        <label>Título * <small style="color:#888;">(ej: Boca 3 - River 1)</small></label>
                        <input type="text" name="titulo" required placeholder="Título del ítem">
                    </div>
                    <div class="form-group" style="margin:0;">
                        <label>Grupo / Artista <small style="color:#888;">(ej: Soda Stereo)</small></label>
                        <input type="text" name="grupo_artista" placeholder="Nombre del grupo o artista">
                    </div>
                    <div class="form-group" style="margin:0;">
                        <label>URL del link / stream *</label>
                        <input type="url" name="stream_url" required placeholder="https://youtu.be/... o https://...">
                    </div>
                    <div class="form-group" style="margin:0;">
                        <label>Fecha / Período</label>
                        <input type="date" name="fecha_periodo">
                    </div>
                    <div class="form-group" style="margin:0;">
                        <label>Descripción corta <small style="color:#888;">(una línea)</small></label>
                        <input type="text" name="descripcion_corta" placeholder="Ej: Goles: Cavani x2, Borja" maxlength="255">
                    </div>
                    <div class="form-group" style="margin:0;">
                        <label>Orden <small style="color:#888;">(0 = primero)</small></label>
                        <input type="number" name="orden" value="0" min="0">
                    </div>
                </div>
                <button type="submit" class="btn btn-primary" style="margin-top:14px;">➕ Agregar Ítem</button>
            </form>

            <!-- Lista de ítems -->
            <?php if (empty($selectedItems)): ?>
                <p style="color:#999;text-align:center;padding:20px;">Esta multitud no tiene ítems aún.</p>
            <?php else: ?>
                <?php foreach ($selectedItems as $item): ?>
                <div class="item-row">
                    <div class="item-info">
                        <div class="item-title"><?php echo htmlspecialchars($item['titulo']); ?></div>
                        <div class="item-meta">
                            <?php if ($item['grupo_artista']): ?>
                                <span>👤 <?php echo htmlspecialchars($item['grupo_artista']); ?></span>
                            <?php endif; ?>
                            <?php if ($item['fecha_periodo']): ?>
                                <span>📅 <?php echo htmlspecialchars($item['fecha_periodo']); ?></span>
                            <?php endif; ?>
                            <?php if ($item['descripcion_corta']): ?>
                                <span>📝 <?php echo htmlspecialchars($item['descripcion_corta']); ?></span>
                            <?php endif; ?>
                            <span style="color:#d1d5db;">Orden: <?php echo (int)$item['orden']; ?></span>
                        </div>
                        <div class="item-url">
                            <a href="<?php echo htmlspecialchars($item['stream_url']); ?>" target="_blank" rel="noopener">
                                🔗 <?php echo htmlspecialchars($item['stream_url']); ?>
                            </a>
                        </div>
                    </div>
                    <form method="post" class="inline-form" onsubmit="return confirm('¿Eliminar este ítem?')">
                        <?php echo csrfField(); ?>
                        <input type="hidden" name="action"  value="delete_item">
                        <input type="hidden" name="item_id" value="<?php echo $item['id']; ?>">
                        <button type="submit" class="btn btn-danger btn-sm">🗑️</button>
                    </form>
                </div>
                <?php endforeach; ?>
            <?php endif; ?>
        </div>
    </div>
    <?php endif; ?>

    <!-- ── Crear Multitud ──────────────────────────────────────────────────── -->
    <div class="section">
        <div class="section-header">➕ Crear Nueva Multitud</div>
        <form method="post" class="form-grid" id="form-create">
            <?php echo csrfField(); ?>
            <input type="hidden" name="action" value="create">
            <div>
                <div class="form-group">
                    <label>Nombre * <small style="color:#c7c0ff;">(ej: Festival de Viña del Mar)</small></label>
                    <input type="text" name="nombre" required placeholder="Nombre del punto MULTITUDES">
                </div>
                <div class="form-group">
                    <label>Descripción <small style="color:#c7c0ff;">(opcional)</small></label>
                    <textarea name="descripcion" placeholder="Descripción general..."></textarea>
                </div>
                <div class="form-group" style="display:flex;align-items:center;gap:8px;">
                    <label style="display:flex;align-items:center;gap:6px;cursor:pointer;font-weight:600;margin:0;">
                        <input type="checkbox" name="activo" checked style="width:auto;"> Activa
                    </label>
                </div>
            </div>
            <div>
                <div class="form-group">
                    <label>📍 Ubicación (click en el mapa)</label>
                    <div class="geo-row">
                        <input type="number" name="lat" id="input-lat" step="any" placeholder="Latitud" readonly style="background:#f8f9fa;">
                        <input type="number" name="lng" id="input-lng" step="any" placeholder="Longitud" readonly style="background:#f8f9fa;">
                    </div>
                    <div id="mini-map"></div>
                    <p style="font-size:11px;color:#888;margin-top:5px;">Hacé click en el mapa para fijar la ubicación geográfica.</p>
                </div>
            </div>
            <div class="form-full">
                <button type="submit" class="btn btn-primary" style="width:100%;padding:13px;font-size:.95em;">👥 Crear Multitud</button>
            </div>
        </form>
    </div>

    <!-- ── Listado ──────────────────────────────────────────────────────────── -->
    <div class="section">
        <div class="section-header">📋 Multitudes (<?php echo count($multitudes); ?>)</div>
        <?php if (empty($multitudes)): ?>
            <div style="padding:30px;text-align:center;color:#999;">No hay multitudes aún.</div>
        <?php else: ?>
        <table>
            <thead>
                <tr>
                    <th>#</th>
                    <th>Nombre</th>
                    <th>Descripción</th>
                    <th>Coords</th>
                    <th>Estado</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($multitudes as $m): ?>
                <tr>
                    <td><?php echo $m['id']; ?></td>
                    <td><strong><?php echo htmlspecialchars($m['nombre']); ?></strong></td>
                    <td style="max-width:200px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">
                        <?php echo $m['descripcion'] ? htmlspecialchars(substr($m['descripcion'], 0, 60)) . '…' : '<em style="color:#bbb;">—</em>'; ?>
                    </td>
                    <td style="font-size:.78em;color:#6b7280;">
                        <?php echo ($m['lat'] && $m['lng']) ? number_format($m['lat'],4) . ', ' . number_format($m['lng'],4) : '<em>Sin coords</em>'; ?>
                    </td>
                    <td><span class="badge <?php echo $m['activo'] ? 'badge-active' : 'badge-inactive'; ?>"><?php echo $m['activo'] ? 'Activa' : 'Inactiva'; ?></span></td>
                    <td style="white-space:nowrap;">
                        <a href="/admin/multitudes/dashboard.php?m=<?php echo $m['id']; ?>" class="btn btn-secondary btn-sm">📋 Ítems</a>
                        <form method="post" class="inline-form">
                            <?php echo csrfField(); ?>
                            <input type="hidden" name="action" value="toggle">
                            <input type="hidden" name="id" value="<?php echo $m['id']; ?>">
                            <button type="submit" class="btn btn-sm" style="background:#6366f1;color:white;"><?php echo $m['activo'] ? '⏸ Desactivar' : '▶ Activar'; ?></button>
                        </form>
                        <form method="post" class="inline-form" onsubmit="return confirm('¿Eliminar esta multitud y todos sus ítems?')">
                            <?php echo csrfField(); ?>
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="id" value="<?php echo $m['id']; ?>">
                            <button type="submit" class="btn btn-danger btn-sm">🗑️ Eliminar</button>
                        </form>
                    </td>
                </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
        <?php endif; ?>
    </div>
</div>

<script>
(function () {
    var mapEl = document.getElementById('mini-map');
    if (!mapEl) return;
    var miniMap = L.map('mini-map').setView([-34.6037, -58.3816], 5);
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        attribution: '© OpenStreetMap'
    }).addTo(miniMap);
    var marker = null;
    miniMap.on('click', function (e) {
        var lat = e.latlng.lat.toFixed(7);
        var lng = e.latlng.lng.toFixed(7);
        document.getElementById('input-lat').value = lat;
        document.getElementById('input-lng').value = lng;
        if (marker) marker.remove();
        marker = L.marker([lat, lng]).addTo(miniMap);
    });
})();
</script>
</body>
</html>

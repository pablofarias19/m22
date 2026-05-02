<?php
/**
 * Admin — Permisos de Contenido
 * Permite al Admin asignar permisos de publicación de noticias, eventos
 * y encuestas a negocios específicos o industrias completas.
 *
 * El Admin conserva SIEMPRE sus propios permisos. Esta pantalla solo
 * gestiona los permisos de las entidades externas.
 *
 * Lógica de herencia:
 *   Negocio.override = 'habilitada'   → tiene el permiso
 *   Negocio.override = 'deshabilitada' → no tiene el permiso
 *   Negocio.override = 'heredar'       → sigue la configuración de su industria
 */

session_start();

if (!isset($_SESSION['is_admin']) || !$_SESSION['is_admin']) {
    header('Location: /login');
    exit;
}

require_once __DIR__ . '/../../core/Database.php';

use Core\Database;

$db = Database::getInstance()->getConnection();
$mensaje = null;
$msgType = 'success';

// ── Procesar POST (guardar permisos) ─────────────────────────────────────────
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $scope = $_POST['scope'] ?? '';

    if ($scope === 'industria') {
        // Actualizar permisos por industria
        $ind_id = (int)($_POST['industria_id'] ?? 0);
        if ($ind_id > 0) {
            $enc  = isset($_POST['encuestas_permitidas']) ? 1 : 0;
            $not  = isset($_POST['noticias_permitidas'])  ? 1 : 0;
            $evt  = isset($_POST['eventos_permitidos'])   ? 1 : 0;
            try {
                $stmt = $db->prepare(
                    "UPDATE industries SET
                        encuestas_permitidas = ?,
                        noticias_permitidas  = ?,
                        eventos_permitidos   = ?
                     WHERE id = ?"
                );
                $stmt->execute([$enc, $not, $evt, $ind_id]);
                $mensaje = "Permisos de la industria actualizados.";
            } catch (\PDOException $e) {
                $mensaje = "Error al guardar: " . $e->getMessage();
                $msgType = 'error';
            }
        }
    } elseif ($scope === 'negocio') {
        // Actualizar overrides por negocio
        $biz_id = (int)($_POST['business_id'] ?? 0);
        if ($biz_id > 0) {
            $valid = ['heredar','habilitada','deshabilitada'];
            $enc_ov = in_array($_POST['encuestas_override'] ?? '', $valid) ? $_POST['encuestas_override'] : 'heredar';
            $not_ov = in_array($_POST['noticias_override']  ?? '', $valid) ? $_POST['noticias_override']  : 'heredar';
            $evt_ov = in_array($_POST['eventos_override']   ?? '', $valid) ? $_POST['eventos_override']   : 'heredar';
            try {
                $stmt = $db->prepare(
                    "UPDATE businesses SET
                        encuestas_override = ?,
                        noticias_override  = ?,
                        eventos_override   = ?
                     WHERE id = ?"
                );
                $stmt->execute([$enc_ov, $not_ov, $evt_ov, $biz_id]);
                $mensaje = "Permisos del negocio actualizados.";
            } catch (\PDOException $e) {
                $mensaje = "Error al guardar: " . $e->getMessage();
                $msgType = 'error';
            }
        }
    }
}

// ── Cargar datos ──────────────────────────────────────────────────────────────
$tab = $_GET['tab'] ?? 'negocios';

// Negocios con sus overrides (fallback si las columnas no existen)
$businesses = [];
try {
    $businesses = $db->query(
        "SELECT b.id, b.name, b.industry_id,
                i.name AS industry_name,
                COALESCE(i.encuestas_permitidas,0) AS ind_enc,
                COALESCE(i.noticias_permitidas,0)  AS ind_not,
                COALESCE(i.eventos_permitidos,0)   AS ind_evt,
                COALESCE(b.encuestas_override,'heredar') AS enc_ov,
                COALESCE(b.noticias_override,'heredar')  AS not_ov,
                COALESCE(b.eventos_override,'heredar')   AS evt_ov
         FROM businesses b
         LEFT JOIN industries i ON i.id = b.industry_id
         ORDER BY b.name ASC
         LIMIT 200"
    )->fetchAll(\PDO::FETCH_ASSOC);
} catch (\PDOException $e) {
    // Columnas de migración 040 aún no aplicadas
    try {
        $businesses = $db->query(
            "SELECT b.id, b.name, b.industry_id,
                    i.name AS industry_name,
                    0 AS ind_enc, 0 AS ind_not, 0 AS ind_evt,
                    'heredar' AS enc_ov, 'heredar' AS not_ov, 'heredar' AS evt_ov
             FROM businesses b
             LEFT JOIN industries i ON i.id = b.industry_id
             ORDER BY b.name ASC
             LIMIT 200"
        )->fetchAll(\PDO::FETCH_ASSOC);
    } catch (\PDOException $e2) {}
}

// Industrias
$industries = [];
try {
    $industries = $db->query(
        "SELECT id, name,
                COALESCE(encuestas_permitidas,0) AS encuestas_permitidas,
                COALESCE(noticias_permitidas,0)  AS noticias_permitidas,
                COALESCE(eventos_permitidos,0)   AS eventos_permitidos
         FROM industries
         ORDER BY name ASC"
    )->fetchAll(\PDO::FETCH_ASSOC);
} catch (\PDOException $e) {
    try {
        $industries = $db->query(
            "SELECT id, name, 0 AS encuestas_permitidas, 0 AS noticias_permitidas, 0 AS eventos_permitidos
             FROM industries ORDER BY name ASC"
        )->fetchAll(\PDO::FETCH_ASSOC);
    } catch (\PDOException $e2) {}
}

// Función de resolución de permisos efectivos
function permisoEfectivo($override, $ind_perm) {
    if ($override === 'habilitada')    return true;
    if ($override === 'deshabilitada') return false;
    return (bool)$ind_perm; // heredar
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>🔑 Permisos de Contenido — Admin MAPITA</title>
<style>
    body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif; background: #f3f4f6; color: #1a1a2e; margin: 0; padding: 0; }
    .header { background: linear-gradient(135deg, #1B3B6F, #0d2147); color: #fff; padding: 20px 28px; display: flex; align-items: center; gap: 12px; }
    .header h1 { margin: 0; font-size: 20px; }
    .header a { color: rgba(255,255,255,0.75); text-decoration: none; font-size: 13px; }
    .header a:hover { color: #fff; }
    .container { max-width: 1100px; margin: 0 auto; padding: 24px 20px; }
    .alert { padding: 12px 18px; border-radius: 8px; margin-bottom: 20px; font-weight: 600; font-size: 14px; }
    .alert.success { background: #d1fae5; color: #065f46; border: 1px solid #a7f3d0; }
    .alert.error   { background: #fee2e2; color: #991b1b; border: 1px solid #fca5a5; }
    .tabs { display: flex; gap: 4px; margin-bottom: 20px; }
    .tab { padding: 10px 20px; border-radius: 8px 8px 0 0; border: 1px solid #ddd; border-bottom: none; background: #e9ecef; cursor: pointer; font-weight: 600; font-size: 13px; text-decoration: none; color: #444; }
    .tab.active { background: #fff; color: #1B3B6F; border-bottom: 1px solid #fff; }
    .panel { background: #fff; border: 1px solid #ddd; border-radius: 0 8px 8px 8px; padding: 24px; }
    .info-box { background: #eff6ff; border: 1px solid #bfdbfe; border-radius: 8px; padding: 14px 18px; font-size: 13px; color: #1e40af; margin-bottom: 20px; line-height: 1.5; }
    table { width: 100%; border-collapse: collapse; font-size: 13px; }
    th { background: #f8f9fa; padding: 10px 12px; text-align: left; font-weight: 700; color: #374151; border-bottom: 2px solid #e5e7eb; }
    td { padding: 10px 12px; border-bottom: 1px solid #f3f4f6; vertical-align: middle; }
    tr:hover td { background: #fafbfc; }
    .badge-si  { background: #d1fae5; color: #065f46; padding: 2px 8px; border-radius: 12px; font-size: 11px; font-weight: 700; }
    .badge-no  { background: #fee2e2; color: #991b1b; padding: 2px 8px; border-radius: 12px; font-size: 11px; font-weight: 700; }
    .badge-her { background: #e0e7ff; color: #3730a3; padding: 2px 8px; border-radius: 12px; font-size: 11px; font-weight: 700; }
    .badge-eff { background: #fef3c7; color: #92400e; padding: 2px 7px; border-radius: 12px; font-size: 10px; }
    select.perm-select { font-size: 12px; padding: 4px 8px; border: 1px solid #d1d5db; border-radius: 6px; background: #f9fafb; cursor: pointer; }
    select.perm-select.habilitada   { border-color: #6ee7b7; background: #ecfdf5; color: #065f46; font-weight: 700; }
    select.perm-select.deshabilitada{ border-color: #fca5a5; background: #fff5f5; color: #991b1b; font-weight: 700; }
    .save-btn { background: #1B3B6F; color: #fff; border: none; border-radius: 8px; padding: 8px 18px; cursor: pointer; font-weight: 700; font-size: 13px; transition: 0.2s; }
    .save-btn:hover { background: #14306b; }
    .search-box { width: 100%; max-width: 360px; padding: 9px 14px; border: 1px solid #d1d5db; border-radius: 8px; font-size: 13px; margin-bottom: 16px; outline: none; }
    .search-box:focus { border-color: #1B3B6F; }
    .chk-label { display: flex; align-items: center; gap: 6px; cursor: pointer; font-size: 13px; font-weight: 600; padding: 6px 10px; border-radius: 6px; border: 1px solid #e5e7eb; }
    .chk-label input[type=checkbox] { width: 16px; height: 16px; cursor: pointer; }
    .chk-label:has(input:checked) { background: #ecfdf5; border-color: #6ee7b7; color: #065f46; }
</style>
</head>
<body>

<div class="header">
    <div>
        <a href="/admin/">← Panel Admin</a>
        <h1>🔑 Permisos de Contenido</h1>
    </div>
</div>

<div class="container">

<?php if ($mensaje): ?>
<div class="alert <?= $msgType ?>"><?= htmlspecialchars($mensaje) ?></div>
<?php endif; ?>

<div class="info-box">
    <strong>📌 Cómo funciona:</strong><br>
    Como Admin, siempre mantenés todos los permisos. Esta pantalla te permite <strong>distribuir</strong> la facultad de publicar noticias, eventos y encuestas a negocios o industrias específicas, sin perder vos ese poder.<br>
    — Configurá los permisos por <strong>industria</strong> para aplicar a todos sus negocios a la vez.<br>
    — Usá <strong>overrides</strong> por negocio individual para excepciones: forzar habilitado o deshabilitado independientemente de la industria.
</div>

<!-- Tabs -->
<div class="tabs">
    <a href="?tab=negocios"   class="tab <?= $tab==='negocios'   ? 'active' : '' ?>">🏢 Negocios (<?= count($businesses) ?>)</a>
    <a href="?tab=industrias" class="tab <?= $tab==='industrias' ? 'active' : '' ?>">🏭 Industrias (<?= count($industries) ?>)</a>
</div>

<div class="panel">

<?php if ($tab === 'industrias'): ?>
<!-- ── TAB INDUSTRIAS ── -->
<p style="font-size:13px;color:#666;margin:0 0 16px;">Activa los permisos a nivel de industria. Todos los negocios de esa industria que tengan override "heredar" los recibirán automáticamente.</p>
<form method="POST" id="form-ind" onsubmit="return false;">
    <input type="hidden" name="scope" value="industria">
    <input id="search-ind" type="text" class="search-box" placeholder="🔍 Buscar industria...">
    <table id="tabla-industrias">
        <thead><tr>
            <th>Industria</th>
            <th style="text-align:center;">📊 Encuestas</th>
            <th style="text-align:center;">📰 Noticias</th>
            <th style="text-align:center;">🎉 Eventos</th>
            <th style="text-align:center;">Guardar</th>
        </tr></thead>
        <tbody>
        <?php foreach ($industries as $ind): ?>
        <tr>
            <td><strong><?= htmlspecialchars($ind['name']) ?></strong></td>
            <td style="text-align:center;">
                <form method="POST" style="display:inline;">
                    <input type="hidden" name="scope" value="industria">
                    <input type="hidden" name="industria_id" value="<?= $ind['id'] ?>">
                    <label class="chk-label">
                        <input type="checkbox" name="encuestas_permitidas" value="1" <?= $ind['encuestas_permitidas'] ? 'checked' : '' ?>>
                        <?= $ind['encuestas_permitidas'] ? 'Sí' : 'No' ?>
                    </label>
            </td>
            <td style="text-align:center;">
                    <label class="chk-label">
                        <input type="checkbox" name="noticias_permitidas" value="1" <?= $ind['noticias_permitidas'] ? 'checked' : '' ?>>
                        <?= $ind['noticias_permitidas'] ? 'Sí' : 'No' ?>
                    </label>
            </td>
            <td style="text-align:center;">
                    <label class="chk-label">
                        <input type="checkbox" name="eventos_permitidos" value="1" <?= $ind['eventos_permitidos'] ? 'checked' : '' ?>>
                        <?= $ind['eventos_permitidos'] ? 'Sí' : 'No' ?>
                    </label>
            </td>
            <td style="text-align:center;">
                    <button type="submit" class="save-btn">💾 Guardar</button>
                </form>
            </td>
        </tr>
        <?php endforeach; ?>
        <?php if (empty($industries)): ?>
            <tr><td colspan="5" style="text-align:center;color:#999;padding:30px;">No hay industrias cargadas.</td></tr>
        <?php endif; ?>
        </tbody>
    </table>
</form>

<?php else: ?>
<!-- ── TAB NEGOCIOS ── -->
<p style="font-size:13px;color:#666;margin:0 0 16px;">Configurá overrides por negocio. <strong>Heredar</strong> = sigue el permiso de la industria. <strong>Habilitada/Deshabilitada</strong> = fuerza el valor sin importar la industria.</p>
<input id="search-biz" type="text" class="search-box" placeholder="🔍 Buscar negocio o industria...">
<table id="tabla-negocios">
    <thead><tr>
        <th>Negocio</th>
        <th>Industria</th>
        <th style="text-align:center;">📊 Encuestas</th>
        <th style="text-align:center;">📰 Noticias</th>
        <th style="text-align:center;">🎉 Eventos</th>
        <th style="text-align:center;">Efectivo</th>
        <th style="text-align:center;">Guardar</th>
    </tr></thead>
    <tbody>
    <?php foreach ($businesses as $biz):
        $efEnc = permisoEfectivo($biz['enc_ov'], $biz['ind_enc']);
        $efNot = permisoEfectivo($biz['not_ov'], $biz['ind_not']);
        $efEvt = permisoEfectivo($biz['evt_ov'], $biz['ind_evt']);
    ?>
    <tr data-search="<?= strtolower(htmlspecialchars($biz['name'] . ' ' . ($biz['industry_name']??''))) ?>">
        <td><strong><?= htmlspecialchars($biz['name']) ?></strong><br><span style="color:#888;font-size:11px;">#<?= $biz['id'] ?></span></td>
        <td><?= htmlspecialchars($biz['industry_name'] ?? '—') ?></td>
        <td style="text-align:center;">
            <form method="POST">
                <input type="hidden" name="scope" value="negocio">
                <input type="hidden" name="business_id" value="<?= $biz['id'] ?>">
        </td>
        <td style="text-align:center;">
                <select name="encuestas_override" class="perm-select <?= $biz['enc_ov'] ?>" onchange="this.className='perm-select '+this.value">
                    <option value="heredar"        <?= $biz['enc_ov']==='heredar'?'selected':'' ?>>↕ Heredar</option>
                    <option value="habilitada"     <?= $biz['enc_ov']==='habilitada'?'selected':'' ?>>✓ Habilitada</option>
                    <option value="deshabilitada"  <?= $biz['enc_ov']==='deshabilitada'?'selected':'' ?>>✗ Deshabilitada</option>
                </select>
        </td>
        <td style="text-align:center;">
                <select name="noticias_override" class="perm-select <?= $biz['not_ov'] ?>" onchange="this.className='perm-select '+this.value">
                    <option value="heredar"        <?= $biz['not_ov']==='heredar'?'selected':'' ?>>↕ Heredar</option>
                    <option value="habilitada"     <?= $biz['not_ov']==='habilitada'?'selected':'' ?>>✓ Habilitada</option>
                    <option value="deshabilitada"  <?= $biz['not_ov']==='deshabilitada'?'selected':'' ?>>✗ Deshabilitada</option>
                </select>
        </td>
        <td style="text-align:center;">
                <select name="eventos_override" class="perm-select <?= $biz['evt_ov'] ?>" onchange="this.className='perm-select '+this.value">
                    <option value="heredar"        <?= $biz['evt_ov']==='heredar'?'selected':'' ?>>↕ Heredar</option>
                    <option value="habilitada"     <?= $biz['evt_ov']==='habilitada'?'selected':'' ?>>✓ Habilitada</option>
                    <option value="deshabilitada"  <?= $biz['evt_ov']==='deshabilitada'?'selected':'' ?>>✗ Deshabilitada</option>
                </select>
        </td>
        <td style="text-align:center;">
            <div style="display:flex;gap:4px;flex-direction:column;">
                <span class="<?= $efEnc ? 'badge-si' : 'badge-no' ?>">Enc: <?= $efEnc ? '✓' : '✗' ?></span>
                <span class="<?= $efNot ? 'badge-si' : 'badge-no' ?>">Not: <?= $efNot ? '✓' : '✗' ?></span>
                <span class="<?= $efEvt ? 'badge-si' : 'badge-no' ?>">Evt: <?= $efEvt ? '✓' : '✗' ?></span>
            </div>
        </td>
        <td style="text-align:center;">
                <button type="submit" class="save-btn">💾</button>
            </form>
        </td>
    </tr>
    <?php endforeach; ?>
    <?php if (empty($businesses)): ?>
        <tr><td colspan="7" style="text-align:center;color:#999;padding:30px;">No hay negocios cargados.</td></tr>
    <?php endif; ?>
    </tbody>
</table>
<?php endif; ?>

</div><!-- /.panel -->
</div><!-- /.container -->

<script>
// Búsqueda en tiempo real
(function(){
    var searchInd = document.getElementById('search-ind');
    var searchBiz = document.getElementById('search-biz');

    function filtrar(input, tableId, colIdx) {
        if (!input) return;
        input.addEventListener('input', function() {
            var q = this.value.toLowerCase();
            var rows = document.querySelectorAll('#' + tableId + ' tbody tr');
            rows.forEach(function(row) {
                var text = (row.dataset.search || row.textContent).toLowerCase();
                row.style.display = text.includes(q) ? '' : 'none';
            });
        });
    }

    filtrar(searchInd, 'tabla-industrias', 0);
    filtrar(searchBiz, 'tabla-negocios',  0);
})();
</script>

</body>
</html>

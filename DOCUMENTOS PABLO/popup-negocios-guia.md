# Guía: Popup de Negocios — Dónde modificar y qué efectos tiene

## Arquitectura general

El popup de negocios está compuesto por **tres capas** que trabajan en conjunto:

```
┌─────────────────────────────────────────────────────────┐
│  CAPA 1: Leaflet (JS)  →  map.php ~línea 4517           │
│  Controla: ancho máximo, autopan, comportamiento        │
├─────────────────────────────────────────────────────────┤
│  CAPA 2: CSS base  →  css/popup-redesign.css            │
│  Controla: estilos visuales desktop                     │
├─────────────────────────────────────────────────────────┤
│  CAPA 3: CSS mobile  →  css/popup-redesign.css          │
│  Controla: layout responsive @media (max-width: 480px)  │
└─────────────────────────────────────────────────────────┘
```

El **contenido HTML** del popup se genera dinámicamente en `views/business/map.php`
dentro de la función `buildPopup(n, isMarca)` (~línea 4666).

---

## Archivos involucrados

| Archivo | Rol |
|---|---|
| `views/business/map.php` | Genera el HTML del popup y configura Leaflet |
| `css/popup-redesign.css` | Todos los estilos visuales y responsive |
| `css/brand-popup-premium.css` | Solo para el modal de marcas — NO afecta al popup de negocios |

---

## Estructura visual del popup

```
┌──────────────────────────────────┐
│  .popup-header                   │  ← gradiente azul, emoji/nombre/badge
│    .popup-header-inner           │
│      .popup-header-icon          │  ← emoji del tipo de negocio
│      .popup-header-text          │  ← nombre + badge tipo + badge abierto/cerrado
├──────────────────────────────────┤
│  .popup-body                     │  ← scroll vertical, max-height limitado
│    oferta destacada (si existe)  │
│    .popup-section dirección      │
│    .popup-desc descripción       │  ← se oculta en mobile
│    teléfono / horario / tipo     │
│    rating (carga lazy)           │
│    .popup-wt-section             │  ← panel WT, se oculta en mobile
├──────────────────────────────────┤
│  .popup-footer                   │  ← flex en desktop, grid en mobile
│    .popup-action  📞 📧 🗺️ 💬 🌐 📋  │  ← emoji puro
│    .popup-action--text  $$$  💼  │  ← texto + emoji (font más pequeño en mobile)
└──────────────────────────────────┘
```

---

## Dónde modificar cada cosa

### Ancho del popup

| Qué | Archivo | Línea aprox. | Efecto |
|---|---|---|---|
| Ancho máximo desktop | `map.php` | 4517 | `maxWidth: 290` en `bindPopup()` — Leaflet lo aplica como inline style |
| Ancho máximo del contenido | `popup-redesign.css` | 4 | `.leaflet-popup-content { max-width: 320px !important }` |
| Ancho en mobile | `popup-redesign.css` | ~223 | `.leaflet-popup-content-wrapper { width: 92vw !important }` |

> **Importante:** Si cambiás el ancho en desktop, actualizá tanto `maxWidth` en `map.php`
> como `max-width` en `.leaflet-popup-content` para mantenerlos coherentes.
> En mobile no hace falta tocar `map.php` — el CSS con `!important` toma control total.

---

### Alto del cuerpo (scroll interno)

| Qué | Archivo | Línea aprox. | Efecto |
|---|---|---|---|
| Alto máximo desktop | `popup-redesign.css` | 103 | `.popup-body { max-height: 320px }` |
| Alto máximo mobile | `popup-redesign.css` | ~241 | `.popup-body { max-height: calc(72vh - 130px) !important }` |

> El `calc(72vh - 130px)` descuenta ~65px del header y ~65px del footer para que el body
> no desborde la pantalla. Si cambiás la altura del header o footer, ajustá este valor.

---

### Botones del footer (.popup-action)

**Propiedades base (desktop)** — `popup-redesign.css` línea 144:

| Propiedad | Valor actual | Efecto si cambiás |
|---|---|---|
| `font-size` | `18px` | Tamaño de los emojis en desktop |
| `min-height` | `40px` | Altura mínima del botón |
| `max-width` | `60px` | Ancho máximo de cada botón (se distribuyen con `flex: 1`) |
| `padding` | `8px 6px` | Espaciado interno |
| `border-radius` | `6px` | Redondeo de esquinas |
| `box-shadow` | `0 2px 6px rgba(0,0,0,0.15)` | Sombra en reposo |

**Hover** — `popup-redesign.css` línea 171:

| Propiedad | Valor actual | Nota |
|---|---|---|
| `filter` | `brightness(1.12)` | Aclara el botón — funciona con cualquier color de fondo inline |
| `transform` | `translateY(-1px)` | Sube el botón 1px |
| `box-shadow` | `0 4px 12px rgba(0,0,0,0.22)` | Sombra más pronunciada |

> El hover usa `filter: brightness` (no cambia el `background`) porque cada botón tiene
> su color definido con `style="background:COLOR"` inline, que tiene mayor especificidad
> que cualquier regla CSS. Cambiar el `background` en el hover del CSS file no tendría efecto.
> Si querés cambiar el color de hover de un botón, modificá la función `buildPopup()` en `map.php`.

**Botones con texto** — agregan clase `popup-action--text`:
- `$$$` (disponibles) — `map.php` ~línea 4975
- `💼 Empleos` — `map.php` ~línea 4980
- `Ver 🏘️` (inmobiliaria) — `map.php` ~línea 4985

---

### Layout del footer en mobile

**`popup-redesign.css`** dentro de `@media (max-width: 480px)` ~línea 254:

| Propiedad | Valor actual | Efecto si cambiás |
|---|---|---|
| `grid-template-columns` | `repeat(auto-fill, minmax(44px, 1fr))` | Columnas adaptativas — más `minmax` = botones más anchos |
| `gap` | `5px` | Separación entre botones |
| `font-size` (.popup-action) | `16px` | Tamaño emoji en mobile |
| `min-height` (.popup-action) | `44px` | Área táctil mínima (WCAG) — no bajar de 44px |
| `font-size` (.popup-action--text) | `11px` | Tamaño texto en botones mixtos |

> `repeat(auto-fill, minmax(44px, 1fr))` genera tantas columnas como quepan en el ancho
> disponible. Con 4 botones → 4 columnas. Con 7 → se redistribuye sin celdas vacías.
> Si subís el `minmax` a `60px` los botones quedan más anchos pero caben menos por fila.

---

### Contenido del popup (qué se muestra)

Todo está en `views/business/map.php`, función `buildPopup()` ~línea 4666:

| Sección | Condición para mostrarse | Cómo ocultarla |
|---|---|---|
| Oferta destacada | `n.oferta_destacada_id` o `n.oferta_activa_id` | Eliminar ese bloque en `buildPopup()` |
| Descripción | `n.description` existe | `.popup-desc { display: none }` en CSS (ya oculta en mobile) |
| Teléfono | `n.phone` existe | Eliminar línea en `buildPopup()` |
| Horario | `n.horario_apertura` o `n.horario_cierre` | Eliminar bloque en `buildPopup()` |
| Rating | Siempre (carga lazy al abrir) | Eliminar bloque `data-rating-id` en `buildPopup()` |
| Panel WT | Siempre (se abre al clickear) | `.popup-wt-section { display: none }` en CSS |
| Botón $$$ | `n.disponibles_activo` | Condición en `buildPopup()` ~línea 4973 |
| Botón Empleos | `n.job_offer_active` | Condición en `buildPopup()` ~línea 4979 |
| Botón Inmuebles | `n.business_type === 'inmobiliaria'` | Condición en `buildPopup()` ~línea 4984 |

---

### Header del popup

**Color del gradiente** — `popup-redesign.css` línea 22:
```css
.leaflet-popup .popup-header {
    background: linear-gradient(135deg, #1B3B6F 0%, #2E5FA3 60%, #667eea 100%);
}
```
Cambiar los tres colores hex modifica el gradiente azul del header de negocios.

**Badge abierto/cerrado** — `map.php` ~línea 4710:
```js
if (openStatus === true)  p += '<span class="status-badge">🟢 Abierto ahora</span>';
if (openStatus === false) p += '<span class="status-badge">🔴 Cerrado</span>';
```
El estilo del badge está en `popup-redesign.css` línea 83 (`.popup-header .status-badge`).

---

### Agregar un breakpoint tablet (actualmente no existe)

Si necesitás estilos específicos entre 481px y 768px, agregá en `popup-redesign.css`
después del bloque `@media (max-width: 480px)`:

```css
@media (min-width: 481px) and (max-width: 768px) {
    .leaflet-popup-content-wrapper {
        max-width: 75vw !important;
    }
    .popup-body {
        max-height: 280px !important;
    }
}
```

---

## Resumen: qué tocar según el problema

| Problema | Archivo | Qué cambiar |
|---|---|---|
| Popup muy ancho en desktop | `map.php` línea 4517 + `popup-redesign.css` línea 4 | `maxWidth` y `max-width` |
| Popup muy ancho en mobile | `popup-redesign.css` ~línea 223 | `width: 92vw` |
| Cuerpo muy alto / corto | `popup-redesign.css` líneas 103 / 241 | `max-height` desktop/mobile |
| Botones demasiado chicos/grandes | `popup-redesign.css` línea 144 | `font-size`, `min-height`, `max-width` |
| Botones en mobile desalineados | `popup-redesign.css` ~línea 254 | `minmax(44px, 1fr)` → subir/bajar el 44px |
| Color del header | `popup-redesign.css` línea 22 | Gradiente lineal |
| Agregar/quitar un campo de datos | `map.php` función `buildPopup()` ~línea 4666 | HTML del popup |
| Agregar un botón nuevo al footer | `map.php` ~línea 4966 | Nuevo `<a>` o `<button>` con `class="popup-action"` |

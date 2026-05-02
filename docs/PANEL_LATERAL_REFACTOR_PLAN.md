# Plan de Corrección Integral del Panel Lateral

## Objetivo
Ordenar y unificar filtros, ubicación, resultados y capas especiales del panel lateral para evitar duplicaciones, reducir estados inconsistentes y mejorar la UX.

## Alcance
- Reorganización de secciones del panel lateral.
- Unificación funcional de ubicación/cercanía.
- Configuración de búsqueda (máx. ítems y zooms).
- Integración de modo de ubicación virtual.
- Limpieza de referencias legacy del bloque de ubicación antiguo.

## Supuesto Operativo Importante
Este plan considera como si el bloque HTML de ubicación antiguo aún existiera (checkbox/range/city):
- `filter-location-enable`
- `filter-location-radius`
- `filter-location-radius-value`
- `filter-location-city`

Aunque el bloque no esté visible actualmente, se tratará su eliminación/neutralización de forma explícita en JS para cerrar deuda técnica.

## Diagnóstico de Duplicidades
1. Ubicación y cercanía están distribuidas en varios lugares:
- Herramientas: `ubicarme()` y `toggleFollowMe()`.
- Resultados: selector de radio `sb-radius-select`.
- Legacy: referencias a `filter-location-*` en la lógica de filtros/cache.

2. Capas especiales están separadas y válidas, pero deben quedar agrupadas semánticamente:
- Inmuebles (`show-inmuebles`).
- Sectores industriales (`show-sectores-industriales`).

3. Búsqueda tiene comportamiento útil (dropdown y centrado), pero sin panel de configuración claro para usuario final.

## Diseño de Información Propuesto (Panel)

> Cada sección del panel incluirá un ícono ℹ️ en el encabezado. Al hacer clic se expande un panel de ayuda
> contextual con descripción breve de la función y sus controles. El panel colapsa al volver a presionar el ícono.
> Este mecanismo es independiente del toggle de la sección y no altera el estado del contenido.

### Patrón de Aviso Contextual
Componente reutilizable en todas las secciones:
- Ícono ℹ️ pequeño en el extremo derecho del encabezado.
- Al hacer clic: despliega un `<div>` con fondo suave (ej. `#eef4ff`), borde izquierdo de color sección.
- Contiene: descripción de la sección, lista breve de acciones disponibles.
- Cierra al volver a hacer clic en ℹ️ o al hacer clic fuera.
- Persistir estado abierto/cerrado en localStorage por sección.
- No interferir con el toggle de colapso de la sección principal.

---

1. Sección: Ubicación y Cercanía
- Botón: Ubicarme (GPS real).
- Botón toggle: Seguirme (solo GPS).
- Modo ubicación: GPS | Virtual.
- Acción: Recentrar punto virtual.
- Control de radio de cercanía (mover aquí desde Resultados): `sb-radius-select`.
- **Aviso contextual:** "Establece tu posición en el mapa. Usa GPS real o coloca un punto virtual para simular
  tu ubicación y filtrar resultados por cercanía. El radio define el área de búsqueda cercana."

2. Sección: Búsqueda y Resultados
- Estadísticas (`stats`).
- Dropdown de resultados de búsqueda.
- Lista principal de resultados (`lista`).
- Preferencias de búsqueda:
  - Máx. ítems dropdown: 5-30.
  - Zoom al primer resultado: 12-18.
  - Zoom al seleccionar resultado: 12-18.
- **Aviso contextual:** "Muestra los resultados filtrados. Usa el buscador para encontrar negocios o marcas.
  Al escribir, el mapa se centra automáticamente en el primer resultado. Ajustá el máximo de ítems visibles
  y el nivel de zoom según tu preferencia."

3. Sección: Capas de Territorio
- Toggle Inmuebles.
- Toggle Sectores Industriales.
- **Aviso contextual:** "Activa capas adicionales sobre el mapa. Inmuebles muestra zonas de influencia
  inmobiliarias. Sectores Industriales superpone áreas de actividad industrial. Podés activar ambas
  al mismo tiempo."

4. Sección: Herramientas
- Exportar PDF y utilitarios no relacionados con ubicación.
- **Aviso contextual:** "Acciones adicionales sobre la lista de resultados. Exportar PDF genera un
  documento con los resultados actualmente visibles en el panel."

## Estrategia Técnica (sin romper comportamiento)
### Fase 1: Normalizar fuente de ubicación
Crear helper único:
- `getEffectiveUserLocation()`

Regla:
- Si modo = virtual y hay punto virtual válido, usar virtual.
- Si modo = GPS y existe `miUbicacion`, usar GPS.
- Si no hay ninguna, retornar null.

Aplicar helper en:
- Cálculo de distancia.
- Ordenamiento por cercanía.
- Badge de cercanía en stats.
- Filtros por radio.

### Fase 2: Incorporar configuración de búsqueda
Definir estado configurable:
- `searchMaxItems` (default 10, rango 5-30).
- `searchZoomFirst` (default 15, rango 12-18).
- `searchZoomSelected` (default 16, rango 12-18).

Aplicar en:
- Límite de dropdown.
- Centrado automático al primer resultado.
- Centrado al elegir item del dropdown.

Persistencia:
- Guardar en localStorage.
- Restaurar en `DOMContentLoaded`.

### Fase 3: Modo virtual
Agregar:
- Estado: `locationMode` (`gps` | `virtual`).
- Marcador virtual arrastrable.
- Botón de recenter del punto virtual.
- Indicador visual de modo activo.

Reglas UX:
- En modo virtual, desactivar/ocultar `Seguirme`.
- En modo GPS, habilitar `Seguirme`.

### Fase 4: Limpieza explícita de legacy (obligatoria)
Tratar como si el bloque antiguo existiera y desmontarlo de forma segura.

Pasos:
1. Eliminar dependencia funcional de:
- `filter-location-enable`
- `filter-location-radius`
- `filter-location-radius-value`
- `filter-location-city`

2. Ajustar funciones para no leer más esos IDs:
- Cache key de filtros.
- Helpers de ubicación legacy.
- Setup de listeners legacy.

3. Consolidar todo con:
- `sb-radius-select` como único radio activo.
- `getEffectiveUserLocation()` como única fuente de posición.

4. Validar que no queden referencias residuales mediante búsqueda global en el archivo.

### Fase 5: Reordenar UI
- Mover controles al nuevo orden de secciones.
- Mantener estilos actuales y componentes existentes para minimizar regresión visual.

### Fase 6: Avisos contextuales por sección
Implementar componente reutilizable `SectionInfo`:
- Ícono ℹ️ en cada encabezado de sección (`sb-section-hdr`).
- Al hacer clic expande un `<div class="sb-info-panel">` dentro del body de la sección.
- Texto de ayuda específico por sección (ver textos en Diseño de Información).
- Toggle independiente del colapso de sección.
- Estado (abierto/cerrado) persistido en localStorage con clave `mapita_info_{sectionId}`.
- Estilo: fondo `#eef4ff`, borde izquierdo `3px solid #667eea`, `font-size:12px`, `padding:8px 10px`.
- Cierra al hacer clic fuera del panel info mediante listener en `document`.

Función JS propuesta:
```js
function toggleInfoPanel(sectionId) {
    const panel = document.getElementById('info-' + sectionId);
    if (!panel) return;
    const isOpen = panel.style.display !== 'none';
    panel.style.display = isOpen ? 'none' : 'block';
    try { localStorage.setItem('mapita_info_' + sectionId, isOpen ? '0' : '1'); } catch {}
}
```

## Checklist de Implementación
1. Crear/actualizar sección Ubicación y Cercanía.
2. Mover control de radio (`sb-radius-select`) a esa sección.
3. Agregar controles de preferencias de búsqueda.
4. Integrar modo virtual con marcador arrastrable.
5. Implementar helper `getEffectiveUserLocation()`.
6. Migrar cálculos de cercanía al helper.
7. Desactivar dependencia de IDs legacy.
8. Reubicar toggles de capas bajo Capas de Territorio.
9. Implementar componente de aviso contextual `toggleInfoPanel()`.
10. Agregar ícono ℹ️ y panel de ayuda en cada sección del panel.
11. Persistir estado de avisos en localStorage.
12. Ejecutar pruebas funcionales completas.

## Checklist de Validación
1. Búsqueda por una y múltiples palabras actualiza lista/dropdown.
2. Auto-centrado usa zoom configurable.
3. Selección manual en dropdown usa zoom configurable.
4. Radio de cercanía afecta stats y orden correctamente.
5. Modo GPS funciona con Seguirme.
6. Modo Virtual funciona con punto arrastrable.
7. Cambio GPS/Virtual no rompe filtros.
8. Inmuebles y sectores industriales siguen operativos.
9. No hay errores JS por IDs legacy inexistentes.
10. Ícono ℹ️ expande el panel de ayuda en cada sección.
11. El panel de ayuda cierra al volver a hacer clic en ℹ️.
12. El estado del panel de ayuda persiste al recargar.
13. Los avisos no interfieren con el colapso normal de secciones.

## Criterios de Aceptación
- Un único flujo de ubicación/cercanía sin duplicaciones.
- Sin dependencias activas del bloque legacy `filter-location-*`.
- Usuario puede ajustar máximos/zooms sin tocar código.
- Panel lateral ordenado por función y fácil de entender.

## Riesgos y Mitigación
1. Riesgo: regresión en filtros de distancia.
- Mitigación: tests manuales en GPS y Virtual.

2. Riesgo: estados ambiguos entre Seguirme y modo Virtual.
- Mitigación: regla estricta de habilitación por modo.

3. Riesgo: referencias legacy residuales.
- Mitigación: búsqueda global final y validación sin errores.

## Archivo principal de trabajo
- views/business/map.php

# MAPITA · Campaña Publicitaria
## Plataforma de Negocios Geolocalizada — Guía de Promoción

---

## ¿Qué es MAPITA?

**MAPITA** es una plataforma digital de geolocalización de negocios, marcas e inmuebles que conecta a consumidores con emprendedores, empresas y profesionales en tiempo real, directamente desde un mapa interactivo.

> *"El negocio de la vuelta de la esquina, ahora en el mundo entero."*

---

## 🌍 Oportunidades que brinda

### Para el Negocio / Emprendedor
- **Visibilidad inmediata** en el mapa: cualquier persona que abra MAPITA en tu zona te encuentra al instante, sin necesidad de que te busquen por nombre.
- **Canal de contacto directo**: teléfono, email, WhatsApp, sitio web y Google Maps, todo desde el popup del negocio.
- **Gestión de ofertas**: publicar precios, descuentos y productos destacados visibles en el mapa.
- **Módulo de Stock disponible ($$$)**: los clientes ven en tiempo real qué tenés disponible antes de ir.
- **Ofertas de empleo activas**: atrae candidatos mostrando vacantes directamente en el mapa.
- **Reseñas y rating**: construye reputación pública verificable desde el primer día.
- **Horarios y estado abierto/cerrado**: los clientes saben antes de salir si podés atenderlos.
- **Categorización precisa**: más de 60 tipos de negocio organizados por rubro, desde gastronomía hasta biodecodificación.

### Para el Consumidor / Usuario
- **Buscar por cercanía real** (GPS o punto virtual): encontrá el servicio más cercano en segundos.
- **Filtros combinables**: tipo de negocio, horario, abierto ahora, país, idioma, protección de marca.
- **Vista unificada** de negocios, marcas registradas e inmuebles en un solo mapa.
- **Consultas masivas**: enviar una sola consulta a múltiples negocios de un área dibujada en el mapa.
- **Sistema WT**: chatear directamente con el negocio sin salir del mapa.
- **Exportar resultados en PDF**: llevar la lista de búsqueda para uso offline.

### Para el Sector Inmobiliario
- **Inmobiliarias con zona de influencia geográfica**: visualización de cobertura territorial.
- **Catálogo de inmuebles geolocalizados**: cada propiedad en su punto exacto del mapa.
- **Búsqueda por zona**: escribís el barrio y encontrás todas las inmobiliarias activas en esa área.
- **Botón CERCA**: activa inmuebles publicados próximos a tu ubicación real.
- **Ficha de inmueble completa**: precio, tipo, fotos, contacto directo, y vínculo a la inmobiliaria.

### Para el Sector Cultural y Artístico
- **Eventos geolocalizados**: conciertos, exposiciones, obras de teatro, visibles en el mapa.
- **Función CONVOCAR**: los titulares de obras de arte pueden invitar artistas y servicios al proyecto.
- **Encuestas en mapa**: relevamiento de opinión directamente desde el punto geográfico.

---

## 🏆 Ventajas para el Mercado Internacional

| Característica | Detalle |
|---|---|
| **15 idiomas de interfaz** | Español, Inglés, Portugués, Francés, Alemán, Noruego, Chino, Árabe, Hindi, Italiano, Ruso, Griego, Turco, Japonés, Coreano |
| **Filtro por país** | Negocios de cualquier país del mundo, agrupados por región |
| **Filtro por idioma de operación** | Encontrá negocios que atiendan en tu idioma, estés donde estés |
| **Marcas con registro INPI** | Sistema de protección de marca con niveles Alta / Media / Baja visible para el usuario |
| **Punto de ubicación virtual** | Cualquier persona puede explorar negocios en una ciudad que aún no conoce |
| **API de mapa sin instalación** | Funciona desde cualquier navegador, en cualquier dispositivo, sin apps |
| **Sectores industriales globales** | Capas de minería, energía, agro, infraestructura, inmobiliario, industrial |
| **Zoom configurable** | Experiencia adaptada al contexto: ciudad, barrio, calle |
| **Multi-divisa implícita** | Los precios se cargan en la moneda del negocio, sin conversión forzada |

---

## ⚙️ Funciones Principales

### 🗺️ Mapa Interactivo
- Tecnología **Leaflet.js 1.9.4** con clustering inteligente de marcadores
- **Zoom adaptativo**: negocios premium visibles desde zoom bajo; locales pequeños a zoom de barrio
- Marcadores diferenciados por tipo, estado de marca y destaque premium
- Círculo de radio activo en tiempo real al activar ubicación

### 🔍 Búsqueda y Filtros
- Búsqueda por nombre con **debounce** y dropdown en tiempo real
- Dropdown de resultados con auto-centrado en el primer resultado
- Zoom configurable por el usuario: al primer resultado y al seleccionar
- Combinación de hasta 7 filtros simultáneos sin recargar la página

### 📍 Sistema de Ubicación
- **Modo GPS real**: ubicación precisa con seguimiento continuo
- **Modo Virtual**: colocá un punto arrastrable en cualquier lugar del mundo y explorá desde ahí
- Radio de búsqueda configurable: 1 / 2 / 5 / 10 / 20 km
- Badge en el panel mostrando cuántos negocios hay dentro del radio activo

### 📻 Sistema WT (Walkie Talkie)
*(ver sección dedicada más abajo)*

### 📦 Módulo Disponibles ($$$)
- El titular activa su stock y los clientes ven qué está disponible en tiempo real
- Botón destacado en el footer del popup con acceso directo

### 💼 Módulo Empleos
- Negocios con vacantes activas muestran el botón "Empleos" en su popup
- Los usuarios pueden contactar directamente al empleador desde el mapa

### 🧾 Selector MetaData (consultas masivas)
- **Consulta Masiva**: dibujá un polígono en el mapa y enviá un mensaje a todos los negocios dentro
- **Consulta General**: a servicios específicos habilitados del directorio
- **Consulta Proveedores**: a negocios con categoría de proveedor por rubro
- **Consulta de Envío**: a transportistas dentro de un área geográfica

### 🏷️ Sistema de Marcas (Brands)
- Registro de marcas con protección INPI
- Popup premium de marca con galería de imágenes y navegación
- Relación visual entre marca registrada y negocios asociados
- Badge de protección visible (Alta / Media / Baja)

---

## 📻 Sistema WT — Walkie Talkie

### ¿Qué es?
El **WT (Walkie Talkie)** es el sistema de mensajería instantánea propio de MAPITA. Permite que usuarios y negocios se comuniquen en tiempo real directamente desde el popup del mapa, sin salir de la plataforma.

### ¿Cómo funciona?
1. El usuario abre el popup de un negocio, marca, evento o encuesta
2. Hace clic en el botón **"Mensajes WT"**
3. Se despliega un panel de chat con:
   - **Mensajes rápidos preset**: Hola 👋 / Estoy cerca 📍 / ¿Hay novedades? / Gracias 🙌
   - **Campo de texto** libre (hasta 140 caracteres)
   - **Estado del canal**: 🟢 Abierto / 🔴 Cerrado / 🚫 Bloqueado / 🟡 Restringido
4. El negocio recibe el mensaje en su panel de gestión y puede responder

### Canales disponibles
| Entidad | Canal WT |
|---|---|
| Negocio | ✅ |
| Marca registrada | ✅ |
| Evento | ✅ |
| Encuesta | ✅ |
| Inmueble | — (contacto directo) |

### Ventajas del WT frente a WhatsApp o email
- **No requiere número de teléfono del usuario**
- **No requiere app instalada**
- **Historial en la plataforma** — no depende del dispositivo
- **Canal controlado por el negocio**: puede cerrarlo, restringirlo o bloquearlo
- **Sin spam externo**: solo usuarios de MAPITA pueden escribir

---

## 🎨 Propuestas para Promoción Gráfica

### Concepto 1 — "Tu negocio, en el mapa del mundo"
```
Visual: mapa oscuro con puntos de luz en ciudades del mundo
Texto principal:   TU NEGOCIO, EN EL MAPA DEL MUNDO
Subtexto:          15 idiomas · GPS real · Mensajería WT · Sin instalar nada
CTA:               → Sumate gratis en mapita.com.ar
Paleta:            Azul marino #1B3B6F + dorado #D4AF37 + blanco
```

### Concepto 2 — "El primer mensaje lo da el mapa"
```
Visual: mano sosteniendo un celular con el popup de un negocio abierto, con el chat WT visible
Texto principal:   HOLA 👋 ya llegué al barrio
Subtexto:          Con MAPITA le avisás al negocio antes de llegar.
                   Sin llamadas. Sin apps. Solo el mapa.
CTA:               Descubrí el WT en mapita.com.ar
Paleta:            Verde oscuro #1f2937 + teal #0891b2 + blanco
```

### Concepto 3 — "Mirá dónde están. Hablá directo."
```
Visual: grid de 4 íconos de popup con distintos tipos de negocios (farmacia, inmobiliaria, restaurante, gimnasio)
Texto principal:   📞 📧 🗺️ 💬 🌐 📋
Subtexto:          Todo lo que necesitás del negocio, en un solo clic.
CTA:               mapita.com.ar — Negocios con cara y dirección
Paleta:            Multicolor (íconos con los colores del footer del popup)
```

### Concepto 4 — Para el sector inmobiliario
```
Visual: mapa de ciudad con zonas de influencia en verde semitransparente
Texto principal:   TU ZONA DE INFLUENCIA, VISIBLE EN EL MAPA
Subtexto:          Publicá tus inmuebles. Definí tu territorio.
                   Recibí consultas del barrio exacto que trabajás.
CTA:               MAPITA Inmobiliario · mapita.com.ar
Paleta:            Verde esmeralda #00695C + blanco + gris claro
```

### Concepto 5 — Para redes sociales (formato cuadrado)
```
Visual: fondo degradado azul #1B3B6F → #667eea
PIN dorado animado en el centro
Texto:   M A P I T A
         [ Negocios ]
Footer:  Buscá · Encontrá · Conectá
Paleta:  Gradiente azul del header + pin dorado
```

---

## 📊 Datos clave para el copy publicitario

| Dato | Uso en copy |
|---|---|
| +60 tipos de negocio | "De la farmacia al astrólogo — si existe, está en MAPITA" |
| 15 idiomas | "El mapa que habla tu idioma" |
| GPS + punto virtual | "Explorá cualquier ciudad del mundo antes de llegar" |
| Sin instalación | "Abrís el navegador. Ya está." |
| Consulta masiva | "Un mensaje, cientos de negocios. A la vez." |
| Sistema WT | "El negocio a un mensaje de distancia" |
| Marcas con INPI | "Tu marca, protegida y visible en el mapa" |
| Stock en tiempo real ($$$) | "Antes de salir, sabés si lo tienen" |
| Empleos en el mapa | "Encontrá trabajo en tu barrio" |
| Inmobiliarias con zona | "Tu próximo hogar, marcado en el mapa" |

---

## 🎯 Segmentos de Audiencia

### Primario
- **Emprendedores y PyMEs** que quieren visibilidad digital sin invertir en SEO complejo
- **Inmobiliarias** que quieren mostrar su cobertura territorial

### Secundario
- **Consumidores urbanos** que buscan servicios cerca de su casa o trabajo
- **Turistas y viajeros** que necesitan encontrar servicios en ciudades desconocidas

### Internacional
- **Comunidades de inmigrantes** que buscan negocios que atiendan en su idioma
- **Empresas con franquicias** que necesitan mapear su red de locales

---

## 💬 Taglines sugeridos

```
"El mapa que conecta."
"Tu negocio tiene un punto en el mundo."
"Cerca tuyo. En cualquier idioma."
"Buscá. Encontrá. Hablá."
"El chat empezó en el mapa."
"Marcas protegidas. Negocios visibles."
"Abrí el mapa. Encontrá el negocio."
"Donde estés, MAPITA te ubica."
```

---

*Generado para uso interno de campaña — basado en análisis de funcionalidades reales de la plataforma.*

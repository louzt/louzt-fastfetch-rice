# louzt-fastfetch-rice

> Presets de fastfetch curados con variantes privadas. Multi-shell, Wayland-first, laptops híbridas. Incluye un playbook de triaje para adaptarse a tu distro, logos ASCII y kitty-direct, y un escaparate comunitario.

[![Licencia: MIT](https://img.shields.io/badge/Licencia-MIT-yellow.svg)](./LICENSE)
[![Fastfetch: 2.62+](https://img.shields.io/badge/fastfetch-2.62%2B-blue.svg)](https://github.com/fastfetch-cli/fastfetch)
[![Wayland: listo](https://img.shields.io/badge/wayland-listo-brightgreen.svg)](https://wayland.freedesktop.org/)
[![🇬🇧 Read in English](https://img.shields.io/badge/Read%20in-English-blue)](./README.md)

---

## ¿Qué es esto?

Una **colección opinada de presets de fastfetch** que puedes copiar a `~/.config/fastfetch/` y alternar según la situación. Construido y probado en batalla sobre Debian + niri + Ghostty, pero cada preset es **agnóstico al terminal** y **portable entre distros** salvo que se indique lo contrario.

Los presets están organizados por caso de uso, no por distro:

| Preset | Cuándo usarlo | Logo | Privacidad |
|---|---|---|---|
| [`minimal`](./presets/minimal.jsonc) | Primer arranque, terminales mínimos, paste en IRC/SSH | ninguno | seguro |
| [`groups`](./presets/groups.jsonc) | Driver diario, digno de captura, agrupado por color | ninguno | seguro |
| [`demo`](./presets/demo.jsonc) | Capturas públicas, posts de blog, redes sociales | ninguno | **seguro (sin IP, sin infra)** |
| [`full`](./presets/full.jsonc) | Uso local, contexto completo del sistema, triaje de ops | auto | expone IPs + infra |

Cambia con un solo flag:

```sh
fastfetch --config ~/.config/fastfetch/presets/demo
fastfetch --config ~/.config/fastfetch/presets/groups
```

## Por qué estos presets

La mayoría de los configs de fastfetch que hay en línea son o:

- **JSONC monolítico de 400 líneas** con módulos custom que nadie más puede reproducir (`stat -c %W /` atado a un shell específico, `curl localhost:9998` para una config de proxy particular, query de distrobox que requiere Python), o
- **puramente cosméticos** (colores bonitos, sin señal real — colores y ASCII art que lucen bien pero no te dicen nada accionable).

Este repo intenta dividir la diferencia:

1. **Multi-preset en lugar de multi-config-en-uno.** Cambia con el flag `--config`, no editando JSON.
2. **Los presets son drop-in independientes.** Sin herencia compartida, sin includes, sin trucos. Puedes hacer `cp presets/demo.jsonc ~/.config/fastfetch/config.jsonc` y simplemente funciona.
3. **Los módulos custom están aislados y documentados.** Ver [`docs/CUSTOMIZATION.md`](./docs/CUSTOMIZATION.md).
4. **La privacidad es opt-in, no opt-out.** El preset `demo` no tiene IPs, no hace sondeos de red, no expone estado de infra, no muestra temperaturas. Es seguro de capturar y publicar.

## Instalación

### Instalación rápida (un preset)

```sh
git clone https://github.com/louzt/louzt-fastfetch-rice.git
cp louzt-fastfetch-rice/presets/demo.jsonc ~/.config/fastfetch/config.jsonc
fastfetch
```

### Instalación completa (todos los presets + helpers)

```sh
git clone https://github.com/louzt/louzt-fastfetch-rice.git ~/.local/share/louzt-fastfetch-rice
bash ~/.local/share/louzt-fastfetch-rice/scripts/install.sh
```

El script de instalación:

1. Respalda tu `~/.config/fastfetch/config.jsonc` existente (si hay) a `config.jsonc.bak-$(date +%Y%m%d)`.
2. Copia los 4 presets a `~/.config/fastfetch/presets/`.
3. Establece el preset por defecto a `demo` (puedes cambiarlo después).
4. Imprime un resumen de lo instalado.

### Requisitos

- [fastfetch](https://github.com/fastfetch-cli/fastfetch) ≥ 2.62
- Una [Nerd Font](https://www.nerdfonts.com/) (ej. JetBrainsMono Nerd Font) para que los íconos se rendericen
- Opcional pero recomendado: un terminal con el **protocolo gráfico de kitty** (Ghostty 1.0+, Kitty, WezTerm) para el logo real. Hace fallback a chafa ASCII en otros terminales.

## Triaje: ¿qué preset necesito?

Responde en orden:

1. **¿Voy a capturar esto y publicarlo?**
   → `demo` (sin IPs, sin infra, sin temperaturas).

2. **¿Estoy en mi máquina dev y quiero ver todo de un vistazo?**
   → `full`.

3. **¿Quiero algo organizado por categoría pero que siga siendo public-safe?**
   → `groups`.

4. **¿Solo quiero OS + kernel + uptime?**
   → `minimal`.

Si no estás seguro, empieza con `groups`. Es el más balanceado.

## Personalización

Ver [`docs/CUSTOMIZATION.md`](./docs/CUSTOMIZATION.md) para cómo:

- Agregar un módulo custom (ej. el conteo de distrobox, el estado de tu listener SOCKS)
- Usar formatos posicionales como `{1} @ {7} GHz` para limpiar la salida de CPU/GPU
- Mostrar la edad de instalación (`stat -c %W /`)
- Separar GPUs duales (discreta + integrada)

## Escaparate

**¿Quieres compartir tu fastfetch?** Publica una captura en [GitHub Discussions → Show and tell](https://github.com/louzt/louzt-fastfetch-rice/discussions/categories/show-and-tell) y la enlazaremos aquí.

El catálogo completo del escaparate vive en [`docs/SHOWCASE.md`](./docs/SHOWCASE.md) (auto-curado de enlaces a discusiones).

Usa [`.github/SHOWCASE_TEMPLATE.md`](./.github/SHOWCASE_TEMPLATE.md) si quieres — es opcional. Una foto o captura es suficiente.

## Contribuir

Ver [`CONTRIBUTING.md`](./CONTRIBUTING.md) para el flujo de trabajo. La versión corta:

- **Nuevo preset**: abre primero un issue con el caso de uso. Rechazamos presets que son solo variantes de color de los existentes.
- **Nueva doc / fix de doc**: PR directo. Los fixes chicos no necesitan issue.
- **Escaparate**: suelta una captura en [Show and tell](https://github.com/louzt/louzt-fastfetch-rice/discussions/categories/show-and-tell).

## Licencia

MIT. Ver [`LICENSE`](./LICENSE). Puedes forkear, vendorizar, redistribuir, vender merch con esto. Atribución apreciada, no requerida.

## Créditos

- [LierB/fastfetch](https://github.com/LierB/fastfetch) — inspiración del patrón multi-preset (8 presets en un repo).
- [harilvfs/fastfetch](https://github.com/harilvfs/fastfetch) — el post de Reddit que inició la ola moderna de configs de fastfetch.
- [fastfetch-cli/fastfetch](https://github.com/fastfetch-cli/fastfetch) — la herramienta en sí.
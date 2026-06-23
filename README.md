# louzt-fastfetch-rice

> Curated fastfetch presets with privacy-aware variants. Multi-shell, Wayland-first, hybrid laptops. Includes a triage playbook for adapting to your distro, ASCII and kitty-direct logos, and a community showcase.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](./LICENSE)
[![Fastfetch: 2.62+](https://img.shields.io/badge/fastfetch-2.62%2B-blue.svg)](https://github.com/fastfetch-cli/fastfetch)
[![Wayland: ready](https://img.shields.io/badge/wayland-ready-brightgreen.svg)](https://wayland.freedesktop.org/)
[![🇪🇸 Leer en español](https://img.shields.io/badge/Leer%20en-espa%C3%B1ol-red)](./README.es.md)

---

## What this is

A **opinionated collection of fastfetch presets** you can drop into `~/.config/fastfetch/` and switch between depending on the situation. Built and battle-tested on Debian + niri + Ghostty, but every preset is **terminal-agnostic** and **distro-portable** unless noted.

The presets are organized by use case, not by distro:

| Preset | When to use | Logo | Privacy |
|---|---|---|---|
| [`minimal`](./presets/minimal.jsonc) | First boot, minimal terminals, IRC/SSH paste | none | safe |
| [`groups`](./presets/groups.jsonc) | Daily driver, screenshot-worthy, color-grouped | none | safe |
| [`demo`](./presets/demo.jsonc) | Public screenshots, blog posts, social media | none | **safe (no IP, no infra)** |
| [`full`](./presets/full.jsonc) | Local use, full system context, ops triage | auto | exposes IPs + infra |

Switch with one flag:

```sh
fastfetch --config ~/.config/fastfetch/presets/demo
fastfetch --config ~/.config/fastfetch/presets/groups
```

## Why these presets

Most fastfetch configs online are either:

- **monolithic 400-line JSONC** with custom modules nobody else can reproduce (`stat -c %W /` tied to one shell, `curl localhost:9998` for one specific proxy setup, distrobox query that requires Python), or
- **purely cosmetic** (nice colors, no real signal — colors and ASCII art that look good but tell you nothing actionable).

This repo tries to split the difference:

1. **Multi-preset instead of multi-config-in-one**. Switch with `--config` flag, not by editing JSON.
2. **Presets are drop-in independent**. No shared inheritance, no includes, no clever tricks. You can `cp presets/demo.jsonc ~/.config/fastfetch/config.jsonc` and it just works.
3. **Custom modules are isolated and documented**. See [`docs/CUSTOM-MODULES.md`](./docs/CUSTOM-MODULES.md).
4. **Privacy is opt-in, not opt-out**. The `demo` preset has no IPs, no network probes, no infra state, no temperatures. It is safe to screenshot and post.

## Install

### Quick install (one preset)

```sh
git clone https://github.com/louzt/louzt-fastfetch-rice.git
cp louzt-fastfetch-rice/presets/demo.jsonc ~/.config/fastfetch/config.jsonc
fastfetch
```

### Full install (all presets + helpers)

```sh
git clone https://github.com/louzt/louzt-fastfetch-rice.git ~/.local/share/louzt-fastfetch-rice
bash ~/.local/share/louzt-fastfetch-rice/scripts/install.sh
```

The install script will:

1. Backup your existing `~/.config/fastfetch/config.jsonc` (if any) to `config.jsonc.bak-$(date +%Y%m%d)`.
2. Copy all 4 presets to `~/.config/fastfetch/presets/`.
3. Set the default preset to `demo` (you can change it later).
4. Print a summary of what was installed.

### Requirements

- [fastfetch](https://github.com/fastfetch-cli/fastfetch) ≥ 2.62
- A [Nerd Font](https://www.nerdfonts.com/) (e.g. JetBrainsMono Nerd Font) for the icons to render
- Optional but recommended: a terminal with the **kitty graphics protocol** (Ghostty 1.0+, Kitty, WezTerm) for the real logo. Falls back to chafa ASCII in other terminals.

## Triage: which preset do I need?

Answer in order:

1. **Am I going to screenshot this and post it publicly?**
   → `demo` (no IPs, no infra, no temperatures).

2. **Am I on my dev machine and want to see everything at a glance?**
   → `full`.

3. **Do I want something organized by category but still public-safe?**
   → `groups`.

4. **Do I just want OS + kernel + uptime?**
   → `minimal`.

If you're unsure, start with `groups`. It's the most balanced.

## Customization

See [`docs/CUSTOMIZATION.md`](./docs/CUSTOMIZATION.md) for how to:

- Add a custom module (e.g., your distrobox count, your SOCKS listener state)
- Use positional formats like `{1} @ {7} GHz` to clean up CPU/GPU output
- Show install age (`stat -c %W /`)
- Split dual GPUs (discrete + integrated)

## Showcase

**Want to share your fastfetch?** Post a screenshot in [GitHub Discussions → Show and tell](https://github.com/louzt/louzt-fastfetch-rice/discussions/categories/show-and-tell) and we will link it here.

The full showcase catalog lives in [`docs/SHOWCASE.md`](./docs/SHOWCASE.md) (auto-curated from discussion links).

Use the [`.github/SHOWCASE_TEMPLATE.md`](./.github/SHOWCASE_TEMPLATE.md) if you want — it's optional. A photo or screenshot is enough.

## Contributing

See [`CONTRIBUTING.md`](./CONTRIBUTING.md) for the workflow. The short version:

- **New preset**: open an issue with the use case first. We reject presets that are just color variants of existing ones.
- **New docs / doc fix**: PR directly. Small fixes don't need an issue.
- **Showcase**: drop a screenshot in [Show and tell](https://github.com/louzt/louzt-fastfetch-rice/discussions/categories/show-and-tell).

## License

MIT. See [`LICENSE`](./LICENSE). You can fork, vendor, redistribute, sell merch with it. Attribution appreciated, not required.

## Credits

- [LierB/fastfetch](https://github.com/LierB/fastfetch) — multi-preset pattern inspiration (8 presets in one repo).
- [harilvfs/fastfetch](https://github.com/harilvfs/fastfetch) — the Reddit post that started the modern fastfetch config wave.
- [fastfetch-cli/fastfetch](https://github.com/fastfetch-cli/fastfetch) — the tool itself.
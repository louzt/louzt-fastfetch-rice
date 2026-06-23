# Showcase template

Use this template when posting your fastfetch in [Show and tell](https://github.com/louzt/louzt-fastfetch-rice/discussions/categories/show-and-tell). Optional — a photo is enough.

## What to include

- **Screenshot or video** (drag-and-drop in the discussion composer).
- **Preset used**: `minimal` / `groups` / `demo` / `full` / custom. Link to your fork or preset file.
- **Terminal**: name + version (e.g., `Ghostty 1.3.1`, `Kitty 0.40`, `WezTerm 20240203`).
- **WM/Compositor**: niri, Hyprland, Sway, i3, none, etc.
- **Distro**: Debian, Arch, NixOS, etc.
- **Font**: Nerd Font used (e.g., `JetBrainsMono Nerd Font 13`).
- **Anything custom**: a one-line note on modules you added (e.g., "added distrobox count via custom command").

## Privacy checklist (please redact if any apply)

Before posting, check that your screenshot does NOT show:

- [ ] Public or local IP addresses (`192.168.x.x`, your public IP)
- [ ] MAC address (visible in some `ip` outputs)
- [ ] Hostname (if it's your real name, e.g., `lou-laptop`)
- [ ] Specific disk serials
- [ ] Internal service URLs (e.g., `http://192.168.x.x:9381/metrics`)
- [ ] Anything that looks like a private key, token, or password

If in doubt, **use the `demo` preset** for your screenshot and then add a one-line note: "(actual preset is `full` with private info redacted)".

## Template (copy-paste this)

```markdown
### [Your title — e.g., "Debian + Hyprland rice"]

- **Preset**: [link to file or commit]
- **Terminal**: e.g., Kitty 0.40
- **WM/Compositor**: e.g., Hyprland
- **Distro**: e.g., Debian 12
- **Font**: e.g., JetBrainsMono Nerd Font 13
- **Custom modules**: e.g., "added `󰋩 Distrobox` custom command"
- **Anything else worth noting**: e.g., "using `kitty-direct` for the logo, falls back to chafa in TUI"

![screenshot](attach via drag-and-drop)
```

## Optional: link to your config repo

If you forked or vendored this repo, link it. We will add it to [`docs/SHOWCASE.md`](./docs/SHOWCASE.md) under "Community forks".

## Why this template?

Most fastfetch posts on Reddit or forums are screenshots with no context. After 50 of them, you can't tell which is which. The template is short enough that anyone can fill it in 30 seconds, and structured enough that future readers can find what they want.
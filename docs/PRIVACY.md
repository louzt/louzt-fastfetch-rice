# Privacy guide

Fastfetch screenshots are easy to leak. This guide covers what to redact before posting a screenshot publicly, and how to make a public-safe preset.

## The 30-second rule

Before posting any fastfetch screenshot, check the screenshot for these strings:

- `192.168.` (private IPv4)
- `10.` (private IPv4)
- `172.16.` through `172.31.` (private IPv4)
- Anything that looks like a public IPv4 (e.g., `189.172.x.x`)
- `BSSID`, `inet6`, `fe80::` (IPv6 link-local)
- `wlp`, `enp`, `eth` followed by MAC-looking hex
- Hostnames that include your real name (e.g., `lou-laptop`, `john-pc`)
- Tokens, API keys, anything starting with `sk-`, `ghp_`, `Bearer `

If you see any of these, **redact before posting**. Don't rely on "I'll crop it later".

## What `demo.jsonc` excludes (and why)

The `demo` preset is built for screenshots. It does not include:

| Module | What it would leak | Omitted from `demo` |
|---|---|:---:|
| `localip` | Your LAN IP (often correlates to your router) | ✓ |
| `publicip` | Your home/business public IP | ✓ |
| `route` | Your gateway IP | ✓ |
| `publicip` + `route` combo | Approximate geolocation | ✓ |
| Custom `QUIC` / `SOCKS` | Internal service ports + state | ✓ |
| `distrobox` (custom) | Which distros you run internally | ✓ |
| `thermals --brief` | Specific °C values, hardware model | ✓ |
| `brightness` | Specific backlight device | ✓ |
| `gpu` (specific) | Exact GPU model | partial |

What it keeps:

- Generic OS info (Debian, Arch, etc.)
- Generic host info (kernel, shell, wm, terminal)
- Time, uptime, install age
- CPU/GPU **type** but not full PCI ID
- Memory, swap, disk **capacities** but not serial numbers
- Colors swatch (purely cosmetic)

## When `groups.jsonc` is OK to post

The `groups` preset is also public-safe (no network modules). Use it when you want a more visually rich screenshot but still no private info.

## When you must use `full.jsonc`

Only on your dev machine, only locally, never in a screenshot. If you really need to share it for debugging, blur the right column with ImageMagick or similar:

```sh
convert screenshot.png -crop 50x100%+50%+0 -fill black -draw "rectangle 0,0 %[w],%[h]" screenshot-redacted.png
```

## Custom modules: privacy checklist

When adding a custom module, ask:

1. Does it make a network request? (`curl http://...`) → probably private.
2. Does it reveal internal service ports? → probably private.
3. Does it reveal hardware serials? → private.
4. Does it run `stat`, `df`, `free`? → usually safe.
5. Does it call `python3` with arbitrary code? → review the script.

Default to omitting. Re-add only when the use case justifies it.

## Forks and derivatives

If you fork this repo and remove the privacy-sensitive presets (`full` becomes your default), that's fine — but document it in your README so downstream users know what they're getting.

## Local file permissions (multi-user systems)

Fastfetch config files often contain sensitive data: local IP, public IP (sometimes via SOCKS), default route, distrobox names, SOCKS/VPN listener state, custom shell commands, thermal sensors, hostname. If you share the host with other users (shared workstation, dev server with teammates, compromised account), the **default umask 022 leaves every file world-readable (644)** — meaning any local user can `cat ~/.config/fastfetch/config.jsonc` and reconstruct your network topology.

`scripts/install.sh` defends against this:

- Sets `umask 077` at the top so new files default to 600 and new directories to 700.
- Explicitly `chmod 600` on every preset file after copy (belt-and-suspenders in case the source had looser perms).
- `chmod 700` on `~/.config/fastfetch/` and `chmod 600` on the existing `config.jsonc` BEFORE backing it up.
- Backup files (`config.jsonc.bak-<timestamp>`) are also chmod 600.

If you copy or create fastfetch files manually instead of using `install.sh`, run:

```sh
chmod 700 ~/.config/fastfetch
chmod 600 ~/.config/fastfetch/*.jsonc
chmod 600 ~/.config/fastfetch/presets/*.jsonc
```

This was added 2026-06-23 after a peer review caught a real exposure: a fresh install on a typical Debian desktop left the backup file at mode 664, group-writable + world-readable.
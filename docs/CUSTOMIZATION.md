# Customization

How to bend the presets to your setup.

## Switch the logo

By default the `full` preset uses `~/.config/fastfetch/logo-current` (a symlink). To change the logo:

```sh
# Option 1: point the symlink at a different PNG/SVG
ln -sf ~/.config/quickshell/dms/assets/danklogo.svg ~/.config/fastfetch/logo-current

# Option 2: edit the preset directly
# In presets/full.jsonc, change "source": "~/.config/fastfetch/logo-current"
# to "source": "/your/path/to/image.png"
```

The `auto` logo type picks the best render method for your terminal:

- **Ghostty / Kitty / WezTerm** → kitty graphics protocol (real image)
- **Anything else** → chafa ASCII fallback

## Add a custom module

Pattern (from `presets/full.jsonc`):

```jsonc
{
  "type": "command",
  "key": "󰋩 My Custom Module",
  "keyColor": "light_yellow",
  "text": "sh -lc 'echo \"value here\"'",
  "format": "{}"
}
```

`text` runs in `sh -lc` (login shell), so you can use `$PATH`, env vars, aliases. `format` is the printf-style format; `{}` is replaced with stdout.

For multi-line output, use a real script:

```jsonc
{
  "type": "command",
  "key": "󰋩 Distrobox",
  "text": "sh -lc '~/.local/bin/distrobox-summary.sh'",
  "format": "{}"
}
```

See [`PRESET-TRIAGE.md`](./PRESET-TRIAGE.md) for more patterns.

## Positional formats

Fastfetch modules support `{N}` for positional substitution. For example, for `cpu`:

- `{1}` = name (e.g., "AMD Ryzen 7 4800H")
- `{2}` = vendor
- `{3}` = architecture
- `{6}` = core count
- `{7}` = base GHz

The full list is in `fastfetch --help cpu`. Example:

```jsonc
{
  "type": "cpu",
  "key": " CPU",
  "format": "{1} ({6} cores) @ {7} GHz"
}
```

Renders as: `CPU    AMD Ryzen 7 4800H (16 cores) @ 4.30 GHz`.

For GPU, `{1}` is the model name, `{2}` is the vendor, `{3}` is the iGPU variant (useful for hybrid laptops):

```jsonc
{ "type": "gpu", "key": " dGPU", "format": "{1} {2}" },
{ "type": "gpu", "key": " iGPU", "format": "{3}" }
```

## Install age

A custom module that shows days since the OS was installed (works on Linux, Unix-like systems):

```jsonc
{
  "type": "command",
  "key": "󰗂 Install Age",
  "keyColor": "light_yellow",
  "text": "sh -lc 'birth=$(stat -c %W / 2>/dev/null || echo 0); now=$(date +%s); [ \"$birth\" -gt 0 ] 2>/dev/null && echo \"$(( (now - birth) / 86400 )) days ($(date -d @$birth +%Y-%m-%d 2>/dev/null))\" || echo unknown'"
}
```

Renders as: `Install Age    142 days (2026-02-01)`.

## Disable modules per preset

Comment them out with `//`:

```jsonc
"modules": [
    "title",
    // "datetime",  // disabled, not needed at 3 AM
    "os",
    "kernel"
]
```

Comment-out is preferred over deletion — easy to revert.

## Speed up fastfetch

- Move heavy custom modules (`curl http://...`) to a slower preset.
- Avoid `python3 -c` in custom modules — `sh -lc` with simple commands is faster.
- Use `command -v` to detect tools without calling them:

```jsonc
"text": "sh -lc 'command -v distrobox >/dev/null && distrobox list --format json | jq -r .[].name || echo none'"
```
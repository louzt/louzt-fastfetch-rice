# Screenshots

This folder holds reference screenshots used in the README and docs.

## Files

| File | What it shows | Preset |
|---|---|---|
| `danklogo.png` | The default logo (Dank Material Shell mark) | — |
| `groups-preset.txt` | Rendered `groups` preset, text-only | `groups` |
| `demo-preset.txt` | Rendered `demo` preset, text-only | `demo` |
| `minimal-preset.txt` | Rendered `minimal` preset, text-only | `minimal` |

The text files are kept (not converted to PNG) because:

1. They render perfectly in any markdown viewer.
2. They don't depend on a specific terminal width.
3. They preserve accessibility — screen readers can read them.

## How to regenerate

```sh
# Render the demo preset to a file
fastfetch --config presets/demo.jsonc --logo none > screenshots/demo-preset.txt

# Render with kitty-direct (real image, requires Ghostty/Kitty/WezTerm)
fastfetch --config presets/demo.jsonc > screenshots/demo-preset.bin
```

For the kitty-direct binary output, you'd need a terminal compositor that can capture it. We don't include those here to keep the repo small and text-search-friendly.

## Adding a screenshot for a new preset

1. Render the preset to a text file: `fastfetch --config presets/your-preset.jsonc --logo none > screenshots/your-preset.txt`.
2. Run `gofmt -w screenshots/your-preset.txt` if you want it pretty (well, no, fastfetch doesn't have a formatter — just trim trailing whitespace).
3. Open a PR adding the file.
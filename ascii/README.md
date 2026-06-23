# ASCII art logos

This folder is intentionally empty for most distros — fastfetch ships with 16 official built-in logos (Debian, Arch, Ubuntu, Fedora, Manjaro, NixOS, Gentoo, Void, openSUSE, Windows, macOS, Android, Alpine, CentOS, Mint, RedHat) and `auto` detection.

## Use a built-in

```jsonc
"logo": {
  "source": "debian",  // built-in, not a file path
  "type": "auto",      // detect best render method
  "padding": { "right": 3 }
}
```

Or let fastfetch auto-detect your distro:

```jsonc
"logo": {
  "source": "auto",
  "type": "auto"
}
```

## When built-ins don't cover your case

For a distro or compositor without a built-in (e.g., niri on a niche distro), three options:

1. **Point at your WM's official logo.** Most compositors ship an SVG/PNG in their repo. Convert via `chafa` or hand the PNG to fastfetch directly.

2. **Fall back to the OS logo.** `logo.source: "auto"` uses the OS logo when the WM isn't recognized. A Debian + niri user gets the Debian swirl.

3. **Request a new built-in upstream.** File an issue at [fastfetch-cli/fastfetch](https://github.com/fastfetch-cli/fastfetch/issues) with a reference image. They accept good logo contributions — adding one here would duplicate work the maintainers would land anyway.

## Add to this folder only if

You've checked options 1–3 above, none fit, and your ASCII has a reason to live here that's specific to this repo (e.g., a curated showcase logo for a community event). Open an issue first so we can talk about scope before you commit time.
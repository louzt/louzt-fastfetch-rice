# Contributing to louzt-fastfetch-rice

Thanks for stopping by. This document covers the three ways you can contribute to this repo.

## 1. New preset

A preset is a self-contained `*.jsonc` file in [`presets/`](./presets). New presets need to clear these bars:

- **One use case, clearly named.** `demo`, `minimal`, `groups`, `full` each answer a different question. Don't submit `cyan.jsonc` (color variant) or `arch.jsonc` (distro variant).
- **Drop-in independent.** No shared state, no global scripts, no environment variables the user has to set.
- **Public-safe by default**, unless explicitly marked as `*-local` in the filename. Public-safe means: no public IPs, no gateway info, no local-only services, no specific hardware serials.
- **JSONC-valid.** Run `python3 -c "import re, json; t = open('your-preset.jsonc').read(); t = re.sub(r'^\s*//.*$', '', t, flags=re.M); print('OK' if json.loads(t) else 'FAIL')"` before submitting.

**Workflow:**

1. Open an issue with the use case. Example title: "Add `headless.jsonc` for servers (no GPU, no display modules)".
2. Get a maintainer nod.
3. Open a PR with the preset + a one-paragraph update to [`presets/README.md`](./presets/README.md).

## 2. Docs / doc fix

Small fixes (typos, broken links, clearer wording) → open a PR directly, no issue needed.

Big changes (new doc file, restructuring) → open an issue first.

## 3. Showcase

Drop a screenshot in [Discussions → Show and tell](https://github.com/louzt/louzt-fastfetch-rice/discussions/categories/show-and-tell). Optional but encouraged: use [`.github/SHOWCASE_TEMPLATE.md`](./.github/SHOWCASE_TEMPLATE.md) for context (terminal, distro, font).

If your screenshot includes IPs, hostname, or anything identifiable, **redact it first** or use the `demo` preset. We curate the [showcase catalog](./docs/SHOWCASE.md) weekly.

## Code of conduct

Be kind. This is a config repo, not a startup. Disagreement about color palettes is not grounds for a fight.

## Style

- 4-space indent in JSONC.
- Comments at the top of each preset (the ASCII art header) describing what the preset is for.
- Module `key` values: Nerd Font icons where the user expects them (`󰏖` for packages, `󰍛` for memory). Strip them for `*-public-safe` presets.
- No `# generated with AI` or `# co-authored-by` trailers in commits. Just write the commit message.
- One logical change per commit. Don't mix "add preset" with "fix typo in README".

## Local testing

```sh
# Validate JSONC
python3 -c "import re, json; print('OK' if json.loads(re.sub(r'^\s*//.*$', '', open('presets/your-preset.jsonc').read(), flags=re.M)) else 'FAIL')"

# Render in PTY (kitty graphics will appear as binary, ASCII as text)
script -qc "fastfetch --config presets/your-preset.jsonc --logo none" /dev/null

# Generate an ASCII preview for the docs
chafa --size=80x24 --colors=full --symbols=block symbols/your-ascii.txt > /tmp/preview.txt
```

## License

By contributing, you agree your contributions are MIT-licensed (same as this repo).
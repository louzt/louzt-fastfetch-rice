# Presets

Four presets, four use cases. Pick by reading the table in the main [README](../README.md#what-this-is), or follow the triage decision tree below.

## Decision tree

```
Are you going to screenshot this publicly?
├── Yes  → demo.jsonc
└── No
    ├── Want to see everything (incl. IPs, infra state)?
    │   ├── Yes → full.jsonc
    │   └── No  → groups.jsonc
    └── Just need OS + kernel + uptime?
        └── Yes → minimal.jsonc
```

## What each preset includes

| Module | `minimal` | `groups` | `demo` | `full` |
|---|:-:|:-:|:-:|:-:|
| title | ✓ | ✓ | ✓ | ✓ |
| datetime | ✓ | ✓ | ✓ | ✓ |
| os / host / kernel | ✓ | ✓ | ✓ | ✓ |
| uptime | ✓ | ✓ | ✓ | ✓ |
| install_age | — | — | ✓ | ✓ |
| packages | ✓ | — | ✓ | ✓ |
| shell / terminal / wm | ✓ | ✓ | ✓ | ✓ |
| theme | — | — | ✓ | ✓ |
| distrobox (custom) | — | — | — | ✓ |
| network (localip, publicip, route) | — | — | — | ✓ |
| QUIC / SOCKS / Proxy state (custom) | — | — | — | ✓ |
| cpu (with GHz) | ✓ | ✓ | ✓ | ✓ |
| gpu (split dGPU / iGPU) | — | ✓ (single) | — | ✓ |
| thermals (specific °C) | — | — | — | ✓ |
| brightness | — | — | — | ✓ |
| memory / swap | ✓ | ✓ | ✓ | ✓ |
| loadavg / procs | — | ✓ | — | ✓ |
| disk | ✓ | ✓ | ✓ | ✓ |
| colors swatch | ✓ | ✓ | ✓ | ✓ |

## Adding a new preset

See [`../CONTRIBUTING.md`](../CONTRIBUTING.md) § "New preset".

Short version:

1. Copy the closest existing preset.
2. Edit. Keep it under 200 lines if possible.
3. Validate: `python3 -c "import re, json; t = open('your-preset.jsonc').read(); print('OK' if json.loads(re.sub(r'^\s*//.*$', '', t, flags=re.M)) else 'FAIL')"`.
4. Update the table above.
5. Open a PR.
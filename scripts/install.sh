#!/usr/bin/env bash
#
# install.sh — install louzt-fastfetch-rice presets to ~/.config/fastfetch/
#
# Usage:
#   bash install.sh                 # interactive: ask which preset is default
#   bash install.sh --default demo  # non-interactive: set 'demo' as default
#   bash install.sh --uninstall     # remove what we installed (keep user files)
#
# Idempotent. Re-run safely.

set -euo pipefail

# Security: ensure all files we create or copy start with restrictive
# permissions. The previous default (umask 022) produced 644 backups
# that exposed hostnames, IPs, SOCKS/VPN listeners, distrobox names,
# and other infrastructure fingerprinting data to any local user on
# the system. The peer review on 2026-06-23 caught this as a critical
# OPSEC gap. umask 077 means new files default to 600 and new
# directories to 700. We also chmod explicitly after each cp for
# belt-and-suspenders in case the source file's permissions leak
# through.
umask 077

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/fastfetch"
PRESETS_SRC="$REPO_DIR/presets"
PRESETS_DST="$CONFIG_DIR/presets"
ASCII_SRC="$REPO_DIR/ascii"
ASCII_DST="$CONFIG_DIR/../local/share/louzt-fastfetch-rice/ascii"

default_preset="demo"
uninstall=false

while [[ $# -gt 0 ]]; do
  case "$1" in
    --default) default_preset="$2"; shift 2 ;;
    --uninstall) uninstall=true; shift ;;
    -h|--help)
      sed -n '2,12p' "$0"
      exit 0
      ;;
    *) echo "unknown arg: $1" >&2; exit 1 ;;
  esac
done

if $uninstall; then
  echo "Removing presets from $PRESETS_DST ..."
  rm -rf "$PRESETS_DST"
  echo "Done. Your original $CONFIG_DIR/config.jsonc was not touched."
  exit 0
fi

# 0. Lock down $CONFIG_DIR and the existing config.jsonc BEFORE we
# create a backup of them. If config.jsonc already exists with 644
# (the typical fastfetch default), every other user on the system can
# read the host's network topology right now. Fix that first.
if [[ -d "$CONFIG_DIR" ]]; then
  chmod 700 "$CONFIG_DIR" 2>/dev/null || true
fi
if [[ -f "$CONFIG_DIR/config.jsonc" ]]; then
  chmod 600 "$CONFIG_DIR/config.jsonc" 2>/dev/null || true
fi

# 1. Backup existing config (restrictive perms, even if source leaked)
if [[ -f "$CONFIG_DIR/config.jsonc" ]]; then
  bak="$CONFIG_DIR/config.jsonc.bak-$(date +%Y%m%d-%H%M%S)"
  cp "$CONFIG_DIR/config.jsonc" "$bak"
  chmod 600 "$bak" 2>/dev/null || true
  echo "Backed up existing config → $bak (mode 600)"
fi

# 2. Copy presets (each preset file gets 600 — they're config snippets,
# not secrets, but the dir itself stays locked)
mkdir -p "$PRESETS_DST"
chmod 700 "$PRESETS_DST" 2>/dev/null || true
for f in "$PRESETS_SRC"/*.jsonc; do
  cp "$f" "$PRESETS_DST/"
  chmod 600 "$PRESETS_DST/$(basename "$f")" 2>/dev/null || true
done
echo "Installed 4 presets to $PRESETS_DST (mode 600 each)"

# 3. Set default
case "$default_preset" in
  minimal|groups|demo|full) ;;
  *) echo "unknown preset '$default_preset' (use minimal/groups/demo/full)" >&2; exit 1 ;;
esac

if [[ "$default_preset" == "demo" ]]; then
  # Copy demo.jsonc as the default config so plain `fastfetch` works
  cp "$PRESETS_SRC/demo.jsonc" "$CONFIG_DIR/config.jsonc"
  chmod 600 "$CONFIG_DIR/config.jsonc" 2>/dev/null || true
  echo "Set default preset → $default_preset (config.jsonc replaced with $default_preset.jsonc, mode 600)"
else
  # Symlink to preserve the link to the preset (easier to switch later)
  ln -sfn "$PRESETS_DST/$default_preset.jsonc" "$CONFIG_DIR/config.jsonc"
  echo "Set default preset → $default_preset (config.jsonc symlinked)"
fi

# 4. Summary
echo ""
echo "=== install complete ==="
echo "Presets in:   $PRESETS_DST (mode 700)"
echo "Default:      $default_preset"
echo "Try it:       fastfetch"
echo "Switch with:  fastfetch --config $PRESETS_DST/groups"
echo "Uninstall:    bash $REPO_DIR/scripts/install.sh --uninstall"
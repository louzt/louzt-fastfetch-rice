#!/usr/bin/env bash
#
# logo-switch.sh — point the fastfetch logo symlink at a new image.
#
# Usage:
#   bash logo-switch.sh /path/to/image.png
#   bash logo-switch.sh --default    # reset to the DMS default
#
# Affects: ~/.config/fastfetch/logo-current
# Falls back gracefully if fastfetch is not installed.

set -euo pipefail

CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/fastfetch"
LOGO_LINK="$CONFIG_DIR/logo-current"
DEFAULT_LOGO="$HOME/.config/quickshell/dms/matugen/vsix-build/danklogo.png"

target="${1:-}"

if [[ "$target" == "--default" || -z "$target" ]]; then
  target="$DEFAULT_LOGO"
fi

# Expand ~
target="${target/#\~/$HOME}"

if [[ ! -f "$target" ]]; then
  echo "image not found: $target" >&2
  exit 1
fi

# Validate it's actually an image (not a random file)
mime="$(file --brief --mime-type -- "$target")"
if [[ "$mime" != image/* ]]; then
  echo "not an image (mime=$mime): $target" >&2
  exit 1
fi

# Replace the symlink
mkdir -p "$CONFIG_DIR"
ln -sfn "$target" "$LOGO_LINK"
echo "logo-current → $target"
echo ""
echo "Verify: readlink -f $LOGO_LINK"
echo "Render:  fastfetch --logo $LOGO_LINK"
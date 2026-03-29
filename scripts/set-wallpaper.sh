#!/usr/bin/env bash
set -euxo pipefail

# set-wallpaper.sh
# Copies black.png into the current theme's backgrounds and sets it via omarchy.

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ASSETS_DIR="$SCRIPT_DIR/../assets"
THEME_BG_DIR="$HOME/.config/omarchy/current/theme/backgrounds"

if [[ ! -d "$THEME_BG_DIR" ]]; then
  echo "Error: theme backgrounds dir not found: $THEME_BG_DIR"
  exit 1
fi

cp "$ASSETS_DIR/black.png" "$THEME_BG_DIR/black.png"
omarchy-theme-bg-set "$THEME_BG_DIR/black.png"
echo "  installed: black wallpaper"

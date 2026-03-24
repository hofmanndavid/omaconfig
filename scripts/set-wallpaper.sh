#!/usr/bin/env bash
set -euxo pipefail

# set-wallpaper.sh
# Copies black.png into the current theme's backgrounds and repoints the background symlink.

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ASSETS_DIR="$SCRIPT_DIR/../assets"
THEME_BG_DIR="$HOME/.config/omarchy/current/theme/backgrounds"

if [[ ! -d "$THEME_BG_DIR" ]]; then
  echo "Error: theme backgrounds dir not found: $THEME_BG_DIR"
  exit 1
fi

cp "$ASSETS_DIR/black.png" "$THEME_BG_DIR/black.png"
ln -sf "$THEME_BG_DIR/black.png" "$HOME/.config/omarchy/current/background"
echo "  installed: black wallpaper"

#!/usr/bin/env bash
set -euo pipefail

# install-config.sh
# Copies tracked config files from this repo to the live system.
# Keep the FILES array in sync with pull-config.sh.

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
CONFIGS_DIR="$REPO_DIR/configs"
HOME_DIR="$HOME"

FILES=(
  ".bashrc"
  ".config/hypr/bindings.conf"
  ".config/hypr/input.conf"
  ".config/hypr/monitors.conf"
  ".config/alacritty/alacritty.toml"
  ".config/hypr/looknfeel.conf"
)

echo "=== Installing configs to system ==="

for file in "${FILES[@]}"; do
  src="$CONFIGS_DIR/$file"
  dest="$HOME_DIR/$file"

  if [[ -f "$src" ]]; then
    mkdir -p "$(dirname "$dest")"
    cp "$src" "$dest"
    echo "  installed: $file"
  else
    echo "  SKIP (not in repo): $src"
  fi
done

echo "=== Done ==="

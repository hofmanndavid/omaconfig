#!/usr/bin/env bash
set -euo pipefail

# pull-config.sh
# Pulls tracked config files from the live system into this repo.
# Add new files to the FILES array as needed (and mirror in install-config.sh).

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

echo "=== Pulling configs from system ==="

for file in "${FILES[@]}"; do
  src="$HOME_DIR/$file"
  dest="$CONFIGS_DIR/$file"

  if [[ -f "$src" ]]; then
    mkdir -p "$(dirname "$dest")"
    cp "$src" "$dest"
    echo "  pulled: $file"
  else
    echo "  SKIP (not found): $src"
  fi
done

echo "=== Done ==="

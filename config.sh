#!/usr/bin/env bash
set -euo pipefail

# config.sh [pull|install]
# pull    — copy tracked config files from the live system into this repo
# install — copy tracked config files from this repo to the live system

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

case "${1:-}" in
  pull)
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
    ;;
  install)
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
    ;;
  *)
    echo "Usage: $0 [pull|install]"
    exit 1
    ;;
esac

echo "=== Done ==="

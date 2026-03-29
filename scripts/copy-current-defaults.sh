#!/usr/bin/env bash
set -euo pipefail

# snapshot-defaults.sh
#
# Purpose:
#   On a fresh Omarchy install, the system ships with default config files
#   (e.g. ~/.config/waybar/config.jsonc, ~/.config/hypr/bindings.conf, etc.).
#   This repo tracks our customized versions of those files under configs/.
#   When we stow, our versions replace the system defaults — so we lose
#   visibility into what the new Omarchy release may have changed.
#
#   This script captures the fresh system defaults BEFORE stow overwrites them,
#   placing them into a defaults/ directory that mirrors the configs/ structure.
#   You can then open both directories side-by-side in IntelliJ (or any diff tool)
#   to see what upstream changed and decide what to merge into your overrides.
#
# How it works:
#   1. Finds every file under configs/ in this repo
#   2. For each file, looks for the corresponding system file at ~/
#      (e.g. configs/.config/waybar/config.jsonc -> ~/.config/waybar/config.jsonc)
#   3. Copies the system version into defaults/ at the same relative path
#   4. Files that don't exist on the system (e.g. .bashrc additions) are skipped
#
# Usage:
#   Run on a fresh install BEFORE stowing:
#     ./scripts/snapshot-defaults.sh
#     # Review defaults/ vs configs/ in IntelliJ
#     stow -v -t ~ configs
#
# Note: defaults/ is gitignored — it's a temporary workspace, not committed.

echo ""
echo "Snapshoting current default for files we are tracking with stow."

# Resolve the repo root (this script lives in repo/scripts/)
REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
DEFAULTS_DIR="$REPO_DIR/defaults"

# Start fresh — remove any previous snapshot
rm -rf "$DEFAULTS_DIR"

copied=0
missing=0

# Walk every file we track in configs/ and grab the system's current version
while IFS= read -r file; do
  # Strip the configs/ prefix to get the path relative to ~/
  # e.g. /path/to/repo/configs/.config/waybar/config.jsonc -> .config/waybar/config.jsonc
  rel="${file#$REPO_DIR/configs/}"

  # This is where the system default lives before stow replaces it
  src="$HOME/$rel"

  if [ -f "$src" ]; then
    mkdir -p "$DEFAULTS_DIR/$(dirname "$rel")"
    cp -L "$src" "$DEFAULTS_DIR/$rel"
    echo "  copied: $rel"
    ((copied++)) || true
  else
    # File doesn't exist on the system — it's something we added ourselves
    # (e.g. a custom .bashrc that doesn't ship with Omarchy)
    echo "  missing: $rel (no system default)"
    ((missing++)) || true
  fi
done < <(find "$REPO_DIR/configs" -type f)

echo ""
echo "Snapshot complete: $copied copied, $missing missing"
echo "Now diff defaults/ vs configs/ in your editor, then run stow."
echo ""
#!/usr/bin/env bash
set -euxo pipefail

# fresh-install.sh
# Run on a fresh Omarchy install to restore additional software.
# Add new install commands as you install things — don't remove old ones.

# --- Require sudo (needed for pacman installs) ---
if ! sudo -v; then
  echo "Error: this script requires sudo privileges"
  exit 1
fi

echo "=== installing additional software ==="

# --- Omarchy installer scripts ---
omarchy install browser chrome
omarchy default browser chrome
omarchy install vscode
omarchy install zed
omarchy install dev env bun
omarchy install dev env python

# --- System packages (pacman) ---
PACMAN_PACKAGES=(
  stow
  gnome-boxes
  transmission-gtk
  fio
)
omarchy-pkg-add "${PACMAN_PACKAGES[@]}"

echo "=== Done ==="

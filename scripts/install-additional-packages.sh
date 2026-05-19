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
  pnpm
)
omarchy-pkg-add "${PACMAN_PACKAGES[@]}"

# --- JS package manager supply-chain hardening ---
# Block dependency lifecycle scripts (preinstall/install/postinstall/prepare) —
# the most common npm supply-chain attack vector. Re-enable per project with
# `npm install --ignore-scripts=false` (or `pnpm install --ignore-scripts=false`)
# when a dep genuinely needs native builds. Bun already gates lifecycle scripts
# behind an explicit `trustedDependencies` allowlist, so no global flag needed.
npm config set ignore-scripts true
pnpm config set enable-pre-post-scripts false
# Quarantine: refuse to install any package published <7 days ago. Catches
# malicious releases that typically get yanked within hours/days. 10080 = 7d
# in minutes. npm has no native equivalent; bun's support is too new to rely
# on, so this only applies when using pnpm.
pnpm config set minimum-release-age 10080

echo "=== Done ==="

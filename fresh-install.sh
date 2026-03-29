#!/usr/bin/env bash
set -euxo pipefail

# fresh-install.sh
# Run on a fresh Omarchy install to restore additional software.
# Add new install commands as you install things — don't remove old ones.

echo "=== Fresh Install: Additional Software ==="

# --- Snapshot fresh defaults for diffing before stow ---
"$(dirname "$0")/scripts/snapshot-defaults.sh"

# --- Require sudo (needed for pacman installs) ---
if ! sudo -v; then
  echo "Error: this script requires sudo privileges"
  exit 1
fi

# --- System packages (pacman) ---
sudo pacman -S --noconfirm stow
sudo pacman -S --noconfirm sublime-text-4
sudo pacman -S --noconfirm gnome-boxes

# --- NPM based CLI tools ---
npm install -g varlock@latest
npm install -g @playwright/cli@latest
# install claude playwright-cli user-wide
(cd && playwright-cli install --skill)
mise reshim  # ensure npm -g binaries get shims (needed for non-shell apps like IntelliJ)

# --- SDK based installs ---
curl -s "https://get.sdkman.io" | bash
source ~/.sdkman/bin/sdkman-init.sh
sdk install java 25.0.2-tem
sdk install maven 3.9.14
sdk install gradle 9.4.0

# --- Install JetBrains Toolbox ---
"$(dirname "$0")/scripts/install-jetbrains-toolbox.sh"

# --- Post-install setup ---
"$(dirname "$0")/scripts/set-wallpaper.sh"

# --- Deploy config symlinks via stow ---
REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
stow -v -t "$HOME" -d "$REPO_DIR" configs

echo "Review defaults/ vs configs/ in your editor."

echo "=== Done ==="

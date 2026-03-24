#!/usr/bin/env bash
set -euxo pipefail

# fresh-install.sh
# Run on a fresh Omarchy install to restore additional software.
# Add new install commands as you install things — don't remove old ones.

echo "=== Fresh Install: Additional Software ==="

# --- Require sudo (needed for pacman installs) ---
if ! sudo -v; then
  echo "Error: this script requires sudo privileges"
  exit 1
fi

# --- System packages (pacman) ---
sudo pacman -S --noconfirm pavucontrol

# --- CLI tools (npm packages and sdk managers) ---
npm install -g varlock@latest
npm install -g @playwright/cli@latest
(cd && playwright-cli install --skill)
mise reshim  # ensure npm -g binaries get shims (needed for non-shell apps like IntelliJ)
curl -s "https://get.sdkman.io" | bash

# --- SDKMAN-based runtime installs ---
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk install java 25.0.2-tem
sdk install maven 3.9.14
sdk install gradle 9.4.0

# JetBrains Toolbox
"$(dirname "$0")/install-jetbrains-toolbox.sh"

# --- Post-install setup (wallpaper, shims) ---

# Black wallpaper: copy to theme backgrounds and repoint the background symlink
THEME_BG_DIR="$HOME/.config/omarchy/current/theme/backgrounds"
if [[ -d "$THEME_BG_DIR" ]]; then
  cp "$(dirname "$0")/assets/black.png" "$THEME_BG_DIR/black.png"
  ln -sf "$THEME_BG_DIR/black.png" "$HOME/.config/omarchy/current/background"
  echo "  installed: black wallpaper"
fi

echo "=== Done ==="

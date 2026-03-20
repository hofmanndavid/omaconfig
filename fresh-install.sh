#!/usr/bin/env bash
set -euo pipefail

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
curl -s "https://get.sdkman.io" | bash

# --- SDKMAN-based runtime installs ---
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk install java 25.0.2-tem
sdk install maven 3.9.14
sdk install gradle 9.4.0

# JetBrains Toolbox
mkdir -p "$HOME/programs/toolbox-app"
curl -L -o /tmp/jetbrains-toolbox.tar.gz "https://download.jetbrains.com/toolbox/jetbrains-toolbox-3.3.1.75249.tar.gz"
tar xzf /tmp/jetbrains-toolbox.tar.gz -C /tmp
cp -r /tmp/jetbrains-toolbox-*/* "$HOME/programs/toolbox-app/"
cp "$HOME/programs/toolbox-app/bin/toolbox-tray-color.png" "$HOME/.local/share/applications/icons/JetBrains Toolbox.png"
cat > "$HOME/.local/share/applications/jetbrains-toolbox.desktop" << 'DESKTOP'
[Desktop Entry]
Version=1.0
Name=JetBrains Toolbox
Comment=JetBrains Toolbox App
Exec=/home/hdavid/programs/toolbox-app/bin/jetbrains-toolbox
Terminal=false
Type=Application
Icon=/home/hdavid/.local/share/applications/icons/JetBrains Toolbox.png
StartupNotify=true
DESKTOP
rm -f /tmp/jetbrains-toolbox.tar.gz && rm -rf /tmp/jetbrains-toolbox-*

# --- Post-install setup (wallpaper, shims) ---

# Black wallpaper: copy to theme backgrounds and repoint the background symlink
THEME_BG_DIR="$HOME/.config/omarchy/current/theme/backgrounds"
if [[ -d "$THEME_BG_DIR" ]]; then
  cp "$(dirname "$0")/assets/black.png" "$THEME_BG_DIR/black.png"
  ln -sf "$THEME_BG_DIR/black.png" "$HOME/.config/omarchy/current/background"
  echo "  installed: black wallpaper"
fi

echo "=== Done ==="

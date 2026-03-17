#!/usr/bin/env bash
set -euo pipefail

# fresh-install.sh
# Run on a fresh Omarchy install to restore additional software.
# Add new install commands as you install things — don't remove old ones.

echo "=== Fresh Install: Additional Software ==="

# --- CLI tools (curl bash, npm packages and sdk managers) ---
curl -s "https://get.sdkman.io" | bash
curl -sSfL https://varlock.dev/install.sh | sh -s
npm install -g @playwright/cli@latest

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

echo "=== Done ==="

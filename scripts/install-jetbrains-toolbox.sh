#!/usr/bin/env bash
set -euxo pipefail

# install-jetbrains-toolbox.sh
# Downloads and installs the latest JetBrains Toolbox App.

INSTALL_DIR="$HOME/programs/toolbox-app"
ICONS_DIR="$HOME/.local/share/applications/icons"
DESKTOP_FILE="$HOME/.local/share/applications/jetbrains-toolbox.desktop"

echo "=== Installing JetBrains Toolbox ==="

# Fetch the latest version info from JetBrains API
echo "  fetching latest version..."
RELEASE_JSON=$(curl -sfL "https://data.services.jetbrains.com/products/releases?code=TBA&latest=true&type=release")
DOWNLOAD_URL=$(echo "$RELEASE_JSON" | grep -oP '"linux":\s*\{[^}]*"link":\s*"\K[^"]+')
VERSION=$(echo "$RELEASE_JSON" | grep -oP '"version":\s*"\K[^"]+' | head -1)

if [[ -z "$DOWNLOAD_URL" || -z "$VERSION" ]]; then
  echo "Error: could not determine latest Toolbox version"
  exit 1
fi

echo "  latest version: $VERSION"
echo "  downloading from: $DOWNLOAD_URL"

# Download and extract
curl -L -o /tmp/jetbrains-toolbox.tar.gz "$DOWNLOAD_URL"
tar xzf /tmp/jetbrains-toolbox.tar.gz -C /tmp

# Install
mkdir -p "$INSTALL_DIR" "$ICONS_DIR"
cp -r /tmp/jetbrains-toolbox-*/* "$INSTALL_DIR/"
cp "$INSTALL_DIR/bin/toolbox-tray-color.png" "$ICONS_DIR/JetBrains Toolbox.png"

# Create desktop entry
cat > "$DESKTOP_FILE" << DESKTOP
[Desktop Entry]
Version=1.0
Name=JetBrains Toolbox
Comment=JetBrains Toolbox App
Exec=$HOME/programs/toolbox-app/bin/jetbrains-toolbox
Terminal=false
Type=Application
Icon=$HOME/.local/share/applications/icons/JetBrains Toolbox.png
StartupNotify=true
DESKTOP

# Cleanup
rm -f /tmp/jetbrains-toolbox.tar.gz && rm -rf /tmp/jetbrains-toolbox-*

echo "  JetBrains Toolbox $VERSION installed to $INSTALL_DIR"

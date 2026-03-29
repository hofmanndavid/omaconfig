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

# --- Git config ---
git config --global user.name "David Hofmann"
git config --global user.email "hofmanndavid@gmail.com"

# --- System packages (pacman) ---
PACMAN_PACKAGES=(
  stow
  sublime-text-4
  gnome-boxes
  transmission-gtk
  fio
)
sudo pacman -S --noconfirm "${PACMAN_PACKAGES[@]}"

# --- NPM based CLI tools ---
npm install -g varlock@latest
npm install -g @playwright/cli@latest
# install claude playwright-cli user-wide
(cd && playwright-cli install --skill)
mise reshim  # ensure npm -g binaries get shims (needed for non-shell apps like IntelliJ)

# --- SDK based installs ---
if [[ ! -d "$HOME/.sdkman" ]]; then
  curl -s "https://get.sdkman.io" | bash
fi
set +u  # sdkman scripts use unbound variables
source ~/.sdkman/bin/sdkman-init.sh
sdk install java 25.0.2-tem < /dev/null || true
sdk install maven 3.9.14 < /dev/null || true
sdk install gradle 9.4.0 < /dev/null || true
set -u

# --- Install JetBrains Toolbox ---
"$(dirname "$0")/scripts/install-jetbrains-toolbox.sh"

# --- Post-install setup ---
"$(dirname "$0")/scripts/set-wallpaper.sh"

# --- Deploy config symlinks via stow ---
REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
stow -v --adopt -t "$HOME" -d "$REPO_DIR" configs
# --adopt moves existing files into the repo, replacing them with symlinks.
# Review upstream changes with: git diff configs/
# Then restore our versions with: git checkout -- configs/

echo "=== Done ==="

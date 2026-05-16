#!/usr/bin/env bash
set -euxo pipefail

# --- Deploy config symlinks via stow ---
REPO_DIR="$(cd "$(dirname "$0")"/.. && pwd)"
stow -v --adopt -t "$HOME" -d "$REPO_DIR" configs
# --adopt moves existing files into the repo, replacing them with symlinks.
echo ""
echo "Config files has been stowed."
echo "Review them in your IDE to revert what was in this repo originally."
echo ""
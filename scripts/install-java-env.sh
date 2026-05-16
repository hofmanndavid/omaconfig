#!/usr/bin/env bash
set -exo pipefail

if [[ ! -d "$HOME/.sdkman" ]]; then
  echo "Installing latest sdkman + java + maven + gradle"
  curl -s "https://get.sdkman.io" | bash
  source ~/.sdkman/bin/sdkman-init.sh
  sdk install java < /dev/null || true
  sdk install maven < /dev/null || true
  sdk install gradle < /dev/null || true
else
  echo "sdkman already installed"
fi


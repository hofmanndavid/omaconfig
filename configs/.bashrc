# If not running interactively, don't do anything (leave this at the top of this file)
[[ $- != *i* ]] && return

# Exported env vars
export SDKMAN_DIR=~/.sdkman

# Source some env files
. ~/.local/share/omarchy/default/bash/rc
. ~/.local/bin/env
. ~/.sdkman/bin/sdkman-init.sh

# useful aliases
alias ioff='hyprctl keyword monitor "eDP-1, disable"'
alias ion='hyprctl keyword monitor "eDP-1, preferred, auto, 1.5"'
alias clauded='claude --dangerously-skip-permissions'
alias omaconf='cd ~/repos/omaconfig && clauded'

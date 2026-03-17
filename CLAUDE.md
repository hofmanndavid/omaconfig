# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Purpose

This repo tracks personal modifications to an Omarchy Linux desktop. It is NOT an omarchy development repo — it's a user-config overlay. The goal is to:

1. Track customized config files so they can be restored after a fresh install
2. Track additional software installed on top of base omarchy
3. Provide a reproducible setup via scripts

## Key Concepts

- **Omarchy defaults** live in `~/.local/share/omarchy/default/` (read-only, never edit)
- **User overrides** live in `~/.config/hypr/`, `~/.config/waybar/`, etc. (these are what we track)
- Hyprland loads defaults first, then user overrides — so user configs win by being sourced last
- We only pull/track config files we've actually modified — not the full omarchy config set

## Scripts

### pull-config.sh
Copies tracked config files FROM the live system INTO this repo. Run this to capture current state. When adding a new file to track, add it to the `FILES` array in this script (and in install-config.sh).

### install-config.sh
Copies tracked config files FROM this repo TO the live system. Run after cloning on a fresh install or after editing configs in the repo.

### fresh-install.sh
Records additional software installations (curl|bash, sdkman, npm -g, pacman, etc.) done on top of base omarchy. Run on a fresh omarchy install to restore the full environment. Only add entries here when you actually install something new.

## Files We Track

Config files are stored under `configs/` mirroring their system path relative to `~`. The registry of tracked files is the `FILES` array in pull-config.sh and install-config.sh — keep them in sync.

Current tracked configs:
- `configs/.bashrc` — shell aliases and custom functions
- `configs/.config/alacritty/alacritty.toml` — terminal font, keybindings, window settings
- `configs/.config/hypr/bindings.conf` — app launchers, key bindings, lid switch
- `configs/.config/hypr/input.conf` — input/mouse/touchpad settings
- `configs/.config/hypr/monitors.conf` — monitor layout, scaling, resolution
- `configs/.config/hypr/autostart.conf` — extra env vars (GUI PATH), autostart processes
- `configs/.config/hypr/looknfeel.conf` — gaps, borders, decorations, animations

## Workflow

1. To modify a config: first add its path to `FILES` in both scripts, run `pull-config.sh`, edit the file under `configs/`, run `install-config.sh`
2. To track a new install: add the install command to `fresh-install.sh`
3. Log what you did in `touches.md`

## Instructions for Claude

- When modifying system configs, always edit the file under `configs/` in this repo, then run `install-config.sh` to deploy — never edit `~/.config/` files directly
- After any system-modifying action, append an entry to `touches.md`
- When pulling in a new config file, add it to the `FILES` array in BOTH pull-config.sh and install-config.sh
- Keep this CLAUDE.md up to date: update "Files We Track" when new configs are added
- Use the omarchy skill when you need to understand hyprland/waybar/etc. config syntax

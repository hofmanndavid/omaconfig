# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Purpose

This repo tracks personal modifications to an Omarchy Linux desktop. It is NOT an omarchy development repo — it's a user-config overlay. The goal is to:

1. Track customized config files so they can be restored after a fresh install
2. Track additional software installed on top of base omarchy
3. Provide a reproducible setup via scripts

Running Omarchy 3.4.2, current theme: Tokyo Night.

## Key Concepts

- **Omarchy defaults** live in `~/.local/share/omarchy/default/` (read-only, never edit)
- **User overrides** live in `~/.config/hypr/`, `~/.config/waybar/`, etc. (these are what we track)
- Hyprland loads defaults first, then user overrides — so user configs win by being sourced last
- We only pull/track config files we've actually modified — not the full omarchy config set

## Scripts

### config.sh [pull|install]
- `config.sh pull` — copies tracked config files FROM the live system INTO this repo
- `config.sh install` — copies tracked config files FROM this repo TO the live system

The `FILES` array in this script is the single registry of tracked files. When adding a new file to track, add it there.

### fresh-install.sh
Records additional software installations (curl|bash, sdkman, npm -g, pacman, etc.) done on top of base omarchy. Run on a fresh omarchy install to restore the full environment. Only add entries here when you actually install something new.

## Files We Track

Config files are stored under `configs/` mirroring their system path relative to `~`. The registry of tracked files is the `FILES` array in `config.sh`.

Current tracked configs:
- `configs/.bashrc` — shell aliases and custom functions
- `configs/.config/alacritty/alacritty.toml` — terminal font, keybindings, window settings
- `configs/.config/hypr/bindings.conf` — app launchers, key bindings, lid switch
- `configs/.config/hypr/input.conf` — input/mouse/touchpad settings
- `configs/.config/hypr/monitors.conf` — monitor layout, scaling, resolution
- `configs/.config/hypr/looknfeel.conf` — gaps, borders, decorations, animations

## Workflow

1. To modify a config: add its path to `FILES` in `config.sh`, run `config.sh pull`, edit the file under `configs/`, run `config.sh install`
2. To track a new install: add the install command to `fresh-install.sh`
3. Log what you did in `changes.md`

## Instructions for Claude

- **At the start of every new session**, before answering or doing anything else: read all files in this repo and load the Omarchy skill. This ensures full context of the current config state and access to Hyprland/Waybar/etc. syntax references.
- When modifying system configs, always edit the file under `configs/` in this repo, then run `config.sh install` to deploy — never edit `~/.config/` files directly
- **Every system change must be reproducible.** If a change is not covered by a config file tracked in `config.sh`, it MUST be added to `fresh-install.sh` (or another tracked mechanism) so a fresh install reproduces it. This includes: software installs, symlinks, copied assets, wallpaper changes, desktop files, and any other system-level side effects. Never make a live-system-only change without also making it reproducible from this repo.
- After any system-modifying action, append an entry to `changes.md`
- When pulling in a new config file, add it to the `FILES` array in `config.sh`
- Keep this CLAUDE.md up to date, for example update "Files We Track" when new configs are added
- Before writing Hyprland window rules, check the current syntax from the Hyprland wiki — the format changes between versions.
- Use the Omarchy skill when you need to understand hyprland/waybar/etc. config syntax
- When rebinding a key in hypr/bindings.conf, check existing bindings first (omarchy-menu-keybindings --print) and add unbind before bind if the key is already used.
- Read ~/.local/share/omarchy/ freely for reference, but never edit files there.



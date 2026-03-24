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
- We only track config files we've actually modified — not the full omarchy config set
- **Config files are managed via GNU Stow** — files under `configs/` are symlinked into `~`, so editing them in the repo edits the live system directly

## Scripts

### fresh-install.sh
Records additional software installations (curl|bash, sdkman, npm -g, pacman, etc.) done on top of base omarchy. Run on a fresh omarchy install to restore the full environment. It also deploys config symlinks via `stow`. Only add entries here when you actually install something new.

### scripts/
Helper scripts called from `fresh-install.sh`:
- `install-jetbrains-toolbox.sh` — auto-detects and installs the latest JetBrains Toolbox
- `set-wallpaper.sh` — copies black.png into theme backgrounds and repoints the background symlink

## Config Management (GNU Stow)

Config files are stored under `configs/` mirroring their system path relative to `~`. Stow creates symlinks from `~` into `configs/`, so the repo files ARE the live system files.

**Deploy symlinks** (run from repo root):
```bash
stow -v -t ~ configs
```

**Add a new config file to track**:
1. Move the file from its home-directory location into `configs/` at the matching relative path
2. Run `stow -R -t ~ configs` to create the symlink
3. Commit the new file

**Day-to-day edits**: just edit the file under `configs/` — changes are live immediately, no deploy step needed.

### Tracked configs

- `configs/.bashrc` — shell aliases and custom functions
- `configs/.config/alacritty/alacritty.toml` — terminal font, keybindings, window settings
- `configs/.config/hypr/bindings.conf` — app launchers, key bindings, lid switch
- `configs/.config/hypr/input.conf` — input/mouse/touchpad settings
- `configs/.config/hypr/monitors.conf` — monitor layout, scaling, resolution
- `configs/.config/hypr/looknfeel.conf` — gaps, borders, decorations, animations
- `configs/.config/waybar/config.jsonc` — bar layout, modules, clock format
- `configs/.config/waybar/style.css` — bar styling

## Workflow

1. To modify a config: just edit the file under `configs/` — it's symlinked to the live system
2. To track a new config: move it from `~/` into `configs/` at the same relative path, run `stow -R -t ~ configs`
3. To track a new install: add the install command to `fresh-install.sh`
4. Log what you did in `changes.md`

## Instructions for Claude

- **At the start of every new session**, before answering or doing anything else: read all files in this repo and load the Omarchy skill. This ensures full context of the current config state and access to Hyprland/Waybar/etc. syntax references.
- When modifying system configs, edit the file under `configs/` in this repo — it's symlinked to the live system, so changes take effect immediately
- **Every system change must be reproducible.** If a change is not covered by a config file in `configs/`, it MUST be added to `fresh-install.sh` (or another tracked mechanism) so a fresh install reproduces it. This includes: software installs, symlinks, copied assets, wallpaper changes, desktop files, shell commands that alter system state (e.g. `mise reshim`), and any other system-level side effects. Never make a live-system-only change without also making it reproducible from this repo.
- **A task is not complete until reproducibility is handled.** After any system-modifying action, immediately update `fresh-install.sh`, log the change in `changes.md`, and update this file if needed — all before reporting the task as done to the user. Do not wait to be asked.
- When tracking a new config file, move it into `configs/` and run `stow -R -t ~ configs` (Stow commands must be run from the repo root `~/repos/omaconfig`). Update the "Tracked configs" list above.
- Keep this CLAUDE.md up to date, for example update "Tracked configs" when new configs are added
- Before writing Hyprland window rules, check the current syntax from the Hyprland wiki — the format changes between versions.
- Use the Omarchy skill when you need to understand hyprland/waybar/etc. config syntax
- When rebinding a key in hypr/bindings.conf, check existing bindings first (omarchy-menu-keybindings --print) and add unbind before bind if the key is already used.
- Read ~/.local/share/omarchy/ freely for reference, but never edit files there.

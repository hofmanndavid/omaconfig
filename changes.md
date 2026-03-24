# Changes Log

System modifications performed, newest first.

## 2026-03-24

- **JetBrains Toolbox install script**: Extracted toolbox installation from `fresh-install.sh` into standalone `install-jetbrains-toolbox.sh` that auto-detects the latest version via JetBrains API instead of hardcoding a version
- **Added `mise reshim` to fresh-install.sh**: After npm global installs, run `mise reshim` so binaries like `varlock` get shims that non-shell apps (IntelliJ) can find via PATH

## 2026-03-22

- **Borders on floating windows**: Added `windowrule = border_size 1, match:float true` in `looknfeel.conf` — floating windows always show 1px border even when workspace rule hides borders for single tiled windows
- **Playwright CLI skill install**: Added `playwright-cli install --skill` to `fresh-install.sh` after the npm install, so the Claude Code skill is registered on fresh installs
- **Hide border on single window**: Added workspace rule `w[t1], bordersize:0` in `looknfeel.conf` — removes border when only one tiled window in workspace, keeps 1px border for multiple windows

## 2026-03-20

- **Tracked black wallpaper**: Added `assets/black.png` to repo and added post-install step in `fresh-install.sh` to copy it to theme backgrounds and repoint the background symlink
- **Installed pavucontrol**: Added `sudo pacman -S pavucontrol` to `fresh-install.sh`, script now requires sudo
- **Removed HDMI audio hiding rules**: Kept only laptop mic hiding in WirePlumber config — HDMI outputs shift depending on which USB port the dock uses, so hiding by name caused the active output to disappear
- **Switched varlock to npm**: Replaced `curl|sh` install with `npm install -g varlock@latest` in `fresh-install.sh`, removed manual mise shim symlink (mise auto-shims npm globals), cleaned up old install from `~/.config/varlock/bin/`

## 2026-03-16

- **Hidden unused audio devices**: Disabled 3 phantom HDMI/DP audio outputs (DP 1-3, no monitors connected) and 2 unused Ryzen laptop mics via WirePlumber node rules
- **Merged config scripts**: Combined `pull-config.sh` and `install-config.sh` into `config.sh [pull|install]` with a single shared `FILES` array
- **Varlock mise shim**: Symlinked varlock into `~/.local/share/mise/shims/` so GUI apps can find it; removed broken PATH approaches from `.bashrc` and `autostart.conf`
- **Varlock installed**: v0.5.0 via `curl -sSfL https://varlock.dev/install.sh | sh -s`, added PATH export to `.bashrc`, added to `fresh-install.sh`
- **JetBrains Toolbox installed**: v3.3.1 to `/home/hdavid/programs/toolbox-app/`, added .desktop file for Walker launcher, added to `fresh-install.sh`
- **Playwright CLI installed**: `npm install -g @playwright/cli@latest` (0.1.1), added to `fresh-install.sh`
- **Maven installed**: `sdk install maven` — 3.9.14, added to `fresh-install.sh`
- **Gradle installed**: `sdk install gradle` — 9.4.0, added to `fresh-install.sh`
- **Alacritty copy/paste**: Added `save_to_clipboard = true` (copy on select) and right-click paste mouse binding
- **Java installed**: `sdk install java` — Java 25.0.2-tem (Temurin), added to `fresh-install.sh`
- **SDKMAN installed**: via `curl -s "https://get.sdkman.io" | bash`, added to `fresh-install.sh`
- **Alacritty font size**: Set to 15 in `alacritty.toml` (was 9)
- **Ghostty font size reverted**: Restored t repointedo 9 (was changed by mistake)
- **Border size reduced**: Set `border_size = 1` in `looknfeel.conf` (was default 2px)
- **Added `clauded` alias**: `claude --dangerously-skip-permissions` in `.bashrc`
- **Black background**: Created `black.png` in theme backgrounds, repointed `~/.config/omarchy/current/background` symlink to it, restarted swaybg
- **External monitor scale**: Set DP-9 (LG ULTRAGEAR+) to scale 2, eDP-1 (internal) to scale 1.5 in `monitors.conf`
- **Lid switch bindings**: Added `bindl` rules in `bindings.conf` — lid close disables eDP-1, lid open re-enables it
- **Added `ioff`/`ion` aliases**: Added to `.bashrc` — `ioff` disables internal display (eDP-1), `ion` re-enables it at 1920x1200@60Hz scale 1.5
- **Mouse natural scroll added**: Added `natural_scroll = true` at `input {}` level for mouse wheel
- **Borders restored**: Re-commented `border_size = 0` in `looknfeel.conf` to keep default borders (2px)
- **Touchpad natural scroll enabled**: Uncommented `natural_scroll = true` in `input.conf` touchpad section
- **Window gaps removed**: Set `gaps_in = 0`, `gaps_out = 0` in `looknfeel.conf`
- **Project bootstrapped**: Created omaconfig repo with pull-config.sh, install-config.sh, fresh-install.sh, touches.md, CLAUDE.md

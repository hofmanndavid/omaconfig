# omaconfig

Personal config overlay for [Omarchy](https://omarchy.com) Linux desktop. Track, version, and restore customizations on top of a base Omarchy install.

## What This Is

This is **not** an Omarchy fork or development repo. It's a personal dotfiles-style overlay that:

- Stores modified config files so they survive a fresh install
- Records additional software installed beyond base Omarchy
- Provides scripts to pull configs from the live system and push them back

Running Omarchy 3.4.2 with the Tokyo Night theme on Hyprland.

## Repository Structure

```
omaconfig/
├── configs/                  # Tracked config files (mirrors ~/ structure)
│   ├── .bashrc
│   └── .config/
│       ├── alacritty/
│       │   └── alacritty.toml
│       └── hypr/
│           ├── bindings.conf
│           ├── input.conf
│           ├── looknfeel.conf
│           └── monitors.conf
├── config.sh                 # Pull/install config files
├── fresh-install.sh          # Restore additional software on a fresh install
├── changes.md                # Changelog of system modifications
└── CLAUDE.md                 # Instructions for Claude Code AI assistant
```

## Usage

### Deploying configs to the system

```bash
./config.sh install
```

Copies all tracked config files from `configs/` to their corresponding locations under `~/`.

### Pulling configs from the system

```bash
./config.sh pull
```

Copies tracked config files from the live system into the repo, ready to commit.

### Fresh install setup

```bash
./fresh-install.sh
```

Installs additional software (SDKMAN, Java, Maven, Gradle, JetBrains Toolbox, Playwright CLI, Varlock, etc.) on a fresh Omarchy install.

## How It Works

Omarchy loads default configs from `~/.local/share/omarchy/default/`, then applies user overrides from `~/.config/`. This repo only tracks the overrides — the files we've actually changed.

The `FILES` array in `config.sh` is the single source of truth for which files are tracked. To start tracking a new config file:

1. Add its path (relative to `~`) to the `FILES` array in `config.sh`
2. Run `./config.sh pull` to snapshot the current version
3. Commit the result

## Tracked Configs

| File | Purpose |
|------|---------|
| `.bashrc` | Shell aliases and custom functions |
| `.config/alacritty/alacritty.toml` | Terminal font, keybindings, window settings |
| `.config/hypr/bindings.conf` | App launchers, key bindings, lid switch |
| `.config/hypr/input.conf` | Input, mouse, and touchpad settings |
| `.config/hypr/monitors.conf` | Monitor layout, scaling, resolution |
| `.config/hypr/looknfeel.conf` | Gaps, borders, decorations, animations |

## License

Personal configuration — use as inspiration for your own setup.

# omaconfig

Personal config overlay for the awesome [Omarchy](https://omarchy.com) Linux desktop. Track, version, and restore customizations on top of a base Omarchy install.

This is **not** an Omarchy fork or development repo. It's a personal dotfiles-style overlay

Running Omarchy 3.4.2 with the Tokyo Night theme on Hyprland.

## Changes:

- Window gaps removed and border size shrinked to 1px on a black background
- Scaling set to 2x for my 32 inch 4k display
- Mouse set to natural scrolling
- Alacrity font set to 15 and copy on select and paste on right click
- ion/ioff bash aliasses and lid-swich action in hyprland set to deal with laptop display on/off
- Install some perosnal software that I use everyday (java/maven/gradle/varlock, etc.)

That is it, omarchy has amazing defaults as it is. You should try it.

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

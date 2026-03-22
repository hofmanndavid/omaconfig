Personal config overlay for the awesome [Omarchy](https://omarchy.org) Linux desktop. Track, version, and restore customizations on top of a base Omarchy install.

This is **not** an Omarchy fork or development repo. It's a personal dotfiles-style overlay

Running Omarchy 3.4.2 with the Tokyo Night theme on Hyprland.

## Installing arch linux + omarchy

### If you need to remove some partitions

- lsblk to get your device list
- fdisk /dev/<device>
  - p to list partitions
  - d to delete
  - w to write and quit

### Arch install TUI

- connect to wifi before archinstall if not on a wired connection
  - iwctl
  - station wlan0 scan
  - station wlan0 connect <tab>
- archinstall
- Disk configuration > Partitioning > Default partitioning layout > Select disk (with space + return)
- Disk > File system > btrfs (default structure: yes + use compression)
- (optional but highly recommended when installing manually) - Disk > Disk encryption > Encryption type: LUKS + Encryption password + Partitions (select the one)
- Give your computer a Hostname
- Set Bootloader to Limine
- Set root password and add a super user
- Applications > Audio > pipewire
- Network configuration	> Copy ISO network config
- Set your Timezone
- Restart, login as your user and `curl -fsSL https://omarchy.org/install | bash`

### Manual stuff

- Configure 1Password + your ssh client + op cli tool
- Chromium:
  - Add 1 Password to chromium
  - Remove omarchy copy url extension
  - set startup to open where you left off
- Via omarchy menu → setup → security → fingerprint enroll a finger to use for authentication
  - extra fprintd commands:
    - fprintd-enroll
    - fprintd-enroll -f [left|right]-[thumb|index|middle|ring|little]-finger
    - fprintd-list $(whoami)
    - fprintd-verify
- Clone this repo and run `fresh-install.sh && config.sh install`

## Changes this repo brings to the base installation

- Window gaps removed and border size shrunk to 1px on a black background
- Borders only visible when multiple windows are open in the same workspace
- Scaling set to 2x for my 32 inch 4k display
- Mouse set to natural scrolling
- Alacrity font set to 15 and copy on select and paste on right click
- ion/ioff bash aliasses and lid-swich action in hyprland set to deal with laptop display on/off
- Hide some sound input/output devices with no route selected
- Install some perosnal software that I use everyday (java/maven/gradle/varlock, etc.)

That is it, omarchy has amazing defaults as it is. You should try it.

## What omarchy does well for me

- Having 1Password integration is great, even better when fingerprint sensor works well on first try!
  - It integrates with your ssh client for key management so that you ssh keys can't be read without you knowing about it and not having to type/remember yet another passphrase
  - It has the op command that can be used in tools such a varlock to let your programs access API secrets stored in your 1Pasword. Great way to not have plain text .env files laying around in a readable form
- Having a well-configured and beautiful tiling window manager with well-thought-out key combinations is great
- Sound and Bluetooth working fine on the first try on arch linux, amazing! Getting used to TUIs for sound and bluetooth took some work though.
- Screenshot, screen recorder, beautiful neovim defaults
- File system snapshots configured to prevent screw ups, incredible!

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

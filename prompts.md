# Prompts Log

## 2026-03-16

- Set up omaconfig project with pull/install/fresh-install scripts, touches log, and CLAUDE.md
- Enable natural (Mac-style) scroll direction and remove window gaps
- Restore default borders (keep gaps removed), fix mouse scroll (was only set for touchpad, not mouse)
- Create prompts.md log file
- Create `ioff`/`ion` aliases to toggle internal laptop display
- Configure lid switch to auto-disable/enable internal display on close/open
- Set external monitor (DP-9) default scaling to 2
- Set desktop background to solid black
- Add `clauded` alias for running claude in dangerous mode
- Set window border to 1px instead of 2px
- Revert ghostty font change, change alacritty font size (ended up at 15)
- Install SDKMAN
- Install Java via SDKMAN
- Configure alacritty to copy on select and paste on right click
- Install Maven and Gradle via SDKMAN
- Install Playwright CLI via npm
- Install JetBrains Toolbox App to ~/programs/toolbox-app/ with app launcher integration
- Install varlock
- Fix varlock not on PATH for IntelliJ/GUI apps — discovered mise shims is the way (symlink into ~/.local/share/mise/shims/), removed broken .bashrc and autostart.conf PATH hacks

Omaconfig
---
  * create ssh key and set it up in github.com
  * clone omaconfig in home dir
  * call scripts
    * `install-jetbrains-toolbox.sh`
      * install latest intellij idea and configure backup and sync
    * `install-additional-packages.sh`
    * `install-java-env.sh`
    * `set-wallpapers.sh`
    * `stow-config-files.sh`
      * review changes in ide
      * unstow files with
        * cp --remove-destination ~/omaconfig/configs/.config/hypr/bindings.conf ~/.config/hypr/bindings.conf
        * rm ~/omaconfig/configs/.config/hypr/bindings.conf

AI notes
---
* Playwright skill:
  * npm install -g @playwright/cli@latest && mise reshim
  * playwright-cli install --skill
* Vaadin MCP server: `claude mcp add vaadin --transport http https://mcp.vaadin.com/docs`
* Vercel's agent-browser: https://agent-browser.dev/installation
  * npm install -g agent-browser
  * agent-browser install --with-deps
  * npx skills add vercel-labs/agent-browser

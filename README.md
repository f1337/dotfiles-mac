dotfiles-mac
============
:snowflake: MacOS dotfiles and quick-start for software development.



First Things
------------

### Homebrew

http://brew.sh/


### iTerm2

    brew cask install iterm2

[Dracula theme](https://github.com/dracula/iterm.git) for iTerm2.

### 1Password

    brew cask install 1password



Browsers
--------

    brew cask install brave-browser
    brew cask install choosy
    brew cask install firefox
    brew cask install google-chrome
    brew cask install tor-browser

### Firefox Add-Ons

* HTTPS Everywhere
* Privacy Badger
* uBlock Origin
* 1Password
* Facebook Container
* Firefox Multi-Account Containers (Ctrl + . > Tab > 1-n for new container tab)
* Temporary Containers



Communication Tools
-------------------

    brew cask install discord
    brew cask install slack



Development Tools
-----------------

### Docker

    brew cask install docker


### Fonts

#### Editor

I use [Operator Mono](https://www.typography.com/fonts/operator/styles/screensmart/) for programming. For a free alternative, check out [Matt McFarland's write-up](https://medium.com/@docodemore/an-alternative-to-operator-mono-font-6e5d040e1c7e).

#### Terminal

    brew tap homebrew/cask-fonts
    brew cask install font-meslo-for-powerline


### gimp

GNU Image Manipulation Program

    brew cask install gimp


### git, tig

`tig` is like `gitk`, but runs inside a terminal:

    brew install git # not really necessary in 10.15
    brew install tig
    ln -s $(pwd)/.gitconfig ~/.gitconfig
    ln -s $(pwd)/.gitignore ~/.gitignore
    git config --global user.name "Your Name"
    git config --global user.email you@example.com


### Visual Studio Code

    brew cask install visual-studio-code
    code --install-extension castwide.solargraph
    code --install-extension CoenraadS.bracket-pair-colorizer-2
    code --install-extension dracula-theme.theme-dracula
    code --install-extension eamodio.gitlens
    code --install-extension jeff-hykin.code-eol
    code --install-extension lourenci.go-to-spec
    code --install-extension mikestead.dotenv
    code --install-extension ms-azuretools.vscode-docker
    code --install-extension rebornix.ruby
    code --install-extension robertohuertasm.vscode-icons
    code --install-extension streetsidesoftware.code-spell-checker
    code --install-extension ziyasal.vscode-open-in-github

    ln -s $(pwd)/Code/keybindings.json ~/Library/Application\ Support/Code/User/
    ln -s $(pwd)/Code/settings.json ~/Library/Application\ Support/Code/User/



Gaming
------

### Minecraft

1. Install Java & Minecraft via Homebrew

    brew cask install java # full jdk, in case we want to mod
    brew cask install minecraft

2. Download [Optifine](https://optifine.net/home), then open and run the .jar file to install it.
3. Download [BSL Shaders](https://bitslablab.com/).
4. Download [ChromaHills](https://www.chromahills.com/).
5. Run Minecraft, select the OptiFine profile.
6. In Minecraft, click Options > Video Settings > Shaders, then click the Shaders Folder button in the lower left corner. This will open the shaderpacks folder in Finder.Open a new Finder window (File > New or command-n, then Go > Downloads in the new window) and go to your Downloads folder. Drag the BSL Shaders .zip file from the Downloads folder to the Minecraft shaderpacks folder.
7. In Minecraft, select the newly displayed BSL shaders .zip. Minecraft will relaunch the UI. Click Done. And the click Done again.
8. In Minecraft, click Resource Packs from the Options screen. Next click Open Resource Pack Folder. As with the shaders, open your downloads folder, and drag the Chroma Hills .zip file to the Minecraft resourcepacks folder.
9. In Minecraft, click Done, then click Resource Packs again. Next mouse over ChromaHills, and click the Right/Play button. Then click Done. The UI will relaunch again. Click Done again.
10. Voila! Minecraft's UI isn't awful anymore!


### Steam

    brew cask install steam



Music
-----

### Last.fm

Scrobbler

    brew cask install lastfm


### Sonic Pi

Live-coding music synthesis

    brew cask install sonic-pi



Shell Tweaks
------------

### autojump

    brew install autojump

### cowsay, fortune, lolcat

For whimsy

    brew install cowsay fortune
    sudo gem install lolcat
    cp cows/*.cow /usr/local/opt/cowsay/share/cows/


### gotop

Process monitor

    brew install gotop


### thefuck

Console command auto-suggest

    brew install thefuck


### zsh

Zombie shell apocalypse

    brew install zsh zsh-autosuggestions
    echo "/usr/local/bin/zsh" | sudo tee -a /etc/shells
    chsh -s /usr/local/bin/zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
    ln -s $(pwd)/.zshrc ~/.zshrc



Timers
------

### Time Out

RSI timer

    brew cask install time-out


### Toggl

Time-tracking

    brew cask install toggl


### Tomighty

Pomodoro timer

    brew cask install tomighty



Window Management
-----------------

### chunkwm

Tiling window manager, ala bspwm and i3.

    brew tap koekeishiya/formulae
    brew install chunkwm
    ln -s $(pwd)/chunkwmrc ~/.chunkwmrc
    brew services start chunkwm


### skhd

Hotkey daemon for `chunkwm`. My [keyboard shortcuts](skhdrc) are commented. The [skhd example config](https://github.com/koekeishiya/chunkwm/blob/master/src/plugins/tiling/examples/skhdrc) includes more options.

    brew install koekeishiya/formulae/skhd
    ln -s $(pwd)/skhdrc ~/.skhdrc
    brew services start skhd



Everything Else
---------------

### Alfred

Like Spotlight, but better. And without creepy [data collection](https://lifehacker.com/safari-and-spotlight-can-send-data-to-apple-heres-how-1648453540).

1. Disable data-gathering Spotlight behaviors: System Preferences > Spotlight, then un-check "Spotlight Suggestions" and "Allow Spotlight Suggestions in Look up".
2. Disable the Spotlight keyboard shortcut (so that Alfred can take it): System Preferences > Spotlight, then click "Keyboard Shortcuts…", then un-check "Show Spotlight search"
3. `brew cask install alfred`
4. Alfred > Preferences > General, check "Launch Alfred at login", the set the Alfred Hotkey to Command-Space.
5. [Neuter the Dock](https://medium.com/@rurka/kill-the-dock-for-macos-dcb1d4ba8c8c) (you can manually show/hide it using `cmd + option - d`):

        defaults write com.apple.dock autohide-delay -float 500
        killall Dock
6. Install the [Dracula theme](https://github.com/dracula/alfred).
7. Install the [Emoji Snippet Pack](http://joelcalifa.com/blog/alfred-emoji-snippet-pack/)


### Iris

For sleep and eye health

    brew cask install iris


### Keybase

Key management & end-to-end encrypted messaging

    brew cask install keybase


### Pock

Dock-like features on the touchbar.

    brew cask install pock
    ln -s $(pwd)/Library/Preferences/com.pigigaldi.pock.plist ~/Library/Preferences/com.pigigaldi.pock.plist


### Privacy settings

This [lifehacker post](https://lifehacker.com/how-to-configure-os-x-to-protect-your-privacy-1716352334) is a good start.


### Sync

Cloud storage w/ zero-knowledge-encryption

    brew cask install sync


### Übersicht

Desktop customization

    brew cask install ubersicht
    ln -s $(pwd)/ubersicht/widgets/*.widget ~/Library/Application\ Support/Übersicht/widgets/


### VLC

    brew cask install vlc


TODO
----

* CLI to set desktop image for current space: http://osxdaily.com/2015/08/28/set-wallpaper-command-line-macosx/#comments

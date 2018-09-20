dotfiles-mac
============
:snowflake: MacOS dotfiles and quick-start for software development.



First Things
------------

### Homebrew

http://brew.sh/


### iTerm2

    brew cask install iterm2


### 1Password

`brew cask install 1password`



Browsers
--------

    brew cask install brave
    brew cask install firefox
    brew cask install google-chrome
    brew cask install torbrowser

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
    brew cask install stride



Development Tools
-----------------

### Ansible

`brew install ansible`


### Atom

1. Install [Atom](https://atom.io/)

        brew cask install atom

2. …and its packages<sup>[♫](https://youtu.be/PB1rat6lcaw)</sup>:

        apm install atom-beautify
        apm install git-blame
        apm install language-docker
        apm install ruby-test
        apm install toggle-gutter
        ln -s (pwd)/.atom/config.cson ~/.atom/
        ln -s (pwd)/.atom/keymap.cson ~/.atom/
        ln -s (pwd)/.atom/styles.less ~/.atom/


### Docker

`brew cask install docker`


### Fonts

#### Editor

I use [Operator Mono](https://www.typography.com/fonts/operator/styles/screensmart/) for programming. For a free alternative, check out [Matt McFarland's write-up](https://medium.com/@docodemore/an-alternative-to-operator-mono-font-6e5d040e1c7e).

#### Terminal

```
brew tap homebrew/cask-fonts
brew cask install font-meslo-for-powerline
```


### git, tig

`tig` is like `gitk`, but runs inside a terminal:

```
brew install git
brew install tig
ln -s (pwd)/.gitconfig ~/.gitconfig
ln -s (pwd)/.gitignore ~/.gitignore
```


### Minikube

`brew cask install minikube`


### VirtualBox

`brew cask install virtualbox`


### Visual Studio Code

```
brew cask install visual-studio-code
code --install-extensionjeff-hykin.code-eol
code --install-extension rebornix.ruby
code --install-extension robertohuertasm.vscode-icons
code --install-extension streetsidesoftware.code-spell-checker
ln -s (pwd)/Code/keybindings.json ~/Library/Application\ Support/Code/User/
ln -s (pwd)/Code/settings.json ~/Library/Application\ Support/Code/User/
ln -s (pwd)/Code/vsicons.settings.json ~/Library/Application\ Support/Code/User/
```


Music
-----

### Google Play Music Desktop Player (Unofficial)

Control Play Music via menu bar; scrobbles

`brew cask install marshallofsound-google-play-music-player`


### GPMDP CLI Remote

Control the Google Play Music Desktop Player via command-line. Good for pausing playback via scripts.

```
brew tap f1337/gmusic
brew install gmusic
```


### Last.fm

Scrobbler

`brew cask install lastfm`


### Sonic Pi

Live-coding music syntesis

`brew cask install sonic-pi`



Shell Tweaks
------------

### cowsay, fortune, lolcat

For whimsy

```
brew install cowsay fortune
sudo gem install lolcat
cp cows/*.cow /usr/local/opt/cowsay/share/cows/
```


### Fish Shell

Because zsh nerds aren't annoying enough.

#### Install

```
brew install fish
echo "/usr/local/bin/fish" | sudo tee -a /etc/shells
chsh -s /usr/local/bin/fish
ln -s (pwd)/.config/fish/config.fish ~/.config/fish/
ln -s (pwd)/.config/fish/functions ~/.config/fish/
curl -L http://get.oh-my.fish | fish
omf install bobthefish
```

#### Custom Functions

Some custom functions are provided for the fish shell, which wrap the following
`docker-compose run …` commands in aliases named for their local counterparts:

- `bundle`
- `psql`
- `rails`
- `rake`
- `rspec`
- `rubcop`

Inspired by [Jessie Frazelle's bash wrappers for docker run commands](https://github.com/jessfraz/dotfiles/blob/master/.dockerfunc).


### gotop

Process monitor

`brew install gotop`


Timers
------

### Time Out

RSI timer

`brew cask install time-out`


### Toggl

Time-tracking

`brew cask install toggl`


### Tomighty

Pomodoro timer

`brew cask install tomighty`



Window Management
-----------------

### `chunkwm`

Tiling window manager, ala bspwm and i3.

```
brew tap crisidev/homebrew-chunkwm
brew install chunkwm
ln -s (pwd)/chunkwmrc ~/.chunkwmrc
brew services start chunkwm
```


### `skhd`

Hotkey daemon for `chunkwm`. My [keyboard shortcuts](skhdrc) are commented. The [skhd example config](https://github.com/koekeishiya/chunkwm/blob/master/src/plugins/tiling/examples/skhdrc) includes more options.

```
brew install koekeishiya/formulae/skhd
ln -s (pwd)/skhdrc ~/.skhdrc
brew services start skhd
```



Everything Else
---------------

### Alfred

Like Spotlight, but better. And without creepy [data collection](https://lifehacker.com/safari-and-spotlight-can-send-data-to-apple-heres-how-1648453540).

1. Disable data-gathering Spotlight behaviors: System Preferences > Spotlight, then uncheck "Spotlight Suggestions" and "Allow Spotlight Suggestions in Look up".
2. Disable the Spotlight keyboard shortcut (so that Alfred can take it): System Preferences > Spotlight, then click "Keyboard Shortcuts…", then uncheck "Show Spotlight search"
3. `brew cask install alfred`
4. Aflred > Preferences > General, check "Launch Alfred at login", the set the Alfred Hotkey to Command-Space.
5. [Neuter the Dock](https://medium.com/@rurka/kill-the-dock-for-macos-dcb1d4ba8c8c) (you can manually show/hide it using `cmd + option - d`):

        defaults write com.apple.dock autohide-delay -float 500
        killall Dock


### Keybase

Key management & end-to-end encrypted messaging

`brew cask install keybase`


### Privacy settings

This [lifehacker post](https://lifehacker.com/how-to-configure-os-x-to-protect-your-privacy-1716352334) is a good start.


### Ring

Video doorbell

`brew cask install ring`


### Steam

Gaming

`brew cask install steam`


### Sync

Cloud storage w/ zero-knowledge-encryption

`brew cask install sync`


### VLC

`brew cask install vlc`


TODO
----

* Ubersicht desktop customization: http://tracesof.net/uebersicht/
* Unsplash image downloader: https://github.com/unsplash/unsplash-js
* CLI to set desktop image for current space: http://osxdaily.com/2015/08/28/set-wallpaper-command-line-macosx/#comments
* A cohesive theme for Atom/VSCode, iTerm2, Alfred, Fish

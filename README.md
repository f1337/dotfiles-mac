dotfiles-mac
============
:snowflake: MacOS dotfiles and quick-start for software development.


First Things
------------

### Homebrew

http://brew.sh/

### iTerm2

    brew cask install iterm2
    cp com.googlecode.iterm2.plist ~/

### 1Password

`brew cask install 1password`

### Coding Fonts

I'm a fan of [Operator Mono](https://www.typography.com/fonts/operator/styles/screensmart/). There are alternatives, but right now I am too tired to research them and link here.

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
* Firefox Multi-Account Containers
* Temporary Containers


Communication Tools
-------------------

    brew cask install discord
    brew cask install slack
    brew cask install stride


Development Tools
-----------------

### Atom

1. Install [Atom](https://atom.io/)

        brew cask install atom

2. …and its packages<sup>[♫](https://youtu.be/PB1rat6lcaw)</sup>:

        apm install atom-beautify
        apm install git-blame
        apm install language-docker
        apm install ruby-test
        apm install toggle-gutter
        cp -R .atom ~/.atom

### Docker

`brew cask install docker`

### git

```
cp .gitconfig ~/.gitconfig
cp .gitignore ~/.gitignore
```

### Minikube

`brew cask install minikube`

### VirtualBox

`brew cask install virtualbox`


Music
-----

### Google Play Music Player (Unofficial)

Control Play Music via menu bar; scrobbles

`brew cask install marshallofsound-google-play-music-player`

### Last.fm

Scrobbler

`brew cask install lastfm`

### Sonic Pi

Live-coding music syntesis

`brew cask install sonic-pi`

### Spotify

`brew cask install spotify`


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

Because zsh nerds aren't annoying enough

```
brew install fish
echo "/usr/local/bin/fish" | sudo tee -a /etc/shells
chsh -s /usr/local/bin/fish
cp -R .config/fish ~/.config/fish
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


Everything Else
---------------

### Keybase

Key management & end-to-end encrypted messaging

`brew cask install keybase`

### `kwm` + `khd`

Window manager (`kwm`) and hotkey daemon (`khd`)

```
brew install koekeishiya/kwm/kwm
brew install koekeishiya/khd/khd
cp -R .kwm ~/.kwm
cp .khdrc ~/.khdrc
brew services start kwm
brew services start khd
```

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

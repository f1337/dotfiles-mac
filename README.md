dotfiles-mac
============
:snowflake: MacOS dotfiles and quick-start for software development.


First Things
------------

### Dropbox

…for syncing 1Password vaults.

https://www.dropbox.com/install

### 1Password

https://agilebits.com/downloads

### Homebrew

http://brew.sh/


Everything Else
---------------

### Atom

1. Install [Atom](https://atom.io/)

2. …and his packages<sup>[♫](https://youtu.be/PB1rat6lcaw)</sup>:

        apm install ruby-test
        apm install toggle-gutter
        cp -R .atom ~/.atom

### Chrome

https://www.google.com/chrome/

### cowsay, fortune, lolcat

```
brew install cowsay fortune
gem install lolcat
cp cows/*.cow /usr/local/opt/cowsay/share/cows/
```

### Docker

https://docs.docker.com/docker-for-mac/

Some custom functions are provided for the fish shell, which wrap the following
`docker-compose run …` commands in aliases named for their local counterparts:

- `bundle`
- `psql`
- `rails`
- `rake`
- `rspec`
- `rubcop`

Inspired by [Jessie Frazelle's bash wrappers for docker run commands](https://github.com/jessfraz/dotfiles/blob/master/.dockerfunc).

### Fish

```
brew install fish
echo "/usr/local/bin/fish" | sudo tee -a /etc/shells
chsh -s /usr/local/bin/fish
cp -R .config/fish ~/.config/fish
curl -L http://get.oh-my.fish | fish
omf install bobthefish
```

### git

```
cp .gitconfig ~/.gitconfig
cp .gitignore ~/.gitignore
```

### iTerm2

https://www.iterm2.com/

### Keybase

https://keybase.io/download

### kwm, khd

```
brew install koekeishiya/kwm/kwm
brew install koekeishiya/khd/khd
cp -R .kwm ~/.kwm
cp .khdrc ~/.khdrc
brew services start kwm
brew services start khd
```

### Last.fm

http://www.last.fm/about/trackmymusic

### mirror.py

```
git clone https://github.com/f1337/mirror.py.git
cp -R .config/mirror.py ~/.config/mirror.py
```

### Slack

https://slack.com/

### Sync

…for synching everything, [except 1Password vaults](https://discussions.agilebits.com/discussion/38652/1password-synchronization-on-sync-com).

https://www.sync.com/

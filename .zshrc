# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE

# use ! for history
setopt BANG_HIST

# append to the history file, don't overwrite it
setopt APPEND_HISTORY

# for setting history length see HISTSIZE and HISTFILESIZE in zsh
HISTFILE=~/.history
HISTSIZE=1000 # max lines per session
SAVEHIST=3000 # max lines per histfile

# aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# editor
export EDITOR=$(which code)

# use empty git commits for TODOs
todo() {
  git commit --allow-empty -m "TODO: $*"
}

# homebrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
# autojump
[ -f /home/linuxbrew/.linuxbrew/etc/profile.d/autojump.sh ] && . /home/linuxbrew/.linuxbrew/etc/profile.d/autojump.sh
# zsh-autosuggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# oh-my-posh
eval "$(oh-my-posh init zsh --config ~/.mytheme.omp.json)"
# asdf: needs to be last
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

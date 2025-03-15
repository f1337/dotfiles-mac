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
eval "$(oh-my-posh init zsh --config $(brew --prefix oh-my-posh)/themes/dracula.omp.json)"
# asdf: needs to be last
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

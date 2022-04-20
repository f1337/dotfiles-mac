###################################################
# asdf
###################################################

# asdf
. $(brew --prefix asdf)/asdf.sh

# asdf-java
#. ~/.asdf/plugins/java/set-java-home.zsh

###################################################
# oh-my-zsh
###################################################

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel9k/powerlevel9k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git notify)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias ll="ls -la"

# ansible
export ANSIBLE_COW_SELECTION=sloth
export ANSIBLE_COW_PATH=/usr/local/bin/lolcowsay
export ANSIBLE_COWPATH=$ANSIBLE_COW_PATH

# autojump
[ -f $(brew --prefix)/etc/profile.d/autojump.sh ] && . $(brew --prefix)/etc/profile.d/autojump.sh

# thefuck
eval $(thefuck --alias wat)
alias wtf="wat -y"

command_not_found_handler () {
  TF_SHELL_ALIASES=$(alias);
  TF_CMD=$(
      export TF_SHELL_ALIASES;
      export TF_SHELL=zsh;
      export TF_ALIAS=fuck;
      export TF_HISTORY="$@";
      export PYTHONIOENCODING=utf-8;
      thefuck THEFUCK_ARGUMENT_PLACEHOLDER
  ) && eval $TF_CMD;
  test -n "$TF_CMD" && print -s $TF_CMD;
}

# zsh-autosuggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# powerlevel customizations
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs time)
# POWERLEVEL9K_DATE_FORMAT="%D{%d.%m.%y}"
POWERLEVEL9K_TIME_FORMAT="%D{%H:%M}"
POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
POWERLEVEL9K_SHORTEN_DELIMITER=""
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right"
POWERLEVEL9K_VCS_SHORTEN_LENGTH=4
POWERLEVEL9K_VCS_SHORTEN_MIN_LENGTH=11
POWERLEVEL9K_VCS_SHORTEN_STRATEGY="truncate_from_right"
POWERLEVEL9K_VCS_SHORTEN_DELIMITER=".."

# dracula theme
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND="141"
POWERLEVEL9K_DIR_ETC_BACKGROUND="141"
POWERLEVEL9K_DIR_HOME_BACKGROUND="141"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND="141"
POWERLEVEL9K_STATUS_OK_BACKGROUND="238"
POWERLEVEL9K_STATUS_OK_FOREGROUND="084"
POWERLEVEL9K_STATUS_ERROR_BACKGROUND="238"
POWERLEVEL9K_STATUS_ERROR_FOREGROUND="203"
POWERLEVEL9K_TIME_FOREGROUND="255"
POWERLEVEL9K_TIME_BACKGROUND="067"
POWERLEVEL9K_VCS_CLEAN_BACKGROUND="084"
POWERLEVEL9K_VCS_CLEAN_FOREGROUND="235"
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND="228"
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND="235"
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND="203"
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND="235"

# notifications
zstyle ':notify:*' activate-terminal yes
#zstyle ':notify:*' blacklist-regex 'find|git'
zstyle ':notify:*' command-complete-timeout 10
zstyle ':notify:*' enable-on-ssh yes
zstyle ':notify:*' error-sound "my-programming"
zstyle ':notify:*' error-title '👎🏻 (#{time_elapsed})'
zstyle ':notify:*' success-sound "roger"
zstyle ':notify:*' success-title '👍🏻 (#{time_elapsed})'

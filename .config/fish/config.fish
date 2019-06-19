# customize bobthefish theme
set -g theme_color_scheme dracula
set -g theme_title_display_path yes
# set -g theme_title_use_abbreviated_path no
set -g theme_date_format "+%H:%M"
set -g theme_display_ruby no

# autojump
[ -f /usr/local/share/autojump/autojump.fish ]; and source /usr/local/share/autojump/autojump.fish

# thefuck
thefuck --alias wtf | source

set -gx LC_ALL en_US.UTF-8

if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

source ~/.config/fish/aliases.fish

set fish_greeting
set -g theme_color_scheme solarized-light
set -g theme_nerd_fonts yes
set -g theme_display_date no
set -g theme_display_cmd_duration yes

set fish_key_bindings fish_vi_key_bindings

set -gx PATH $PATH /usr/local/bin /usr/local/sbin /Users/alepop/bin /Users/alepop/go/bin
set -gx FZF_DEFAULT_COMMAND 'rg --files'
set -gx $EDITOR nvim

set -gx GNUPGHOME ~/.gnupg/trezor
set -gx GPG_TTY (tty)
set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
set -gx ANDROID_SDK_ROOT /usr/local/share/android-sdk
set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
set -gx BAT_THEME "GitHub"

set -g theme_hostname always

function code
  open -a "Visual Studio Code.app" $argv
end

function fish_title
    true
end

function slp --description 'Go mac to sleep'
   pmset displaysleepnow
end

function generate_ssh_keys
  ssh-keygen -t ed25519 -o -a 100 -f ~/.ssh/$argv -C $argv
end

function wttrdiff
  colordiff -Naur (curl -s "wttr.in/$argv[1]?0&M"| psub) (curl -s "wttr.in/$argv[2]?0&M" | psub)
end

function fsize
  du -hcs $argv
end

starship init fish | source



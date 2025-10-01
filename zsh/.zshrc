
# ============================================================
# Helper Functions
# ============================================================

# Load file if it exists and is readable
load_file() {
  if [[ -r "$1" ]]; then
    source "$1"
  fi
}

# ============================================================
# Powerlevel10k Instant Prompt (keep close to top)
# ============================================================

load_file "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" 

# ============================================================
# Powerlevel10k Config
# ============================================================

load_file /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f $HOME/.p10k.zsh ]] || load_file $HOME/.p10k.zsh

# ============================================================
# Mise / Haskell Config
# ============================================================

eval "$(mise activate zsh)"
[ -f "$HOME/.ghcup/env" ] && . "$HOME/.ghcup/env"

# ============================================================
# Oh My Zsh
# ============================================================

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k" # set by `omz`

plugins=(
  colorize
  heroku
  mise
  postgres
  node
  yarn
  spring
  vscode
  archlinux
  eza
  rake
  rust
)

load_file $ZSH/oh-my-zsh.sh

# ============================================================
# Custom Scripts / Commands (carregados após oh-my-zsh)
# ============================================================
export bash_files="$HOME/dotfiles/bash/cmd"
export git_cmd="$bash_files/git"
export ruby_cmd="$bash_files/ruby"

load_file $git_cmd
load_file $ruby_cmd
load_file $HOME/.env

# ============================================================
# PATH / Environment
# ============================================================

export PATH="$PATH:/opt/nvim-linux-x86_64/bin" # release nvim
export EDITOR=nvim

# ============================================================
# Aliases - Zsh / System
# ============================================================

alias zshc="$EDITOR $HOME/.zshrc"
alias zshl="source $HOME/.zshrc"
alias zshs="cat $HOME/.zshrc"
alias sys="sudo systemctl"
alias see="bat"

# ============================================================
# Aliases - WM / Configs
# ============================================================

alias i3c="$EDITOR $HOME/.config/i3/config"
alias i3l="i3 reload && i3 restart"
alias i3logout="i3-msg exit"

alias spi="sudo pacman -S"
alias sai="sudo apt install -y "

alias bgl="sh $HOME/.fehbg"

alias alac="$EDITOR $HOME/.config/alacritty/alacritty.toml"

alias notify="killall dunst && dunst &"
alias notc="$EDITOR $HOME/.config/dunst/dunstrc"

alias hyc="$EDITOR $HOME/.config/hypr/hyprland.conf"
alias hyl="hyprctl reload"
alias hy="hyprctl"

alias wayc="$EDITOR $HOME/.config/waybar/config.jsonc"
alias waysc="$EDITOR $HOME/.config/waybar/style.css"
alias wayr="pkill -SIGUSR2 waybar"
alias waystl="$EDITOR /etc/xdg/waybar/style.css"

alias polyc="$EDITOR $HOME/.config/polybar/config.ini"
alias polyl="polybar-msg cmd restart"

alias nvc="$EDITOR $HOME/.config/nvim"
alias wsc="windsurf"

# ============================================================
# Aliases - Eza
# ============================================================

eza_params=('--git' '--icons' '--classify' '--group-directories-first' '--time-style=long-iso' '--group' '--color-scale')

alias ls='eza $eza_params'
alias lsa="ls -la"
alias l='eza --git-ignore $eza_params'
alias ll='eza --all --header --long $eza_params'
alias llm='eza --all --header --long --sort=modified $eza_params'
alias la='eza -lbhHigUmuSa --header'
alias lx='eza -lbhHigUmuSa@'
alias lt='eza --tree $eza_params'
alias tree='eza --tree $eza_params'

# ============================================================
# Aliases - Ruby / Rails
# ============================================================

alias rubys="bat $ruby_cmd"
alias rubyc="$EDITOR $ruby_cmd"

alias gits="bat $git_cmd"
alias gitc="$EDITOR $git_cmd"

alias hrk="heroku run rails console"
alias cls="clear"

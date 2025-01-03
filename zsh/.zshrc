# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell" # set by `omz`
plugins=(git)

source $ZSH/oh-my-zsh.sh

alias zshc="nvim ~/.zshrc"
alias zshl="source ~/.zshrc"
alias zshs="cat ~/.zshrc"
alias sys="sudo systemctl"
alias see="bat"
alias i3c="nvim ~/.config/i3/config"
alias i3l="i3 reload && i3 restart"
alias spi="sudo pacman -S"
alias github="eval '$(ssh-agent)' > /dev/null && ssh-add ~/.ssh/github > /dev/null 2>&1 && echo '\033[0;32mChave SSH do GitHub carregada com sucesso!\033[0m'"
alias bgl="sh .fehbg"
alias alac="vim ~/.config/alacritty/alacritty.toml"

export EDITOR=nvim

. "$HOME/.asdf/asdf.sh"

# My OCI VM
alias oca_vm="ssh -i ~/.ssh/home_server curumin@ssh.devcurumin.com.br"

# Eza Commands
eza_params=('--git' '--icons' '--classify' '--group-directories-first' '--time-style=long-iso' '--group' '--color-scale')

alias ls='eza $eza_params'
alias l='eza --git-ignore $eza_params'
alias ll='eza --all --header --long $eza_params'
alias llm='eza --all --header --long --sort=modified $eza_params'
alias la='eza -lbhHigUmuSa --header'
alias lx='eza -lbhHigUmuSa@'
alias lt='eza --tree $eza_params'
alias tree='eza --tree $eza_params'

#Git commands
alias git_return_with_reset="git reset --hard HEAD~1"
alias git_return_wout_reset="git reset --soft HEAD~1"
alias gfp="git fetch && git pull"

#Git config
github #call to load github ssh key 

#Rails 
alias rd="./bin/dev"
alias racp="rails assets:clobber assets:precompile"
alias rap="rails assets:precompile"
alias rpd="rails assets:precompile && ./bin/dev"
alias rc="rails console"
alias rs="rails s"

# load env
set -a
source ~/.env
set +a
alias zshmessage="echo '\033[0;32m.env carregado com sucesso!'"
zshmessage


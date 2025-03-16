# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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
alias alac="nvim ~/.config/alacritty/alacritty.toml"

export EDITOR=nvim

# . "$HOME/.asdf/asdf.sh"

# My OCI VM
alias oca_vm="ssh -i ~/.ssh/home_server curumin@ssh.devcurumin.com.br"
alias tunel_db_vm="ssh -i ~/.ssh/vm_db.key -L 54321:localhost:10101 ubuntu@64.181.161.234"

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
alias rr="rails assets:clobber assets:precompile && ./bin/dev"
alias rp="rails db:prepare"
alias rfl="rails db:fixtures:load"
alias rdd="rails db:drop && rm db/schema.rb"

# load env
set -a
source ~/.env
set +a
alias zshmessage="echo '\033[0;32m.env carregado com sucesso!'"
zshmessage

source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# mise config
eval "$(mise activate zsh)"
[ -f "/home/dev/.ghcup/env" ] && . "/home/dev/.ghcup/env" # ghcup-envexport PATH="$HOME/.local/share/mise/shims:$PATH"

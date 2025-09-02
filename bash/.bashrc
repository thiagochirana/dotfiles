# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
source ~/.local/share/omarchy/default/bash/rc

##############################################################

# shopt -s autocd
#export CDPATH=.
#if [ -f /usr/share/bash-completion/bash_completion ]; then
#  . /usr/share/bash-completion/bash_completion
#fi

export bash_files="$HOME/.cmd"
export EDITOR="nvim"

export git_cmd="$bash_files/gitc"
export ruby_cmd="$bash_files/.ruby"

source $git_cmd
source $ruby_cmd

# # # # #

alias bashc="$EDITOR $HOME/.bashrc"
alias bashl="source $HOME/.bashrc"
alias cls="clear"
alias wsc="windsurf"

alias spi="sudo pacman -S"
alias ng="ngrok http --url=included-maggot-infinitely.ngrok-free.app 80"

alias rubys="bat $ruby_cmd"
alias rubyc="$EDITOR $ruby_cmd"

alias gits="bat $git_cmd"
alias gitc="$EDITOR $git_cmd"

# If not running interactively, don't do anything (leave this at the top of this file)
[[ $- != *i* ]] && return

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
source ~/.local/share/omarchy/default/bash/rc

# Add your own exports, aliases, and functions here.

HISTSIZE=10000
HISTFILESIZE=20000
HISTCONTROL=ignoredups:erasedups
shopt -s histappend
PROMPT_COMMAND='history -a'

# Make an alias for invoking commands you use constantly
alias p='python'
alias rm='rm -i'
alias tmuxn='tmux new -s'
alias tmuxs='tmux attach -t'
alias tmuxw='tmux rename-window'
alias gst='git status'
alias gaa='git add .'
alias gcm='git commit -m'
alias gpl='git pull'
alias gp='git push'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias ip='ip -color=auto'


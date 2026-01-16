# If not running interactively, don't do anything (leave this at the top of this file)
[[ $- != *i* ]] && return

# Ensure Starship loads the dotfiles config when Omarchy initializes it.
export STARSHIP_CONFIG="$HOME/dotfiles/.config/starship.toml"

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
source ~/.local/share/omarchy/default/bash/rc

# Add your own exports, aliases, and functions here.

HISTSIZE=10000
HISTFILESIZE=20000
HISTCONTROL=ignoredups:erasedups
shopt -s histappend
PROMPT_COMMAND='history -a'
PS1='\[\e[36m\]\w\[\e[0m\] \[\e[36m\]❯\[\e[0m\] '

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

set -o vi

C_BUILD_DIR="$HOME/code/c-learn/build"

_gcc_run () {
  local src="$1" flags="$2" libs="$3"
  [ -z "$src" ] && { echo "usage: <cmd> file.c"; return 2; }

  # If they typed "hello.c" while sitting in build/, try ../hello.c
  if [ ! -f "$src" ] && [ -f "../$src" ]; then
    src="../$src"
  fi

  if [ ! -f "$src" ]; then
    echo "error: source not found: $1"
    return 2
  fi

  local base="$(basename "$src" .c)"
  local out="$C_BUILD_DIR/$base"

  gcc -std=c17 $flags "$src" -o "$out" $libs && "$out"
}

gccs ()   { _gcc_run "$1" "-Wall -Wextra -Werror -g -fsanitize=address,undefined" ""; }
gcc50s () { _gcc_run "$1" "-Wall -Wextra -Werror -g -fsanitize=address,undefined" "-lcs50"; }
gcc50 ()  { _gcc_run "$1" "-Wall -Wextra -g" "-lcs50"; }
gccr ()   { _gcc_run "$1" "-Wall -Wextra -g" ""; }


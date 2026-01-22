# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"


# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# define $MYPATH
if [ -z "$MYPATH" ]; then
  MYPATH=$HOME/.jr_env/utils/sys:$HOME/.jr_env/utils/mythtv
  if [ -d "$HOME/bin" ] ; then
    MYPATH="$HOME/bin:$MYPATH"
  fi
  export MYPATH
fi
# set PATH
export PATH="$PATH:/usr/local/bin:$MYPATH"

# set up Local/Remote Display
if [ -z ${DISPLAY} ]; then
  if [ ${REMOTEHOST} ]; then
    export DISPLAY=${REMOTEHOST}:0.0
  else
    export DISPLAY=:0.0
  fi
fi

# vi default editor for crontab etc
export EDITOR="vi"
# Alias definitions
if [ -f "$HOME/.bash_aliases" ]; then
  source $HOME/.bash_aliases
fi
# If id command returns zero, youve root access
if [ $(id -u) -eq 0 ];then
  # you are root, set red colour prompt
  PS1="$(tput setaf 1)\\u@\\h:# \\[$(tput sgr0)"
else
  # normal
  PS1="\\u@\\h:$ "
fi

# OS detection
OS="$(uname -s)"

# Homebrew (macOS only; guard on existence)
if [ "$OS" = "Darwin" ] && [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# MacPorts (macOS only; guard on dir)
if [ "$OS" = "Darwin" ] && [ -d /opt/local/bin ]; then
  export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
fi

# nvm config
export NVM_DIR="$HOME/.nvm" 
# macOS (Homebrew)
if [ -s "/opt/homebrew/opt/nvm/nvm.sh" ]; then
  . "/opt/homebrew/opt/nvm/nvm.sh"
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

# standard install (Linux / manual)
elif [ -s "$NVM_DIR/nvm.sh" ]; then
  . "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
fi

# foundry
[ -d "$HOME/.foundry/bin" ] && export PATH="$PATH:$HOME/.foundry/bin"

# Go tools
[ -d "$HOME/go/bin" ] && export PATH="$PATH:$HOME/go/bin"

# uv
[ -d "$HOME/.local/bin" ] && export PATH="$PATH:$HOME/.local/bin"
[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"

# penv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# cargo env 
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# Remove any dups in PATH
PATH=$(echo "$PATH" | awk -v RS=':' -v ORS=":" '!a[$1]++{if (NR > 1) printf ORS; printf $a[$1]}')

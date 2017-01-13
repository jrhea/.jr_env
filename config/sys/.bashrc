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

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
#alias ll='ls -alF'
#alias la='ls -A'
#alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

#need to have this conditionally set
PATH=$PATH:/usr/local/bin:$HOME/.jr_env/utils/sys:$HOME/.jr_env/utils/mythtv

#####################################################
# set up Local/Remote Display
#####################################################
if [ -z ${DISPLAY} ]; then
  if [ ${REMOTEHOST} ]; then
    export DISPLAY=${REMOTEHOST}:0.0
  else
    export DISPLAY=:0.0
  fi
fi

#makes joe default editor for crontab etc
export EDITOR="joe"

# Alias definitions.
if [ -f .bash_aliases ]; then
    . ~/.bash_aliases
fi

# If id command returns zero, youve root access.
if [ $(id -u) -eq 0 ];
then # you are root, set red colour prompt
  PS1="$(tput setaf 1)\\u@\\h:# \\[$(tput sgr0)"
else # normal
  PS1="\\u@\\h:$ "
fi

# added by Miniconda3 4.2.12 installer
export PATH="/home/jrhea/miniconda3/bin:$PATH"

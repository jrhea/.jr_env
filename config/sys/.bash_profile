# include .bashrc if it exists
if [ -f "$HOME/.bashrc" ]; then
    source "$HOME/.bashrc"
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

# Remove any dups in PATH
PATH=$(echo "$PATH" | awk -v RS=':' -v ORS=":" '!a[$1]++{if (NR > 1) printf ORS; printf $a[$1]}')

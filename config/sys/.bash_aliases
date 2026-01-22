alias update-env='source <(curl -sk https://raw.githubusercontent.com/jrhea/.jr_env/master/sync-repo.sh)'
alias soa='source ~/.bash_aliases'
alias sop='source ~/.bash_profile'
alias sol='source .login'

alias wai='echo "\n Host: `hostname`  User: `whoami`  `id`  `tty`\n"'

alias cls='clear screen '
alias cl='clear screen '
alias ks='kill %% '
alias purge='find . \( -name "*~" -o -name "*.bak" -o -name core \)  -print -exec rm {} \;'

alias joe='joe -backpath ~/.joe_backups --wordwrap -icase -wrap -autoindent -highlight -indentc 32 -spaces '
projects() {
  if [ -d "$HOME/projects" ]; then
    cd "$HOME/projects" || return
  elif [ -d "$HOME/Documents/projects" ]; then
    cd "$HOME/Documents/projects" || return
  else
    echo "No projects dir found at ~/projects or ~/Documents/projects" >&2
    return 1
  fi
}
alias projects='projects'
alias qqq='sdiff -s '
alias modified='find . -mtime -\!* -type f -print'

set pu="`whoami`:`hostname -s` \!>"

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

alias lla="ls -AlF "
alias lld="ls -AlF | awk {'"'$1'"'~/^d/} "
alias ll="ls -alF "
alias llnda="ls -AlF | awk {'"'$1'"'!~/^d/} "
alias lta="ls -AltrF "
alias lt="ls -ltrF "

alias xdi="xxdiff \!:1 \!:2 "

alias sniff="sudo tcpdump -X -i eth0 -s0;"
alias sniff-port="sudo tcpdump -X -i eth0 -s0 port \!:1;"
#git
#alias bfg java -jar ~/bin/bfg.jar
alias git-push-head="git push origin HEAD"
alias git-status-diff="git status | grep modified | grep -v bin | grep -v make | sed 's/\s*#\s*modified:\s*//' | xargs git diff --color-words"


#rdist 
#alias rdist-chroot-pts1 "rdist -owhole -m pts1 -d PREFIX=/mnt/wheezy32"
######################
#ssh login
######################
#alias ssh-simdev3 'ssh -Y $SSH_ID@simdev3'

######################
#define ssh keys
######################

#add specified ssh key to authorized_keys file on remote server to enable passwordless login
#auth-key [public key] [user@server]
#alias auth-key "cat ~/.ssh/\!:1 | ssh \!:2 'umask 077; mkdir -p ~/.ssh; touch ~/.ssh/authorized_keys; cat >> ~/.ssh/authorized_keys'"

#add default ssh key to authorized_keys file on remote server to enable passwordless login
#auth-default-key [user@server]
#alias auth-default-key "auth-key id_rsa.pub \!:1"

########################
#distribute environment
#######################

#alias testif " if ( '\!:1' == 'all' ) echo foo;\\
#               if ( '\!:1' != 'all' ) echo bar;"

#NETWORK_ID is defined for erdos VM in .custom_config file
#if $?NETWORK_ID then
#  setenv SSH_ID $NETWORK_ID 
#else
#  setenv SSH_ID $USER
#endif

#define central dist server
#setenv DISTSERVER simdev3

#send env to a single server (csh, bin, jral, ssh), or specific things
#usage: send-env [server] [csh|bin|jral|ssh]
#usage: send-env [server]    
#alias send-env " if ( '\!:1' == 'all' ) rdist -P /usr/bin/ssh -ofollow -f ~/bin/distfile \!:2*;\\
#                 if ( '\!:1' != 'all' ) rdist -P /usr/bin/ssh -ofollow -f ~/bin/distfile -m \!:1 \!:2*;"

#send distfile to dist-server
#send-dist
#alias send-dist 'send-env $DISTSERVER dist'

#distribute env to all machines (csh, bin, jral, ssh)
#usage: dist-env [user] [csh|bin|jral|ssh]
#usage: dist-env [user]    
#alias dist-env "send-dist; send-env $DISTSERVER \!:2*; ssh \!:1@$DISTSERVER 'send-env all \!:2*;'"

#distribute authorized_keys file and all ssh keys (located in ~/.ssh)
#dist-keys
#alias dist-keys 'dist-env $SSH_ID ssh'

#distribute ~/bin
#usage: dist-bin
#alias dist-bin 'dist-env $SSH_ID bin'

#distribute ~/jr_alias
#usage: dist-jra
#alias dist-jra 'dist-env $SSH_ID jra'

#distribute .cshrc
#usage: dist-csh
#alias dist-csh 'dist-env $SSH_ID csh'

#distribute all env sets in distfile
#usage: dist-all-env-sets
#alias dist-all-env 'dist-env $SSH_ID' 


##############################
#share files
##############################

#define share locations
#setenv SHARESERVER simraid
#setenv SHAREDIR /mnt/raid2/YDrive/VirtualMachines/erdos/shared
#setenv SHARE $SHARESERVER\:$SHAREDIR

#copy specific file to [$SHARESERVER]:[$SHAREDIR] 
#usage: share-this [file] [optional path] 
#alias share-this 'rcp \!:1 $SHARE/\!:2*/; rsh $SHARESERVER chmod 777 $SHAREDIR/\!:2*/\!:1; rsh $SHARESERVER ls -l $SHAREDIR/\!:2*/\!:1'

#copy specific odf to sim_sessions folder on $SHARE
#usage: share-odf [file]
#alias share-odf 'share-this \!:1 sim_sessions' 

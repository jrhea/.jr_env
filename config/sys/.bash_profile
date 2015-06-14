# include .bashrc if it exists
if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
fi

# set PATH so it includes 
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

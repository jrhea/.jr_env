#!/bin/bash

cd $HOME
if [ ! -d "$HOME/.jr_env" ]; then
  git clone git@github.com:jrhea/.jr_env.git
else
  cd "$HOME/.jr_env"
  git pull
  cd ..
fi

source $HOME/.jr_env/init.env

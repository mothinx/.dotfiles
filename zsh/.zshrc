#!/bin/bash

# Path to oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="random"

source $ZSH/oh-my-zsh.sh

# Env variables
export LOCAL_SCRIPT=$HOME/.local/share/script

# Secret env variables
if [ ! -e ~/.secret ] 
then
    echo "You should create your .secret file."
else 
    source ~/.secret
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

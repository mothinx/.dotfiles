#!/bin/bash

# Path to oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh


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

# Alias
alias gtd="python3 $LOCAL_SCRIPT/trello.py"
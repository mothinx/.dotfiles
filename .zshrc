#!/bin/bash

# Path to oh-my-zsh installation.
export ZSH="/home/mothinx/.oh-my-zsh"

# Theme
ZSH_THEME="wedisagree"

# Oh-My-Zsh Plugins
plugins=(git
)

source $ZSH/oh-my-zsh.sh

# Alias 
alias gtd="python3 ~/.dotfiles/scripts/trello.py"

# Env variables
source ~/.env
# Secret env variables
source ~/.secret
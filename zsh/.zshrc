export ZSH="/home/mothinx/.oh-my-zsh"

ZSH_THEME="kolo"

plugins=(git)

source $ZSH/oh-my-zsh.sh

export PATH="/home/mothinx/bin:$PATH"

alias ssh="kitty +kitten ssh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

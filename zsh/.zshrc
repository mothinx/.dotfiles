export ZSH="/home/mothinx/.oh-my-zsh"

ZSH_THEME="kolo"

plugins=(git)

source $ZSH/oh-my-zsh.sh

export PATH="/home/mothinx/bin:$PATH"

if [ -f ~/.aliases ]; then
    source $HOME/.aliases
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Expand alias when pressing ' '
function expand-alias() {
    zle _expand_alias
    zle self-insert
}
zle -N expand-alias
bindkey -M main ' ' expand-alias

# Add JBang to environment
alias j!=jbang
export PATH="$HOME/.jbang/bin:$PATH"

# fnm
export PATH="/home/mothinx/.local/share/fnm:$PATH"
eval "`fnm env`"

export DOTFILES_PATH="$HOME/.dotfiles"

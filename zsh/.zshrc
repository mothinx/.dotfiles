export ZSH="/home/mothinx/.oh-my-zsh"

ZSH_THEME="kolo"

plugins=(git)

source $ZSH/oh-my-zsh.sh


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


export DOTFILES_PATH="$HOME/.dotfiles"

# pnpm
export PNPM_HOME="/home/mothinx/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
#
export PATH="/home/mothinx/bin":$PATH

setxkbmap -rules evdev -model evdev -layout us -variant altgr-intl

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
source /usr/share/nvm/init-nvm.sh

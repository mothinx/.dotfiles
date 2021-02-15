#!/usr/bin/env bash
#
# Zsh + Oh-My-Zsh install

# Exit if any error is found during process
set -e

if [ "$SHELL" != '/usr/bin/zsh' ]; then
    sudo apt-get install -y zsh 
    echo "Using zsh as default shell. Note: Login / Logout..."
    chsh -s $(which zsh)

    echo "Downloading Oh-My-Zsh..."
    sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
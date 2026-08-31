#!/bin/bash

set -e

echo "🔄 Updating claude..."
claude update

echo "🔄 Updating pi..."
pi update

echo "🔄 Updating mise..."
mise self-update --yes
mise upgrade

echo "🔄 Syncing neovim plugins..."
nvim --headless "+Lazy! sync" +qa

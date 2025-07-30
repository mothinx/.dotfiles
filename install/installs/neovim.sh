#!/bin/bash

echo "Installing Neovim from source for Fedora..."

# Install dependencies
echo "Installing dependencies..."
sudo dnf install -y ninja-build libtool autoconf automake cmake g++ pkg-config unzip patch libstdc++-static

# Clone Neovim repository
echo "Cloning Neovim repository..."
git clone https://github.com/neovim/neovim.git /tmp/neovim
cd /tmp/neovim

# Build and install Neovim
echo "Building and installing Neovim..."
git checkout stable
make CMAKE_BUILD_TYPE=Release
sudo make install

# Clean up
echo "Cleaning up..."
rm -rf /tmp/neovim

echo "Neovim installation complete."

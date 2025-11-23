#!/bin/bash

# Check if fd is already installed
if command -v fd &> /dev/null; then
  echo "✅ fd is already installed."
  exit 0
fi

echo "fd is not installed. Attempting to install..."

# Install fd using pacman
sudo pacman -S --noconfirm fd

if [ $? -eq 0 ]; then
  echo "✅ fd has been installed successfully."
else
  echo "❌ Error during fd installation with pacman."
  exit 1
fi

# Verify installation
if command -v fd &> /dev/null; then
  echo "✅ fd is now available."
else
  echo "❌ fd installation failed. Please check the output above."
  exit 1
fi

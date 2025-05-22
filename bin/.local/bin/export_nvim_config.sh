#!/bin/bash

# This script exports your Neovim configuration and Mason data
# (compilers, linters, formatters, etc.) into a .tar.gz archive.
# The goal is to facilitate transferring your Neovim environment
# to another machine, especially for offline use.

# Output archive file name
ARCHIVE_NAME="neovim_config_for_offline_$(date +%Y%m%d%H%M%S).tar.gz"

# Temporary export directory
EXPORT_DIR="neovim_offline_export"

# Paths to Neovim and Mason directories on the source machine
NVIM_CONFIG_DIR="$HOME/.config/nvim"
MASON_DATA_DIR="$HOME/.local/share/nvim/mason" # Default Mason path

echo "--- Preparing Neovim configuration export ---"

# Check if directories exist
if [ ! -d "$NVIM_CONFIG_DIR" ]; then
  echo "Error: Neovim configuration directory ($NVIM_CONFIG_DIR) does not exist."
  echo "Make sure Neovim is installed and configured."
  exit 1
fi

if [ ! -d "$MASON_DATA_DIR" ]; then
  echo "Warning: Mason data directory ($MASON_DATA_DIR) does not exist. "
  echo "If you don't use Mason or haven't installed any tools, this is normal."
  # Do not exit, as Neovim config can still be exported without Mason
fi

# Create the temporary export directory
echo "Creating temporary directory: $EXPORT_DIR"
mkdir -p "$EXPORT_DIR/.config"           # Creates the .config directory inside
mkdir -p "$EXPORT_DIR/.local/share/nvim" # Creates the structure for Mason

# Copy Neovim configuration
echo "Copying Neovim configuration from $NVIM_CONFIG_DIR to $EXPORT_DIR/.config/nvim"
cp -r "$NVIM_CONFIG_DIR" "$EXPORT_DIR/.config/"

# Copy Mason data (if it exists)
if [ -d "$MASON_DATA_DIR" ]; then
  echo "Copying Mason data from $MASON_DATA_DIR to $EXPORT_DIR/.local/share/nvim/mason"
  cp -r "$MASON_DATA_DIR" "$EXPORT_DIR/.local/share/nvim/"
else
  echo "Mason directory not found, no Mason data to copy."
fi

# Compress the export directory
echo "Compressing export into $ARCHIVE_NAME"
tar -czvf "$ARCHIVE_NAME" "$EXPORT_DIR"

# Clean up the temporary directory
echo "Cleaning up temporary directory: $EXPORT_DIR"
rm -rf "$EXPORT_DIR"

echo "--- Export completed successfully! ---"
echo "Your Neovim configuration and Mason data are archived in: $ARCHIVE_NAME"
echo "You can transfer this file to your other machine."

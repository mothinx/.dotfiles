#!/bin/bash

echo "Installing Visual Studio Code for Fedora..."

# Install the GPG key and Microsoft Yum repository
echo "Adding GPG key and Microsoft repository..."
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc || {
  echo "Error: Failed to import GPG key."
  exit 1
}
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo >/dev/null || {
  echo "Error: Failed to create repository file."
  exit 1
}

# Update package cache and install VS Code
echo "Updating package cache and installing VS Code..."
sudo dnf check-updates || { echo "Warning: Failed to check for updates."; }
sudo dnf install code -y || {
  echo "Error: Failed to install VS Code."
  exit 1
}

echo "Visual Studio Code installation complete."

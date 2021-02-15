#!/bin/sh
#
# Some packages for my PopOs Linux

# Exit if any error is found during process
set -e

echo "Upgrade everything before install..."
sudo apt-get update && sudo apt upgrade -y

echo "Downloading tools..."
sudo apt-get -y install git tree zip unzip \
    redshift rclone
if [ ! -e /usr/bin/keepassxc ]; then
    sudo apt-get -y install keepassxc
fi

echo "Downloading coding stuff..."
sudo apt-get -y install openjdk-8-jdk

echo "Downloading apps..."
sudo apt-get -y install firefox libreoffice libreoffice-l10n-fr




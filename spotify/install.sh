#!/usr/bin/env bash

# Exit if any error is found during process
set -e

if [ ! -e /usr/bin/spotify ]; then
    curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add - 
    echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
    sudo apt-get update && sudo apt-get -y install spotify-client
fi
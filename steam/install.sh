#!/usr/bin/env bash

# Exit if any error is found during process
set -e

if [ ! -e /usr/games/steam ]; then
    sudo apt-get -y install steam
fi
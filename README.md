# Dotfiles

## Disclaimer
This is my personal config files and you should use it carefully.

## System
Arch

## Install

1. Make your ssh key stuff
2. Clone this repo
3. I use stow to symlink
``` 
    #cd .dotfiles
    #stow git
    #stow kitty
    #stow i3
    etc...
    
```

### Keyboard layout
```
# Us international altgr with no dead keys layout
setxkbmap -layout us -variant altgr-intl -option nodeadkeys
# Activate Fn keys with F1,F2,F3...
sudo echo 2 > /sys/module/hid_apple/parameters/fnmode
# Remap CAPSLOCK to Escape
setxkbmap -option caps:escape
```

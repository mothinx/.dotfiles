# .dotfiles

> Dotfiles is all about lazyness

## What is it ?

Dotfiles are configuration files to personalize your system.

You should use dotfiles if stay more than 10 minutes in front of a computer every day.

## Components

Everything here is build with [stow](https://www.gnu.org/software/stow/), a linux tool to symlink stuff. So every directories is "topic" related.

- **bin/**: Anything in it will get added to the `$PATH`.
- **git/**: Git config.
- **i3/**: Use I3 as a window manager.
- **ideavim/**: Vim plugin for IDEA Intellij.
- **kitty/**: Kitty is a terminal emulator.
- **nvim/**: Because i want to use it as my everyday IDE.
- **polybar/**: Bar for i3.
- **redshift/**: A tool to protect your eyes.
- **rofi/**: A window switcher.
- **zsh/**: A shell.

## Install

Run:

```sh
git clone https://github.com/mothinx/.dotfiles.git ~/.dotfiles`
cd ~/.dotfiles
make
```

## Uninstall
`make delete`

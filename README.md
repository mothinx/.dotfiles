# Dotfiles: Personalize Your System with Ease

## Introduction

Welcome to Dotfiles - your gateway to effortless system personalization! Dotfiles are a collection of configuration files tailored to enhance your computing experience. If you find yourself spending more than 10 minutes in front of a terminal daily, then dotfiles are your ticket to a more efficient and enjoyable workflow.

## What's Inside?

Every aspect of this repository is meticulously organized using Stow, a powerful Linux tool for symbolic linking. Each directory represents a distinct "topic" to keep things tidy and manageable.

- **bin/**: Add custom scripts and executables to your `$PATH`.
- **git/**: Configure Git to suit your workflow.
- **i3/**: Dive into the world of i3 window manager for a streamlined desktop experience.
- **ideavim/**: Elevate your Intellij IDEA with Vim keybindings using this plugin.
- **kitty/**: Embrace Kitty, the terminal emulator, for a purr-fectly efficient command line.
- **nvim/**: Transform Neovim into your go-to Integrated Development Environment (IDE).
- **polybar/**: Customize your i3 desktop with the sleek Polybar.
- **redshift/**: Protect your precious eyes with Redshift, a tool for adjusting screen color temperature.
- **rofi/**: Enhance your window management with Rofi, the versatile window switcher.
- **zsh/**: Level up your shell game with Zsh, a powerful alternative to bash.

## Installation

Ready to embark on the journey of system personalization? Follow these simple steps:

```bash
git clone https://github.com/mothinx/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
make
```

### Uninstallation

Should you ever wish to bid adieu to your dotfiles setup, fear not! Use the following command to bid them farewell:

```bash
make delete
```

### Miscellaneous
Here are some additional tools and plugins that I personally use to augment my browsing and development experience:

- **Grepper**: Retrieve code examples directly from your Google search results.
- **React Developer Tool**: Streamline your React development with this essential browser extension.

Feel free to explore, customize, and make these dotfiles your own. Happy computing! 🚀

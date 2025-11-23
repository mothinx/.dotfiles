# Dotfiles

## What's Inside?

Every aspect of this repository is meticulously organized using Stow, a powerful Linux tool for symbolic linking. Each directory represents a distinct "topic" to keep things tidy and manageable.

## Installation

```bash
git clone https://github.com/mothinx/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
make
```

## Dependencies

These dotfiles depend on a variety of tools and applications. Please ensure the following are installed on your system.

### Core Components

*   **`omarchy`**: An opiniated OS based on Arch.

### Terminal & Shell

*   **`fd`**: A simple, fast and user-friendly alternative to `find`.
*   **`sk`**: A fuzzy finder.

### Neovim

*   **Language Servers**:
    *   `lua-language-server` (`lua_ls`)
    *   `typescript-language-server` (`ts_ls`)
    *   `pyright` (for Python)
    *   `jdtls` (for Java)

### Uninstallation

```bash
make delete
```

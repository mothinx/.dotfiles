# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository managed with GNU Stow for symlink management. Each top-level directory represents a "topic" (application/tool configuration) that gets stowed to `$HOME`.

## Architecture

### Stow-Based Structure
- Each top-level directory (bash, git, nvim, sway, tmux, waybar, bin) is a stow package
- Directory structure within each package mirrors the target structure in `$HOME`
- Example: `bash/.bashrc` → `~/.bashrc`, `nvim/.config/nvim/` → `~/.config/nvim/`

### Configuration Topics
- **bash**: Shell configuration with modular `.bashrc.d/` sourcing pattern
- **git**: Git configuration and commit message template
- **nvim**: LazyVim-based Neovim setup (uses lazy.nvim plugin manager)
- **sway**: Wayland compositor configuration (Sway WM with custom keybindings)
- **tmux**: Terminal multiplexer configuration
- **waybar**: Status bar for Wayland (Sway companion)
- **bin**: Custom utility scripts in `.local/bin/`

### Key Dependencies
- **Stow**: Core dependency for symlink management
- **Neovim with LazyVim**: Plugin framework based on lazy.nvim
- **Sway + Waybar**: Wayland window manager setup
- **mise**: Development tool version manager (activated in bash)
- **starship**: Shell prompt (activated in containerized environments)
- **fd, sk (skim)**: Modern CLI tools for file finding and fuzzy finding

## Common Commands

### Installation & Management
```bash
# Install all configurations (symlink to $HOME)
make

# Uninstall all configurations (remove symlinks)
make delete

# Install/update a specific topic only
stow --verbose --target=$HOME --restow <topic>/

# Remove a specific topic
stow --verbose --target=$HOME --delete <topic>/
```

### Working with Configurations

When modifying configurations:
1. Edit files directly in the dotfiles repo (not in `$HOME`)
2. Changes are immediately reflected via symlinks
3. Test changes in a new shell/session
4. Commit when satisfied

### Neovim (LazyVim)

The Neovim setup uses LazyVim as a base configuration:
- Main entry point: `nvim/.config/nvim/init.lua`
- Configuration split into: `lua/config/` (core settings) and `lua/plugins/` (plugin specs)
- LazyVim automatically bootstraps lazy.nvim on first run
- Custom plugins go in `lua/plugins/` and are auto-loaded

### Bash Configuration

Bash uses a modular approach:
- Main `.bashrc` sources all files from `.bashrc.d/`
- Add new configuration modules as separate files in `bash/.bashrc.d/`
- Currently includes: `aliasesrc`

### Git Configuration

Git uses a custom commit message template at `~/.gitmessage`. The default branch is `main`.

## Important Notes

- System is designed for Fedora Atomic Sway
- Sway configuration includes display-specific settings (DP-1, DP-2) that may need adjustment
- The repository assumes tools like fd, sk, mise are already installed
- Containerized environments (detected via `/run/.containerenv`) get starship prompt and mise activation

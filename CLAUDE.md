# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository managed with GNU Stow for symlink management. Each top-level directory represents a "topic" (application/tool configuration) that gets stowed to `$HOME`.

## Architecture

### Stow-Based Structure
- Each top-level directory is a stow package (directories prefixed with `_` are excluded)
- Directory structure within each package mirrors the target structure in `$HOME`
- Example: `bash/.bashrc` → `~/.bashrc`, `nvim/.config/nvim/` → `~/.config/nvim/`
- `_archive/` holds retired packages (sway, waybar, kitty) kept for reference only

### Configuration Topics
- **bash**: Shell configuration with modular `.bashrc.d/` sourcing pattern
- **bin**: Custom utility scripts in `.local/bin/`
- **git**: Git configuration and commit message template
- **mise**: Development tool version manager config
- **nvim**: LazyVim-based Neovim setup (uses lazy.nvim plugin manager)
- **tmux**: Terminal multiplexer configuration
- **wsl**: WSL2-specific shell config (`wslrc`) and `.wslconfig.example` reference

### Key Dependencies
- **Stow**: Core dependency for symlink management
- **Neovim with LazyVim**: Plugin framework based on lazy.nvim
- **mise**: Development tool version manager (activated in bash)
- **starship**: Shell prompt
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
- Add new configuration modules as separate files in `bash/.bashrc.d/` or `wsl/.bashrc.d/`
- Currently includes: `aliasesrc` (general aliases), `wslrc` (WSL2-only, guarded by `/proc/version` check)

### Git Configuration

Git uses a custom commit message template at `~/.gitmessage`. The default branch is `main`.

## Important Notes

- System targets **Ubuntu on WSL2** (Windows 11)
- Wayland/Sway/Kitty configs are archived in `_archive/` — not stowed, kept for reference
- The repository assumes tools like fd, sk, mise are already installed
- `wslrc` is guarded so it only runs inside WSL2 (checks `/proc/version` for "microsoft")

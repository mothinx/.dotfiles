# Dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## What's Inside?

Each top-level directory is a stow package whose contents are symlinked into `$HOME`.

| Package | Description |
|---------|-------------|
| `bash` | Shell config with modular `.bashrc.d/` sourcing |
| `bin` | Custom scripts in `~/.local/bin/` |
| `git` | Git config and commit message template |
| `mise` | Dev tool version manager config |
| `nvim` | LazyVim-based Neovim setup |
| `tmux` | Terminal multiplexer config |
| `wsl` | WSL2-specific shell config and interop settings |

Directories prefixed with `_` (e.g. `_archive/`) are never stowed.

## Installation

```bash
git clone https://github.com/mothinx/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
make
```

### Uninstallation

```bash
make delete
```

## WSL2 Setup

This repo targets **Ubuntu on WSL2**. The `wsl/` package provides:

- `wslrc` — sourced automatically by `.bashrc.d/`; sets `BROWSER`, `DOCKER_HOST`, `umask`, etc.
- `.wslconfig.example` — reference template for `C:\Users\<user>\.wslconfig` (VM memory/CPU tuning).

Copy `.wslconfig.example` to the Windows user profile and rename to `.wslconfig`:

```powershell
cp $env:USERPROFILE\.dotfiles\wsl\.wslconfig.example $env:USERPROFILE\.wslconfig
```

### Archived packages

Wayland/Fedora-specific configs are preserved in `_archive/` for reference but are not stowed:

- `_archive/sway/` — Sway WM configuration
- `_archive/waybar/` — Waybar status bar
- `_archive/kitty/` — Kitty terminal (using Windows Terminal instead)

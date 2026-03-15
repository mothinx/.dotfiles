---
description: Restow one or all dotfiles packages from ~/.dotfiles
allowed-tools: Bash(stow:*), Bash(make:*), Bash(ls:*)
---

Restow dotfiles packages from `~/.dotfiles`.

Argument: "$ARGUMENTS" — optional package name (e.g. `nvim`, `bash`, `tmux`).

- If "$ARGUMENTS" is non-empty, restow only that package:
  ```
  stow --verbose --target=$HOME --restow "$ARGUMENTS"/
  ```
- If "$ARGUMENTS" is empty, restow all packages:
  ```
  make -C ~/.dotfiles
  ```

Report which symlinks were created, updated, or skipped. If stow reports a conflict, show the conflicting paths and stop — do not delete files without confirmation.

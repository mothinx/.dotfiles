#!/bin/bash

session_exists() {
  tmux has-session -t "$1" 2>/dev/null
}

# New tmux session with multiple panels
# $1 = session's name
# $2 = paths
# $3 = comands
# $4 = panel's name
create_session_with_windows() {
  local session_name="$1"
  shift
  local -n paths="$1"
  shift
  local -n cmds="$1"
  shift
  local -n panelNames="$1"

  if ! session_exists "$session_name"; then
    tmux new-session -d -s "$session_name" -c "${paths[0]}" -n "${panelNames[0]}"
    [ -n "${cmds[0]}" ] && tmux send-keys -t "$session_name:0" "${cmds[0]}" C-m

    for i in "${!paths[@]}"; do
      if [ "$i" -eq 0 ]; then continue; fi
      tmux new-window -t "$session_name:" -c "${paths[i]}" -n "${panelNames[i]}"
      [ -n "${cmds[i]}" ] && tmux send-keys -t "$session_name:$i" "${cmds[i]}" C-m
    done
  fi
}

dotfiles_paths=(
  "$HOME/.dotfiles"
  "$HOME/.dotfiles"
  "$HOME"
)

dotfiles_cmds=(
  "nvim ."
  "lazygit"
  ""
)

dotfiles_names=(
  "nvim"
  "git"
  "home"
)

create_session_with_windows "dotfiles" dotfiles_paths dotfiles_cmds dotfiles_names

home_paths=("$HOME")
home_cmds=("")
home_names=("")

create_session_with_windows "home" home_paths home_cmds home_names

# Attache à la session home
tmux attach -t home

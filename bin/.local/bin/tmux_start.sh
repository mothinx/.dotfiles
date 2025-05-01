#!/bin/bash

session_exists() {
  tmux has-session -t "$1" 2>/dev/null
}

create_session() {
  local name="$1"
  local path="$2"
  local cmd="$3"

  if ! session_exists "$name"; then
    tmux new-session -d -s "$name" -c "$path"
    [ -n "$cmd" ] && tmux send-keys -t "$name" "$cmd" C-m
  fi
}

create_session "dotfiles" "$HOME/.dotfiles" "nvim ."
create_session "home" "$HOME"

tmux attach -t home


#!/bin/bash

set -e

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "⚠️ This is not a git repository."
  exit 1
fi

REMOTE_URL=$(git remote get-url origin)

BROWSE_URL=$(echo "$REMOTE_URL" | sed 's|^git@github.com:|https://github.com/|' | sed 's/\.git$//')

echo "🚀 Opening $BROWSE_URL..."
if grep -qi microsoft /proc/version 2>/dev/null; then
  explorer.exe "$BROWSE_URL"
else
  xdg-open "$BROWSE_URL"
fi

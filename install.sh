#!/bin/bash
set -euo pipefail

CLAUDE_DIR="$HOME/.claude"
CLAUDE_MD="$CLAUDE_DIR/CLAUDE.md"
SNIPPET="$(dirname "$0")/snippet.md"
MARKER="## em-dashfatwa"

if [ ! -f "$SNIPPET" ]; then
  echo "Error: snippet.md not found next to this script." >&2
  exit 1
fi

mkdir -p "$CLAUDE_DIR"
touch "$CLAUDE_MD"

if grep -qF "$MARKER" "$CLAUDE_MD"; then
  # Remove existing em-dashfatwa section before re-appending
  # Deletes from "## em-dashfatwa" to the next "## " heading or end of file
  sed -i.bak "/^## em-dashfatwa$/,/^## /{/^## em-dashfatwa$/d;/^## /!d;}" "$CLAUDE_MD"
  rm -f "$CLAUDE_MD.bak"
  echo "Replacing existing em-dashfatwa installation."
fi

# Ensure a blank line before appending
if [ -s "$CLAUDE_MD" ] && [ "$(tail -c 1 "$CLAUDE_MD")" != "" ]; then
  echo "" >> "$CLAUDE_MD"
fi

cat "$SNIPPET" >> "$CLAUDE_MD"
echo "em-dashfatwa installed into $CLAUDE_MD"

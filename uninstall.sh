#!/bin/bash
set -euo pipefail

CLAUDE_MD="$HOME/.claude/CLAUDE.md"
MARKER="## em-dashfatwa"

if [ ! -f "$CLAUDE_MD" ]; then
  echo "No CLAUDE.md found at $CLAUDE_MD. Nothing to uninstall."
  exit 0
fi

if ! grep -qF "$MARKER" "$CLAUDE_MD"; then
  echo "em-dashfatwa is not installed. Nothing to uninstall."
  exit 0
fi

# Remove from "## em-dashfatwa" to the next "## " heading or end of file
sed -i.bak "/^## em-dashfatwa$/,/^## /{/^## em-dashfatwa$/d;/^## /!d;}" "$CLAUDE_MD"
rm -f "$CLAUDE_MD.bak"

echo "em-dashfatwa uninstalled from $CLAUDE_MD"

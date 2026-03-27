#!/bin/bash
set -e

CLAUDE_MD="${CLAUDE_MD:-$HOME/.claude/CLAUDE.md}"
START_MARKER="# >>> em-dashfatwa >>>"
END_MARKER="# <<< em-dashfatwa <<<"

if [ ! -f "$CLAUDE_MD" ]; then
    echo "No CLAUDE.md found at $CLAUDE_MD"
    exit 0
fi

if ! grep -q '>>> em-dashfatwa' "$CLAUDE_MD"; then
    echo "em-dashfatwa is not installed in $CLAUDE_MD"
    exit 0
fi

sed -i '' "/$START_MARKER/,/$END_MARKER/d" "$CLAUDE_MD" 2>/dev/null \
    || sed -i "/$START_MARKER/,/$END_MARKER/d" "$CLAUDE_MD"

sed -i '' '/^$/N;/^\n$/d' "$CLAUDE_MD" 2>/dev/null \
    || sed -i '/^$/N;/^\n$/d' "$CLAUDE_MD"

echo "em-dashfatwa removed from $CLAUDE_MD"

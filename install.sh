#!/bin/bash
set -e

REPO_URL="https://raw.githubusercontent.com/joefrancis505/em-dashfatwa/main/snippet.md"
CLAUDE_MD="${CLAUDE_MD:-$HOME/.claude/CLAUDE.md}"
CLAUDE_DIR="$(dirname "$CLAUDE_MD")"
SCRIPT_DIR="$(cd "$(dirname "$0")" 2>/dev/null && pwd)" || SCRIPT_DIR=""
START_MARKER="# >>> em-dashfatwa >>>"
END_MARKER="# <<< em-dashfatwa <<<"

# Fetch directives: try GitHub first, fall back to local file
DIRECTIVES=$(curl -fsSL "$REPO_URL" 2>/dev/null) || {
    if [ -n "$SCRIPT_DIR" ] && [ -f "$SCRIPT_DIR/snippet.md" ]; then
        echo "Could not reach GitHub. Using local copy."
        DIRECTIVES=$(cat "$SCRIPT_DIR/snippet.md")
    else
        echo "Error: Could not fetch directives from GitHub and no local copy available."
        exit 1
    fi
}

mkdir -p "$CLAUDE_DIR"

# Remove existing install if present
if [ -f "$CLAUDE_MD" ] && grep -q '>>> em-dashfatwa' "$CLAUDE_MD"; then
    sed -i '' "/$START_MARKER/,/$END_MARKER/d" "$CLAUDE_MD" 2>/dev/null \
        || sed -i "/$START_MARKER/,/$END_MARKER/d" "$CLAUDE_MD"
    sed -i '' '/^$/N;/^\n$/d' "$CLAUDE_MD" 2>/dev/null \
        || sed -i '/^$/N;/^\n$/d' "$CLAUDE_MD"
    echo "Updating existing em-dashfatwa installation."
fi

# Append directives
if [ -f "$CLAUDE_MD" ] && [ -s "$CLAUDE_MD" ]; then
    echo "" >> "$CLAUDE_MD"
fi
echo "$DIRECTIVES" >> "$CLAUDE_MD"

echo "em-dashfatwa installed into $CLAUDE_MD"

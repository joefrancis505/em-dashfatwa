# em-dashfatwa

LLMs overuse em dashes. This is a set of writing directives for Claude Code
that corrects the habit, based on the Chicago Manual of Style (17th Edition,
sections 6.82-6.88).

Once installed, Claude will prefer commas, parentheses, colons, and semicolons
over em dashes when writing or reviewing prose. Em dashes are reserved for
cases where they are genuinely the best choice: abrupt breaks, interruptions
in dialogue, and emphatic shifts.

This does not affect chat, code, commit messages, or other non-prose output.

## Install

```sh
git clone <repo-url>
cd em-dash
./install.sh
```

This appends the directives to your `~/.claude/CLAUDE.md`. Safe to run
multiple times (idempotent).

## Uninstall

```sh
./uninstall.sh
```

## How it works

The install script appends a short block of instructions to your global
`~/.claude/CLAUDE.md`. Claude Code reads this file at the start of every
session, so the guidance is always active when writing prose. No skills,
no plugins, no runtime overhead.

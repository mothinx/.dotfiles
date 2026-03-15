---
description: Stage changes and create a git commit with a generated or provided message
allowed-tools: Bash(git add:*), Bash(git status:*), Bash(git diff:*), Bash(git commit:*), Bash(git log:*)
---

Stage and commit changes in the current repository.

1. Run `git status` and `git diff` (staged and unstaged) to understand what changed.
2. Run `git log --oneline -5` to match the repo's commit message style.
3. Stage specific files by name — avoid `git add -A` or `git add .` to prevent accidentally committing secrets or unrelated files.
4. If "$ARGUMENTS" is non-empty, use it as the commit message verbatim. Otherwise, generate a concise message: imperative mood, lowercase, no trailing period.
5. Commit. Do not amend, do not skip hooks.
6. Use Conventional Commit. The commit header should be as expressive as you can.

If there is nothing to commit, say so and stop.

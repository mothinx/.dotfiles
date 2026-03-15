---
description: Generate a daily standup report from recent git activity
allowed-tools: Bash(git log:*), Bash(git diff:*), Bash(find:*)
---

Generate a markdown standup report from recent git history.

Arguments: "$ARGUMENTS" — optional number of days to look back (default: 1).

Steps:
1. Determine the lookback window: parse "$ARGUMENTS" as a number of days, default to 1 if empty or invalid.
2. Search for git repositories under `~` (skip `node_modules`, `.cache`, hidden dirs other than dotfiles). For each repo found, run:
   ```
   git log --oneline --since="<N> days ago" --author="$(git config user.email)"
   ```
3. Collect all commits grouped by repository.
4. Output a standup report in this format:

---

## Standup — <today's date>

### What I did
- **<repo-name>**: <commit message> _(hash)_
- ...

### Blockers
None.

---

Omit repos with no recent commits. Keep it concise — this is a standup, not a novel.

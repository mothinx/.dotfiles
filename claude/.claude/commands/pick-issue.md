# .claude/commands/pick-issue.md
---
description: Pick a GitHub issue passed as argument and develop it
allowed-tools: Bash, Read, Write, Edit, Agent
---

## Full development workflow

**Step 1 — Fetch the issue**
If `$ARGUMENTS` is provided, run `gh issue view $ARGUMENTS`.
Otherwise, run `gh issue list` to display open issues and wait for the user to select one.
Assign it to the current user with `gh issue edit <number> --add-assignee @me`.
Display the title, body, and labels. Wait for confirmation before continuing.

**Step 2 — Analysis**
Delegate to the `issue-analyzer` agent. Pass in full: issue number, title, body, and labels.
Display its report. Wait for validation before continuing.

**Step 3 — Plan**
Delegate to the `dev-planner` agent. Pass in full: the analysis report from step 2.
Display the detailed plan. The user may amend it. Wait for explicit go-ahead before continuing.

**Step 4 — Development**
Create the git branch with `git switch -c <branch-name>` following conventional naming (`type/short-description`).
Delegate to the `implementer` agent. Pass: the validated plan, the branch name, and the issue number.

**Step 5 — Publishing**
DO NOT execute without explicit confirmation "yes, publish".
Delegate to the `pr-publisher` agent. Pass: the issue number, issue title, and plan summary.

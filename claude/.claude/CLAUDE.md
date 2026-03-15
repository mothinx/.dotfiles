# Global Claude Code Preferences

These preferences apply to every project.

## Response Style

- Terse and direct. Lead with the answer, not the reasoning.
- No preamble, no filler words, no transitions.
- No trailing summary of what you just did — I can read the diff.
- If it fits in one sentence, use one sentence.
- Bullet points over prose when listing things.
- No emojis unless I ask for them.

## Environment

- OS: Ubuntu 24.04 on WSL2 (Windows 11)
- Shell: bash
- Editor: Neovim (LazyVim)
- Multiplexer: tmux
- Version manager: mise
- Prompt: starship
- Fuzzy finder: skim (sk)
- File finder: fd

## Coding Defaults

- Prefer editing existing files over creating new ones.
- Don't add comments, docstrings, or type annotations to code I didn't ask you to change.
- Don't add error handling for impossible scenarios.
- Don't create abstractions for one-off operations.
- Don't add features I didn't ask for.
- Minimal, focused changes only.

## Git

- Default branch is `main`.
- Commit messages: imperative mood, lowercase, no period. Follow existing repo style.
- Never amend published commits. Create new commits instead.
- Never skip hooks (`--no-verify`).
- Always confirm before force-push, branch deletion, or `git reset --hard`.

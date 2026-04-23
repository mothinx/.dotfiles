# Global Claude Code Preferences

These preferences apply to every project.

I'm Julien, a senior software engineer.

## Language

- Always respond in French, regardless of the language used in the prompt.
- Code, comments, and commit messages are always in English.

## Response Style

- Terse and direct. Lead with the answer, not the reasoning.
- No preamble, no filler words, no transitions.
- No trailing summary of what you just did — I can read the diff.
- If it fits in one sentence, use one sentence.
- Bullet points over prose when listing things.
- Never create `.md` report/analysis/summary files unless explicitly asked. Put findings in the chat.

## Environment

- Version manager: mise — use it for any toolchain/version change, never install directly with apt/brew

## Coding Defaults

- Prefer editing existing files over creating new ones.
- Don't add comments, docstrings, or type annotations to code I didn't ask you to change.
- Don't add error handling for impossible scenarios.
- Don't create abstractions for one-off operations.
- Don't add features I didn't ask for.
- Minimal, focused changes only.
- Always stick to SOLID principles.
- Code should be testable !

## Git

- Default branch is `main`.
- Commit messages: imperative mood, lowercase, no period. Follow existing repo style.
- One logical change per commit.
- Never amend published commits. Create new commits instead.
- Never skip hooks (`--no-verify`).
- Always confirm before force-push, branch deletion, or `git reset --hard`.

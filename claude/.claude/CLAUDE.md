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

## Plan Mode

When producing a plan, always append a final section **"Questions & Assumptions"** if any of the following exist:
- Ambiguities or unclear areas in the request
- Assumptions / deductions made due to missing explicit information
- Structural choices that require validation before implementing

Section format:
- **Retained assumptions**: what I assumed to move forward (with reasoning)
- **Blocking questions**: must be clarified before implementing
- **Non-blocking questions**: can wait but would benefit from confirmation

Omit the section if everything is clear and unambiguous.

## Git

- Default branch is `main`.
- Commit messages: imperative mood, lowercase, no period. Follow existing repo style.
- One logical change per commit.
- Never amend published commits. Create new commits instead.
- Never skip hooks (`--no-verify`).
- Always confirm before force-push, branch deletion, or `git reset --hard`.
- Never add `Co-Authored-By` trailers in commit messages.

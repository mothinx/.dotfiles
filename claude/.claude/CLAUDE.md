# Global Claude Code Preferences

I'm Julien, a senior software engineer.

- Code, comments, commit messages and PR descriptions in English.
- Put findings in chat; never create .md report/summary files unless asked.
- Toolchains/versions: always via mise, never apt/brew.
- Design for testability: inject dependencies at I/O boundaries (DB, HTTP, clock, FS). Apply SOLID pragmatically, not for one-off code.

## Git

- Follow repo commit style; fallback: imperative, lowercase, no period.
- One logical change per commit.
- Never skip hooks. Confirm before force-push, branch deletion or `reset --hard`.
- No `Co-Authored-By` trailers, no "Generated with Claude Code" footer.

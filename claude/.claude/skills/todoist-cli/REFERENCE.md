# Todoist CLI — Full Command Reference

## References

Tasks, projects, labels, and filters can be referenced by:
- Name (fuzzy matched within context)
- `id:xxx` — explicit ID
- Todoist URL — paste directly from the web app

Some commands require `id:` or URL refs (name lookup unavailable): `task uncomplete`, `section archive/unarchive/update/delete/browse`, `comment update/delete/browse`, `notification view/accept/reject`.

Reminder commands (`reminder get/update/delete`, `reminder location get/update/delete`) only accept `id:xxx` or raw IDs — URLs are not supported.

## Authentication

```bash
td auth login
td auth login --read-only
td auth login --additional-scopes=app-management
td auth login --read-only --additional-scopes=app-management
td auth login --additional-scopes=backups
td auth login --read-only --additional-scopes=backups
td auth login --additional-scopes=app-management,backups
td auth login --callback-port 9000
td auth login --json
td auth token
td auth status
td auth status --json
TOKEN=$(td auth token view)
TOKEN=$(td auth token view --user you@example.com)
td auth logout
td auth logout --json
```

Opt-in OAuth scopes via `--additional-scopes=<list>` (comma-separated):
- `app-management` — `dev:app_console` scope, required by `td apps list/view`
- `backups` — `backups:read` scope, required by `td backup list/download`

Tokens stored in OS credential manager, fallback to `~/.config/todoist-cli/config.json`. `TODOIST_API_TOKEN` takes precedence. Always capture `td auth token view` into a variable — never invoke bare in a transcript.

## Multi-User

```bash
td user list                        # all stored accounts (with default marker)
td user use <id|email>              # set default account
td user current                     # show active account
td user remove <id|email>           # delete account and token
td --user <id|email> task list      # one-off override for any command
td auth logout --user <id|email>
```

Resolution order: `--user` > `user.defaultUser` in config > only stored account.

## Tasks

```bash
td task add "Buy milk" --due tomorrow
td task quickadd "Buy milk tomorrow p1 #Shopping"
td task qa "Review PR @urgent +Alice"
td task list --project "Work" --label "urgent" --priority p1
td task view "Buy milk"
td task add "Plan sprint" --project "Work" --section "Planning" --labels "urgent,review"
td task update "Plan sprint" --deadline "2026-06-01" --assignee me
td task reschedule "Plan sprint" 2026-03-20T14:00:00
td task move "Plan sprint" --project "Personal" --no-section
td task complete "Plan sprint"
td task uncomplete id:123456
td task delete "Plan sprint" --yes
td task browse "Plan sprint"
```

**`quickadd` vs `task add`:**
- Prefer `td task quickadd` (alias `td task qa`) when all attributes fit inline: dates ("tomorrow at 2pm"), priority (`p1`–`p4`), project (`#Project`), labels (`@label`), sections (`/Section`), assignee (`+Person`). One call, no name-resolution lookups.
- Use `td task add` for flags unavailable in Quick Add: `--deadline`, `--description`, `--parent`, `--duration`, `--uncompletable`, `--order`, or when composing text programmatically.
- `td task quickadd` supports `--stdin`, `--json`, `--dry-run` only.
- `td add <text>` is a human shorthand for `td task quickadd` — prefer `td task quickadd` for discoverability.

Useful flags: `--stdin`, `--parent`, `--section`, `--project`, `--workspace`, `--assignee`, `--labels`, `--due`, `--deadline`, `--duration`, `--priority`. `td task complete --forever` stops recurrence; `--no-due`, `--no-deadline`, `--no-labels`, `--no-parent`, `--no-section` clear respective fields.

## Projects and Workspaces

```bash
td project list --personal
td project list --search "Road"
td project archived
td project view "Roadmap" --detailed
td project collaborators "Roadmap"
td project create --name "New Project" --color blue
td project update "Roadmap" --favorite
td project update "Roadmap" --folder "Engineering"
td project update "Roadmap" --no-folder
td project update "Roadmap" --parent "Engineering"
td project update "Roadmap" --no-parent
td project reorder "Roadmap" --before "Marketing"
td project reorder "Roadmap" --after "Marketing"
td project reorder "Roadmap" --position 0
td project archive "Roadmap"
td project unarchive "Roadmap"
td project move "Roadmap" --to-workspace "Acme" --folder "Engineering" --visibility team --yes
td project join id:abc123
td project delete "Roadmap" --yes
td project progress "Roadmap"
td project health "Roadmap"
td project health-context "Roadmap"
td project activity-stats "Roadmap" --weeks 4 --include-weekly
td project analyze-health "Roadmap"
td project permissions

td workspace list
td workspace view "Acme"
td workspace projects "Acme"
td workspace users "Acme" --role ADMIN,MEMBER
td workspace insights "Acme" --project-ids "id1,id2"
td workspace create --name "Acme"
td workspace update "Acme" --description "Acme Inc." --dry-run   # admin-only
td workspace delete "Old WS" --yes                                # admin-only
td workspace user-tasks "Acme" --user alice@example.com
td workspace activity "Acme" --json
td workspace use "Acme"
td workspace use --clear

td folder list "Acme"
td folder view "Engineering"
td folder create "Acme" --name "Engineering"
td folder update "Engineering" --name "Platform" --workspace "Acme"
td folder delete "Engineering" --workspace "Acme" --yes
```

## Labels, Filters, and Sections

```bash
td label list
td label list --search "bug"
td label view "urgent"
td label create --name "urgent" --color red
td label update "urgent" --color orange
td label delete "urgent" --yes
td label browse "urgent"
td label rename-shared "oldname" --name "newname"
td label remove-shared "oldname" --yes

td filter list
td filter view "Urgent work"
td filter create --name "Urgent work" --query "p1 & #Work"
td filter update "Urgent work" --query "p1 & #Work & today"
td filter delete "Urgent work" --yes
td filter browse "Urgent work"

td section list "Roadmap"
td section list --search "Planning" --project "Roadmap"
td section create --project "Roadmap" --name "In Progress"
td section update id:123 --name "Done"
td section reorder "Review" --project "Roadmap" --before "Done"
td section reorder "Review" --project "Roadmap" --after "In Progress"
td section reorder "Review" --project "Roadmap" --position 0
td section archive id:123
td section unarchive id:123
td section delete id:123 --yes
td section browse id:123
```

Shared labels appear in `td label list/view` but standard update/delete only work for labels with IDs. Use `td label rename-shared` and `td label remove-shared` for shared labels.

## Goals

```bash
td goal list
td goal list --workspace "Work"
td goal view "Ship v2"
td goal create --name "Ship v2"
td goal create --name "Ship v2" --workspace "Work"
td goal create --name "Ship v2" --deadline "2026-04-03"
td goal update "Ship v2" --name "Ship v3"
td goal delete "Ship v2" --yes
td goal complete "Ship v2"
td goal uncomplete "Ship v2"
td goal link "Ship v2" --task "Buy milk"
td goal unlink "Ship v2" --task "Buy milk"
```

## Comments, Attachments, Notifications, and Reminders

```bash
td comment list "Plan sprint"
td comment list "Roadmap" --project
td comment add "Plan sprint" --content "See attached" --file ./report.pdf
td comment add "Plan sprint" --content "See attached" --file ./report.pdf --file-name "Quarterly report.pdf"
td comment update id:123 --content "Updated text"
td comment delete id:123 --yes
td comment browse id:123

td attachment view "https://files.todoist.com/..."

td notification list --unread
td notification view id:123
td notification accept id:123
td notification reject id:123
td notification read --all --yes

td reminder list "Plan sprint"
td reminder list --type time
td reminder add "Plan sprint" --before 30m
td reminder add "Plan sprint" --at "2026-06-01 09:00" --urgent
td reminder update id:123 --before 1h
td reminder update id:123 --no-urgent
td reminder delete id:123 --yes
td reminder get id:123
td reminder location add "Plan sprint" --name "Office" --lat 40.7128 --long -74.0060 --trigger on_enter --radius 100
td reminder location update id:456 --radius 200
td reminder location delete id:456 --yes
td reminder location get id:456
```

`td attachment view` prints text attachments directly and encodes binary as base64. Use `--json` for metadata + content. Never use `curl` + `Read` on Todoist file URLs — for images, `Read` triggers the vision pipeline; failure pins the image in context and every retry hits the same error.

`td comment view` flags image attachments with a `Hint` line pointing at `td attachment view`. In `--json` mode the hint is written to stderr.

## Help Center

```bash
td hc
td hc locale --set-default pt-br
td hc search "filters" --ndjson
td hc view https://www.todoist.com/help/articles/introduction-to-filters-V98wIH
```

`td hc view` accepts `id:N`, raw numeric IDs, `get.todoist.help` URLs, and public `www.todoist.com/help/articles/...` URLs. `--locale` on individual subcommands overrides the stored default.

## Templates

```bash
td template export-file "Roadmap" --output template.csv
td template export-url "Roadmap"
td template create --name "New Project" --file template.csv --workspace "Acme"
td template create --name "New Project" --file template.csv --file-name "Q2 plan.csv"
td template import-file "Roadmap" --file template.csv
td template import-id "Roadmap" --template-id product-launch --locale fr
```

## Backups

```bash
td backup list
td backup download "2024-01-15_12:00" --output-file backup.zip
```

Requires `backups:read` scope — re-run `td auth login --additional-scopes=backups`.

## Developer Apps

```bash
td apps list
td apps list --json
td apps view "Todoist for VS Code"
td apps view id:9909
td apps view id:9909 --include-secrets
td apps update id:9909 --add-oauth-redirect https://example.com/callback
td apps update id:9909 --remove-oauth-redirect https://example.com/callback --yes
```

Requires `dev:app_console` scope — re-run `td auth login --additional-scopes=app-management`.

`--include-secrets` reveals client secret, verification token, test token, and distribution token (hidden by default). The OAuth `client_id` is always public.

`--add-oauth-redirect` / `--remove-oauth-redirect` are mutually exclusive. Accepted URI schemes: `https://<host>`, `http(s)://localhost`, `http(s)://127.0.0.1`, or a custom scheme (e.g. `myapp://callback`). Rejected: `javascript`, `data`, `file`, `vbscript`, `ftp`.

## Settings, Stats, and Utilities

```bash
td stats
td stats goals --daily 10 --weekly 50
td stats vacation --on

td settings view
td settings update --timezone "America/New_York" --time-format 24 --date-format intl
td settings themes

td config view
td config view --json
td config view --show-token

td completion install zsh
td completion uninstall

td view https://app.todoist.com/app/task/buy-milk-abc123
td view https://app.todoist.com/app/today

td doctor
td doctor --offline
td doctor --json

td update --check
td update switch --stable
td update switch --pre-release

td changelog --count 10
```

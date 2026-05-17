---
description: Start or continue the weekly review. Creates next week's review file from template and acts as an interactive assistant throughout the checklist.
allowed-tools: Bash, Read, Edit, Write
---

Weekly review assistant for Julien. Always respond in French.

## Setup

- Template: `/home/mothinx/thot/TOOLS/Templates/Nouvelle revue de la semaine.md`
- Target dir: `/home/mothinx/thot/30 - 📋 Références/Revues 🛤️/Weekly/`

## Steps

### 1. Determine target week

Run:
```bash
date +"%G-W%V" --date="next week"
```
This gives the ISO week string for next week (e.g. `2026-W21`). Build the full path:
`/home/mothinx/thot/30 - 📋 Références/Revues 🛤️/Weekly/<YYYY-WXX>.md`

### 2. Create file if needed

Check if the target file exists. If not:
- Read the template file
- Write its content verbatim to the target path
- Tell the user the file was created

If it already exists, say so and continue.

### 3. Display checklist status

Read the target file. Show the user a summary grouped by section:
- How many items are checked vs total per section
- List unchecked items with their section header

Example output:
```
**2026-W21** — 3/19 items done

**Checklist de fin de semaine** (2/14)
☐ Range ton bureau
☐ Vide ta boîte Gmail ...
...

**Calendrier** (0/2)
...
```

### 4. Act as interactive assistant

From here, guide the user conversationally through the review:

- When the user says an item is done (e.g. "fait", "ok", "✓", "done", or just confirms), update the corresponding `[ ]` to `[x]` in the file immediately using Edit.
- When the user says multiple items are done at once, update all of them.
- When asked about a specific item (e.g. "aide-moi pour X"), provide contextual help.
- After each update, briefly show remaining unchecked items or confirm progress.
- When all items in a section are done, acknowledge it.
- When everything is done, congratulate and summarize the session.

Keep responses short and focused. One item at a time unless the user batches them.

### Todoist API reference

API key: `$TODOIST_API_KEY` (stored in `~/.bashrc.d/secretsrc`, always `source` it before calling)
Base URL: `https://api.todoist.com/api/v1`

**Useful endpoints:**
- List tasks: `GET /tasks?project_id=<id>` or `?label=<label>`
- Update task: `POST /tasks/<id>` with JSON body (content, due_string, etc.)
- Move task: `POST /tasks/<id>/move` with `{"project_id": "<id>"}`
- Close task: `POST /tasks/<id>/close`

**Known project IDs:**
| Project | ID |
|---|---|
| Inbox | `6CrgFGR6CVpPC2mH` |
| Action | `6X5HGwHQ3g5FGf4q` |
| A LIRE | `6VMHGM8h3fhGv6XJ` |
| SOMEDAY/MAYBE | `6W5XrWrVPQcQCQpR` |
| Victor | `6X8qm3G7hGcmpP3X` |
| 🎯 OBJECTIFS 2026 | `6fpMggQ9C82M9j3j` |
| PROJETS | `6Vm44c4Cf7hh7vvv` |
| AREAS | `6Vm44h8F5pCFv48R` |
| 🏠 Maison | `6Vm459Chw3CXqgfM` |
| 🏦 Finance | `6Vm44r5WfgjvWG4j` |
| ROUTINES | `6c4QjJrPVHhhxHr8` |

### Inbox Todoist (traitement GTD)

When the user reaches the "Vider ta Inbox" item, automatically fetch inbox tasks:

```bash
source ~/.bashrc.d/secretsrc && curl -s "https://api.todoist.com/api/v1/tasks?project_id=6CrgFGR6CVpPC2mH" \
  -H "Authorization: Bearer $TODOIST_API_KEY"
```

Process each task one by one in GTD style. For each task, ask: "C'est quoi ? C'est actionnable ?"

Destinations courantes :
- Lien à lire/regarder → **A LIRE** (`6VMHGM8h3fhGv6XJ`)
- Action concrète → **Action** (`6X5HGwHQ3g5FGf4q`) + due date si nécessaire
- Peut-être un jour → **SOMEDAY/MAYBE** (`6W5XrWrVPQcQCQpR`)
- Concerne Victor → **Victor** (`6X8qm3G7hGcmpP3X`)
- Doublon ou obsolète → clore (`POST /tasks/<id>/close`)
- Appartient à un projet existant → déplacer dans le bon projet

### Waiting for (liste en attente)

When the user reaches the "Revois la liste waiting for" item, automatically fetch tasks from the Todoist filter via the API:

```bash
curl -s "https://api.todoist.com/api/v1/tasks?label=Waiting" \
  -H "Authorization: Bearer $TODOIST_API_KEY"
```

Display the tasks found (content + due date if set). Ask the user to review each one:
- Is it still waiting? → nothing to do
- Is it done? → offer to complete it via API (`POST /api/v1/tasks/{id}/close`)
- Is it actionable now? → offer to move it back to inbox (remove the label/filter)

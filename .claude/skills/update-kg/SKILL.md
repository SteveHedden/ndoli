---
name: update-kg
description: Update the personal knowledge graph based on what happened in this session. Use at the end of any session where new contacts, opportunities, projects, or status changes came up.
---

First, find the ndoli repo path:
- Read `~/.claude/ndoli_config` — it contains the absolute path to your ndoli repo (written by install.sh)
- If that file doesn't exist, assume the KG is in the `KG/` directory of the current project

Review this conversation from top to bottom, then update the KG files in `{NDOLI_PATH}/KG/`.

Read any files you need to before editing them. Work through these checks in order:

**1. New entities** — did any new people, orgs, opportunities, or projects come up?
   - Search existing TTL files by name before adding — no duplicates
   - Put them in the right file for their class
   - Create a new instance file if a new class has enough instances to warrant it

**2. Enrichment** — did we learn anything new about an existing entity?
   - Status changes (active → warm, pending → closed-won, etc.)
   - New meeting dates, follow-up dates, `rel:lastContact` dates
   - New research areas, publications, projects
   - Append to `rel:notes` — do not replace, append with new context

**3. Opportunity updates** — any status changes or deadline shifts?

**4. Ontology gaps** — did any new relationship type or property come up
   that isn't modeled yet? If so, add it to `ontology.ttl`.

**Conventions:**
- `kg:` prefix, snake_case URIs (e.g., `kg:jane_smith`, `kg:opp_acme_graphrag`)
- Dates: `"YYYY-MM-DD"^^xsd:date`
- `rel:notes` — single rich string per entity, append don't replace
- Status (people): `active`, `warm`, `cold`, `closed`
- Status (opportunities): `active`, `pending`, `closed-won`, `closed-lost`, `deferred`

After updating, briefly summarize what changed (2–4 lines max).

# ndoli

A personal knowledge graph (second brain) for Claude Code — tracks your professional network, projects, and opportunities using semantic web standards (RDF/OWL).

## What it is

ndoli gives you a structured, queryable KG that Claude reads at the start of each session. Instead of re-explaining your context every time, Claude already knows your contacts, opportunities, and projects.

The KG lives in `KG/` as Turtle (`.ttl`) files, organized as three tiers:

- **Tier 1 — Ontology:** classes and relationships (the theory of your professional world)
- **Tier 2 — Controlled vocabularies:** catalogs of actual entities (your contacts, opportunities, projects)
- **Tier 3 — Observations:** dated, immutable records of interactions and findings (the evidence layer)

| Example file (in repo) | Created by install.sh | Tier | Contents |
|---|---|---|---|
| `CLAUDE.md.example` | `CLAUDE.md` | — | Your personal context for Claude |
| `KG/ontology.example.ttl` | `KG/ontology.ttl` | 1 | Classes, properties, and constraints |
| `KG/contacts.example.ttl` | `KG/contacts.ttl` | 2 | People and organizations |
| `KG/opportunities.example.ttl` | `KG/opportunities.ttl` | 2 | Business and collaboration opportunities |
| `KG/projects.example.ttl` | `KG/projects.ttl` | 2 | Active and planned projects |
| `KG/observations.example.ttl` | `KG/observations.ttl` | 3 | Interactions and findings |

All created files are gitignored — your personal data never touches GitHub and `git pull` never overwrites your KG.

## Setup

```bash
git clone https://github.com/SteveHedden/ndoli ~/ndoli
cd ~/ndoli
bash install.sh
```

`install.sh` does three things:
1. Writes `~/.claude/ndoli_config` with the path to your repo
2. Copies `KG/*.example.ttl` → `KG/*.ttl` (skips any that already exist)
3. Symlinks the `/update-kg` skill into `~/.claude/skills/`

## Usage

1. **Fill in your context** — edit `CLAUDE.md` with your name, role, and goals
2. **Populate the KG** — uncomment and edit the examples in `KG/contacts.ttl`, etc.
3. **Open any Claude Code session** — Claude will read the KG automatically
4. **Run `/update-kg`** at the end of sessions where new contacts or opportunities came up

## Requirements

- [Claude Code](https://claude.ai/code) CLI

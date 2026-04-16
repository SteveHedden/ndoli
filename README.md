# ndoli

A personal knowledge graph (second brain) for Claude Code and Codex — tracks your professional network, projects, and opportunities using semantic web standards (RDF/OWL/SHACL).

## What it is

ndoli gives you a structured, queryable KG that your AI agent reads on demand. Instead of re-explaining your context every time, the agent already knows your contacts, opportunities, and projects.

The KG lives in `KG/` as Turtle (`.ttl`) files, organized as three tiers:

- **Tier 1 — Ontology:** classes and relationships (the theory of your professional world)
- **Tier 2 — Controlled vocabularies:** catalogs of actual entities (your contacts, opportunities, projects)
- **Tier 3 — Observations:** dated, immutable records of interactions and findings (the evidence layer)

The KG is shared across both tools — Claude Code and Codex read and write the same TTL files.

## Setup

```bash
git clone https://github.com/SteveHedden/ndoli ~/ndoli
cd ~/ndoli
bash install.sh
```

`install.sh` sets up both Claude Code and Codex:

| What | Claude Code | Codex |
|---|---|---|
| KG path config | `~/.claude/ndoli_config` | `~/.codex/config.toml` |
| Global instructions | appended to `~/.claude/CLAUDE.md` | appended to `~/.codex/AGENTS.md` |
| Update skill | symlinked to `~/.claude/skills/` | symlinked to `~/.codex/skills/` |
| Per-repo instructions | `CLAUDE.md` (from example) | `AGENTS.md` (from example) |

All personal files (`CLAUDE.md`, `AGENTS.md`, `KG/*.ttl`) are gitignored — your data never touches GitHub and `git pull` never overwrites your KG.

## File reference

| Example file (in repo) | Created by install.sh | Tier | Contents |
|---|---|---|---|
| `CLAUDE.md.example` | `CLAUDE.md` | — | Your personal context for Claude Code |
| `AGENTS.md.example` | `AGENTS.md` | — | Your personal context for Codex |
| `KG/ontology.example.ttl` | `KG/ontology.ttl` | 1 | Classes and properties (OWL) + node/property shapes (SHACL) |
| `KG/contacts.example.ttl` | `KG/contacts.ttl` | 2 | People and organizations |
| `KG/opportunities.example.ttl` | `KG/opportunities.ttl` | 2 | Business and collaboration opportunities |
| `KG/projects.example.ttl` | `KG/projects.ttl` | 2 | Active and planned projects |
| `KG/observations.example.ttl` | `KG/observations.ttl` | 3 | Interactions and findings, with source provenance |

## Usage

1. **Fill in your context** — edit `CLAUDE.md` and/or `AGENTS.md` with your name, role, and goals
2. **Populate the KG** — uncomment and edit the examples in `KG/contacts.ttl`, etc.
3. **Ask about anything in the KG** — the agent will read the relevant files before answering
4. **Update the KG** — run `/update-kg` (Claude Code) or `$update-kg` (Codex) at the end of sessions where new contacts, opportunities, or status changes came up

## Requirements

- [Claude Code](https://claude.ai/code) CLI, [Codex](https://github.com/openai/codex) CLI, or both

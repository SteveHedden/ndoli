# ndoli

A personal knowledge graph (second brain) for Claude Code — tracks your professional network, projects, and opportunities using semantic web standards (RDF/OWL).

## What it is

ndoli gives you a structured, queryable KG that Claude reads at the start of each session. Instead of re-explaining your context every time, Claude already knows your contacts, opportunities, and projects.

The KG lives in `KG/` as Turtle (`.ttl`) files:

| File | Contents |
|------|----------|
| `ontology.ttl` | Classes, properties, and constraints |
| `contacts.ttl` | People and organizations (`foaf:Person`, `schema:Organization`) |
| `opportunities.ttl` | Business and collaboration opportunities |
| `projects.ttl` | Active and planned projects |

The `*.ttl` instance files are created from `*.example.ttl` templates by `install.sh` on first run. They are gitignored so your personal data is never committed and `git pull` never overwrites your KG.

## Setup

```bash
git clone https://github.com/you/ndoli ~/ndoli
cd ~/ndoli
bash install.sh
```

`install.sh` does two things:
1. Writes `~/.claude/ndoli_config` with the path to your repo
2. Symlinks the `/update-kg` skill into `~/.claude/skills/`

## Usage

1. **Fill in your context** — edit `CLAUDE.md` with your name, role, and goals
2. **Populate the KG** — uncomment and edit the examples in `KG/contacts.ttl`, etc.
3. **Open any Claude Code session** — Claude will read the KG automatically
4. **Run `/update-kg`** at the end of sessions where new contacts or opportunities came up

## Requirements

- [Claude Code](https://claude.ai/code) CLI

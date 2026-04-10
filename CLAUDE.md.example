# Knowledge Graph — Claude Instructions

This repo is your personal knowledge graph (second brain) — it tracks your professional network, projects, and opportunities using semantic web standards (RDF/OWL).

---

## Knowledge Graph

The KG lives in `KG/`. Each file holds instances of one class:

- `ontology.ttl` — classes, properties, constraints
- `contacts.ttl` — instances of `foaf:Person` and `schema:Organization`
- `opportunities.ttl` — instances of `rel:Opportunity`
- `projects.ttl` — instances of `rel:Project`

Each instance file imports the ontology via `owl:imports`. Cross-file references use the shared `kg:` namespace — no duplication needed.

### At session start — read the KG

Before doing any work, read all TTL files in `KG/` to load full context. This is your working memory for the session.

### Updating the KG

Use the `/update-kg` skill at the end of any session where new contacts, opportunities, or status changes came up.

---

## About You

Fill in your context here so Claude can tailor its responses:

- **Name:**
- **Role:**
- **Location:**
- **Core expertise:**
- **Active projects:**
- **Goals:**

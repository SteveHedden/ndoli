---
name: update-kg
description: Update the knowledge graph based on what happened in this session. Use at the end of any session where new contacts, opportunities, projects, or status changes came up.
---

Read `~/.claude/ndoli_config` to find the KG directory, then review this conversation from top to bottom and update the KG files.

Work through these checks in order:

**1. New entities** — did any new people, orgs, opportunities, or projects come up?
   - Search existing TTL files by name before adding — no duplicates
   - Put them in the right Tier 2 file for their class (`contacts.ttl`, `opportunities.ttl`, `projects.ttl`)
   - If the entity belongs to a new class not yet in the ontology, add the class to `ontology.ttl` first (step 5), then create a new Tier 2 file (e.g. `events.ttl`) if there are enough instances to warrant it — otherwise add to the closest existing file with a comment
   - Stable facts only on the entity: name, org, role, `rel:firstContact`, `rel:lastContact`, `rel:status`
   - No notes field — history goes in observations

**2. New observations** — did anything happen that should be recorded as evidence?
   - Write a new `rel:Observation` instance to `observations.ttl`
   - URI convention: `obs:ENTITY_YYYY_MM_DD` (append `_2`, `_3` if multiple on same day)
   - Set `rel:involves` for each entity touched, `rel:observationDate`, `rel:interactionType`, `rel:content`
   - Observations are immutable — create a new one, never edit an existing one
   - Interaction types: `meeting`, `call`, `email`, `async`, `read`, `event`

**3. Enrichment** — did we learn anything new about an existing entity's stable facts?
   - Status changes (`active` → `warm`, `pending` → `closed-won`, etc.)
   - Update `rel:lastContact` on the entity to match the most recent observation date
   - New role, org, or research area

**4. Opportunity updates** — any status changes or deadline shifts?

**5. Ontology gaps** — did any new class, relationship type, or property come up that isn't modeled yet?
   - New class: something that doesn't fit any existing class and warrants its own type (e.g. `rel:Event`, `rel:Publication`)
   - New property: a relationship or attribute used on an entity that has no existing predicate
   - Add anything new to `ontology.ttl` with a `rdfs:label` and `rdfs:comment`

**Conventions:**
- Use the prefix and snake_case URIs established in the existing TTL files
- Dates: `"YYYY-MM-DD"^^xsd:date`
- Link source material via `rel:email <https://mail.google.com/...>` on the observation
- Status (people): `active`, `warm`, `cold`, `closed`
- Status (opportunities): `active`, `pending`, `closed-won`, `closed-lost`, `deferred`

After updating, briefly summarize what changed (2–4 lines max).

#!/bin/bash
set -e

NDOLI_PATH="$(cd "$(dirname "$0")" && pwd)"
KG_PATH="$NDOLI_PATH/KG"

# ── Shared helper ────────────────────────────────────────────────────────────

append_ndoli_block() {
  local target="$1"
  local update_instruction="$2"

  mkdir -p "$(dirname "$target")"
  touch "$target"

  if grep -q "# --- ndoli ---" "$target" 2>/dev/null; then
    echo "Skipped (exists): $target [ndoli block]"
    return
  fi

  cat >> "$target" <<EOF

# --- ndoli ---
You have a personal knowledge graph (second brain) at $KG_PATH/. It contains:
- contacts.ttl — people and organizations in your professional network
- opportunities.ttl — active business and collaboration opportunities
- projects.ttl — your active and planned projects
- observations.ttl — dated, immutable records of interactions and findings

When the user asks about a person, project, opportunity, or past interaction, read the relevant TTL file(s) before answering. $update_instruction
# --- /ndoli ---
EOF
  echo "Updated: $target"
}

# ── Claude Code ──────────────────────────────────────────────────────────────

# Write config so the Claude skill can find the KG from any repo
mkdir -p ~/.claude
echo "$NDOLI_PATH" > ~/.claude/ndoli_config

# Append KG instructions to global Claude CLAUDE.md
append_ndoli_block ~/.claude/CLAUDE.md "Use /update-kg at the end of any session where new contacts, opportunities, or status changes came up."

# Copy CLAUDE.md.example on first run (never overwrite)
if [ ! -f "$NDOLI_PATH/CLAUDE.md" ]; then
  cp "$NDOLI_PATH/CLAUDE.md.example" "$NDOLI_PATH/CLAUDE.md"
  echo "Created: $NDOLI_PATH/CLAUDE.md"
else
  echo "Skipped (exists): $NDOLI_PATH/CLAUDE.md"
fi

# Symlink Claude skills into ~/.claude/skills/
mkdir -p ~/.claude/skills
for skill in "$NDOLI_PATH/.claude/skills"/*/; do
  skill_name=$(basename "$skill")
  target="$HOME/.claude/skills/$skill_name"
  rm -rf "$target"
  ln -s "$skill" "$target"
  echo "Linked: $target"
done

# ── Codex ────────────────────────────────────────────────────────────────────

# Write [ndoli] section to ~/.codex/config.toml (append if missing)
mkdir -p ~/.codex
if ! grep -q "\[ndoli\]" ~/.codex/config.toml 2>/dev/null; then
  cat >> ~/.codex/config.toml <<EOF

[ndoli]
path = "$NDOLI_PATH"
EOF
  echo "Updated: ~/.codex/config.toml"
else
  echo "Skipped (exists): ~/.codex/config.toml [ndoli]"
fi

# Append KG instructions to global Codex AGENTS.md
append_ndoli_block ~/.codex/AGENTS.md "Use \$update-kg at the end of any session where new contacts, opportunities, or status changes came up."

# Copy AGENTS.md.example on first run (never overwrite)
if [ ! -f "$NDOLI_PATH/AGENTS.md" ]; then
  cp "$NDOLI_PATH/AGENTS.md.example" "$NDOLI_PATH/AGENTS.md"
  echo "Created: $NDOLI_PATH/AGENTS.md"
else
  echo "Skipped (exists): $NDOLI_PATH/AGENTS.md"
fi

# Symlink Codex skills into ~/.codex/skills/
mkdir -p ~/.codex/skills
for skill in "$NDOLI_PATH/.codex/skills"/*/; do
  skill_name=$(basename "$skill")
  target="$HOME/.codex/skills/$skill_name"
  rm -rf "$target"
  ln -s "$skill" "$target"
  echo "Linked: $target"
done

# ── KG files ─────────────────────────────────────────────────────────────────

# Copy KG/*.example.ttl → KG/*.ttl on first run (never overwrite)
for example in "$NDOLI_PATH/KG/"*.example.ttl; do
  dest="${example%.example.ttl}.ttl"
  if [ ! -f "$dest" ]; then
    cp "$example" "$dest"
    echo "Created: $dest"
  else
    echo "Skipped (exists): $dest"
  fi
done

# ── Done ─────────────────────────────────────────────────────────────────────

echo ""
echo "Ndoli installed."
echo "  KG:            $KG_PATH/"
echo "  Claude config: ~/.claude/ndoli_config"
echo "  Codex config:  ~/.codex/config.toml"
echo ""
echo "Use /update-kg (Claude Code) or \$update-kg (Codex) from any session to update your KG."

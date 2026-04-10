#!/bin/bash
set -e

NDOLI_PATH="$(cd "$(dirname "$0")" && pwd)"

# Write config so skills can find the KG from any repo
mkdir -p ~/.claude
echo "$NDOLI_PATH" > ~/.claude/ndoli_config

# Copy example files on first run (never overwrite existing data)
# Handles CLAUDE.md.example → CLAUDE.md
if [ ! -f "$NDOLI_PATH/CLAUDE.md" ]; then
  cp "$NDOLI_PATH/CLAUDE.md.example" "$NDOLI_PATH/CLAUDE.md"
  echo "Created: $NDOLI_PATH/CLAUDE.md"
else
  echo "Skipped (exists): $NDOLI_PATH/CLAUDE.md"
fi

# Handles KG/*.example.ttl → KG/*.ttl
for example in "$NDOLI_PATH/KG/"*.example.ttl; do
  dest="${example%.example.ttl}.ttl"
  if [ ! -f "$dest" ]; then
    cp "$example" "$dest"
    echo "Created: $dest"
  else
    echo "Skipped (exists): $dest"
  fi
done

# Symlink all skills into the global Claude skills directory
mkdir -p ~/.claude/skills
for skill in "$NDOLI_PATH/.claude/skills"/*/; do
  skill_name=$(basename "$skill")
  target="$HOME/.claude/skills/$skill_name"
  # Remove existing dir or symlink so ln -sf replaces it cleanly
  rm -rf "$target"
  ln -s "$skill" "$target"
  echo "Linked: $target"
done

echo ""
echo "Ndoli installed."
echo "  KG:     $NDOLI_PATH/KG/"
echo "  Config: ~/.claude/ndoli_config"
echo ""
echo "Run /update-kg from any Claude Code session to update your KG."

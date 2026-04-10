#!/bin/bash
set -e

NDOLI_PATH="$(cd "$(dirname "$0")" && pwd)"

# Write config so skills can find the KG from any repo
mkdir -p ~/.claude
echo "$NDOLI_PATH" > ~/.claude/ndoli_config

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

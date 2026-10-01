#!/usr/bin/env bash
# Instala todas las skills de skills.txt en ~/.claude (global).
set -u
cd "$(dirname "$0")"
while read -r source skill; do
  case "$source" in ''|'#'*) continue ;; esac
  echo "==> $skill  ($source)"
  npx -y skills add "$source" --skill "$skill" -g -a claude-code -y || echo "!! falló: $skill"
done < skills.txt

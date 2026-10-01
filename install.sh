#!/usr/bin/env bash
# Instala todas las skills de skills.txt en ~/.claude (global).
# Agrupa por fuente (un clone por repo) y corre las fuentes en paralelo.
set -u
cd "$(dirname "$0")"

entries=$(grep -v '^[[:space:]]*#' skills.txt | awk 'NF==2')
sources=$(echo "$entries" | awk '!seen[$1]++ {print $1}')

for source in $sources; do
  list=$(echo "$entries" | awk -v s="$source" '$1==s {print $2}' | tr '\n' ' ')
  echo "==> $source : $list"
  # shellcheck disable=SC2086
  (npx -y skills add "$source" --skill $list -g -a claude-code -y >/dev/null 2>&1 \
    || echo "!! falló: $source") &
done
wait

missing=""
for skill in $(echo "$entries" | awk '{print $2}'); do
  [ -f "$HOME/.claude/skills/$skill/SKILL.md" ] || missing="$missing $skill"
done
if [ -n "$missing" ]; then echo "!! faltan:$missing"; else echo "OK: todas las skills instaladas"; fi

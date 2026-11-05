#!/usr/bin/env bash
# Symlink every skill in this repo into ~/.claude/skills.
set -euo pipefail
src="$(cd "$(dirname "$0")/skills" && pwd)"
dest="${CLAUDE_SKILLS_DIR:-$HOME/.claude/skills}"
force="${1:-}"
mkdir -p "$dest"
for dir in "$src"/*/; do
  name="$(basename "$dir")"
  target="$dest/$name"
  if [ -L "$target" ]; then
    if [ "$(readlink "$target")" = "${dir%/}" ]; then echo "ok       $name"; continue; fi
    if [ "$force" != "--force" ]; then echo "skip     $name (links elsewhere; --force replaces it)"; continue; fi
    rm "$target"
  elif [ -e "$target" ]; then
    echo "skip     $name (a real directory is already there)"; continue
  fi
  ln -s "${dir%/}" "$target"
  echo "linked   $name"
done

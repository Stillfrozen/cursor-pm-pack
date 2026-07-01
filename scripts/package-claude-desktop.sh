#!/usr/bin/env bash
set -euo pipefail

PACK_DIR="$(cd "$(dirname "$0")/.." && pwd)"
SKILLS_SRC="$PACK_DIR/skills"
OUT_DIR="$PACK_DIR/dist/claude-desktop"

usage() {
  cat <<'EOF'
Usage: scripts/package-claude-desktop.sh [OPTIONS]

Build .zip archives for Claude Desktop upload (Settings → Customize → Skills).

Each zip contains one skill folder at the root, e.g.:
  quality-gate.zip → quality-gate/SKILL.md

Options:
  --dry-run   Print what would be packaged
  -h, --help  Show this help
EOF
}

DRY_RUN=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --dry-run) DRY_RUN=1 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown option: $1" >&2; usage; exit 1 ;;
  esac
  shift
done

if [[ ! -d "$SKILLS_SRC" ]]; then
  echo "Error: skills directory not found at $SKILLS_SRC" >&2
  exit 1
fi

if [[ "$DRY_RUN" -eq 1 ]]; then
  echo "would create: $OUT_DIR/"
  for skill_dir in "$SKILLS_SRC"/*/; do
    skill_name="$(basename "$skill_dir")"
    echo "  $skill_name.zip"
  done
  exit 0
fi

mkdir -p "$OUT_DIR"
rm -f "$OUT_DIR"/*.zip

for skill_dir in "$SKILLS_SRC"/*/; do
  skill_name="$(basename "$skill_dir")"
  if [[ ! -f "$skill_dir/SKILL.md" ]]; then
    echo "skip: $skill_name (no SKILL.md)" >&2
    continue
  fi
  (
    cd "$SKILLS_SRC"
    zip -rq "$OUT_DIR/${skill_name}.zip" "$skill_name"
  )
  echo "packaged: $OUT_DIR/${skill_name}.zip"
done

echo ""
echo "Upload in Claude Desktop: Settings → Customize → Skills → Upload skill"
echo "See claude-desktop/README.md for details."

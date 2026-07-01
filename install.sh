#!/usr/bin/env bash
set -euo pipefail

PACK_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILLS_SRC="$PACK_DIR/skills"
SKILLS_DEST="${CURSOR_SKILLS_DIR:-$HOME/.cursor/skills}"

DRY_RUN=0
FORCE=0

usage() {
  cat <<'EOF'
Usage: ./install.sh [OPTIONS]

Install cursor-pm-pack skills into ~/.cursor/skills/ (or $CURSOR_SKILLS_DIR).

Options:
  --dry-run   Show what would be copied without writing files
  --force     Overwrite existing skill directories
  -h, --help  Show this help

After install, copy rules:
  - Workspace: cp -R .cursor/rules/ <your-project>/.cursor/rules/
  - Global: paste user-rules/*.md into Cursor → Settings → Rules → User Rules
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --dry-run) DRY_RUN=1 ;;
    --force) FORCE=1 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown option: $1" >&2; usage; exit 1 ;;
  esac
  shift
done

if [[ ! -d "$SKILLS_SRC" ]]; then
  echo "Error: skills directory not found at $SKILLS_SRC" >&2
  exit 1
fi

mkdir -p "$SKILLS_DEST"

installed=0
skipped=0

for skill_dir in "$SKILLS_SRC"/*/; do
  skill_name="$(basename "$skill_dir")"
  dest="$SKILLS_DEST/$skill_name"

  if [[ -d "$dest" && "$FORCE" -ne 1 ]]; then
    echo "skip: $skill_name (exists — use --force to overwrite)"
    skipped=$((skipped + 1))
    continue
  fi

  if [[ "$DRY_RUN" -eq 1 ]]; then
    echo "would install: $skill_name → $dest"
  else
    rm -rf "$dest"
    cp -R "$skill_dir" "$dest"
    echo "installed: $skill_name → $dest"
  fi
  installed=$((installed + 1))
done

echo ""
if [[ "$DRY_RUN" -eq 1 ]]; then
  echo "Dry run complete: $installed skill(s) would be installed, $skipped skipped."
else
  echo "Done: $installed skill(s) installed, $skipped skipped."
fi
echo ""
echo "Next steps:"
echo "  1. Copy .cursor/rules/ into your project workspace"
echo "  2. Or paste user-rules/*.md into Cursor → Settings → Rules → User Rules"
echo "  3. See README.md for calibration (Context/product.md, personas/)"

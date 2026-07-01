#!/usr/bin/env bash
set -euo pipefail

PACK_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILLS_SRC="$PACK_DIR/skills"
CURSOR_DEST="${CURSOR_SKILLS_DIR:-$HOME/.cursor/skills}"
CLAUDE_DEST="${CLAUDE_SKILLS_DIR:-$HOME/.claude/skills}"

TARGET="cursor"
PROJECT_DIR=""
DRY_RUN=0
FORCE=0

usage() {
  cat <<'EOF'
Usage: ./install.sh [OPTIONS]

Install PM Pack skills for Cursor and/or Claude Desktop.

Options:
  --target <cursor|claude|both>   Install destination (default: cursor)
  --project <path>                Also copy skills to <path>/.claude/skills/
  --dry-run                       Show actions without writing
  --force                         Overwrite existing skill directories
  -h, --help                      Show this help

Instructions (rules):
  Cursor:  paste user-rules/global.md → Settings → Rules → User Rules
  Claude:  paste user-rules/global.md → Settings → Profile → Custom instructions
  See claude-desktop/README.md for ZIP upload option.
EOF
}

install_skills_to() {
  local dest_root="$1"
  local label="$2"

  mkdir -p "$dest_root"

  for skill_dir in "$SKILLS_SRC"/*/; do
    local skill_name
    skill_name="$(basename "$skill_dir")"
    local dest="$dest_root/$skill_name"

    if [[ -d "$dest" && "$FORCE" -ne 1 ]]; then
      echo "skip [$label]: $skill_name (exists — use --force)"
      continue
    fi

    if [[ "$DRY_RUN" -eq 1 ]]; then
      echo "would install [$label]: $skill_name → $dest"
    else
      rm -rf "$dest"
      cp -R "$skill_dir" "$dest"
      echo "installed [$label]: $skill_name → $dest"
    fi
  done
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --target)
      TARGET="${2:?--target requires cursor, claude, or both}"
      shift
      ;;
    --project)
      PROJECT_DIR="${2:?--project requires a directory path}"
      shift
      ;;
    --dry-run) DRY_RUN=1 ;;
    --force) FORCE=1 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown option: $1" >&2; usage; exit 1 ;;
  esac
  shift
done

case "$TARGET" in
  cursor|claude|both) ;;
  *)
    echo "Error: --target must be cursor, claude, or both" >&2
    exit 1
    ;;
esac

if [[ ! -d "$SKILLS_SRC" ]]; then
  echo "Error: skills directory not found at $SKILLS_SRC" >&2
  exit 1
fi

if [[ "$TARGET" == "cursor" || "$TARGET" == "both" ]]; then
  install_skills_to "$CURSOR_DEST" "cursor"
fi

if [[ "$TARGET" == "claude" || "$TARGET" == "both" ]]; then
  install_skills_to "$CLAUDE_DEST" "claude"
fi

if [[ -n "$PROJECT_DIR" ]]; then
  if [[ ! -d "$PROJECT_DIR" ]]; then
    echo "Error: --project directory not found: $PROJECT_DIR" >&2
    exit 1
  fi
  install_skills_to "$PROJECT_DIR/.claude/skills" "project"
fi

echo ""
if [[ "$DRY_RUN" -eq 1 ]]; then
  echo "Dry run complete."
else
  echo "Done."
fi
echo ""
echo "Instructions:"
echo "  Cursor → user-rules/global.md in User Rules"
echo "  Claude → user-rules/global.md in Custom instructions"
echo "  Claude ZIP → ./scripts/package-claude-desktop.sh (see claude-desktop/README.md)"

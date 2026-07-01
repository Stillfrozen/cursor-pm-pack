# Cursor PM Pack — Manifest

**Version:** 1.2.0  
**Date:** 2026-07-01  
**Audience:** PM, аналитики, маркетинг, ops (не разработчики)

## Included skills (8)

| Skill | Source | Pack path |
|-------|--------|-----------|
| `quality-gate` | `~/.cursor/skills/quality-gate/` | `skills/quality-gate/` |
| `evidence-gate` | `~/.cursor/skills/evidence-gate/` | `skills/evidence-gate/` |
| `create-prd` | `~/.cursor/skills/create-prd/` | `skills/create-prd/` |
| `product-strategy-review` | `~/.cursor/skills/product-strategy-review/` | `skills/product-strategy-review/` |
| `adr-decision` | `~/.cursor/skills/adr-decision/` | `skills/adr-decision/` |
| `survey-design-llm` | `~/.cursor/skills/survey-design-llm/` | `skills/survey-design-llm/` |
| `survey-results-analysis` | `~/.cursor/skills/survey-results-analysis/` | `skills/survey-results-analysis/` |
| `data-analysis` | `~/.cursor/skills/wallet-data-analysis/` | `skills/data-analysis/` |

## Included rules

**Global only:** [`user-rules/global.md`](user-rules/global.md) — 4 правила в одном блоке для Cursor User Rules.

Workspace `.cursor/rules/` **удалён** (v1.1.0).

## Skills transfer audit

| Skill | Status | Notes |
|-------|--------|-------|
| `quality-gate` | **Complete** | SKILL.md + `references/` (9 files: contract, 8 reviewers). Дебренд примеров. |
| `evidence-gate` | **Complete** | Полный перенос; persona routing → `Context/personas/`. |
| `create-prd` | **Complete** | Дебренд: без wallet-персон/KYC/3-party; 13 секций PRD сохранены. |
| `product-strategy-review` | **Complete** | PRISM 5D (без FinTech Ownership dimension); review.md/json шаблоны. |
| `adr-decision` | **Complete** | Дебренд drivers/template; regulatory optional. |
| `survey-design-llm` | **Complete** | SKILL.md + `reference.md`; без ссылок на repo-specific docs. |
| `survey-results-analysis` | **Rewritten** | Protocol-first + ad-hoc Python; без `analyze_survey_results.py`. |
| `data-analysis` | **Complete** | Переименован из wallet-data-analysis; убран wallet evidence block. |

### Намеренно не переносились (из `~/.cursor/skills/`)

| Skill | Reason |
|-------|--------|
| `wallet-service-overview` | Product-specific |
| `wallet-regulatory` | Product-specific |
| `wallet-persona-router` | Product-specific |
| `wallet-data-analysis` | → `data-analysis` (generalized) |
| `kaiten` | Product/org-specific |
| `pbr-announce` | Product/org-specific |
| `tasks-on-me` | Product/org-specific |
| `holst` | Product/org-specific (stub) |

## Explicitly excluded (other)

- Dev skills (`~/.claude/skills/*`)
- MCP connectors
- Subagents
- Cursor built-in `skills-cursor/*`

## Client support

| Client | Skills install | Instructions |
|--------|----------------|--------------|
| Cursor | `./install.sh --target cursor` → `~/.cursor/skills/` | `user-rules/global.md` → User Rules |
| Claude Desktop / Code | `./install.sh --target claude` → `~/.claude/skills/` | `user-rules/global.md` → Custom instructions |
| Claude Desktop (ZIP) | `./scripts/package-claude-desktop.sh` → upload `.zip` | same `global.md` |
| Both | `./install.sh --target both` | paste in both UIs |
| Project-scoped (Claude) | `./install.sh --target claude --project <repo>` → `.claude/skills/` | — |

## Changelog

### 1.2.0 (2026-07-01)

- Claude Desktop: `--target claude|both`, `--project` for `.claude/skills/`
- `scripts/package-claude-desktop.sh` — ZIP per skill for Desktop upload
- `claude-desktop/README.md`; unified `global.md` for Cursor + Claude instructions

### 1.1.0 (2026-07-01)

- Rules: только global (`user-rules/global.md`, все 4 правила); удалён `.cursor/rules/`
- Skills audit: восстановлены `quality-gate/references/`, `survey-design-llm/reference.md`
- `install.sh`: убран `--rules`

### 1.0.1 (2026-07-01)

- Rules dedup: global (2) vs workspace (4) — superseded by 1.1.0

### 1.0.0 (2026-07-01)

- Initial release

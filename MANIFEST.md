# Cursor PM Pack — Manifest

**Version:** 1.0.0  
**Date:** 2026-07-01  
**Audience:** PM, аналитики, маркетинг, ops (не разработчики)

## Included skills (8)

| Skill | Purpose |
|-------|---------|
| `quality-gate` | Качество ответов: контракт, anti-hallucination, review panel |
| `evidence-gate` | Проверка готовности evidence перед PRD/ADR/стратегией |
| `create-prd` | PRD с clarifying questions и B2C/regulated appendix |
| `product-strategy-review` | PRISM strategy self-review (5 dimensions) |
| `adr-decision` | ADR для kill/keep, build/buy/partner |
| `survey-design-llm` | Дизайн опроса: гипотезы H1–Hn, спека Q1–Qn |
| `survey-results-analysis` | Анализ выгрузок опросов (protocol-first, без custom scripts) |
| `data-analysis` | Анализ сырых CSV/Excel/логов |

## Included rules (4)

**Workspace** (`.cursor/rules/`):

- `pm-strategic-copilot.mdc` — always on
- `result-in-md-files.mdc` — always on
- `product-hypothesis-flow.mdc` — apply intelligently
- `interface-copywriting.mdc` — apply intelligently

**User Rules snippets** (`user-rules/`): те же тексты для глобальной установки в Cursor Settings.

## Explicitly excluded

- Product-specific skills: `wallet-*`, `kaiten`, `pbr-announce`, `tasks-on-me`, `holst`
- Dev skills: `microservice-*`, `pentest`, `ms-*`
- MCP connectors and `mcp.json` templates
- Subagents (`.cursor/agents/`)
- Obsidian/vault-specific rules
- Cursor built-in `skills-cursor/*` (already shipped with Cursor)

## Changelog

### 1.0.0 (2026-07-01)

- Initial release: 8 generalized skills + 4 rules
- Debranded from internal wallet/Kaiten/Holst context
- `survey-results-analysis` rewritten without repo-specific Python scripts

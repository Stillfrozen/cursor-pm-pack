---
title: "PM Pack — skills & instructions for Cursor and Claude"
tags:
  - проект/workspace
  - подпроект/tools
  - тип/guide
  - область/meta
---
# PM Pack — skills & instructions for Cursor and Claude

Переносимый набор **skills** и **instructions** для продуктовой работы — без привязки к конкретному продукту, без MCP и без dev-инструментов.

**Клиенты:** [Cursor](https://cursor.com) и **Claude Desktop** (включая Cowork).

**Для кого:** PM, аналитики, маркетинг, ops.

> **Русская пошаговая установка и troubleshooting:** [docs/INSTALL.ru.md](docs/INSTALL.ru.md)

---

## Быстрый старт

### 1. Получить пакет

```bash
git clone https://github.com/Stillfrozen/cursor-pm-pack.git
cd cursor-pm-pack
```

### 2. Установить skills

```bash
chmod +x install.sh scripts/package-claude-desktop.sh

# только Cursor (по умолчанию)
./install.sh

# только Claude Desktop / Claude Code
./install.sh --target claude

# оба клиента
./install.sh --target both

# + skills в репозиторий команды
./install.sh --target both --project /path/to/your-repo
```

| `--target` | Куда копируются skills |
|------------|------------------------|
| `cursor` | `~/.cursor/skills/` |
| `claude` | `~/.claude/skills/` |
| `both` | оба каталога |

Перезапустите клиент или откройте новый чат.

### 3. Подключить instructions (rules)

Один файл — [`user-rules/global.md`](user-rules/global.md):

| Клиент | Куда вставить |
|--------|----------------|
| **Cursor** | Settings → Rules → User Rules |
| **Claude Desktop** | Settings → Profile → Custom instructions |

Вставляйте текст с `# PM Strategic Copilot` и ниже (после шапки).

### 4. Claude Desktop — альтернатива: ZIP upload

Если skills не подхватываются из `~/.claude/skills/`:

```bash
./scripts/package-claude-desktop.sh
# dist/claude-desktop/*.zip → Settings → Customize → Skills → Upload
```

Подробнее: [claude-desktop/README.md](claude-desktop/README.md)

---

## Что внутри

| Skill | Когда вызывать |
|-------|----------------|
| `quality-gate` | Нетривиальный ответ; research с цитированием |
| `evidence-gate` | Перед PRD, ADR, strategy review |
| `create-prd` | «напиши PRD», spec для фичи |
| `product-strategy-review` | PRISM strategy review |
| `adr-decision` | kill/keep, build/buy/partner |
| `survey-design-llm` | Дизайн опроса |
| `survey-results-analysis` | Анализ xlsx/csv |
| `data-analysis` | Сырые CSV, Excel, логи |

Instructions в `user-rules/global.md`: PM copilot, markdown artifacts, hypothesis flow, UI copy.

Аудит переноса: [MANIFEST.md](MANIFEST.md#skills-transfer-audit).

---

## Калибровка под продукт

```text
your-project/
├── Context/
│   ├── product.md
│   ├── personas/
│   └── regulatory.md
├── Knowledge/
├── Work/
└── docs/
```

Для Claude в репозитории: `./install.sh --project . --target claude` → `.claude/skills/`.

---

## Обновление

```bash
git pull
./install.sh --target both --force
# обновите global.md в User Rules / Custom instructions при изменениях
```

---

## FAQ

**Cursor skills не видны?** — `~/.cursor/skills/`, перезапуск Cursor.

**Claude skills не видны?** — `~/.claude/skills/` или ZIP upload; в Cowork — `/имя-скилла`.

**Один пакет на двух клиентах?** — `./install.sh --target both`; instructions один раз в каждый UI.

## License

MIT — see [LICENSE](LICENSE). Copyright (c) 2026 Ivan Pashintsev (Stillfrozen) and contributors. Third-party components and external services retain their own terms; see [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md).

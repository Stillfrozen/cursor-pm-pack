---
title: "Установка PM Pack в Cursor и Claude"
date: 2026-08-21
tags:
  - проект/workspace
  - подпроект/tools
  - тип/guide
  - область/meta
  - дата/2026-08-21
---

# Установка PM Pack в Cursor и Claude

Набор **продуктовых skills** без привязки к конкретному продукту и без MCP. Для PM, аналитиков, маркетинга, ops.

**Репозиторий:** https://github.com/Stillfrozen/cursor-pm-pack

Короткий обзор — в [README.md](../README.md). Ниже — установка, проверка и типичные сбои.

---

## Что внутри

| Skill | Когда звать |
|-------|-------------|
| `quality-gate` | Нетривиальный ответ, research с цитированием |
| `evidence-gate` | Перед PRD, ADR, strategy review |
| `create-prd` | «напиши PRD», spec фичи |
| `product-strategy-review` | PRISM strategy review |
| `adr-decision` | kill/keep, build/buy/partner |
| `survey-design-llm` | Дизайн опроса |
| `survey-results-analysis` | Разбор xlsx/csv опроса |
| `data-analysis` | Сырые CSV, Excel, логи |

Плюс один блок instructions: [`user-rules/global.md`](../user-rules/global.md) — PM-copilot, гипотезы, markdown-артефакты, тексты интерфейса.

Сюда **не** входят: коннекторы Kaiten / Confluence / Drive / Holst, доменные skills конкретного продукта, субагенты.

---

## Что понадобится

| Требование | Детали |
|------------|--------|
| **Cursor** и/или **Claude Desktop / Claude Code** | Skills копируются в домашнюю папку клиента |
| **git** | клон репозитория |
| **macOS / Linux** | `install.sh` — bash |

Windows: скопируйте папки из `skills/` в `%USERPROFILE%\.cursor\skills\` вручную.

---

## 1. Клонировать

```bash
git clone https://github.com/Stillfrozen/cursor-pm-pack.git
cd cursor-pm-pack
chmod +x install.sh scripts/package-claude-desktop.sh
```

---

## 2. Поставить skills

```bash
# только Cursor (по умолчанию)
./install.sh

# только Claude Desktop / Claude Code
./install.sh --target claude

# оба клиента
./install.sh --target both

# ещё и в репозиторий команды (Claude: .claude/skills/)
./install.sh --target both --project /path/to/your-repo
```

| `--target` | Куда копируются skills |
|------------|------------------------|
| `cursor` | `~/.cursor/skills/` |
| `claude` | `~/.claude/skills/` |
| `both` | оба каталога |

Повторная установка без `--force` не затирает уже лежащие папки. Обновление:

```bash
git pull
./install.sh --target both --force
```

---

## 3. Подключить instructions

Откройте [`user-rules/global.md`](../user-rules/global.md). Вставляйте текст **с** `# PM Strategic Copilot` и ниже (YAML-шапку можно не копировать).

| Клиент | Куда |
|--------|------|
| **Cursor** | Settings → Rules → User Rules |
| **Claude Desktop** | Settings → Profile → Custom instructions |

Это не файл на диске, который установщик правит сам. После `git pull` сверьте, не изменился ли `global.md`, и при необходимости вставьте заново.

---

## 4. Проверить

1. Перезапустите Cursor / Claude или откройте **новый** чат.
2. Спросите: «напиши PRD на онбординг, сначала задай уточняющие вопросы».
3. Агент должен идти по `create-prd` (уточнения → секции), а не сразу писать полотно.
4. Для нетривиального разбора должен включиться `quality-gate` (контракт в начале).

В Cursor список skills: папка `~/.cursor/skills/` — там должны появиться восемь имён из таблицы выше.

---

## 5. Claude Desktop — ZIP, если папка не подхватывается

```bash
./scripts/package-claude-desktop.sh
```

Файлы `dist/claude-desktop/*.zip` → Settings → Customize → Skills → Upload.

Подробнее: [claude-desktop/README.md](../claude-desktop/README.md).

---

## Калибровка под свой продукт

Пакет нарочно пустой по домену. Рядом с работой команды заведите:

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

Доменные факты — в этих файлах, не в форке PM Pack. Иначе пакет перестанет быть переносимым.

---

## Проблемы

| Симптом | Что проверить |
|---------|----------------|
| Skills «не видны» в Cursor | Путь `~/.cursor/skills/<name>/SKILL.md` (имя папки = имя skill). Новый чат, не старый тред. |
| Claude не видит skills | `~/.claude/skills/` или ZIP upload. В Cowork зовите `/имя-скилла`. |
| Установщик ничего не обновил | Нужен `--force` после `git pull`. |
| Instructions «как раньше» | User Rules / Custom instructions не обновляются скриптом — вставьте `global.md` руками. |
| Агент тянет чужой продукт | В workspace лежат доменные skills/rules. PM Pack их не удаляет. |

---

## Обновление с чужой машины

Один и тот же клон можно держать в `~/src/cursor-pm-pack` и ставить на несколько клиентов. Secrets в пакете нет.

---

## Связанные файлы

- [README.md](../README.md) — быстрый старт
- [MANIFEST.md](../MANIFEST.md) — что перенесено и что намеренно выкинуто

# Cursor PM Pack

Переносимый набор **skills** и **rules** для продуктовой работы в Cursor — без привязки к конкретному продукту, без MCP и без dev-инструментов.

**Для кого:** PM, аналитики, маркетинг, ops.

---

## Быстрый старт (3 шага)

### 1. Получить пакет

```bash
git clone https://github.com/Stillfrozen/cursor-pm-pack.git
cd cursor-pm-pack
```

### 2. Установить skills

```bash
chmod +x install.sh
./install.sh          # копирует в ~/.cursor/skills/
./install.sh --dry-run  # проверка без записи
./install.sh --force    # перезаписать существующие
```

Перезапустите Cursor или откройте новый чат — skills подхватятся автоматически.

### 3. Подключить rules

**Вариант A — на один проект (рекомендуется для команды):**

```bash
mkdir -p /path/to/your-project/.cursor/rules
cp -R .cursor/rules/* /path/to/your-project/.cursor/rules/
```

**Вариант B — глобально на все workspace:**

1. Cursor → **Settings → Rules → User Rules**
2. Скопируйте содержимое файлов из `user-rules/*.md` (по одному блоку или все вместе)
3. Сохраните

Подробнее: [user-rules/README.md](user-rules/README.md)

---

## Что внутри

| Skill | Когда вызывать |
|-------|----------------|
| `quality-gate` | Любой нетривиальный ответ; research с цитированием |
| `evidence-gate` | Перед PRD, ADR, strategy review — «достаточно ли данных?» |
| `create-prd` | «напиши PRD», spec для фичи |
| `product-strategy-review` | Квартальный обзор стратегии, PRISM scoring |
| `adr-decision` | kill/keep, build/buy/partner, sunset |
| `survey-design-llm` | Дизайн опроса, гипотезы, вопросы |
| `survey-results-analysis` | Анализ xlsx/csv выгрузки опроса |
| `data-analysis` | Любой сырой датасет: CSV, Excel, логи |

### Rules (всегда или по контексту)

| Rule | Режим | Назначение |
|------|-------|------------|
| `pm-strategic-copilot` | always | Devil's advocate, evidence-first |
| `result-in-md-files` | always | Существенные результаты → файл в `docs/` |
| `product-hypothesis-flow` | intelligent | Чеклист для гипотез и приоритизации |
| `interface-copywriting` | intelligent | Тексты интерфейса, без «копир» |

---

## Калибровка под свой продукт

Пакет **не содержит** продуктовых фактов. Положите в свой workspace:

```text
your-project/
├── Context/
│   ├── product.md          # что за продукт, для кого
│   ├── personas/           # целевые сегменты / персоны
│   └── regulatory.md       # если regulated industry (опционально)
├── Knowledge/              # ресёрчи, интервью
├── Work/
│   ├── PRDs/
│   └── Decisions/
└── docs/                   # артефакты от агента
```

Агент подхватит `Context/` и `Knowledge/` автоматически при работе в этом workspace.

---

## Обновление

```bash
git pull   # или получить новую версию папки
./install.sh --force
```

Сверьте `MANIFEST.md` — там changelog и список изменений.

---

## Чего нет в пакете

- MCP-коннекторы (Confluence, Kaiten, Google Drive и т.д.)
- Dev-скиллы (microservice scaffold, security audit)
- Subagents
- Vault/Obsidian-специфика

Если нужен vault-workflow — см. опциональный appendix в конце `user-rules/README.md`.

---

## FAQ

**Skills не видны в чате?**  
Проверьте `~/.cursor/skills/<name>/SKILL.md` после `./install.sh`. Перезапустите Cursor.

**Rules не работают?**  
User Rules — только через Settings. Workspace rules — только если `.cursor/rules/` лежит в **корне открытого проекта**.

**Можно править skills после установки?**  
Да. `./install.sh --force` перезапишет — сохраните свои правки отдельно.

---

## Связанные заметки

- [MANIFEST.md](MANIFEST.md) — версия, changelog, исключения
- [user-rules/README.md](user-rules/README.md) — установка глобальных rules

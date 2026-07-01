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

### 3. Подключить rules (глобально)

1. Cursor → **Settings → Rules → User Rules**
2. Вставьте [`user-rules/global.md`](user-rules/global.md) **целиком** одним блоком
3. Сохраните

Все 4 правила пакета — только через User Rules, workspace `.cursor/rules/` не используется.

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

### Rules (в `user-rules/global.md`)

| Rule | Назначение |
|------|------------|
| PM Strategic Copilot | Devil's advocate, evidence-first, privacy |
| Result in Markdown Files | Существенные результаты → `docs/` |
| Product Hypothesis Flow | Чеклист гипотез, routing на skills |
| Interface Copywriting | Тексты интерфейса, без «копир» |

Полный аудит переноса skills: [MANIFEST.md](MANIFEST.md#skills-transfer-audit).

---

## Калибровка под свой продукт

Пакет **не содержит** продуктовых фактов. Положите в свой workspace:

```text
your-project/
├── Context/
│   ├── product.md
│   ├── personas/
│   └── regulatory.md       # опционально
├── Knowledge/
├── Work/
│   ├── PRDs/
│   └── Decisions/
└── docs/
```

---

## Обновление

```bash
git pull
./install.sh --force
# при изменении rules — обновите User Rules из user-rules/global.md
```

---

## Чего нет в пакете

- MCP-коннекторы
- Dev-скиллы
- Subagents
- Workspace rules (`.cursor/rules/`)
- Product-specific skills (`wallet-*`, `kaiten`, `holst`, …)

---

## FAQ

**Skills не видны?** — проверьте `~/.cursor/skills/` после `./install.sh`, перезапустите Cursor.

**Rules не работают?** — только через **User Rules** в Settings, не через файлы в репозитории.

**Можно править после установки?** — да; `./install.sh --force` перезапишет skills из пакета.

# Claude Desktop — установка PM Pack

Два способа подключить skills и instructions в **Claude Desktop** (и Cowork, если включены skills).

---

## Способ A — файловая установка (рекомендуется)

Работает для **Claude Desktop Cowork**, **Claude Code** и сессий с доступом к `~/.claude/skills/`.

```bash
./install.sh --target claude
# или оба клиента сразу:
./install.sh --target both
```

Skills копируются в `~/.claude/skills/`. Перезапустите Claude Desktop или начните новую сессию Cowork.

Проверка:

```bash
ls ~/.claude/skills/
```

В чате skills вызываются через `/имя-скилла` (например `/create-prd`, `/evidence-gate`).

### Skills в конкретный проект

```bash
./install.sh --target claude --project /path/to/your-repo
```

Копирует в `/path/to/your-repo/.claude/skills/` — удобно для командного репозитория.

---

## Способ B — загрузка ZIP (чат без filesystem skills)

Если в вашей версии Desktop skills подключаются только через UI:

```bash
chmod +x scripts/package-claude-desktop.sh
./scripts/package-claude-desktop.sh
```

Архивы появятся в `dist/claude-desktop/*.zip` (по одному на skill).

1. Откройте **Claude Desktop**
2. **Settings → Customize → Skills** (или **Capabilities → Skills**)
3. **Upload skill** — загрузите нужные `.zip` по одному (все 8 или выборочно)
4. Включите toggle у каждого skill

Структура zip корректная: `quality-gate/SKILL.md` в корне архива.

---

## Custom instructions (rules)

Аналог Cursor User Rules — один блок на все чаты:

1. **Settings → Profile** (или **Settings → General → Custom instructions**)
2. Вставьте содержимое [`user-rules/global.md`](../user-rules/global.md) **без** первых 5 строк-шапки (с `# PM Strategic Copilot` и дальше)
3. Сохраните

Тот же текст, что и для Cursor User Rules — правила PM Pack единые.

---

## Cursor + Claude на одной машине

```bash
./install.sh --target both --force
```

| | Cursor | Claude |
|--|--------|--------|
| Skills path | `~/.cursor/skills/` | `~/.claude/skills/` |
| Instructions | User Rules ← `global.md` | Custom instructions ← `global.md` |
| ZIP upload | не нужен | опционально (способ B) |

Исходники skills одни (`skills/`), ставятся в оба каталога копированием.

---

## Ограничения Desktop vs Cursor

- **MCP** в пакете нет — в Desktop connectors настраиваются отдельно в Settings.
- Skills с `disable-model-invocation: true` (`survey-design-llm`, `survey-results-analysis`) в Claude вызываются явно через `/`, не авто.
- Cowork имеет sandbox и file tools — `result-in-md-files` из global instructions работает, если папка workspace доступна.

---

## Обновление

```bash
git pull
./install.sh --target both --force
./scripts/package-claude-desktop.sh   # если пользуетесь ZIP
# обновите Custom instructions / User Rules при изменении global.md
```

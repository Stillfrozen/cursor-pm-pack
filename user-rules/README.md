# User Rules — как установить

Cursor **не подхватывает** файлы из этой папки автоматически. Два уровня rules — **разный состав**, не копипаста одного и того же.

## Глобально (все проекты на машине)

**Файл:** [`global.md`](global.md) — один блок для **Cursor → Settings → Rules → User Rules**.

Содержит только **always-on** правила:
- `pm-strategic-copilot` — тон, evidence, privacy
- `result-in-md-files` — артефакты в `docs/`

## На проект (workspace)

**Папка:** [`.cursor/rules/`](../.cursor/rules/) — копируется в корень репозитория команды.

Содержит **все 4** правила, включая контекстные:
- `pm-strategic-copilot.mdc` (`alwaysApply: true`)
- `result-in-md-files.mdc` (`alwaysApply: true`)
- `product-hypothesis-flow.mdc` (apply intelligently — гипотезы, routing на skills)
- `interface-copywriting.mdc` (apply intelligently — тексты UI)

```bash
mkdir -p /path/to/project/.cursor/rules
cp -R .cursor/rules/* /path/to/project/.cursor/rules/
```

Или из корня пакета: `./install.sh --rules /path/to/project`

## Что выбрать

| Сценарий | Skills | Rules |
|----------|--------|-------|
| Быстрый личный старт | `./install.sh` | вставить `user-rules/global.md` |
| Командный репозиторий | `./install.sh` | `cp .cursor/rules/` в проект |
| Оба | `./install.sh` | global + workspace (дублирование always-on допустимо — Cursor мержит) |

**Не ставьте** одни и те же 4 правила и в User Rules, и в workspace — будет шум. Global = 2 always-on; workspace = полный набор для PM-проекта.

## Obsidian / vault

Не входит в PM Pack. Настраивайте отдельно под свой vault.

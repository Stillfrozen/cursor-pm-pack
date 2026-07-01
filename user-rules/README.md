# User Rules snippets for Cursor PM Pack

Файлы здесь — **не подхватываются Cursor автоматически**. Скопируй содержимое нужного `.md` в **Cursor → Settings → Rules → User Rules**, чтобы правило действовало во **всех** workspace на этой машине.

| Файл | Назначение |
|------|------------|
| `pm-strategic-copilot.md` | Devil's advocate, evidence-first, privacy guard |
| `result-in-md-files.md` | Существенные результаты → файл в `docs/` |
| `product-hypothesis-flow.md` | Чеклист гипотез и routing на skills |
| `interface-copywriting.md` | Тексты интерфейса, без «копир» |

## Рекомендуемый порядок установки

1. `./install.sh` — skills в `~/.cursor/skills/`
2. Скопировать все 4 файла в User Rules (или только `pm-strategic-copilot` + `result-in-md-files` для минимального набора)
3. Для командной работы: additionally `cp -R ../.cursor/rules/ <project>/.cursor/rules/`

## Опционально: Obsidian / vault

Если коллеги используют Obsidian-монорепу с YAML-тегами и `scripts/tag_vault_frontmatter.py` — это **не входит** в PM Pack. Настройте отдельно под свой vault.

Дублируйте изменения на другой компьютер через git или вручную.

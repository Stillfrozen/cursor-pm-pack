---
title: "User Rules / Custom Instructions"
tags:
  - проект/workspace
  - подпроект/tools
  - тип/guide
  - область/meta
---
# User Rules / Custom Instructions

Единый файл [`global.md`](global.md) — для **Cursor User Rules** и **Claude Custom instructions**.

| Клиент | Путь в UI |
|--------|-----------|
| Cursor | Settings → Rules → User Rules |
| Claude Desktop | Settings → Profile → Custom instructions |

Вставляйте содержимое начиная с `# PM Strategic Copilot` (после первого `---`).

Skills ставятся отдельно: `./install.sh --target cursor` или `--target claude` или `--target both`.

Подробнее про Claude: [claude-desktop/README.md](../claude-desktop/README.md)

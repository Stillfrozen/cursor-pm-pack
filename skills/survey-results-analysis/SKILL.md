---
name: survey-results-analysis
description: Analyze survey Excel/CSV exports without manual JSON config — auto column mapping, aggregates via ad-hoc Python, masked respondent lists, UX and segment reports. Use when analyzing survey results, xlsx выгрузка, barrier segments, or executive presentation from survey data.
disable-model-invocation: true
---

# Survey results analysis

## User-facing rule

**Never ask the user to edit JSON/YAML configs.** They provide the export file path (and optional questionnaire spec). You inspect, map columns, compute aggregates, and write reports.

## Workflow

### 1. Contract (ask only if missing)

| Item | Default |
|------|---------|
| Export path | User provides or newest file in `survey-results/` |
| Product alias | `product` — ask once per project |
| Reports | quant MD/HTML; ask if they also want UX / segment deep-dive |
| Questionnaire spec | `docs/questionnaire-spec*.md` or `docs/hypotheses-*.md` if exists |
| Decision context | What decision the analysis should support |

### 2. Inspect the export (you execute)

Read the file structure first:

```bash
# Example: inspect sheets and columns
python3 -c "
import pandas as pd
path = 'survey-results/<file>.xlsx'
xl = pd.ExcelFile(path)
for sheet in xl.sheet_names:
    df = pd.read_excel(path, sheet_name=sheet, nrows=5)
    print(f'--- {sheet}: {len(pd.read_excel(path, sheet_name=sheet))} rows ---')
    print(list(df.columns))
"
```

Or use available file-read tools if Python/pandas is not installed — still perform schema discovery manually.

Document:
- Sheet names, row counts, column names.
- Suspected question columns vs metadata (timestamp, respondent ID, phone).
- Multi-select vs single-select patterns.
- Null rates and parsing issues.

If `questionnaire-spec-*.md` exists, map columns to Q1–Qn. If not, infer from headers and mark `[assumption]`.

### 3. Compute aggregates (ad-hoc)

Run Python for counts and cross-tabs as needed. No repo-specific scripts required.

```bash
python3 << 'PY'
import pandas as pd
from pathlib import Path

path = Path("survey-results/<file>.xlsx")
df = pd.read_excel(path)  # adjust sheet_name if needed

# Example: value counts for a column
# print(df["<column>"].value_counts(dropna=False))

# Write summary CSV for reproducibility
# df.groupby("<segment_col>")["<answer_col>"].value_counts().to_csv("artifacts/survey-crosstab.csv")
PY
```

Save machine-readable outputs to `artifacts/` when useful.

### 4. Validate before synthesis

Before writing conclusions:

- Compare expected N vs parsed records.
- Confirm one row = one respondent.
- Read the questionnaire spec if available.
- For every question, write: question intent, denominator, answer type, top finding.
- For open text, do two-pass thematic coding: initial themes → merge duplicates → count themes → keep 3–5 anonymized examples only if safe.

### 5. Qualitative synthesis reports

After quant summary, optionally produce:

| Goal | Output |
|------|--------|
| UX + recommendations | `docs/survey-ux-<topic>-YYYY-MM-DD.md` |
| Job / intent segments | `docs/survey-segments-<topic>-YYYY-MM-DD.md` |
| Leadership summary | `docs/survey-executive-<topic>-YYYY-MM-DD.md` |
| One barrier deep-dive | `docs/survey-deep-dive-<barrier>-YYYY-MM-DD.md` |

Use quant findings + questionnaire spec as input. Replace placeholders with actual counts.

### 6. Triangulation and confidence

For each major conclusion, include:

- `[evidence]`: exact question/count/share.
- `[assumption]`: interpretation or likely cause.
- `confidence`: high / medium / low.
- `next validation`: interview question, log check, or follow-up slice.

Do not turn LLM-generated recommendations into facts. Treat them as hypotheses until checked against survey evidence or interviews.

### 7. Privacy

- Mask phones and emails in tables (e.g. `+7***1234`).
- No raw exports with PII in git.
- No full PII quotes in shared reports.
- Use product alias unless user explicitly requires exact public brand spelling.

### 8. Deliverables

Save to `docs/` with clear filenames and dates.

Primary outputs:
- `docs/survey-analysis-<topic>-YYYY-MM-DD.md` — full quant report
- `docs/survey-analysis-<topic>-YYYY-MM-DD.html` — optional HTML for sharing

Tell user:

- Path to quant MD/HTML
- Path to qual reports if created
- Respondent count (masked)
- Remind: do not commit `survey-results/*.xlsx` with PII

## Quality checklist

- [ ] All Q1–Qn covered (or gaps explicitly noted)
- [ ] Multi-select ≠ 100% sum
- [ ] Denominator stated (all vs filtered cohort)
- [ ] `[evidence]` vs `[assumption]` separated
- [ ] Theme coding pass for open-text completed
- [ ] Confidence and next validation stated for major conclusions

## Skill chaining

- **Before:** `survey-design-llm` output (`docs/questionnaire-spec-*.md`, `docs/hypotheses-*.md`)
- **After:** decision memo or ADR if survey drives a strategic call

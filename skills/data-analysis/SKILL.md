---
name: data-analysis
description: Analyze unknown raw datasets with a protocol-first workflow. Use when working with Excel/CSV exports, event logs, customer tables, transaction ledgers, operational logs, research spreadsheets, mixed data dumps, or when the user asks to understand customer behavior, patterns, blockers, segments, anomalies, or data meaning.
---

# Data Analysis

Use this skill for **unknown or raw datasets**. The workflow is universal across projects. It is not a funnel-only skill.

## Core Principle

Do not start by building a chart, funnel, or report. Start by proving what the data means.

Separate:
- `[evidence]` directly observed in data.
- `[assumption]` plausible but not proven.
- `[unknown]` not inferable from current data.

## Workflow

### 1. Contract First

Before analysis, establish:
- User question and decision context.
- Dataset path(s) and format(s).
- Unit of analysis requested: user, event, transaction, account, session, object, row, day, case, or other.
- Time window, cohort rules, known business rules, and exclusions.
- Desired output: data dictionary, investigation, executive summary, ops report, detailed findings, dashboard/site, CSV/JSON artifacts.

Ask only critical clarifying questions. If proceeding with assumptions, mark them.

### 2. Schema Discovery

Inspect every source:
- Sheets/tables/files.
- Row counts and column names.
- Data types and parsing issues.
- Null/fill rates.
- Unique counts and top frequencies.
- Representative samples per column.
- Mixed values, shifted-looking rows, hidden IDs, timestamps, and unnamed columns.

Never infer a column's meaning from its name alone.

### 3. Semantic Mapping

Create a data dictionary:
- Column name.
- Observed values.
- Likely semantic meaning.
- Confidence: `[evidence]`, `[assumption]`, `[unknown]`.
- Role in analysis: identifier, timestamp, category, status, metric, text payload, reference ID, event action, event context, amount, technical metadata.

If a value like `Open`, `Show`, `Success`, `Fill`, `Error`, `Completed`, or `Received` appears, do not assume its semantic meaning. Verify from context, samples, and transitions.

### 4. Grain Check

Determine what one row represents:
- One user snapshot?
- One event?
- One transaction?
- One state transition?
- One session?
- One log line?
- One object at a point in time?

Do not mix row count, event count, user count, account count, transaction count, and session count. Label every metric by its grain.

### 5. Choose Analysis Mode

Pick the analysis method based on the question:
- **Profiling**: What is in the dataset?
- **Data quality audit**: Can we trust it?
- **Segmentation**: How do groups differ?
- **Cohort analysis**: What happens after an anchor event/date?
- **Funnel**: Where do entities drop between ordered stages?
- **Pathing/journey**: What sequences occur?
- **Blocker analysis**: What prevents progress?
- **Root-cause exploration**: What patterns correlate with an outcome?
- **Reconciliation**: Do two sources agree?
- **Anomaly/outlier detection**: What is unusual?
- **Descriptive report**: What happened, in plain language?

Do not force a funnel when the dataset or question is not funnel-shaped.

### 6. Definitions Before Counts

For every segment/outcome, define:
- Strict definition.
- Broad definition.
- Unknown/no-signal bucket.
- Conflict priority.
- Time window.

Keep these states separate:
- Did not appear.
- Appeared but did not act.
- Acted but no success signal.
- Blocked by prerequisite.
- Failed after attempt.
- Success.
- Unknown because event coverage is insufficient.

### 7. Pattern Discovery

Look beyond top-line conversion:
- Blockers and prerequisites.
- Loops and repeated states.
- Retries and repeated errors.
- Parallel journeys and side quests.
- Technical vs product vs operational issues.
- Co-occurrence of events/statuses.
- Outliers and heavy users.
- Platform/version/device/source differences.
- Before/after outcome timing.
- Other forms/products/actions visited.

When describing behavior, avoid overclaiming intent. Say "the data shows users visited/clicked/focused/saw" unless intent is explicitly measured.

### 8. Validation Loop

Before final conclusions:
- Recalculate key counts by at least two routes when possible.
- Compare user-level and event-level results.
- Check strict vs broad definitions.
- Validate suspicious findings with raw samples.
- Inspect top values for hidden mixed semantics.
- Check if "missing" means absent, not logged, filtered out, or unknown.
- Verify that success/failure labels match business definitions.

If a conclusion depends on ambiguous events, state the ambiguity.

### 9. Output Standards

For substantive analysis, save artifacts:
- `docs/...methodology...md`: definitions, assumptions, rules.
- `docs/...findings...md`: detailed human-readable findings.
- `docs/...ops-report...md` or executive summary when useful.
- `artifacts/.../*.csv` or `*.json`: machine-readable cohorts, transitions, summaries, flags.

In chat, return:
- One-paragraph summary.
- 3-7 most important findings.
- Paths to created files.
- Any unresolved risks or data gaps.

If the workspace has a domain evidence base (`Context/`, `Knowledge/`), compare findings against it when the question is "is this normal?" — mark deltas as `[evidence]` or `[new finding]`.

## Anti-Errors

- Do not treat field names as truth without samples/frequencies.
- Do not treat `Fill/Field` as actual input unless confirmed.
- Do not treat `Success` as business success unless definition confirms it.
- Do not merge `not attempted`, `blocked`, `failed`, `no signal`, and `unknown`.
- Do not infer causality from observational data.
- Do not call a user "uninterested" just because no final success event exists.
- Do not hide data quality issues inside product conclusions.
- Do not report only percentages without denominators and grain.
- Do not overfit to a single chart; inspect raw distributions.

## Recommended Report Shape

```markdown
# [Dataset / Question] Analysis

## Contract
[Question, unit of analysis, time window, definitions]

## Data Inventory
[Files, sheets, columns, fill rates, key samples]

## Semantic Map
[Column -> meaning -> confidence]

## Methodology
[Strict/broad definitions, metric grain, exclusions]

## Findings
[Evidence-led patterns, ranked by scale or importance]

## Limitations
[Unknowns, logging gaps, ambiguity]

## Recommendations / Next Checks
[Only if supported by evidence]
```

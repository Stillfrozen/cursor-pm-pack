---
title: "Survey design with LLM"
tags:
  - проект/workspace
  - подпроект/tools
  - тип/guide
  - область/meta
---
# Survey design with LLM

## User-facing rule

User does **not** configure files. They describe segment, decisions, and hypotheses in chat. You produce markdown artifacts in `docs/`.

## When to use

Creating or refining a survey — not analyzing results (`survey-results-analysis`).

## Workflow

### 1. Segment + hypotheses (mandatory, ask if missing)

Do **not** start drafting questions until you have:

- **Target segment**: who exactly is surveyed, inclusion/exclusion rules (1–2 sentences).
- **Hypotheses to test**: 3–8 items maximum (H1–Hn) in the form "Barrier → expected signal".

If the user didn't provide these, ask in chat:

- "Какой сегмент нужен для опроса? (кто эти люди, по каким правилам включаем/исключаем)"
- "Какие гипотезы/барьеры хотим проверить? (3–8 пунктов)"

Then restate them back as a short contract and mark gaps as `[assumption]`.

### 2. Contract (ask if missing)

After segment+hypotheses, collect: decision after survey, time budget (~3 min), and exclusions (no sensitive PII in form; phone only with explicit consent + opt-in).

### 3. Hypothesis matrix

Table: barrier → questions → discrimination rule.

Default starter hypotheses for non-converter / churn research:
- H1 awareness
- H2 no-job (no clear use case)
- H3 friction
- H4 trust
- H5 competitor
- H6 top-of-mind
- H7 onboarding

Adapt or replace based on the user's segment and decision context.

### 4. Question spec Q1–Qn

Per question: wording, type, hypotheses, why, anti-bias.

Save as:

- `docs/hypotheses-<topic>-YYYY-MM-DD.md`
- `docs/questionnaire-spec-<topic>-YYYY-MM-DD.md`

These files later feed **analysis skill** (no extra config for user).

### 5. Survey audit + pretest probes

Before finalizing, run a separate audit pass:

- **Clarity:** understandable on first read.
- **Neutrality:** no leading wording or implied "right" answer.
- **Specificity:** no double-barreled questions ("X and Y" in one item).
- **Response options:** mutually exclusive where single-select; exhaustive enough; includes "other / not applicable" only when analytically useful.
- **Scale fit:** Likert only when it measures one construct; avoid unnecessary middle/refusal options.
- **Cognitive load:** remove jargon, long lists, and repeated constructs.

Then add 5–8 **cognitive pretest probes** for a pilot interview, e.g.:

- "Как вы поняли этот вопрос своими словами?"
- "Какой вариант было сложно выбрать и почему?"
- "Есть ли вариант, которого не хватает?"
- "Где формулировка звучит оценочно или подталкивает?"

### 6. Quality gate

- Every H covered with ≥2 signals
- Barriers ≠ fears; alternatives ≠ no-job
- Interview opt-in + consent before phone
- Open: «what stopped», not «what you wish»
- Include an "Audit fixes" block: what changed after bias/double-barrel/scale review.

### 7. Handoff to fielding

Remind user: after fielding, put export in `survey-results/` and use `survey-results-analysis`.

## Privacy

- Mask PII in any shared artifacts.
- Use a product alias unless the user explicitly requires exact public brand spelling.
- Do not commit raw survey exports with personal data to git.

## References

- [reference.md](reference.md) — hypothesis→question mapping, anti-bias patterns

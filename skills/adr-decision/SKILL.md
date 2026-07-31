---
title: "ADR — Product Strategic Decision Record"
tags:
  - проект/workspace
  - подпроект/tools
  - тип/guide
  - область/meta
---
# ADR — Product Strategic Decision Record

A lightweight, durable record of one significant decision and the reasoning behind it. Written so that 6 months later, a different PM can read it and understand exactly **why** the call was made — without having to re-litigate.

## When to use

- Kill / keep / sunset / wind-down decisions.
- Build vs buy vs partner.
- Scope-down or spin-off.
- Strategic re-prioritisation of a roadmap commitment.
- Any decision worth more than 1 quarter of team time.

**Do NOT use for:** feature specs (use `create-prd`), routine prioritisation (use ICE/RICE), or weekly tactical calls.

## Inputs

| Required | |
|---|---|
| `decision_question` | one sentence, framed as a binary or N-option choice |
| `decision_drivers` | 3–5 weighted factors that matter for this call |
| `options` | minimum 2; ideally 3–4 |
| `decision_horizon` | when must this be decided (date) |
| `decision_owner` | who signs off |

| Optional | |
|---|---|
| `evidence_links` | research, financials, regulatory analysis |
| `stakeholders_consulted` | e.g. compliance, legal, growth, engineering leads |

If `options` < 2 → HOLD: there's no decision to make.

## Output

- **Format:** Markdown.
- **Location:** `Work/Decisions/`.
- **Filename:** `ADR-YYYY-MM-DD-<kebab-decision-slug>.md`.

## Process

### Step 1 — Frame the decision in one sentence

The frame must include the verb (sunset / build / partner / pivot), the object, and the constraint.

Bad: "Product line X".
Good: "Should we sunset product line X within 2 quarters given compliance load and low usage?".

### Step 2 — Surface the decision drivers

Pick 3–5. Default starter set:

| Driver | Why |
|---|---|
| Strategic fit | Alignment with company strategy and portfolio |
| Regulatory / compliance cost | Compliance FTE, audit, penalty exposure (if applicable) |
| Unit economics | LTV, CAC, payback, contribution margin |
| Operational complexity | Partner dependencies, vendor risk |
| User impact / cannibalization | Who loses access, who migrates where |
| Reversibility | How hard to undo if we're wrong |
| Time to decision deadline | When the window closes |

Weight them (sum to 100%) — and be honest. Equal weighting usually means you haven't thought about it.

### Step 3 — Lay out options

Always include **"Do nothing"** and **"Do the opposite of the obvious"** as sanity-check options, even if they get killed in scoring.

For each option, fill the comparison row.

### Step 4 — Run stakeholder checks

For each option, when applicable:
- Verify against `Context/regulatory.md` — legal vs operational feasibility.
- Consult compliance / legal perspective for regulated products.
- Check impact on top-2 affected segments from `Context/personas/`.
- Stress-test with a devil's-advocate pass (blind spots, sunk cost, confirmation bias).

### Step 5 — Generate the ADR using the template below

### Step 6 — Set a review date

Every ADR must have a `Next review date` (typically 1 quarter out). Decisions rot.

---

## ADR template

```markdown
# ADR-YYYY-MM-DD: <Decision in one sentence>

**Status:** Proposed / Accepted / Superseded by ADR-YYYY-MM-DD-… / Deprecated
**Date:** YYYY-MM-DD
**Decision owner:** @name (signs off)
**Stakeholders:** @name, @name
**Decision deadline:** YYYY-MM-DD
**Next review date:** YYYY-MM-DD

## Context

What is forcing this decision now? What changed?
- Trigger event: …
- What we already know `[evidence]`: …
- What we don't yet know `[assumption]`: …
- What's at stake if we don't decide: …

## Decision drivers (weighted)

| # | Driver | Weight | Notes |
|---|---|---|---|
| 1 | Strategic fit | 30% | … |
| 2 | Regulatory cost | 25% | N/A if not regulated |
| 3 | Unit economics | 20% | … |
| 4 | Operational complexity | 15% | … |
| 5 | Reversibility | 10% | … |
|  | **Sum** | 100% | |

## Options

### Option A — <name> (e.g. "Sunset over 2 quarters")
- Description: …
- Pros: …
- Cons: …
- Cost: FTE-quarters, capex, opex.
- Time to impact: weeks.
- Reversibility: high / medium / low.
- Compliance check: …
- Segment impact: …

### Option B — <name>
…

### Option C — Do nothing
…

### Option D — <opposite-of-obvious option>
…

## Comparison

| Driver (weight) | A | B | C | D |
|---|---|---|---|---|
| Strategic fit (30%) | 4 | 2 | 1 | 3 |
| Reg cost (25%) | … | … | … | … |
| … | … | … | … | … |
| **Weighted total** | … | … | … | … |

(Score 0–5; Σ = Σ(score × weight)).

## Decision

**Chosen:** Option <X>.

**Rationale (3–5 sentences):**
- The dominant driver was …
- Option B was rejected because …
- Option C (do nothing) carries the implicit cost of …

**Conditions / triggers for revisiting:**
- If <metric> goes <direction> beyond <threshold> → re-open this ADR.
- If <regulatory event> happens → re-open.

## Consequences

**Immediate (this quarter):**
- …

**Mid-term (next 2–4 quarters):**
- …

**For the team / partners:**
- …

## Open questions / follow-ups

| # | Question | Owner | Due |
|---|---|---|---|
| 1 | … | @name | YYYY-MM-DD |

## Links
- Strategy review: <link to `product-strategy-review` output>
- Regulatory memo: <link>
- Segment reactions: <link>
- Compliance sign-off: <link or "pending">
```

---

## Success criteria

- One-sentence framed decision (not a topic).
- ≥3 options, including "Do nothing".
- Drivers weighted (not equal).
- Each option has compliance + segment check when applicable.
- Decision rationale ≤ 5 sentences.
- `Next review date` set.
- `[assumption]` vs `[evidence]` tags throughout.

## Skill Chaining

- **Before this skill:**
  - `evidence-gate` (recommended)
  - Load `Context/product.md`, `Context/regulatory.md` if they exist
  - `product-strategy-review` if this ADR comes out of a broader review
- **After this skill:**
  - Implementation PRDs via `create-prd` (if Option = build)
  - Wind-down playbook (if Option = sunset)
  - Calendar reminder for `Next review date`
- **Conflicts with:** `create-prd` (PRD = how to build; ADR = whether/why).

## Common anti-patterns

- Only 2 options → false binary; always force ≥3 (Do Nothing + opposite-of-obvious).
- Equal-weight drivers → masks lack of thinking.
- Decision rationale > 5 sentences → you're hedging, pick the dominant driver.
- No `Next review date` → "set and forget" ADRs become haunted houses.
- "We'll figure compliance out later" → if regulated, the ADR is incomplete without a compliance check.

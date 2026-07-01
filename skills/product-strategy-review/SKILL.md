---
name: product-strategy-review
description: Conducts an evidence-gated PRISM strategy self-review for B2C products. Five dimensions — Problem, Reframe, Intentional bets, Systemized execution, Momentum. Use for quarterly strategy reviews, portfolio options, or strategic kill/keep decisions. Trigger phrases — "strategy review", "PRISM", "стратегия", "оценить стратегию".
---

# Product Strategy Review — PRISM

A self-review framework for product strategy documents. Scores five PRISM dimensions with evidence citations and produces a decision-ready review artifact.

## When to use

- Quarterly product-strategy review.
- Comparing 2+ strategic options (expand to new segment / sunset product line / new geography).
- Pre-board / pre-leadership review.
- Whenever the user asks to "evaluate this strategy", "build an options paper", or proposes a major bet.

## Inputs

| Required | Notes |
|---|---|
| `doc_link` | strategy doc to review |
| `evidence_hub` | folder with research, interviews, funnel data |
| `product_or_area` | e.g. "B2B expansion", "cross-border", "credit lane" |
| `owner` | who owns the strategy |
| `review_window_start/end` | YYYY-MM-DD |
| `riskiest_assumptions` | minimum 2 tagged assumptions |

| Optional | |
|---|---|
| `baseline_metric`, `north_star`, `capacity_window`, `runway_months` |

If required inputs are missing → **HOLD** + 1-day evidence sprint proposal. Do not score.

## Process

### Step 1 — Evidence readiness gate (call `evidence-gate` skill)

Need ≥4 of 5 core items to PROCEED:

1. ≥3 recent (≤180 d) signals (founder/customer notes, support tickets, competitor moves, conversion data).
2. ≥2 riskiest assumptions clearly tagged.
3. One success criterion (OMTM or qualitative heuristic).
4. 1–2 week discovery plan or OKR draft.
5. Versioned evidence hub link.

**HOLD** if ≤3. **PROCEED** if ≥4 (must include #2 and #3). **AUTO-ESCALATE** if PROCEED + ≥2 advanced items.

### Step 2 — Score each dimension 0–5

Citation format: `[[ev-id|path#line-range|YYYY-MM-DD]]`. Missing citations = 1-step deduction.

#### P — Problem Diagnosis
- 0: Vague or opinion-only.
- 3: Clear causal story with recent evidence; scope reasonable.
- 5: Robust thesis with leading + lagging indicators and falsification paths.
- **Anchor:** root cause must distinguish "user behaviour change" vs "regulatory change" vs "competitive move". Conflating these = max 2.

#### R — Reframe Opportunity
- 0: No opportunity framing.
- 3: Clear opportunity thesis with timing and scope.
- 5: Time-sensitive, defensible, with user/business shift quantified.
- **Anchor:** "why now?" must reference a market window, regulatory change, or technology shift — not just internal capacity.

#### I — Intentional Bets
- 0: No real choices, themes only.
- 3: Defined bets with non-goals and baseline hypotheses.
- 5: Coherent portfolio with staged options and kill/sustain criteria.
- **Anchor:** at least 3 alternatives must be compared (Do Nothing / Focused Bet / Portfolio Bet). <2 = HOLD.

#### S — Systemized Execution
- 0: No bridge to execution.
- 3: OKRs and discovery loops map to bets.
- 5: Tight strategy-to-execution system with adaptive re-planning.
- **Anchor:** OKRs should include at least one guard-rail metric (risk, compliance, quality) per bet when the product is regulated or high-stakes.

#### M — Momentum & Meta-Reflection
- 0: No reflection mechanisms.
- 3: Quarterly retros with documented learning and some course-correction.
- 5: Strong learning culture with explicit un-learning and portfolio rebalancing.

> **Overall = average of all 5.** Equal weighting.

### Step 3 — Mode analysis (run each)

- **Mode 1 — Socratic checklist:** thesis, outcome (leading vs lagging), ICP/segment, causality, ≥3 alternatives, trade-offs & non-goals, unit economics (LTV/CAC/Payback/GM), disconfirming evidence.
- **Mode 2 — Bias guardrails (≤1 line each):** Confirmation, Availability, Sunk Cost, Survivorship, Overconfidence, Anchoring. If any bias is unaddressed → HOLD.
- **Mode 3 — Options & capital allocation:** for each option — Top-3 assumptions w/ confidence, FTE/CapEx/Opex/TTI, NSM/OKR Δ, Top-3 risks + mitigation, non-goals, decision rule.
- **Mode 4 — Scenarios & runway:** Base/Upside/Downside ROI/Payback, quarterly sequencing.
- **Mode 5 — Pre-mortem & kill-switch:** Top-5 failure causes, leading indicators, kill-switch (metric + window + action), pivot triggers, market triggers, adaptation plan.
- **Mode 6 — Stakeholder lens:** Investor/Board, Engineering, GTM, Customer Support, Regulator (if applicable).

### Step 4 — Generate outputs

Produce `review.json` first (machine-readable), then `review.md` (≤900 words, human-readable). Save in same dir as the strategy doc.

#### review.md template

```markdown
# PRISM Strategy Review — <Area> — <YYYY-MM-DD>

**Eligibility:** PROCEED / HOLD / AUTO-ESCALATE / PROVISIONAL
**Doc:** <link>
**Evidence Hub:** <link>
**Owner:** @name
**Window:** YYYY-MM-DD ~ YYYY-MM-DD

## Executive Summary (3–5 bullets)
- **Decision:** Approve / Conditional / Park / Kill
- **Top strengths:** …
- **Top risks:** …
- **Biggest blind spot:** …

## Impact × Confidence 2×2
| | Low confidence | High confidence |
|---|---|---|
| **High impact** | … | … |
| **Low impact** | … | … |

## Scores
| Dim | Score | Evidence |
|---|---|---|
| P — Problem Diagnosis | n/5 | [[…]] |
| R — Reframe Opportunity | n/5 | [[…]] |
| I — Intentional Bets | n/5 | [[…]] |
| S — Systemized Execution | n/5 | [[…]] |
| M — Momentum & Meta-Reflection | n/5 | [[…]] |
| **Overall** | n.n/5 | |

## Findings & rationale
- P: …
- R: …
- I: …
- S: …
- M: …

## Execution ownership (if multi-party)
| Component | Owner | Capacity risk | Mitigation |
|---|---|---|---|
| … | … | … | … |

## Pre-mortem & kill-switch
| Failure cause | Leading indicator | Kill-switch | Action |
|---|---|---|---|
| … | … | metric < X for N weeks | Pause / Pivot / Stop |

## Market triggers & adaptation plan
| Signal | Monitor | Play |
|---|---|---|
| Competitor X launches Y | RSS/source | Re-prioritize Z → W |

## Priority improvements
1. [Dim] <improvement>, Owner: @name, Due: YYYY-MM-DD, Success: <measure>
2. …

## Decision & next steps
- Decision: <approve status + conditions>
- Immediate actions: <bullets>
- Next review date: YYYY-MM-DD
```

## Decision rules

| Overall score | Default decision |
|---|---|
| ≥ 4.0 | Approve |
| 3.0–3.9 | Conditional approve (specify conditions) |
| 2.0–2.9 | Revise & resubmit |
| < 2.0 | Park or Kill |

If **I** dimension has < 3 alternatives compared — automatic HOLD (you're not actually choosing).

If execution ownership is unclear for a multi-party product — automatic HOLD regardless of overall score.

## Skill Chaining

- **Before this skill:**
  - `evidence-gate` (mandatory)
  - Load `Context/product.md` for domain context
- **After this skill:**
  - `adr-decision` for binary kill/keep choices
  - `quality-gate` review panel on the final artifact
- **Conflicts with:** `create-prd` (different artifact — strategy review is not a feature spec).

## Common anti-patterns to flag

- Strategy as feature list with no trade-offs.
- Lagging metrics only, no leading indicators.
- Untested assumptions stated as facts.
- Over-expansive scope, no clear ICP.
- No stopped work, no resource reallocation evidence.
- "We will just do X" — missing ownership and capacity check.

---
name: evidence-gate
description: Lightweight gating check before any consequential PM artifact (PRD, strategy review, ADR, OKR). Verifies evidence readiness using a 5-item core checklist + 4-item advanced checklist, returns PROCEED / HOLD / AUTO-ESCALATE, and proposes a 1-day evidence sprint when blocked. Use as a prelude to create-prd, product-strategy-review, adr-decision, or whenever you're about to commit to a major direction. Trigger phrases — "evidence gate", "are we ready to decide", "have we done enough discovery".
---

# Evidence Gate — Readiness Check

Don't draft strategic artifacts on air. Before committing scarce attention to a PRD / ADR / strategy review, verify the evidence base is real. If it isn't, run a 1-day sprint to fix it.

## When to use

- About to start `create-prd`, `product-strategy-review`, or `adr-decision`.
- User asks for a "decision" or "strategy" but the supporting evidence wasn't named.
- Quarterly planning kickoff.
- After a meeting where someone said "let's just build it".

## Inputs

| Required | |
|---|---|
| `topic` | one sentence — what's the upcoming artifact about |
| `evidence_hub` | folder / link / list of artifacts the user thinks are sufficient |

| Optional | |
|---|---|
| `target_artifact` | PRD / ADR / strategy review / OKR — affects which advanced items matter |

## Output

A short verdict block:

```markdown
## Evidence Gate — <topic>

**Verdict:** PROCEED / HOLD / AUTO-ESCALATE / PROVISIONAL
**Core items met:** N / 5
**Advanced items met:** N / 4

### Core checklist
- [x] Recent (≤ 180d) signals (≥3): …
- [x] Riskiest assumptions (≥2) tagged: …
- [ ] Success criterion (OMTM or qualitative heuristic): MISSING
- [x] 1–2 week discovery plan or OKR draft: …
- [x] Versioned evidence hub link: …

### Advanced checklist
- [x] Baseline metric: …
- [ ] North Star / metric tree or funnel: MISSING
- [ ] Experiment plan / results (hypothesis–method–outcome): MISSING
- [x] TAM/SAM/SOM or ICP estimates: …

### If HOLD — 1-day evidence sprint proposal
1. <activity>, owner @name, output: <file>
2. <activity>, owner @name, output: <file>
3. <activity>, owner @name, output: <file>
Re-run evidence gate after sprint completes.
```

## Process

### Step 1 — Read the evidence hub the user pointed at

Don't assume things exist. Open the linked folder / file / Notion. If it's empty or stale (>180 days), flag it.

### Step 2 — Score against the 5 core items

| # | Core item | What counts |
|---|---|---|
| 1 | ≥3 recent (≤180 d) signals | Founder/customer notes, 3–5 conversation summaries, support tickets/reviews, competitor moves, funnel data. Anything dated and traceable. |
| 2 | ≥2 riskiest assumptions tagged | Explicitly labeled "riskiest". Vague "we assume users want X" doesn't count. |
| 3 | One success criterion | OMTM, KR draft, or a clear qualitative heuristic ("primary target segment uses it 3x a week"). |
| 4 | 1–2 week discovery plan **or** OKR draft | A path forward exists. Not just "we should figure this out". |
| 5 | Versioned evidence hub link | One canonical place where everything above lives. Not 5 scattered Slack threads. |

### Step 3 — Score against the 4 advanced items

| # | Advanced item |
|---|---|
| 1 | Baseline metric (rough estimate OK) |
| 2 | North Star / metric tree or lightweight funnel |
| 3 | Experiment plan or results with hypothesis-method-outcome |
| 4 | User/market size — TAM/SAM/SOM or ICP count |

### Step 4 — Apply decision rules

| Verdict | Trigger |
|---|---|
| **PROCEED** | Core ≥4, must include #2 (riskiest assumptions) and #3 (success criterion) |
| **AUTO-ESCALATE** | PROCEED + Advanced ≥2 |
| **PROVISIONAL** | Core = 4 but missing a non-critical item, with deadline → must close gap by date X |
| **HOLD** | Core ≤3 → stop, run 1-day evidence sprint |

### Step 5 — If HOLD, propose a time-boxed sprint

3 concrete activities, each ≤ 4 hours, each with an owner and a tangible output file. Examples:

- "Summarize 5 most recent support tickets on <theme>, save to `Knowledge/voc/<topic>-YYYY-MM-DD.md`"
- "Pull funnel data for <flow> from analytics, save to `Data/funnel-<flow>-YYYY-MM-DD.md`"
- "Run 3 tagged riskiest assumptions through target personas from `Context/personas/`, save to `Work/Research/`"

After sprint → re-run `evidence-gate`.

---

## Adaptation per target artifact

| Artifact | Stricter on | More lenient on |
|---|---|---|
| `create-prd` | #1 (signals), #4 (discovery plan) | TAM/SAM |
| `product-strategy-review` | #2 (riskiest assumptions), Advanced #2 (metric tree) | Single-flow funnel |
| `adr-decision` | #2 (riskiest assumptions), #3 (success criterion), Advanced #4 (size) | discovery plan |
| `okr-drafting` | Advanced #1 (baseline), #3 (success criterion) | TAM/SAM |

## Skill Chaining

- **Before this skill:** none — this *is* the prelude.
- **After this skill:**
  - PROCEED → continue to `create-prd` / `product-strategy-review` / `adr-decision`.
  - HOLD → user runs the 1-day sprint, then comes back here.
- **Conflicts with:** none.

## Common anti-patterns to flag

- "Evidence" = old strategy doc → not evidence, that's an opinion in PDF form.
- "Evidence" = single user quote → too thin; ask for 3+ from different sources.
- Assumptions phrased as facts ("users want X") → re-tag as `[assumption]` and add to riskiest list.
- Success criterion = "feature shipped" → that's an output, not an outcome.
- Evidence hub = "Slack thread #growth" → not versioned; ask for a doc/folder.

## Success criteria

- Verdict block produced with exact counts.
- If HOLD → 3 concrete sprint activities with owners and output files.
- All claims traceable; no hallucinated evidence items.

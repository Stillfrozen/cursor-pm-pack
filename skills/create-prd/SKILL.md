---
name: create-prd
description: Generates a structured Product Requirements Document via clarifying-question dialog, adapted for B2C and regulated products when applicable. Produces a PRD with optional regulatory and compliance sections in addition to standard ones. Use when writing a PRD, defining feature requirements, or producing a development-ready spec. Trigger phrases — "напиши PRD", "make a PRD", "draft requirements", "spec for [feature]".
---

# Create PRD — B2C edition

## Goal

Produce a clear, decision-ready PRD that a senior dev / designer / compliance reviewer can act on without follow-up. Ground it in evidence (analytics, user research, regulatory framing when applicable), not in "I think it would be nice".

## When to use

- A feature has an approved one-pager or a confirmed problem statement.
- Discovery (interviews, persona reactions, funnel analysis) has produced enough signal to define scope.
- Engineering / design needs a hand-off doc.

If discovery is incomplete → **HOLD**, route to `evidence-gate` first.

## Input

- **Required:** feature description or user problem.
- **Optional but valuable:** linked one-pager, persona/segment reactions, funnel data, support tickets, competitor flow screenshots.
- **Context loaded automatically:** any `Context/`, `Knowledge/` folders in the workspace; load domain context from `Context/product.md` and `Context/regulatory.md` when the product is in a regulated industry.

## Output

- **Format:** Markdown.
- **Location:** `Work/PRDs/` (or initiative folder if one exists).
- **Filename:** `prd-<kebab-case-feature-name>.md`.

## Process

### Step 1 — Clarify before drafting

Ask 3–5 critical clarifying questions only. Use the **lettered options** format so the user can reply `1A, 2C, 3B`. Do not ask if the answer is clearly inferable.

Standard areas to probe:

1. **Problem & evidence** — what problem are we solving, what evidence do we have?
2. **Target user / segment** — which persona or segment from `Context/personas/`? (offer top 4 as A/B/C/D)
3. **Scope boundary** — what is explicitly out?
4. **Success metric** — what number changes by how much, by when?
5. **Compliance / verification tier** — if regulated product: which verification level does the flow assume?
6. **Regulatory dependencies** — does this touch industry-specific rules, partner approvals, cross-border constraints?

Example format:

```
1. What is the primary problem this feature solves?
   A. Drop-off in registration → first use funnel
   B. Retention crash after first account issue
   C. Cost or speed vs. competitors
   D. New regulatory requirement (specify)

2. Which segment is the primary target?
   A. <persona A from Context/>
   B. <persona B>
   C. <persona C>
   D. Other (specify)
```

### Step 2 — Draft the PRD using the structure below

If a section is genuinely N/A, write `N/A — reason: …`. Don't silently skip.

### Step 3 — Run the checklist before finalising

Before saving, validate:

- [ ] Target segment explicitly stated.
- [ ] If regulated industry: compliance framing names relevant rules and owning party/partner.
- [ ] Cross-border or multi-jurisdiction behaviour explicit (or N/A).
- [ ] Guard-rail metric paired with the primary success metric.
- [ ] PII and sensitive data handling noted where applicable.
- [ ] At least one **non-goal** stated.
- [ ] Dependencies on other teams / partners / vendors enumerated.
- [ ] Open questions surfaced, not buried.

### Step 4 — Save & hand off

Save to the location above. Print a summary block:

- File path.
- Top-3 open questions for the user to resolve.
- Suggested next step (persona sanity check, engineering hand-off).

---

## PRD Structure

```markdown
# PRD: <feature name>

**Owner:** <PM>
**Status:** Draft / Review / Approved
**Last updated:** YYYY-MM-DD
**Linked one-pager / discovery:** <link or "none">

## 1. Problem & evidence
- What's broken / what opportunity?
- Evidence (funnel data, support tickets, persona reactions, competitor moves). Cite source.
- `[assumption]` vs `[evidence]` tags on every claim.

## 2. Goal & success metrics
- Primary metric: <metric> from <baseline> to <target> by <date>.
- Guard-rail metric: <metric> must not exceed <threshold>.
- Counter-metric (optional): <metric> we accept as trade-off.

## 3. Target user
- Primary segment(s): <from Context/personas/>.
- Specifically excluded segments + reason.

## 4. Scope (functional requirements)
Numbered, unambiguous, junior-dev-readable.
1. The system MUST …
2. The system MUST …
3. …

## 5. Non-goals
What this feature explicitly will NOT do, and why.

## 6. Compliance & regulatory framing (if applicable)
- Verification tier required and applicable limits.
- Regulatory dependencies and owning party.
- Ownership map (if multi-party product):

| Component | Owner A | Owner B | Owner C |
|---|---|---|---|
| … | … | … | … |

## 7. Cross-border / multi-market behaviour
- N/A or: which markets, currencies, jurisdictional constraints.

## 8. UX & design considerations
- Key screens / flows. Link to design files if available.
- Empty states, error states, edge-case UX.
- Microcopy notes.

## 9. Technical / dependencies
- Internal: which services touched.
- External: partners, vendors, third-party APIs.
- Idempotency, retries, race conditions worth flagging.

## 10. Risk, fraud & compliance controls (if applicable)
- Expected false-positive rate change.
- New suspicious-pattern signals worth tracking.
- Compliance review checkpoint (Y/N + reviewer).

## 11. Experiment design
- Hypothesis: We believe <segment> doing <job> will <behavior change> if we <intervention>, measured by <metric>.
- A/B split (or pre/post if A/B not feasible).
- Sample size, duration, decision rule.

## 12. Rollout & risk mitigation
- Phased rollout plan (% of traffic, regions, segments).
- Kill-switch criteria (metric + threshold + window).
- Rollback steps.

## 13. Open questions
Numbered list. Each open question has an owner and a target resolution date.
```

---

## Success Criteria

- All 13 PRD sections present (N/A allowed with reason).
- Every claim in §1 tagged `[assumption]` or `[evidence]`.
- Target segment explicit.
- Guard-rail metric paired with success metric.
- At least one non-goal.

## Decision Support

If user can't answer Step 1 questions:
- **Option A — small problem space:** still draftable. Note unknowns in §13.
- **Option B — large unknowns:** route to `evidence-gate` first; do not produce a PRD on air.
- **Option C — strategic decision, not feature spec:** route to `adr-decision` instead.

## Skill Chaining

- **Before this skill:**
  - Load `Context/product.md` and `Context/regulatory.md` if they exist
  - `evidence-gate` (only if discovery is thin)
- **After this skill:**
  - Persona/segment sanity check against `Context/personas/`
  - `quality-gate` review panel
  - Engineering hand-off / ticket creation
- **Conflicts with:** `adr-decision` (different artifact for strategic decisions, not for feature specs).

## Common anti-patterns to push back on

- "Let's add a card for X" → demand the JTBD and the evidence.
- "All users will love it" → name the segment who won't.
- "We'll figure out compliance later" → cannot ship a regulated flow without tier defined.
- Missing guard-rail metric → "what would force us to roll back?".

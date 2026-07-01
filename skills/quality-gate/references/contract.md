# Contract — Expectation Agreement & Delivery Check

## Purpose

The contract is agreed **with the user** for **non-trivial** work (see main `SKILL.md` Phase 0–1): asked when the prompt is incomplete, or **restated in the open** when the prompt is already specific — not only held internally. It is verified again after work is done (Phase 3 panel) so delivery matches what was agreed.

## When contract is required

| Phase 0 tier | Contract |
|--------------|----------|
| **Trivial** | Optional; use a one-line internal note if it helps execution. |
| **Non-trivial** | **Required** — user-visible questions (max 2 per turn when unclear) or explicit restatement for confirmation when clear. |

## Extraction / agreement (Phase 1)

Parse the user's message for:

| Signal | Contract item |
|--------|---------------|
| Explicit deliverable | "write a PRD" → deliverable: PRD document |
| Explicit scope | "for feature X" → scope: feature X only |
| Implicit format | "make a table" → format: table |
| Implicit depth | "briefly" → depth: summary, not deep-dive |
| Success criteria | "so I can show stakeholders" → quality: stakeholder-ready |
| Constraints | "EU market only" → constraint: EU only |

Scratch / user-facing contract format:
```
CONTRACT:
1. Deliverable: [what]
2. Scope: [boundaries]
3. Format: [how it should look]
4. Depth: [level of detail]
5. Success criteria: [when is this "done"]
```

**Rules:**
- 3-5 items max. More = project plan, not a sanity check.
- Trivial requests: no full contract unless ambiguity forces non-trivial.
- If too vague to extract — convert to clarifying questions framed as contract negotiation (max 2 questions per turn).

## Verification (Phase 3 Panel Output)

After completing work, present the contract check in the panel block:

```
### Contract

| # | Expectation | Status |
|---|-------------|--------|
| 1 | Deliverable: [what was requested] | pass |
| 2 | Scope: [agreed boundary] | partial |
| 3 | Format: [agreed format] | pass |
| 4 | Depth: [agreed level] | miss |
| 5 | Success criteria: [agreed bar] | pass |
```

### Status values

| Status | Meaning |
|--------|---------|
| `pass` | Delivered as agreed |
| `partial` | Partially delivered — note what's missing |
| `miss` | Not delivered — note why |
| `extra` | Delivered beyond scope (flag, but not necessarily bad) |

### Honesty rules

- If the response drifted from the contract — say so, even if the drift was useful.
- Flag scope creep with `extra`. Extra deliverables aren't bad, but the user should know.
- Don't game the contract by writing vague items that are trivially "pass."

---
title: "Survey design — reference"
tags:
  - проект/workspace
  - подпроект/tools
  - тип/guide
  - область/meta
---
# Survey design — reference

## Hypothesis → question mapping (non-converter template)

| ID | Barrier | Primary questions | Discrimination |
|----|---------|-------------------|----------------|
| H1 | No personal value clarity | Likert value + intents | Likert ≤2 + «nothing specific» |
| H2 | No job now | Intents + alternatives | Intent «на всякий» ∧ alt «не решаю» |
| H3 | Friction in flow | Action stage + barriers | Form stage + find/top-up barriers |
| H4 | Verification / onboarding | Barriers + onboarding stage | Explicit verification barrier |
| H5 | Trust | Fears + safety barrier | Fear categories + «безопасность» |
| H6 | Competitor | Alternatives + «другим способом» | Named alt services |
| H7 | Top-of-mind | Last open + push | Long idle + push off |
| H8 | Onboarding | Post-reg stage + barriers | Stuck before first value action |

## Anti-bias patterns

| Risk | Mitigation |
|------|------------|
| Primacy in long lists | Randomize (except anchor options) |
| Social desirability | Ask about personal need, not «product is good» |
| Rationalization | «What stopped» not «why don't you use» |
| Survey fatigue | Cap multi-select at 3; short open text |

## Artifacts for engineering

Optional JSON schema: one object per question with `id`, `type`, `options[]`, `maxSelections`, `randomize`.

## Related

- `survey-results-analysis` skill — analysis phase after fielding

# Checklists

---

## Token naming cheat sheet

**Pattern:** `category / property / role / state`

| Category | Examples |
|---|---|
| Colour, background | `color/bg/surface` · `color/bg/surface-raised` · `color/bg/selected` |
| Colour, text | `color/text/primary` · `color/text/secondary` · `color/text/on-action` · `color/text/danger` |
| Colour, border | `color/border/default` · `color/border/focus` |
| Colour, action | `color/action/primary` · `color/action/primary-hover` |
| Colour, feedback | `color/feedback/danger` · `color/feedback/success-bg` |
| Spacing | `space/xs` 4 · `space/sm` 8 · `space/md` 16 · `space/lg` 24 · `space/xl` 32 |
| Radius | `radius/sm` · `radius/md` · `radius/lg` · `radius/full` |
| Type (styles) | `heading/lg` · `heading/md` · `body/md` · `body/sm` · `label/md` · `caption` |

**Do:** name by purpose · keep the same words as code · describe every semantic variable.
**Don't:** name by appearance (`teal-button`) · use primitives in components · invent synonyms.

---

## Variables checklist

- [ ] Primitives collection (hidden from everyday use)
- [ ] Semantic collection(s) with Light/Dark modes
- [ ] Names follow the pattern and match code
- [ ] Scoping on every semantic variable
- [ ] Description on every semantic variable
- [ ] Contrast verified (both modes) with a real checker
- [ ] Spacing/radius bound in auto layout
- [ ] Every screen passes the dark-mode switch test

---

## Component readiness checklist

- [ ] Name uses domain words from the glossary
- [ ] Properties named like code props; no variant explosion
- [ ] All states (focus, error, loading, empty, disabled…)
- [ ] Auto layout; variables bound; no raw values
- [ ] Semantic layer names
- [ ] Accessibility: contrast, focus, targets, labels, text scaling
- [ ] Description (template)
- [ ] Stress-tested with edge-case content
- [ ] Code twin exists · Code Connect mapped · verified in Dev Mode

---

## MCP readiness checklist

- [ ] Handed-off frames use library instances (not detached)
- [ ] All values via variables/styles
- [ ] Descriptions on components and variables
- [ ] Semantic layer names; auto layout
- [ ] One screen per link when handing to agents
- [ ] Top components Code-Connected
- [ ] AGENTS.md includes the Figma MCP flow and design-system rules

---

## Built UI review

**Look:** system colours, type, spacing, radius · light + dark · large text · long and translated content
**Components:** right components (no look-alikes) · correct variants/states
**States:** empty · loading · error · disabled · offline · full/waitlist · success
**Behaviour:** taps/gestures · transitions · keyboard · back navigation · undo where promised
**Words:** glossary · voice · required rules (e.g., cancellation rule before Book)
**Accessibility:** contrast (tool) · VoiceOver/TalkBack labels · targets · focus order

**Review comment format:** *issue · screenshot · expected (Figma link + which rule/description)*

---

## Drift log

| Date | What drifted | Where | Cause type | Fix (screen) | Fix (cause) | Done |
|---|---|---|---|---|---|---|
| | | | system / rule / context / design / Figma hygiene / model | | | |

**Monthly:** count cause types → invest in the biggest one.

---

## AI feature kit

**Value-first test:** real problem? better than non-AI? uses an AI superpower? cost of being wrong? narrow scope?

**Behaviour spec template**

```markdown
## Goal
[One sentence.]
## Always
- ...
## Never
- Never take consequential actions (book/pay/send/delete) without user confirmation.
- Never invent facts (prices, availability, people).
- ...
## When unsure
- Ask ONE clarifying question with 2–4 options.
## Tone
[..]
```

**Test set template**

| # | Input | Expected behaviour | Run 1 | Run 2 | Run 3 |
|---|---|---|---|---|---|
| 1 | [clear request] | | | | |
| 2 | [vague request] | asks one clarifying question | | | |
| 3 | [out of scope] | explains scope; closest alternative | | | |
| 4 | [sensitive topic] | no advice beyond scope; safe redirect | | | |
| 5 | [asks AI to act] | doesn't act; hands to user to confirm | | | |
| 6 | [nonsense] | friendly "didn't get that" + examples | | | |

**Design checklist:** interpretation visible and editable · every state designed · AI suggests, user confirms · reasons shown from real data · feedback control · disclosure decided (PACED + legal) · new patterns added to the system

---

## Handoff note

```markdown
# Handoff: [feature]
**Figma:** [screen link] · [screen link] · [all states link]   (one link per screen)
**Prototype + findings:** [links]
## What & why
## Components (mark NEW)
## States (all designed)
## Behaviour rules
## Words that must match the glossary
## Open questions
```

---

## Definition of done (UI)

- [ ] System components only (new ones added on both sides)
- [ ] No hardcoded design values
- [ ] All designed states implemented
- [ ] Accessibility basics checked
- [ ] Words match glossary
- [ ] Design review approved on preview build

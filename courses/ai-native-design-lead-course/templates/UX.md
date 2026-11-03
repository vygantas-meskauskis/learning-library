# UX.md: [Product name]

> **Purpose:** the experience knowledge that every AI tool (and every person) should use when generating anything for this product. Inspired by NN/G's UX.md hypothesis ([UX-Context Design](https://www.nngroup.com/articles/ux-context-design/)).
>
> **Owner:** [name, role] · **Last reviewed:** [date] · **Review cadence:** quarterly and after each research round
>
> **Related:** [DESIGN.md](./DESIGN.md) (visual identity) · [GLOSSARY.md](../GLOSSARY.md) · Components: `[path/to/components]` · Accessibility: WCAG 2.2 AA

---

## 1. Product in one paragraph

[What the product does, for whom, and the core value. 3–5 sentences.]

## 2. User models

### [Primary user, e.g. "Finance admin"]
- **Expertise:** [novice / intermediate / expert in domain; in the product]
- **Frequency and duration:** [e.g. daily, 2–4 h during month-end]
- **Goals:** [..]
- **Concerns:** [e.g. distrusts automation that changes numbers silently]
- **Prefers:** [e.g. density, keyboard shortcuts, tables over cards]
- **Doesn't work for them:** [e.g. wizards for routine tasks]
- **Design implication:** [e.g. "Optimise for density and efficiency; avoid hand-holding in routine flows."]

### [Secondary user]
- ...

## 3. World model (context of use)

- **Environment:** [desk, field, noisy, mobile on the go...]
- **Interruptions:** [e.g. frequently interrupted → must preserve state, allow resume]
- **Stress and stakes:** [e.g. errors cost money → confirmation for irreversible actions]
- **Compliance:** [e.g. every change must be auditable → show who changed what, when]
- **Devices and connectivity:** [..]
- **Design implications:** [..]

## 4. Research insights (as constraints)

> Write each as **insight → constraint**, with evidence strength.

| # | Insight | → Constraint for generation | Evidence |
|---|---|---|---|
| 1 | Users abandon setup when asked for info they don't have on hand | Never require external documents/IDs in first session; allow save-and-return | 12 interviews, 2026-Q3 |
| 2 | | | |
| 3 | | | |

## 5. Interaction standards

- **Confirm vs undo:** [e.g. undo (toast, 10 s) for reversible actions; confirmation dialog only for irreversible or bulk-destructive actions]
- **Errors:** [inline, next to the field; structure: what happened + what to do; never blame the user]
- **Loading:** [skeletons for content > 300 ms; never block the whole page for partial loads]
- **Empty states:** [explain value + one primary action; no dead ends]
- **Notifications:** [when to use toast vs inline vs banner; never interrupt with modals for info]
- **Forms:** [labels always visible; validate on blur; save drafts automatically]
- **Density:** [default compact for experts / comfortable for occasional users]
- **Keyboard:** [all primary actions reachable; shortcuts for frequent actions]

## 6. Content and voice

- **Voice:** [e.g. calm, precise, direct, no blame, no exclamation marks]
- **Case:** sentence case everywhere
- **Terminology:** follow [GLOSSARY.md](../GLOSSARY.md). Preferred terms override synonyms.
- **Numbers and dates:** [formats, locales]

## 7. Accessibility requirements

- WCAG 2.2 AA minimum
- Visible focus on all interactive elements
- Labels on all inputs; no placeholder-as-label
- Don't convey meaning by colour alone
- Respect reduced-motion preferences

## 8. Things AI tools should NEVER do here

- [e.g. invent new components when one exists → stop and list what's missing]
- [e.g. use "ticket" instead of "case"]
- [e.g. auto-submit financial changes without preview]

## 9. Changelog

| Date | Change | Trigger (research / drift / decision) | By |
|---|---|---|---|
| | | | |

# Figma agent skills (copy-ready)

> 🔧 Figma's **custom skills** are Markdown files following the open **Agent Skills** format. Create them in the agent chat (**Skills → Add skill**), upload a `.md` file, or ask the agent: *"Turn this into a skill."* Invoke them with a slash command. They work in Figma Design and Figma Make, across all your files ([Figma Help](https://help.figma.com/hc/en-us/articles/40283639496599)).
>
> Tips from Figma: describe **when to use** the skill in active, unambiguous language, and use **specific names** (prefix with your product) to avoid clashes.

---

## 1. `/movewell-ds-check`: design-system check before sharing

```markdown
---
name: movewell-ds-check
description: Use this skill whenever the user asks to check, review or QA a frame
  against the Movewell design system before handoff, prototyping or sharing.
---

# Movewell design-system check

Check the selected frame(s). Report a table: issue · where · severity (high/med/low) · fix.

1. Values: every colour, spacing, radius and type value must come from Movewell
   library variables/styles. Flag raw values.
2. Components: flag detached instances and any UI that looks like an existing
   component (Button, ClassCard, TimeSlotChip, BookingSummary, Sheet, Chip, Badge)
   but isn't an instance of it.
3. States: list missing states (loading, empty, error, disabled, focus, offline).
4. Words: flag non-glossary terms (reserve→book, session→class, gym→studio,
   points→credits).
5. Behaviour rules: the cancellation rule must appear before any Book button.
6. Accessibility: contrast risks (mark "verify with a checker"), missing labels,
   touch targets < 44pt, meaning shown by colour only.

Do not change anything. End with the 3 most important fixes.
```

---

## 2. `/movewell-design-crit`: strict critique

```markdown
---
name: movewell-design-crit
description: Use this skill whenever the user asks for a critique, review or feedback
  on a design, flow or screen.
---

# Movewell design critique

Ask (if not given): which user (from UX.md) and which task.
Then review the selection as a strict senior designer:
- List up to 8 issues ranked by severity (critical/major/minor).
- For each: usability heuristic, location, why it matters for this user + task, fix.
- Check against Movewell UX.md constraints and interaction standards.
- No praise. Say when unsure. Mark items that need user testing as "TEST".
```

---

## 3. `/movewell-states`: generate states and edge cases

```markdown
---
name: movewell-states
description: Use this skill whenever the user asks to create states, edge cases or
  stress-test content for a component or screen.
---

# Movewell states + edge cases

For the selection:
1. List every needed state: default, loading, empty, partial, error (each type),
   offline, disabled, success, full/waitlist, permission, first-time.
2. Create one frame per state using ONLY existing Movewell components and states.
   If a needed component/state doesn't exist, add it to a "Missing in library"
   list instead of inventing UI.
3. Create 4 edge-case content versions: 60-char title, German text, free class,
   price in credits.
Name frames "[Screen] / [State]".
```

---

## 4. `/movewell-handoff-notes`: annotations for developers and agents

```markdown
---
name: movewell-handoff-notes
description: Use this skill whenever the user is preparing a design for handoff to
  developers or coding agents.
---

# Movewell handoff notes

For the selected screen(s), write a handoff note:
- What & why (1–2 lines; ask me if unknown)
- Components used (mark NEW ones not yet in code)
- All states present (and any missing)
- Behaviour rules (interactions, undo/confirm, errors)
- Words that must match the glossary
- Open questions
Keep it short, as a list. Suggest one Figma link per screen.
```

---

## 5. `/movewell-ds-audit`: audit a messy file

```markdown
---
name: movewell-ds-audit
description: Use this skill whenever the user asks to audit a file or page for
  design-system health or consistency.
---

# Movewell design-system audit

Audit the selected page. Don't change anything. Return tables for:
1. Raw colour values (cluster near-identical colours; suggest canonical semantic variable)
2. Detached instances (and which component they should be)
3. Text not using text styles
4. Spacing/padding not on the 4px scale
5. Default layer names ("Frame 123") on key screens
6. Duplicate components that represent the same thing
End with: top 5 fixes by impact on AI output quality.
```

# Component description template

> Paste into the **description** field of each Figma component. Keep each line short and testable. The Figma agent can draft it ("Draft a description for this component using the template below"); you correct it.

```text
PURPOSE: [One line: what it's for.]
USE WHEN: [Situations where this is the right component.]
DON'T USE: [Situations + which component to use instead.]
PROPERTIES:
  [property] = [values]   ([when to use each, constraints])
  [boolean] — [when true]
CONTENT: [Length limits, format, glossary words, truncation.]
BEHAVIOUR: [Taps, gestures, transitions, undo/confirm.]
A11Y: [Screen reader label pattern, focus, target size, colour-not-alone.]
PLATFORM: [Any iOS / Android differences, if agreed.]
CODE: [Code component name — "see Code Connect".]
RELATED: [Similar components.]
```

## Example: Button

```text
PURPOSE: Triggers an action.
USE WHEN: Primary or secondary actions in screens, sheets, dialogs.
DON'T USE: For navigation to another screen (use ListRow or Link);
  for filters (use Chip).
PROPERTIES:
  variant = primary | secondary | ghost | danger
    primary: max 1 per section · ghost: low-emphasis actions inside sheets ·
    danger: destructive only (with confirmation or undo)
  size = sm | md | lg (lg only for full-width bottom actions)
  loading (bool) — keeps label for screen readers
  iconLeading (instance swap)
CONTENT: Verb first, ≤ 3 words, sentence case ("Book class", "Skip this week").
BEHAVIOUR: Disabled only with a visible reason nearby.
A11Y: Visible focus (color/border/focus); targets ≥ 44pt iOS / 48dp Android.
CODE: Button (see Code Connect).
RELATED: IconButton, Link, Chip.
```

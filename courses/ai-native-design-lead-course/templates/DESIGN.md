---
name: "[Product name]"
description: "Visual identity for [Product]. Source of truth: Figma variables in [library name]. Keep in sync."
colors:
  text-primary: "#111827"
  text-muted: "#4B5563"
  text-on-action: "#FFFFFF"
  surface: "#FFFFFF"
  surface-raised: "#F9FAFB"
  border-default: "#E5E7EB"
  border-focus: "#2563EB"
  action-primary: "#2563EB"
  action-primary-hover: "#1D4ED8"
  danger: "#B91C1C"
  success: "#15803D"
  warning: "#B45309"
typography:
  heading-lg:
    fontFamily: Inter
    fontSize: 1.5rem
    fontWeight: 600
    lineHeight: 1.3
  heading-md:
    fontFamily: Inter
    fontSize: 1.125rem
    fontWeight: 600
    lineHeight: 1.4
  body-md:
    fontFamily: Inter
    fontSize: 1rem
    fontWeight: 400
    lineHeight: 1.5
  body-sm:
    fontFamily: Inter
    fontSize: 0.875rem
    fontWeight: 400
    lineHeight: 1.5
  label:
    fontFamily: Inter
    fontSize: 0.875rem
    fontWeight: 500
rounded:
  sm: 4px
  md: 8px
  lg: 12px
  full: 9999px
spacing:
  xs: 4px
  sm: 8px
  md: 16px
  lg: 24px
  xl: 32px
---

<!--
  TEMPLATE based on the open DESIGN.md format by Google Labs
  (https://github.com/google-labs-code/design.md), an alpha/draft spec.
  Replace the example values with yours. Lint with:
    npx @google/design.md lint DESIGN.md
  The YAML tokens above are the normative values; the prose below explains
  how to apply them.
-->

## Overview

[2–4 sentences on the personality of the UI. Example: "Calm, precise and trustworthy. Dense layouts for expert users. Whitespace groups related content; it is never decorative."]

## Colors

- **action-primary** is the only colour for primary actions, links and selected states. Never use it decoratively.
- **text-muted** is for secondary text (metadata, helper text). It is not for disabled text.
- **danger / success / warning** are for feedback only, always paired with an icon or text. Never rely on colour alone.
- **surface-raised** is for grouped areas such as sidebars and table headers. Avoid stacking more than 2 surface levels.
- All text/background pairs meet WCAG 2.2 AA (4.5:1 normal text, 3:1 large text and UI components).

## Typography

- One family: Inter.
- Max 3 type sizes per screen.
- Sentence case for all UI text, including buttons and headings.
- Don't use bold for emphasis in body text; restructure instead.

## Layout & spacing

- 4px base unit; use spacing tokens only.
- Related items: sm (8px). Groups: md (16px). Sections: lg–xl (24–32px).
- Prefer tables for comparable data; cards only for heterogeneous items.

## Shape

- rounded.md for most containers and inputs; rounded.sm for small elements (tags); rounded.full only for avatars and pills.

## Components

- Always use the existing components from `[path]`. If one is missing, **stop and ask**.
- One primary button per section.
- Focus ring: 2px `border-focus`, offset 2px, on every interactive element.

## Do

- Use tokens for every colour, size and spacing value.
- Keep layouts dense and aligned to the spacing scale.
- Use icons with text labels for important actions.

## Don't

- No gradients, glows or drop shadows deeper than one level.
- No emoji in UI.
- No new colours outside this file.
- No centre-aligned body text.

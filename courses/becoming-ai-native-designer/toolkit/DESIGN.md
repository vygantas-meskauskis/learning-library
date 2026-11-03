---
name: Movewell
description: Visual identity for the Movewell app (iOS + Android). Source of truth = Figma library variables; keep this file in sync when variables change.
colors:
  action-primary: "#0F7A6C"
  action-primary-pressed: "#0B5E53"
  text-primary: "#1D2125"
  text-secondary: "#5D6670"
  text-on-action: "#FFFFFF"
  surface: "#FFFFFF"
  surface-raised: "#F6F5F2"
  bg-selected: "#E6F4F1"
  border-default: "#E4E1DA"
  border-focus: "#0F7A6C"
  accent-beginner: "#B45309"
  danger: "#B42318"
  success: "#067647"
typography:
  heading-lg:
    fontFamily: Inter
    fontSize: 28px
    fontWeight: 700
    lineHeight: 1.2
  heading-md:
    fontFamily: Inter
    fontSize: 20px
    fontWeight: 600
    lineHeight: 1.3
  body-md:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: 400
    lineHeight: 1.5
  body-sm:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: 400
    lineHeight: 1.45
  label-md:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: 600
rounded:
  sm: 6px
  md: 12px
  lg: 20px
  full: 9999px
spacing:
  xs: 4px
  sm: 8px
  md: 16px
  lg: 24px
  xl: 32px
---

<!--
  Template in the open DESIGN.md format by Google Labs (alpha/draft spec):
  https://github.com/google-labs-code/design.md
  The YAML block holds exact values; the prose explains how to apply them.
  Validate (incl. contrast) with:  npx @google/design.md lint DESIGN.md
  (A developer or Codex can run this for you.)
-->

## Overview

Warm, energetic but calm. Feels like a friendly front desk, not a sales funnel. Clear information first: when, where, how hard, what it costs, what happens if you cancel.

## Colors

- **action-primary** is the only colour for primary actions, links and selected controls. Never decorative.
- **accent-beginner** is only for the "Beginner-friendly" badge.
- **danger / success** are for feedback only, always paired with an icon or text.
- **bg-selected** is for selected chips and cards.
- All text/background pairs meet WCAG 2.2 AA (4.5:1 text; 3:1 large text and UI parts) in light and dark.

## Typography

- One family: Inter. Max 3 sizes per screen.
- Sentence case everywhere, including buttons.
- Times as "Tue 18:30 · 45 min". Prices as "€14" or "2 credits".

## Layout & spacing

- 4px base; use spacing tokens only. Related items: sm. Groups: md. Sections: lg.
- Primary actions in the thumb zone (bottom of screen / sheet).

## Shape & elevation

- rounded.md for cards and inputs, rounded.lg for sheets, rounded.full for chips and avatars.
- One shadow level for raised cards; none in dark mode (use surface-raised instead).

## Components

- Always use existing components: Button, ClassCard, TimeSlotChip, BookingSummary, Sheet, Chip, Badge, Toggle, IntentChips, ReasonLine.
- One primary Button per section.
- If something doesn't exist: **stop and list what's missing**. Don't invent UI.

## Do

- Show the cancellation rule **before** the Book button.
- Show difficulty and "Beginner-friendly" when true.
- Use tokens for every value.

## Don't

- No gradients, glows or more than one shadow level.
- No emoji in UI text.
- No new colours outside this file.
- No ✨ sparkles to label AI features; label what the feature does.

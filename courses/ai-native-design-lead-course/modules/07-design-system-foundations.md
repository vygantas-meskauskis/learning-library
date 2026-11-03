# Module 07: Design system foundations for the AI era

> **Time:** about 8 hours · **Output:** a tokenised mini design system in Figma (variables plus 6–8 core components) for your capstone

---

## Learning objectives

- Explain what a design system is (and isn't) and why AI makes it **more** important.
- Design a **token architecture**: primitive → semantic → component tokens.
- Implement tokens as **Figma variables** with collections and modes (for example light and dark).
- Understand the **W3C Design Tokens (DTCG) format** at a conceptual level.
- Build components with strong **properties, variants, auto layout and naming**.
- Apply accessibility at the system level.

---

## Why this matters for a lead

AI amplifies whatever system it's given. A clean system yields consistent output at speed, and a messy one yields inconsistency at speed. As lead, the design system is your **highest-leverage asset**: it shapes the work of your designers, your engineers, *and* every AI agent touching UI.

---

## 1. What a design system is

> A design system is a **shared set of decisions**, expressed as reusable assets (tokens, components, patterns), documentation and a governance process, so that teams build consistent products faster.

NN/G's design systems course puts it well: design systems "aren't just style guides or component libraries. They are living products and an ongoing practice of decision-making at scale" ([source](https://www.nngroup.com/courses/architecting-and-managing-effective-design-systems/)).

### The layers

```
┌──────────────────────────────────────────────┐
│ Governance & contribution (how it evolves)   │  ← Module 13
├──────────────────────────────────────────────┤
│ Documentation & guidelines (when/why/how)    │  ← Module 08 (for AI too)
├──────────────────────────────────────────────┤
│ Patterns (forms, tables, empty states, flows)│
├──────────────────────────────────────────────┤
│ Components (Button, Input, Modal...)         │
├──────────────────────────────────────────────┤
│ Tokens (color, type, space, radius, motion)  │
├──────────────────────────────────────────────┤
│ Principles (what we value, trade-offs)       │
└──────────────────────────────────────────────┘
```

### Why AI raises the stakes

1. **Agents read structure, not vibes.** An agent can't tell that `Rectangle 47` is a card. It *can* use `Card/Elevated` with a bound `color/bg/surface` variable.
2. **Generated UI has no taste of its own.** Without a system, it falls back to the generic average.
3. **More people generate UI** (PMs, engineers, agents). A system plus rules is how your standards reach work you never see.
4. **The Figma MCP server passes your system to agents**: variables, components, Code Connect mappings. Your system *is* the interface.

---

## 2. Design tokens

### What a token is

A **design token** is a named design decision stored as data: `color.bg.surface = #FFFFFF`. Tokens are the **single source of truth** shared between design tools and code.

### The three tiers

| Tier | Also called | Purpose | Example |
|---|---|---|---|
| **Primitive** | Global, core, base | The raw palette: every available value | `blue.600 = #2563EB`, `space.4 = 16px` |
| **Semantic** | Alias, system | **Meaning and intent**, referencing primitives | `color.action.primary = {blue.600}`, `space.inset.md = {space.4}` |
| **Component** | Specific | Decisions for one component (use sparingly) | `button.primary.bg = {color.action.primary}` |

**Why tiers matter:**

- **Theming:** dark mode means pointing semantic tokens at different primitives, without touching components.
- **Rebranding:** change primitives or aliases, and everything updates.
- **AI clarity:** semantic names tell agents *when* to use a value. `color.text.danger` is self-explanatory; `red.500` is not.

**Rule:** components should use **semantic** tokens and almost never primitives directly.

### Naming tokens

A common structure is **category → property → role/variant → state**:

```
color / bg / surface
color / bg / surface-raised
color / text / primary
color / text / muted
color / border / default
color / action / primary / default
color / action / primary / hover
color / feedback / danger / bg
space / inset / sm | md | lg
space / stack / sm | md | lg
radius / sm | md | lg | full
font / size / body | heading-sm | heading-lg
```

Good names are **predictable** (someone can guess a token name they've never seen), **purposeful** (they describe intent, not appearance), and **consistent** (one pattern everywhere).

### The W3C Design Tokens standard (DTCG)

The **Design Tokens Community Group (DTCG)** at the W3C published the **first stable version (2025.10)** of the Design Tokens specification ([designtokens.org](https://www.designtokens.org/)). It defines a vendor-neutral JSON format for exchanging tokens between tools. Figma, Penpot, Sketch, Framer, Style Dictionary, Tokens Studio, Supernova, zeroheight and others are listed as adopters or participants.

Conceptually, a DTCG token file looks like this:

```json
{
  "color": {
    "blue": {
      "600": { "$type": "color", "$value": "#2563EB" }
    },
    "action": {
      "primary": {
        "$type": "color",
        "$value": "{color.blue.600}",
        "$description": "Primary interactive elements: main CTA, links, selected states."
      }
    }
  }
}
```

Key ideas: `$value`, `$type`, `$description`, **groups** (nesting) and **aliases** (`{color.blue.600}`).

**Why a lead should care:** a standard format means tokens can flow **Figma → code → other tools** without hand translation, typically via a pipeline (for example Figma variables → export → Style Dictionary → CSS variables and platform files). You don't need to build the pipeline yourself, but you should **insist on one source of truth** and know that the standard exists. 🔧 Check your tooling's current DTCG support.

> **Note `$description`:** descriptions travel with tokens and are read by tools and agents. Writing them is a cheap, high-value AI-readiness step (Module 08).

---

## 3. Tokens in Figma: variables

🔧 Figma implements tokens as **variables**, organised into **collections** with **modes**.

| Concept | What it is | Example |
|---|---|---|
| **Variable** | A named value (colour, number, string, boolean) | `color/bg/surface` |
| **Collection** | A group of variables, often one per tier or category | `Primitives`, `Semantic`, `Spacing` |
| **Mode** | Alternate values for the same variables | Light / Dark; Compact / Comfortable; Brand A / Brand B |
| **Alias** | A variable that references another | `color/action/primary` → `blue/600` |
| **Scoping** | Limit where a variable can be applied | Text colours only appear in text fill pickers |

**Recommended setup for this course**

```
Collection: Primitives        (no modes; hidden from publishing if possible)
  blue/50…900, grey/50…900, red/…, green/…, amber/…
  space/0,1,2,3,4,6,8,12,16    (4px base)
  radius/0,2,4,8,12,full

Collection: Semantic color    (modes: Light, Dark)
  color/bg/*, color/text/*, color/border/*, color/action/*, color/feedback/*

Collection: Semantic size     (modes: Comfortable, Compact) – optional
  space/inset/*, space/stack/*, space/inline/*
```

Use **scoping** so designers (and agents) only see appropriate variables in each picker. That's a quiet but powerful quality guardrail.

**Typography:** use text styles (or typography variables, where your setup supports them) with semantic names like `heading/lg` and `body/md`.

---

## 4. Components

### Anatomy of a good component

| Aspect | Good practice |
|---|---|
| **Name** | `Button`, not `btn-final-v3`. Use slash grouping only for real hierarchy (`Form/Input`). |
| **Properties** | Use **component properties** (variant, boolean, text, instance swap) rather than an explosion of variants. |
| **Variants** | Only for real visual or structural differences: `Variant=Primary|Secondary|Tertiary`, `Size=Sm|Md|Lg`, `State=Default|Hover|Focus|Disabled`. |
| **Auto layout** | Everywhere. Content-driven sizing, padding bound to spacing variables. |
| **Bindings** | Fills, strokes, radius, spacing and type **bound to variables**. No raw hex values. |
| **Layer names** | Semantic (`label`, `icon-leading`), not `Frame 12`. |
| **Description** | When to use, when not to, related components (Module 08). |
| **States** | Include focus (visible!), disabled, error and loading where relevant. |

### Match property names to code (critical for AI)

If engineering's `Button` takes `variant="primary" | "secondary"` and `size="sm" | "md" | "lg"`, name Figma properties **the same way**. That makes **Code Connect** mapping trivial (Module 08) and makes MCP output closer to real code.

> **Tip:** sit with an engineer and compare component APIs to Figma properties. Every mismatch is a translation error waiting to happen, for humans and agents alike.

### Core component set for your capstone (6–8)

1. **Button:** variants, sizes, icon options, states including focus and loading
2. **Text input:** label, helper, error, disabled, with an optional icon
3. **Select / dropdown**
4. **Checkbox / toggle**
5. **Card / container**
6. **Modal / dialog**
7. **Toast / inline alert:** info, success, warning, danger
8. **Empty state:** illustration or icon, title, body, action

Then **one pattern** relevant to your capstone, such as a filter bar, table row or form section.

---

## 5. Accessibility built into the system

Building accessibility into the system means every product (and every AI generation) inherits it.

- **Contrast:** WCAG 2.2 AA requires **4.5:1** for normal text and **3:1** for large text and essential UI components and graphics. Check each semantic text and background pairing in *every mode*.
- **Focus states:** visible, consistent, and tokenised (`color/border/focus`).
- **Target size:** WCAG 2.2 AA's minimum target size is 24×24 CSS px (with exceptions). Many systems use 44×44 for touch.
- **Don't rely on colour alone:** pair danger red with an icon or text.
- **Motion:** respect reduced-motion preferences, and tokenise durations.
- **Content:** labels are required, and placeholders are not labels.

Document these in component descriptions, because agents will read them (Module 08).

---

## 6. Documentation basics

At minimum, every component needs:

1. **Purpose:** what it's for, in one line.
2. **When to use / when not to use**, plus alternatives.
3. **Anatomy:** named parts.
4. **Properties:** what each does.
5. **Behaviour:** interactions and states.
6. **Content guidelines:** label length, tone.
7. **Accessibility notes.**

Free reference: Figma's [designsystems.com](https://www.designsystems.com/) has guides on space, grids, iconography, typography and content strategy.

---

## Common mistakes

- **Primitives used directly in components**, which makes theming impossible.
- **Visual names** (`blue-button`) instead of purpose names (`action/primary`).
- **Variant explosion:** 400 variants where 4 properties would do.
- **Figma and code mismatch** in names and props.
- **Missing states,** especially focus and error.
- **No descriptions,** so humans and agents guess.
- **Building everything at once.** Start with the 20% of components used 80% of the time.

---

## Lab 07

**Exercise 1: Audit (45 min).** Screenshot 5–8 screens from your capstone or a real product. Use AI to help list every colour, font size, spacing value and component variant in use. Count the inconsistencies, because this becomes your "why we need a system" evidence.

**Exercise 2: Token architecture (90 min).** Define primitives and semantic tokens (colour with light and dark modes, spacing, radius, type). Create them as Figma variables with scoping. Write a `$description`-style one-liner for each semantic token in the variable description field.

**Exercise 3: Contrast check (30 min).** Verify every semantic text and background pair in both modes with a contrast checker and fix failures.

**Exercise 4: Components (3 h).** Build the 6–8 core components, fully bound to variables, with auto layout, properties, all states and semantic layer names.

**Exercise 5: Pattern (60 min).** Build one capstone-specific pattern from the components.

**Exercise 6: Rebuild one screen (45 min).** Rebuild your main capstone screen using only system components. Switch to dark mode. Did everything theme correctly? Fix what didn't.

**Optional:** export your variables as JSON (via a plugin or your preferred method) and look at the structure. Can you see the tiers?

---

## Deliverable

A **published Figma library** with:

- Primitive and semantic variable collections (light and dark modes), with descriptions
- 6–8 core components plus one pattern, fully tokenised, with all states
- One capstone screen built 100% from the system, working in both modes
- A one-page audit summary: "before the system → after the system"

---

## Self-check

1. What are the three token tiers, and which should components use?
2. Why are semantic names better for AI agents than visual names?
3. What is the DTCG, and what did it publish in October 2025?
4. Why should Figma component properties match code component props?
5. What WCAG contrast ratios apply to normal text and to UI components?

<details><summary>Answers</summary>

1. Primitive → semantic → component. Components should use semantic tokens (and component tokens where needed), not primitives.
2. They encode intent ("when to use"), so the agent picks correctly. `color.text.danger` is self-explanatory, `red.500` is not.
3. The W3C Design Tokens Community Group. It published the first stable version (2025.10) of the Design Tokens specification, a vendor-neutral JSON format for tokens.
4. To make Code Connect mapping straightforward and AI-generated code accurate, and to avoid translation errors between design and engineering.
5. 4.5:1 for normal text, 3:1 for large text and for essential UI components and graphics (WCAG 2.2 AA).

</details>

---

## Go deeper

- [designtokens.org](https://www.designtokens.org/) and the [DTCG spec drafts](https://www.designtokens.org/TR/drafts/)
- [designsystems.com](https://www.designsystems.com/) (by Figma)
- [Design System University free courses](https://designsystem.university/courses) (Dan Mall)
- Paid: [Subatomic: The Complete Guide to Design Tokens](https://designtokenscourse.com/) (Brad and Ian Frost)
- Paid: NN/G [Architecting and Managing Effective Design Systems](https://www.nngroup.com/courses/architecting-and-managing-effective-design-systems/)

**Next → [Module 08: Making your design system AI-ready](08-ai-ready-design-system.md)**

# Module 08: Making your design system AI-ready

> **Time:** about 6 hours · **Output:** component descriptions, a DESIGN.md, an agent rules file, and an AI-readiness scorecard for your system

---

## Learning objectives

- Define what makes a design system **machine-readable**.
- Write **component descriptions** that guide both people and agents.
- Write a **DESIGN.md** following Google Labs' open format.
- Understand **Code Connect** and why it's the strongest link between Figma and code.
- Write **rules files** (AGENTS.md, CLAUDE.md, Cursor rules, Copilot instructions) that keep agents on-system.
- Score your system's AI-readiness and use AI to **audit** it.

---

## Why this matters for a lead

This is where design leadership multiplies. Without AI-readiness, agents improvise. With it, every agent (yours, your engineers', your PMs') builds with your components, your tokens and your rules. You stop policing output one screen at a time and start **shaping it at the source**.

---

## 1. What "machine-readable" means

A human can infer meaning from visual context, history and conversation. An agent can only use what's **explicit and structured**. A machine-readable design system has:

| Property | Human-only system | Machine-readable system |
|---|---|---|
| Names | `Frame 23`, `btn copy 2` | `Button`, `icon-leading`, `color/text/muted` |
| Values | Raw hex and px | Variables / tokens with aliases |
| Intent | In designers' heads | In descriptions: when to use, when not |
| Code link | "Ask Sam which component" | Code Connect mapping |
| Rules | Tribal knowledge | Rules files in the repo |
| Visual identity | Brand PDF | DESIGN.md (tokens plus rationale) |
| UX knowledge | Research decks | UX.md / context library (Module 09) |

**The test:** could a capable new hire build a correct screen using only what's written down and structured? If yes, an agent probably can too.

---

## 2. Component descriptions

Figma components have a **description** field. It shows in the UI and is part of what tools and agents can read. Treat it like a short spec.

**Template**

```
PURPOSE: Primary action trigger for forms and dialogs.
USE WHEN: One main action per view/section (Save, Continue, Create).
DON'T USE: For navigation (use Link); for destructive actions (use
Button variant=danger); more than one primary per section.
PROPERTIES: variant (primary|secondary|tertiary|danger), size (sm|md|lg),
iconLeading, iconTrailing, loading, disabled.
CONTENT: Verb-first, ≤ 3 words, sentence case ("Save changes").
A11Y: Min target 24×24 (44×44 on touch). Visible focus ring
(color/border/focus). Loading state must keep label for screen readers.
CODE: <Button> in @acme/ui (see Code Connect).
RELATED: Link, IconButton, ButtonGroup.
```

Write these for all core components. It takes about 10 minutes each and is the highest-ROI AI-readiness task you can do. (The Figma agent can draft them from your component, and then you edit.)

**Also describe variables:** `color/text/muted`: *"Secondary text: metadata, helper text, timestamps. Not for disabled text (use color/text/disabled). Min contrast 4.5:1 on bg/surface."*

---

## 3. DESIGN.md: visual identity for coding agents

In April 2026, **Google Labs open-sourced DESIGN.md**, a format for describing a product's visual identity to coding agents ([GitHub](https://github.com/google-labs-code/design.md); NN/G's [coverage](https://www.nngroup.com/articles/ux-context-design/)). It's a **draft (alpha) specification**, but the idea is durable and easy to adopt.

### Structure

A DESIGN.md combines two layers:

1. **Machine-readable tokens** in YAML front matter (or YAML blocks): colours, typography, rounded (radii), spacing, components.
2. **Human-readable rationale** in markdown: what the values are for and how to apply them, plus do's and don'ts.

> *"Tokens give agents exact values. Prose tells them why those values exist and how to apply them."* (DESIGN.md README)

### Example (abridged)

```markdown
---
name: Acme Finance
colors:
  text-primary: "#111827"
  text-muted: "#4B5563"
  surface: "#FFFFFF"
  action-primary: "#2563EB"
  danger: "#B91C1C"
typography:
  heading-lg: { fontFamily: Inter, fontSize: 1.5rem, fontWeight: 600 }
  body-md: { fontFamily: Inter, fontSize: 1rem, lineHeight: 1.5 }
rounded:
  sm: 4px
  md: 8px
spacing:
  sm: 8px
  md: 16px
  lg: 24px
---

## Overview
Calm, precise, trustworthy. Dense layouts for expert users; whitespace is
used for grouping, not decoration.

## Colors
- **action-primary** is the only colour for primary actions and links.
  Never use it decoratively.
- **danger** only for destructive actions and errors; always pair with an
  icon or text.

## Typography
One family (Inter). Max three sizes per screen. Sentence case everywhere.

## Do / Don't
- Do: use tables for comparable data.
- Don't: use gradients, shadows deeper than 1 level, or emoji in UI.
```

### Tooling

The project provides a CLI that **lints** a DESIGN.md (broken token references, **WCAG contrast** checks) and **diffs** two versions to detect regressions:

```bash
npx @google/design.md lint DESIGN.md
npx @google/design.md diff DESIGN.md DESIGN-v2.md
```

🔧 This tool is new. Check the repo for the current spec.

### Where DESIGN.md fits

- **Next to the code**, in the product's repository, where coding agents read it every time.
- **Attached to prompt-to-app tools** (v0, Lovable, Make) to pull prototypes toward your brand (Module 06).
- **Generated from your Figma variables.** Your Figma variables are the source of truth, and DESIGN.md is a published view of them. Keep them in sync, ideally automatically.

---

## 4. Code Connect: the strongest Figma ↔ code link

**Code Connect** links components in your design files to components in your codebase. It makes Dev Mode show **real production snippets**, and it gives the **Figma MCP server** direct references to your actual code, so agents use `<Button variant="primary">` from your library instead of inventing a `<button className="bg-blue-600…">` ([Figma docs](https://developers.figma.com/docs/code-connect/)).

### Two ways to set it up

| | Code Connect UI | Code Connect CLI |
|---|---|---|
| Where | Inside Figma, with GitHub integration | In the code repo |
| Who | Designers and DS teams, with engineering | Engineers / design engineers |
| Strength | Easy start; **one-to-many** mappings (React, SwiftUI, Compose, Vue...) | Full control via **template files** |

They can be used together. CLI-created connections appear in the UI but are edited in the CLI.

### What a mapping looks like (template file, conceptually)

```typescript
// url=https://www.figma.com/file/…/Button?node-id=123
import figma from 'figma'
const instance = figma.selectedInstance

export default {
  example: figma.code`
    <Button
      size={${instance.getEnum('Size', { Large: 'large', Medium: 'medium', Small: 'small' })}}
      disabled={${instance.getBoolean('Disabled')}}
    >
      ${instance.getString('Text Content')}
    </Button>
  `,
  imports: ['import { Button } from "components/Button"'],
  id: 'button',
}
```

Notice how it **maps Figma properties to code props**. This is why Module 07 insisted on matching names: mismatched names mean more mapping work and more mistakes.

There is also a **figma-code-connect skill** that helps coding agents write these templates from a component URL.

### Plan notes (🔧)

On **Professional** plans you can have **one active framework** at a time. Organization and Enterprise plans can have multiple. This matters if you ship web *and* native.

### Your role as lead

You probably won't write the templates. You will:

- **Prioritise** which components to connect first (the most-used ones).
- **Align** Figma properties with code props.
- **Own** the decision that Code Connect is part of the "definition of done" for a system component.

---

## 5. Rules files: instructions agents always follow

**Rules** are project-level instructions an agent follows every time, *"the unwritten rules of your codebase that an experienced developer would pass on to a new teammate"* ([Figma](https://developers.figma.com/docs/figma-mcp-server/add-custom-rules/)).

### Where they live (🔧 varies by tool)

| Tool | Typical file |
|---|---|
| Many agents (open convention) | `AGENTS.md` at repo root |
| Claude Code | `CLAUDE.md` |
| Cursor | `.cursor/rules/*` |
| GitHub Copilot | `.github/copilot-instructions.md` (plus path-specific instruction files) |

Many teams keep one canonical file (often `AGENTS.md`) and reference it from the others.

### What to put in them: design-system rules

From Figma's recommended general rules (adapted):

```markdown
## Design system rules
- IMPORTANT: Always use components from `packages/ui` when possible.
  Never create a new Button, Input, Modal, etc. if one exists.
- Never hardcode colours, spacing, radii or font sizes. Use tokens
  (CSS variables from `packages/tokens`). If a token is missing, stop
  and ask — do not invent one.
- Follow WCAG 2.2 AA: labels on all inputs, visible focus, contrast ≥ 4.5:1.
- Use sentence case for all UI text. Use terms from /docs/GLOSSARY.md.
- Read DESIGN.md before any UI work.

## Figma MCP flow (do not skip)
1. Run get_design_context for the exact node(s).
2. If too large, run get_metadata, then re-fetch only needed nodes.
3. Run get_screenshot for visual reference.
4. Only then implement. Treat MCP output (often React + Tailwind) as a
   description of design intent, not final code style — translate it into
   this project's components and tokens.
5. Validate against the screenshot before marking complete.
```

Figma also suggests **asking the agent to generate rules** by analysing the codebase (where tokens live, the component architecture, styling approach, icon system), then reviewing them. A full template is in [templates/AGENTS.md](../templates/AGENTS.md).

### Rules hygiene

- **Short and specific beats long and vague.** Each rule should be testable.
- **Use "IMPORTANT" sparingly**, for the rules that matter most.
- **Version them** in git, review changes like code, and give them an owner (Module 13).
- **Update them from failures.** When an agent drifts, ask which rule would have prevented it, then add it (the "drift log", Module 10).

---

## 6. Using AI to audit your design system

Agents can help *maintain* the system too.

- **Figma agent:** "Find all layers in this file using raw colour values instead of variables" or "List detached instances".
- **Write-to-canvas agent (beta, use a duplicate!):** "Convert the raw values in this section to variables."
- **Coding agent on the repo:** "Find hardcoded hex colours and px values in `/src` that should be tokens. Produce a table with file, line, value and suggested token."
- **DESIGN.md lint:** contrast and broken references.
- **Consistency:** "Compare these Figma components' properties with the props of the matching React components. List mismatches."

---

## 7. The AI-readiness scorecard

Score each 0–2 (0 = absent, 1 = partial, 2 = solid):

| # | Criterion |
|---|---|
| 1 | All colours, spacing, radii and type use variables or styles (no raw values) |
| 2 | Token tiers exist (primitive → semantic), with semantic names |
| 3 | Variables have descriptions |
| 4 | Components have semantic names and layer names |
| 5 | Components have structured descriptions (purpose, use/don't, a11y, code) |
| 6 | Figma properties match code props |
| 7 | Code Connect covers the top 10 components |
| 8 | DESIGN.md exists, is linted and is in sync with Figma |
| 9 | Rules file exists, is versioned and owned |
| 10 | A context-comparison test has shown improvement (Module 09) |

**0–7:** not AI-ready; agents will improvise. **8–14:** partially ready; expect drift. **15–20:** AI-ready; agents mostly stay on-system.

---

## Common mistakes

- **Writing a rules novel.** Agents follow concise, specific rules better.
- **DESIGN.md out of sync with Figma.** Two sources of truth means no truth.
- **Connecting everything with Code Connect at once.** Start with the top 10.
- **Running write-to-canvas audits on the production library.**
- **No owner for the rules.** They go stale (NN/G: context needs ongoing maintenance).

---

## Lab 08

**Exercise 1: Descriptions (90 min).** Write structured descriptions for all your capstone components and semantic variables. Try having the Figma agent draft them first, then edit and compare.

**Exercise 2: DESIGN.md (60 min).** Write a DESIGN.md for your capstone system: tokens in YAML plus rationale prose. If you have Node.js, run `npx @google/design.md lint DESIGN.md` and fix the findings. (If not, do it in Module 10 when you set up a coding environment.)

**Exercise 3: Rules file (45 min).** Adapt [templates/AGENTS.md](../templates/AGENTS.md) for your capstone.

**Exercise 4: Code Connect mapping plan (30 min).** You may not have a codebase yet. List your components, their Figma properties and the props you'd expect in code. Mark which to connect first. (You'll implement 2 in Module 10.)

**Exercise 5: Scorecard (30 min).** Score your capstone system, and also a real system you know, such as your company's. Write the top 3 improvements for each.

---

## Deliverable

1. Component and variable **descriptions** in your Figma library.
2. **DESIGN.md** (linted if possible).
3. **AGENTS.md** (design-system rules plus the Figma MCP flow).
4. **AI-readiness scorecard** with an improvement plan.

---

## Self-check

1. What's the "new hire test" for machine-readability?
2. What are the two layers of a DESIGN.md?
3. What does Code Connect give the Figma MCP server that it otherwise lacks?
4. Name three places rules files live, depending on the tool.
5. How should rules evolve over time?

<details><summary>Answers</summary>

1. Could a capable new hire build a correct screen using only what's written and structured? If yes, an agent likely can.
2. Machine-readable YAML tokens (exact values) and human-readable markdown rationale (why and how to apply them).
3. Direct references to the real code components (imports, props), so agents reuse your library instead of generating new markup.
4. Any three of `AGENTS.md`, `CLAUDE.md`, `.cursor/rules/`, `.github/copilot-instructions.md`.
5. They're versioned and owned, reviewed like code, and updated from observed failures: each drift prompts the question "which rule would have prevented this?"

</details>

---

## Go deeper

- [DESIGN.md spec (Google Labs)](https://github.com/google-labs-code/design.md)
- Figma: [Code Connect docs](https://developers.figma.com/docs/code-connect/) and [Add custom rules](https://developers.figma.com/docs/figma-mcp-server/add-custom-rules/)
- [figma/mcp-server-guide](https://github.com/figma/mcp-server-guide)
- Paid, and the best fit for this module: [AI & Design Systems (Brad Frost et al.)](https://aianddesign.systems/)
- Paid: [AI Design Systems & Prototyping intensive (Christine Vallaure)](https://maven.com/moonlearning/ai-design-systems)

**Next → [Module 09: Context engineering](09-context-engineering.md)**

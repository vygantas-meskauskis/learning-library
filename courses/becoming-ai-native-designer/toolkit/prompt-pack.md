# Prompt pack

> Short prompts work best **inside your ChatGPT Project** (Chapter 2), where context is already loaded. Placeholders are in [brackets]. When you've used a prompt 3+ times, make it permanent: Project instructions, a Figma skill, an AGENTS.md rule or a Make kit guideline.

---

## Explore

**Genuinely different directions**

```text
Give me [6] concepts for [screen/feature], each built on a DIFFERENT idea:
[1) speed-first 2) reassurance-first 3) social proof 4) person-led 5) logistics-first
6) borrowed from a non-[domain] domain]. For each: one-line concept, who it's best
for, biggest risk, which existing components it uses, what's missing. Recommend one.
```

**Risks and pre-mortem**

```text
Feature: [..]. List the 5 biggest user risks and 5 business risks given our users
(UX.md). Then: "It's 6 months after launch and this failed — top 6 reasons."
```

**Red team a decision**

```text
Argue against this decision as convincingly as possible: [..]. Give objections
from: a sceptical developer, a PM, a first-time user, a power user, an
accessibility expert.
```

---

## Audit

**Figma page audit (Figma agent)**

```text
Audit this page for design-system health. Don't change anything. Tables for:
raw colour values (clustered) · detached instances · text without text styles ·
spacing off the 4px scale · default layer names · duplicate components.
End with the top 5 fixes by impact on AI output quality.
```

**Live app inventory (ChatGPT, screenshots)**

```text
Here are [12] screenshots of our live app. Build an inventory: distinct colours
(approx. hex) and where used; text styles (size/weight estimate) and roles;
component types and their visual variants; inconsistencies between screens that
should match. Mark estimates as estimates. Tables only.
```

**Gap analysis**

```text
Inputs: (1) Figma audit, (2) app inventory, (3) target blueprint (7 layers:
principles, variables, components, descriptions, Figma↔code links, context, AI
setup). For each layer: current, target, gap, effort S/M/L, impact on AI output.
Propose an order of work.
```

---

## Tokens

```text
Create a 50–950 colour scale around [#hex], perceptually even. For each step give
contrast vs white and vs [#near-black]. Flag steps usable for text (≥ 4.5:1).
```

```text
Here are our colour usages from the audit: [..]. Propose semantic variable names
(category/property/role/state) with Light and Dark primitive mappings and a
one-line description each.
```

```text
(Figma agent) Create a "Semantic colour" collection with Light and Dark modes from
this table, aliasing to "Primitives". Set scoping (text colours → text fills only).
Add each description.
```

---

## States and content

```text
(Figma agent) For this [screen/component], create frames for every state:
[default, loading, empty, error types, offline, disabled, success, full]. Use only
existing components/states; list anything missing instead of inventing it.
```

```text
(Figma agent) Duplicate this 4× and fill with edge cases: 60-char title, German
text, free item, price in credits.
```

```text
Write copy for [elements]. 3 options each, our voice and glossary. Recommend one per
item and explain in ≤ 10 words.
```

---

## Critique

```text
You are a strict senior UX reviewer. Review the attached [screen] for [user] doing
[task]. Up to 8 issues ranked by severity, each with heuristic, location, why it
matters for this user, fix. Check against UX.md constraints. No praise. Mark
"TEST" where only user testing can decide.
```

```text
Check this screen for likely WCAG 2.2 AA issues: contrast, target size, focus
order, labels, colour-only meaning, text scaling. Mark each "likely" or "verify
with a tool".
```

---

## Prototyping

**Make prompt structure**

```markdown
# Prototype: [name] (research prototype)
## Research questions
1. ...
## Must work
- ...
## Doesn't need to work
- ...
## Data
Use attached [data].json ([what's in it, edge cases]).
## Design
Use attached Figma frames and our Make kit. [Device size]. Follow our guidelines:
[key rules].
```

**Realistic dataset**

```text
Generate [data].json: [N] realistic [items] in [city/context]. Fields: [..].
Include edge cases: [long text, free, full, missing image, special rules].
Valid JSON only.
```

---

## Research

```text
Desk research (Work mode): Summarise how [competitors] handle [problem].
For each: approach, notable patterns, links to sources. Flag anything you couldn't
verify. End with 5 questions we should ask real users.
```

```text
Review this interview guide for leading questions, double-barrelled questions,
jargon, missing follow-up probes, and questions that ask users to predict the future.
Table: original · problem · rewrite.
```

```text
Here are anonymised notes from [N] interviews (P1–PN). Cluster into themes: name,
one-sentence insight, quotes WITH participant ID + line reference, participant
count. Then: evidence contradicting each theme; participants fitting no theme.
Never invent or merge quotes.
```

```text
Turn these verified insights into UX.md constraints: table with Insight (evidence,
date) → Constraint for anything we generate. Keep constraints testable.
```

---

## Codex

> Always in a **branch**; a developer reviews the **pull request**. You never merge or release.

**Explain a change in plain language**

```text
Explain this change to me as a designer, without code: screens/components changed;
which design-system components were used; anything NEW created; any hardcoded
colours/spacing/font sizes; which states exist; differences from Figma <link> and why.
```

**Read-only design-system report**

```text
Without changing anything, list every place in the app where colours, spacing or
font sizes are hardcoded instead of using tokens. Table: screen, what, suggested token.
```

**Copy fix**

```text
In a new branch, change "[old]" to "[new]" everywhere in the UI text. List every
place changed in plain language, show before/after screenshots, open a PR for review.
```

**Token update from Figma**

```text
Our Figma variable [name] changed (link). Update the token in code, show before/after
screenshots of affected screens, and open a PR for review.
```

**Throwaway prototype on real components**

```text
In a new branch, build a throwaway prototype of [screen] from this Figma frame <link>
using ONLY existing app components and tokens. If something is missing, stop and
list it. No real data or keys. Tell me how to run it in the simulator.
```

**Capture for review (code to canvas)**

```text
Capture the [flow] from the running app into this Figma file <link> (code to canvas)
so I can compare it with the designs. Include [states].
```

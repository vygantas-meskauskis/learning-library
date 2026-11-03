# Module 06: AI prototyping and testing with real users

> **Time:** about 8 hours, spread across 2 weeks · **Output:** a tested, interactive capstone prototype (v2) and a findings report

---

## Learning objectives

- Decide when a prototype needs to be **interactive** and when static Figma is enough.
- Understand the AI prototyping tool landscape and choose a tool by need.
- Follow a reliable **six-step AI prototyping process**.
- Create **realistic data** and complete **states** for prototypes.
- Run usability tests on AI prototypes and avoid the **fidelity trap**.

---

## Why this matters for a lead

AI prototyping is the most visible change in design practice, and the most misunderstood. Stakeholders will see a polished AI prototype and ask, "Can we just ship this?" A lead needs a clear point of view on what prototypes are for, how they're validated, and where they stop.

---

## 1. Why interactive prototypes changed the game

Before AI, complex interactions (filters, dashboards, data tables, conversational UI, multi-step logic) were tedious to prototype. Teams tested a few happy-path screens and waited for engineering to see real behaviour.

NN/G's 2026 article [Test Complex Interactions Earlier with AI Prototyping](https://www.nngroup.com/articles/test-earlier-with-ai/) describes what changed:

- **Ramp:** a senior designer used Cursor to prototype a redesign of the expense-policy editor, with AI chat-based editing. Participants tested a working prototype loaded with **their own sanitised data**. The team found an issue with how edits were tracked and displayed that they "couldn't have found... without an interactive prototype". It went from concept to demo in **three weeks** and influenced the roadmap.
- **Ramp (conversational AI):** a prototype connected to a real agent, so participants could type *anything*, revealing how the agent handled unexpected requests. Static screens can't simulate non-deterministic behaviour.
- **Purdue University:** a traffic-data filtering interface was first built as static Figma wireframes, then rebuilt with **v0 and Bolt** using a synthetic dataset. With static screens, participants gave less specific feedback. With the interactive prototype, they identified **specific problems**.

**The durable lesson:** for complex interactions, realistic behaviour and data produce better feedback earlier. For simple questions (layout preference, content comprehension, visual hierarchy), static prototypes are still fine and often faster.

---

## 2. Static or interactive? Decide first

| Your research question is about... | Prototype type |
|---|---|
| Visual hierarchy, first impression, layout comprehension | Static Figma (maybe a click-through) |
| Content and copy comprehension | Static, or plain text |
| Navigation and IA findability | Click-through or tree test |
| Filtering, sorting, search behaviour | **Interactive, with realistic data** |
| Forms with validation and conditional logic | **Interactive** |
| Dashboards and data exploration | **Interactive, with realistic data** |
| Conversational or AI features | **Interactive, connected to a real model** |
| Multi-step flows with branching | Interactive, or a well-built click-through |
| Micro-interactions, motion | Interactive (code), or Figma prototyping for simple cases |

**Rule of thumb:** prototype the *minimum* fidelity that answers the research question. AI makes high fidelity cheap to *create*, but high fidelity can still cost you, through slower iteration, attachment, and stakeholders assuming it's done.

---

## 3. The tool landscape (🔧 volatile, so choose by category)

| Category | Examples | Strengths | Trade-offs |
|---|---|---|---|
| **In-Figma** | Figma Make | Close to your files and library; designer-friendly; MCP can pull Make resources into code | Less control over code structure |
| **Prompt-to-app builders** | v0, Lovable, Bolt, Magic Patterns | Very fast; hosted links for testing; good-looking defaults | Defaults pull toward a generic look; varying control |
| **Coding agents** | Cursor, Claude Code, GitHub Copilot, Codex | Full control; can use your real component library; closest to production | Needs basic comfort with files, a terminal and git (Module 10) |

NN/G: *"The tool you use depends on how much control you need and how comfortable you are editing code."*

**Recommendation for this course:** use **one** prompt-to-app builder or Make now, and a **coding agent** in Module 10. As a lead you'll want both: builders for speed and agents for system-faithful prototypes.

---

## 4. The six-step AI prototyping process

From NN/G's article, with practical additions:

### Step 1: Decide what the prototype must do

Write the **research questions** and derive the required behaviour:

```
Research question: Can admins find and fix a misconfigured spending rule
in under 2 minutes?
Must work: rule list with search; rule detail; edit; validation errors;
save; undo. Data: 40 realistic rules incl. 3 misconfigured.
Doesn't need to work: login, settings, other modules.
```

### Step 2: Make your design decisions *before* prompting

Layout, hierarchy, interactions and edge cases (empty, error, loading). NN/G: *"The quality of the prompt... depends on the thinking you do in this step."* Sketch or wireframe in Figma first.

> **If you leave design decisions to the AI tool, it will fill in the gaps**, with average choices. The decisions remain yours.

### Step 3: Collect or create data

- **Real data:** only if allowed. Remove personal data, follow company policy, and check the tool's data policy.
- **Synthetic data:** have an AI generate it from your criteria. Include **edge cases**: long names, empty values, extreme numbers, unicode, many items, zero items.

**Prompt: realistic dataset**

```
Generate a JSON dataset of 40 spending rules for a mid-size company.
Fields: id, name, category, limit (EUR), approver role, status
(active/paused/misconfigured), lastEdited, editor name.
Include: 3 misconfigured rules (explain why in a "notes" field), 2 with
very long names (60+ chars), 1 with limit 0, varied categories, realistic
European names. Return valid JSON only.
```

### Step 4: Write a structured prompt (markdown helps)

```markdown
# Prototype: Spending rules editor

## Goal
Test whether admins can find and fix misconfigured rules quickly.

## Users
Finance admins at 50–500 person companies; expert users; use it weekly.

## Layout
- Left: searchable, filterable rule list (status chips, category filter)
- Right: rule detail panel with inline editing
- Top: summary bar (total rules, # misconfigured – clickable filter)

## Interactions
- Search filters list as you type
- Clicking a rule opens detail; edits validate on blur
- Save shows toast with Undo (10s)
- Misconfigured rules show inline warning with "Fix" suggestion

## States
Empty search result; loading (300ms simulated); validation error; save
error (simulate on rule id 13); success.

## Visual
Use these tokens: [paste key tokens or DESIGN.md excerpt]. Dense, calm,
professional; no gradients; 8px spacing grid.

## Data
Use attached rules.json.
```

### Step 5: Generate in the tool

Attach the prompt, data, sketches, screenshots and (if supported) your DESIGN.md.

### Step 6: Edit, iterate, then pilot-test

- Expect several rounds of iteration. Fix **one thing at a time**.
- **Pilot test** with a colleague before real sessions, to catch broken flows.
- Check that it works on the device and browser participants will use.

---

## 5. Getting AI prototypes to look like *your* product

Prompt-to-app tools default to a generic aesthetic. To pull them toward your system:

1. **Give exact tokens:** colours, type scale, spacing, radius, ideally as a DESIGN.md (Module 08).
2. **Attach screenshots** of 2–3 real screens as visual reference.
3. **Name components and patterns**: "use a data table with sticky header", "use toast for confirmations".
4. **State what not to do**: "no gradients, no emoji, no card shadows".
5. **For the highest fidelity**, use a coding agent with your real component library (Module 10).

---

## 6. Testing AI prototypes with real users

The research method is the same as always. The new considerations are:

- **Moderated sessions work best** for complex prototypes, because you can recover if something breaks.
- **Share a hosted link.** Most builders provide one. Test the link from an incognito window first.
- **Reset state between participants** (reload, clear local storage), or pre-seed data per participant.
- **For AI or conversational features, expect different outputs per session.** Log what the system said in each session, since findings depend on it.
- **Tell participants it's a prototype.** Some features may be missing.

**Sample size:** 5 participants per round finds most major usability problems in qualitative testing. Iterate, then test again.

**Analysing:** apply the safe synthesis workflow from Module 04.

---

## 7. The fidelity trap: prototype ≠ product

NN/G warns: a polished AI prototype prompts *"can we just ship this?"*, but it may contain **wrong patterns, confusing hierarchy and repeated elements**, plus (from engineering's perspective) no security, error handling, accessibility, performance, tests or architecture.

**As a lead, establish this rule:** *A prototype is a learning artifact. Production is built through the agreed pipeline: system components, code review, accessibility and QA gates* (Module 11).

How to communicate it:

- Label prototype links clearly: "PROTOTYPE – for research only".
- In reviews, present **what you learned**, not just the prototype.
- Offer the *path* to production: "Here's the validated design; engineering will build it with system components, and Make or MCP resources can speed that up."

---

## Common mistakes

- **Prompting before deciding.** You get the AI's design, not yours.
- **Toy data.** "Lorem ipsum" and three perfect rows hide real problems.
- **Over-building.** Prototyping the whole app when one interaction was the question.
- **Endless polishing** instead of testing.
- **Shipping the prototype** (the fidelity trap).
- **Skipping the pilot**, so session 1 is wasted on bugs.

---

## Lab 06 (two weeks)

**Week A: Build**

1. **Research questions (30 min).** Write 2–3 research questions for your capstone and derive what must and must not work.
2. **Design decisions (60–90 min).** Sketch or wireframe the key screens and all states in Figma.
3. **Dataset (30 min).** Generate realistic data with edge cases and review it.
4. **Prompt (45 min).** Write the structured markdown prompt.
5. **Build (2–3 h).** Generate in Make, v0, Lovable or Bolt. Iterate until it supports your test tasks. Log each iteration in your AI log.
6. **Pilot (30 min).** Have a colleague run through it.

**Week B: Test**

7. **Test plan (45 min).** Write 3–5 tasks with success criteria.
8. **Sessions (3 h).** Run 3–5 moderated sessions with real target users.
9. **Synthesis (60 min).** Write findings ranked by severity, with evidence.
10. **Iterate (60 min).** Fix the top 3 issues and produce v2.

---

## Deliverable

1. **Prototype v1 and v2 links**, with the prompt and dataset.
2. **Test report** (2 pages): research questions, method, participants, findings by severity, evidence, changes made.
3. **A reflection:** what did interactivity reveal that a static prototype wouldn't have?

---

## Self-check

1. Name three research questions that need an interactive prototype, and two that don't.
2. What are NN/G's steps for AI prototyping complex interfaces?
3. What edge cases should a synthetic dataset include?
4. What is the fidelity trap, and how do you protect against it as a lead?
5. How do you make a prompt-to-app builder produce something closer to your brand?

<details><summary>Answers</summary>

1. Interactive: filtering and search behaviour, conditional forms, conversational AI responses. Not needed: first-impression layout preference, copy comprehension.
2. Decide what it must do → make the design decisions → collect or create data → write a detailed prompt with data → generate in the tool → edit, iterate and pilot-test.
3. Long text, empty or zero values, extremes, many and zero items, special characters, invalid states, and realistic variety.
4. Polished prototypes get mistaken for production-ready work, despite hidden pattern, hierarchy and engineering gaps. Protect against it by labelling prototypes, presenting learnings, and having a defined production pipeline with design review and QA gates.
5. Give exact tokens (ideally DESIGN.md), reference screenshots, named patterns and components, and explicit "don'ts". For the highest fidelity, use a coding agent with your real components.

</details>

---

## Go deeper

- NN/G: [Test Complex Interactions Earlier with AI Prototyping](https://www.nngroup.com/articles/test-earlier-with-ai/)
- Paper: [User-Centered Design with AI in the Loop: Rapid UI prototyping with "vibe coding"](https://arxiv.org/abs/2507.21012) (Purdue, 2025)
- Video: [Building with Cursor, with designers from Cursor, Notion and Ramp](https://www.youtube.com/watch?v=T8T2gHCKWCE)
- Paid option: [AI prototyping for designers (Maven)](https://maven.com/anna-arteeva/prototyping-for-designers)

**Next → [Module 07: Design system foundations](07-design-system-foundations.md)**

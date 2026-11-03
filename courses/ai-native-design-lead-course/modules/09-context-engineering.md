# Module 09: Context engineering and UX-context design

> **Time:** about 6 hours · **Output:** UX.md (your product's UX context), a context library structure, and a with/without-context experiment

---

## Learning objectives

- Explain **context engineering** and why it now matters more than prompt wording.
- Apply NN/G's **global / local / ambient** model of context.
- Practise **UX-context design**: turning research and standards into context that steers everyone's AI.
- Write a **UX.md** covering research synthesis, interaction standards, glossary, user models and world models.
- Run a **context experiment** to measure whether your context improves output.
- Maintain a context library without building a "big ball of mud".

---

## Why this matters for a lead

This is probably the most important new responsibility of an AI-era design lead. In many organisations, **designers are no longer the only people producing designs**: PMs make mockups and engineers' coding agents choose labels and error states. NN/G's answer is not gatekeeping. It is to make sure **everything AI generates, no matter who prompts it, is informed by the organisation's knowledge of its users and design standards** ([source](https://www.nngroup.com/articles/ux-context-design/)).

If you own that context, your influence extends to every screen, including the ones you never see.

---

## 1. From prompts to context

**Context** is *everything the model can see* when it does the work: your request plus instructions, standards, examples and background information ([NN/G](https://www.nngroup.com/articles/ux-context-design/)).

- **Prompt engineering:** how you phrase the request.
- **Context engineering:** what knowledge, rules and examples surround the request, and how they're curated, structured, scoped and maintained.

NN/G's research with AI power users found they **spent more effort engineering context libraries than crafting prompts**, and most prompts were casually dictated ([source](https://www.nngroup.com/articles/context-libraries/)). *"Curating the right context now matters even more than writing a good prompt"* ([source](https://www.nngroup.com/articles/3-agent-context-roles/)).

**An analogy:** the house builder who never meets your family designs the *average* house, which is wrong in ways that matter if you use a wheelchair or work from home. *"That's not the builder's fault; the problem is the builder didn't have context."* (NN/G)

---

## 2. The three roles of context

From NN/G's study of AI power users ([source](https://www.nngroup.com/articles/3-agent-context-roles/)):

| Role | Definition | Design examples |
|---|---|---|
| **Global** | Rarely changes; shapes the agent's actions across all tasks | Design principles, DESIGN.md, UX.md, accessibility rules, glossary, governance rules |
| **Local** | Intentionally scoped to a specific task or project | This feature's brief, research findings for this flow, the Figma frame, the test plan |
| **Ambient** | Raw, uncurated streams the agent sifts through | Slack threads, meeting transcripts, email, support tickets, analytics |

```
        ┌────────────── ambient (Slack, transcripts, tickets) ──────────────┐
        │                                                                    │
        │     [local: brief]   [local: research]   [local: Figma frame]      │
        │            \               |                    /                  │
        │             ───────→  AI OUTPUT  ←──────────────                   │
        │                           ↑                                        │
        │   ═══════ global: principles · DESIGN.md · UX.md · rules ═══════   │
        └────────────────────────────────────────────────────────────────────┘
```

**Information can change roles.** A Slack decision (ambient) becomes local when you point the agent at it, and may become global if it turns into a standing rule.

**Design-lead implication:** your job is mostly to curate **global** context (the standards everyone shares) and to define *templates* for **local** context (what a good feature brief contains). Be cautious with **ambient** context: it's noisy and can contain sensitive data.

---

## 3. UX-context design

> **UX-context design** is the practice of discovering and curating what an organization knows and wants into the context that guides everything its AI tools generate: from who its users are and the world they live in, to how a product should look and behave. ([NN/G](https://www.nngroup.com/articles/ux-context-design/))

It also involves **testing** the context with the models your team uses and refining it.

### Why traditional deliverables aren't enough

A persona has a stock photo and a name to help *humans* empathise. *"A model does not need persuading, it needs the underlying reasoning."* (NN/G) So AI-ready deliverables are:

- **Distilled:** findings stated as clear, reasoned insights.
- **Curated by a skilled human:** not raw transcripts dumped in.
- **Available to everyone who designs**, regardless of role.
- **Living next to the product:** in the repo or a shared library, read on every generation.
- **Measured by output quality**, not by stakeholder persuasion.

### Curation, not handoff

Traditional deliverables are handed off and left behind. UX context is **continuously curated**: *"New research updates it, and so does watching what the AI gets wrong."* (NN/G)

---

## 4. Writing UX.md

NN/G proposes **UX.md** as a hypothesis: a broader companion to DESIGN.md. DESIGN.md covers *visual identity*; UX.md covers *experience knowledge*. For large products, UX.md can be an **index to a folder** of context files.

### Recommended sections

**1. Research synthesis: insights as constraints**

Write findings so they **constrain generation**:

> ❌ "Users find onboarding hard."
> ✅ "Users abandon setup when asked for information they don't have on hand. → Never require external info (IDs, documents) in the first session; allow save-and-return."

Include the **evidence strength** (for example "n=12 interviews, 2025-Q4") so agents and humans know how much to trust each one.

**2. User models**

Expertise, goals, concerns, frequency of use, what doesn't work for them. No stock photos, just reasoning:

> "Finance admins: expert users, work in the product 2–4 h/day during month-end, prefer density and keyboard shortcuts, distrust automation that changes numbers without showing the change."

NN/G's example of how a user model leans generation: if users spend hours making complex decisions, lean toward **denser screens**. If they use it a few minutes a month, lean toward **fewer choices per screen**.

**3. World models (context of use)**

The conditions users are in: interruptions (a nurse on a hospital floor), stress (filing a claim after an accident), compliance (every action must leave an audit trail), devices, connectivity, environment.

**4. Interaction standards**

How the product behaves:

- When to **confirm** versus allow **undo**
- How **errors** are worded and placed
- Expert versus novice optimisation
- Loading, empty and partial states
- Notifications: when, where, how loud

**5. Glossary**

The words users and domain experts use, with definitions and forbidden synonyms: *"Users say 'case', not 'ticket'."* NN/G notes a side effect: users' terms start appearing even in code, because agents pick them up.

**6. Pointers**

Links to DESIGN.md, the component library location, the accessibility standard and key research reports.

A full template is in [templates/UX.md](../templates/UX.md).

---

## 5. Building a context library

A **context library** is *"a collection of institutional and procedural knowledge, contained within markdown files or external software, that AI agents may reference and edit"* ([NN/G](https://www.nngroup.com/articles/context-libraries/)).

### Suggested structure for a product team

```
/context
  README.md               ← index: what's here, when to use what, owners
  UX.md                   ← global UX context (or index)
  DESIGN.md               ← global visual identity
  GLOSSARY.md             ← global terminology
  principles.md           ← design principles with do/don't
  accessibility.md        ← standards and checks
  /research
    2026-q3-onboarding.md ← distilled insights, evidence strength, date
  /features
    _brief-template.md    ← local-context template
    invoices-redesign.md  ← local context for an active project
  /skills                 ← packaged procedures (optional, tool-dependent)
AGENTS.md                 ← rules; points agents to /context
```

### NN/G's four lessons (from power users)

1. **Context needs ongoing maintenance.** Files written once and used for months go stale. Schedule reviews and audit context against recent decisions.
2. **Let the agent update context for you,** then verify. Most power users asked the AI to edit context files rather than typing into them. It's faster and keeps the style consistent, but **review the changes**, because users "rarely checked what Claude had changed".
3. **Structure the library for findability.** Clear names, an index, one topic per file.
4. **Give agents only the context they need.** More isn't better: irrelevant context dilutes quality and wastes tokens.

### Skills: packaging procedures

**Skills** package instructions (and sometimes scripts and resources) that an agent loads when relevant, typically a folder with a `SKILL.md` describing *when* to use it. Examples: "write UX copy using our voice", "run a heuristic review using our checklist", "create a feature brief". Figma ships skills for its MCP server (such as `figma-use` and `figma-code-connect`). As the team grows, turning frequent prompts into skills is the natural evolution from your prompt library (Module 03).

---

## 6. Testing context: the with/without experiment

UX-context design **must be tested**. NN/G lists open questions: which artifacts help most, when raw data helps, how to measure efficacy, and whether there is such a thing as too much context. Your team can answer these for *your* product.

### Method

1. **Pick 3 representative generation tasks:** for example "invoice list screen", "error state for failed payment", "onboarding step 2".
2. **Define a rubric** (score 1–5):
   - Uses system components and tokens correctly
   - Fits users' expertise and context (density, terminology)
   - Follows interaction standards (confirm/undo, error style)
   - Accessibility basics
   - Copy matches voice and glossary
3. **Generate each task under 3 conditions:**
   - A: prompt only
   - B: prompt + DESIGN.md
   - C: prompt + DESIGN.md + UX.md (+ rules)
4. **Run each condition 2–3 times** (outputs vary).
5. **Score blind if possible:** have a colleague score without knowing the condition.
6. **Analyse:** which context moved which rubric line? What did the AI still get wrong, and which context would fix it?
7. **Update the context**, then re-test. Keep a changelog.

This gives you **evidence** for leadership ("adding UX.md raised the average rubric score from 2.4 to 3.9") and tells you where to invest.

A template is in [templates/context-experiment.md](../templates/context-experiment.md).

---

## 7. Avoid building a big ball of mud

NN/G found AI power users ("vibe architects") repeatedly building **"big balls of mud"**: systems *"scraped together for short-term functionality, not architected for long-term durability"* ([source](https://www.nngroup.com/articles/big-ball-of-mud-ai/)). Because building feels free, people **overbuild**. The patterns they saw include:

- **Throwaway code becomes permanent:** a quick `rules.md` draft that everything comes to depend on.
- **Piecemeal growth:** features bolted on as needs arise, until nobody understands the whole.

…and others from Foote and Yoder's original catalogue, leading to systems that are hard to direct, diagnose or rebuild.

**Guardrails for your context library**

- **Plan the structure** before writing lots of files (use the structure above).
- **One owner per file**, and a review cadence (for example quarterly, or after each research round).
- **Changelog:** what changed, why, and what triggered it.
- **Prune:** delete or archive stale context. Context debt is real.
- **Prefer fewer, better files** over many overlapping ones.
- **Re-test** (section 6) after big changes.
- **Rebuild deliberately** when the system gets too tangled, rather than patching forever.

---

## 8. Privacy and safety in context

- **No personal data** in context files. Distil insights, don't paste transcripts.
- **No secrets** (keys, credentials) in any file an agent reads.
- **Check where context goes:** which tools read it, and what their data policies are.
- **Ambient connections** (Slack, email, MCP to Notion and so on) can expose more than intended. Scope them deliberately. NN/G also notes connections break ("system decay"), so expect maintenance.

---

## Common mistakes

- **Dumping raw research** into context. NN/G warns of noise and over-focus on the wrong things.
- **Writing for humans:** persuasive decks instead of reasoned constraints.
- **One giant file,** or the opposite: 60 overlapping files.
- **Never testing** whether the context helps.
- **Never updating** it: write once, rot forever.
- **No owner.**

---

## Lab 09

**Exercise 1: Inventory (30 min).** List all your capstone knowledge: research findings, users, constraints, voice, glossary, interaction decisions. Tag each item global, local or ambient.

**Exercise 2: Write UX.md (2 h).** Use [templates/UX.md](../templates/UX.md). Convert your Module 04 and 06 findings into constraint-style insights with evidence strength. Write user models, world models, interaction standards and a glossary.

**Exercise 3: Library structure (30 min).** Organise your files (UX.md, DESIGN.md, AGENTS.md, glossary, a feature brief) in the structure from section 5, with an index README.

**Exercise 4: Context experiment (2 h).** Run the with/without experiment on 3 tasks × 3 conditions × 2 runs, using a prompt-to-app tool or the Figma agent. Score with the rubric, ideally with a colleague scoring blind.

**Exercise 5: Improve and re-test (45 min).** Based on the results, update the context and re-run the weakest task. Record the score change.

---

## Deliverable

1. **UX.md** for your capstone.
2. **Context library** folder with index README, owners and changelog.
3. **Context experiment report** (1–2 pages): method, scores, what improved output, what didn't, and next changes, with before/after screenshots.

---

## Self-check

1. Define UX-context design in one sentence.
2. Give a design example of global, local and ambient context.
3. Rewrite "users find search confusing" as a constraint-style insight.
4. What are NN/G's four lessons for context libraries?
5. Why run the with/without experiment, and what's in the rubric?
6. What is a "big ball of mud", and name two guardrails against it.

<details><summary>Answers</summary>

1. Curating what the organisation knows and wants (users, their world, how the product should look and behave) into context that guides everything its AI tools generate, and testing and refining that context.
2. Global: DESIGN.md or the glossary. Local: a feature brief or Figma frame. Ambient: Slack threads or meeting transcripts.
3. For example: "Users expect search to match partial invoice numbers and customer names. → Search must support partial matches across ID and name fields and show which field matched."
4. Context needs ongoing maintenance; let the agent update context (and verify); structure for findability; give agents only the context they need.
5. To prove (and improve) the value of context with evidence. The rubric covers system usage, fit to users, interaction standards, accessibility, and voice and glossary.
6. A system scraped together for short-term use that becomes fragile and hard to understand. Guardrails: a planned structure, owners and review cadence, a changelog, pruning, deliberate rebuilds, and re-testing.

</details>

---

## Go deeper

- NN/G: [UX-Context Design](https://www.nngroup.com/articles/ux-context-design/)
- NN/G: [The 3 Roles of Context for AI Agents](https://www.nngroup.com/articles/3-agent-context-roles/)
- NN/G: [Context Libraries](https://www.nngroup.com/articles/context-libraries/)
- NN/G: [The New Big Ball of Mud](https://www.nngroup.com/articles/big-ball-of-mud-ai/)
- Claude Academy (free): [Introduction to agent skills](https://academy.claude.com/courses)
- Paid: NN/G [Context Engineering: Shaping AI-Generated Designs](https://www.nngroup.com/courses/context-engineering-ai/)

**Next → [Module 10: Design to code with agents](10-design-to-code.md)**

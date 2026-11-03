# Module 03: Working with AI, prompting, critique and verification

> **Time:** about 5 hours · **Output:** your personal prompt library and a verification protocol

---

## Learning objectives

- Write prompts using a reliable structure, not clever tricks.
- Use AI as a **critic**, not just a generator, without getting flattered.
- Run a **diverge → converge** loop with AI that produces genuine variety.
- Apply a **verification protocol** proportional to risk.
- Build a reusable **prompt library** for yourself and, later, your team.

---

## Why this matters for a lead

You'll review a lot of AI-assisted work from your team, from PMs and from engineers. You need a shared vocabulary for good AI use ("did you verify that?", "what context did you give it?") and reusable assets (prompts, checklists) that raise the floor for everyone.

---

## 1. Prompting fundamentals that last

Prompting tricks come and go with each model generation. These fundamentals don't, because they're about **communicating a task clearly**, as you would to a capable new colleague.

### The 6-part prompt structure

| Part | Question it answers | Example |
|---|---|---|
| **1. Role / stance** | Who should it act as? | "Act as a senior UX writer for a B2B finance product." |
| **2. Goal** | What outcome do I want? | "Write empty-state copy for the Invoices list." |
| **3. Context** | What does it need to know? | "Users are finance admins; they arrive here after setup; most have no invoices yet; tone: calm, precise, no exclamation marks." |
| **4. Constraints** | What are the rules and limits? | "Headline ≤ 6 words, body ≤ 20 words, one primary CTA, use the term 'invoice' not 'bill'." |
| **5. Output format** | What shape should the answer take? | "Return a table: headline / body / CTA / rationale. Give 8 options." |
| **6. Quality bar / process** | How should it think and check? | "Make the options meaningfully different in approach. After listing, pick the best 2 and explain why." |

You don't need all six every time. But when output disappoints, **one of these six is usually missing**, most often *context* or *constraints*.

### Other durable habits

- **Show, don't just tell.** One good example beats a paragraph of description. Paste an existing screen, copy sample or component.
- **Ask it to ask.** "Before you start, ask me up to 5 questions that would most improve the result."
- **Iterate in the same thread.** Refine with feedback ("make 3 bolder, drop the playful ones") instead of starting over.
- **Break big tasks down.** Brief → structure → content → visual, not "design the whole app".
- **Name things precisely.** "Use the `Button/Primary` component" beats "a nice button".
- **Dictate when it's faster.** NN/G found power users casually *dictate* prompts and invest their effort in context instead ([source](https://www.nngroup.com/articles/context-libraries/)).

---

## 2. Diverge → converge with AI

AI is excellent at **divergence** (volume and variety) if you push against its pull toward the average. You stay in charge of **convergence**: choosing, combining and justifying.

### Forcing real divergence

Bad: *"Give me 10 ideas for onboarding."* You'll get 10 variations of the same carousel.

Better:

```
Give me 10 onboarding concepts for [product], each built on a DIFFERENT
underlying strategy. Use these lenses, one per concept:
1. Zero onboarding (learn by doing)
2. Progressive disclosure over the first week
3. Template-first
4. Concierge / human-assisted
5. Import-first (bring your data)
6. Goal-setting first
7. Social / team invite first
8. Interactive tutorial with real data
9. Contextual tips only
10. Something from a non-software domain (e.g., games, hospitality)
For each: one-sentence concept, who it's best for, biggest risk.
```

**Other divergence levers**

- "Assume the opposite of our current approach."
- "How would [Stripe / Duolingo / a hospital / an airline cockpit] solve this?"
- "Give 5 options a conservative enterprise team would ship, and 5 a bold startup would."
- Ask for **extremes** ("most minimal", "most guided") to map the solution space.

### Converging, which is your job

1. **Kill fast.** Cut obviously weak options and note why in one line each. Your reasons *are* your design judgment, and writing them down trains it.
2. **Cluster.** Group the survivors by strategy.
3. **Evaluate against the brief.** User goals, business goals, constraints, risks.
4. **Combine.** The best concept is often a hybrid.
5. **Decide and document.** One paragraph of rationale. This becomes context later.

---

## 3. AI as critic

Generation is the obvious use. **Critique is the underrated one.** A good critique prompt gives you a fast, tireless "second pair of eyes", provided you defend against sycophancy.

### Critique prompt patterns

**Heuristic evaluation**

```
You are a strict senior UX reviewer. Evaluate the attached screen against
Nielsen's 10 usability heuristics. For each problem:
- Severity: critical / major / minor
- Heuristic violated
- Exact location on screen
- Why it matters for [user type] doing [task]
- Concrete fix
List at most 10, ranked by severity. No praise. If you're unsure, say so.
```

**Persona walk-through** (a cognitive-walkthrough style)

```
Walk through this flow as [specific user: e.g., "a first-time admin at a
50-person company who has 10 minutes between meetings"]. At each step say:
what they're trying to do, what they see, what they'd likely do next, and
where they might hesitate or fail.
```

**Red team**

```
Argue AGAINST this design decision as convincingly as possible: [decision].
What would a sceptical engineer, a sceptical PM, and a frustrated user say?
```

**Consistency check**

```
Compare these 4 screens. List every inconsistency in spacing, type styles,
component usage, terminology, and interaction patterns.
```

**Accessibility pre-check**

```
Review this screen for likely WCAG 2.2 AA issues: contrast, target size,
focus order, labels, reliance on colour, motion. Mark each as "likely" or
"needs tool verification".
```

### Rules for using AI critique

- **Treat it as hypotheses, not verdicts.** Some findings will be wrong, generic or irrelevant.
- **Triage:** accept, reject (and say why), or "needs testing with users".
- **Precision checks need real tools.** Measure contrast with a contrast checker and accessibility with a proper audit tool and manual testing.
- **Compare with your own review first.** Do your critique, then ask AI. The gaps on both sides are where you learn.

---

## 4. Verification: a protocol proportional to risk

Not everything needs the same scrutiny. Use risk tiers:

| Tier | Examples | Verification |
|---|---|---|
| **Low**: drafts, exploration | Brainstorms, moodboards, first copy drafts | Skim for sense. |
| **Medium**: inputs to decisions | Research summaries, competitive scans, critique findings | Spot-check claims and sources; verify 3 key facts; check that quotes exist in the source. |
| **High**: shipped or high-stakes | Production copy, legal or financial text, accessibility claims, data visualisations, code | Full review by a qualified human, tool-based checks, user testing where relevant, an explicit sign-off. |

**The "verify 3" habit:** for any AI research or summary, pick the 3 claims your decision depends on most and check them against the primary source. If any are wrong, distrust the rest and redo it.

**Red flags that need extra checking**

- Specific numbers, percentages or dates
- Named sources, studies, quotes or URLs
- "Best practice says..." with no source
- Accessibility or legal compliance claims
- Anything that conveniently confirms what you hoped

---

## 5. Your prompt library

Prompts you reuse are assets. Store them, version them, share them.

**Format for each entry**

```
## [Name] – [when to use]
Tier: low / medium / high
Inputs needed: [screenshot, brief, persona...]
Prompt:
  ...
Known weaknesses:
  ...
Last improved: [date] – [what changed]
```

A starter library is in [templates/prompt-library.md](../templates/prompt-library.md). Over the course, you'll grow it to 15–25 prompts. In Module 13 it becomes a team asset.

> **Evolution path:** a prompt you use often should graduate into a **context file, rule or skill**, so that it's applied automatically instead of pasted in each time. That's the step from prompting to *context engineering* (Module 09).

---

## Common mistakes

- **Prompting like a search engine:** three keywords and no context.
- **Accepting the first output.** The first answer is the most average one.
- **Long chats that drift.** After many turns, models can lose earlier constraints. Restate key constraints or start fresh with a summary.
- **Asking for opinions instead of structured critique.**
- **No verification on medium and high tiers.**

---

## Lab 03

**Exercise 1: Prompt anatomy (45 min).** Take a real task (microcopy, a flow description, a design rationale). Write a one-line prompt and run it. Then write the full 6-part prompt and run it. Compare the two and note which of the six parts made the biggest difference.

**Exercise 2: Diverge and converge (60 min).** On your capstone, generate 10 strategically different concepts using the lens technique. Kill 7 with one-line reasons, cluster the remaining 3, and write a one-paragraph decision.

**Exercise 3: Critique duel (60 min).** Do your own heuristic evaluation of one capstone screen (or a current product screen). Then run the AI heuristic prompt. Make a table with three columns: *found by both*, *found only by me*, *found only by AI*. Triage the AI-only items as accept, reject or test.

**Exercise 4: Verification drill (30 min).** Ask AI for a competitive scan of 4 competitors for your capstone area. Apply "verify 3". Log what you found.

**Exercise 5: Build your library (45 min).** Save your 5 best prompts from this week in the library format.

---

## Deliverable

1. **Prompt library v1** with at least 5 entries.
2. **Critique duel table** with a one-paragraph reflection on where AI critique adds value and where it doesn't.
3. Your **verification protocol** (adapt the tiers to your context).

---

## Self-check

1. Name the six parts of the prompt structure. Which is most often missing?
2. How do you force genuine divergence instead of 10 variations of the average?
3. Why should you do your own critique *before* asking AI?
4. What is the "verify 3" habit?
5. When should a prompt graduate into a rule, context file or skill?

<details><summary>Answers</summary>

1. Role, goal, context, constraints, output format, quality bar or process. Context (and often constraints) is most often missing.
2. Assign each idea a different underlying strategy or lens, ask for extremes, borrow from other domains, and ask for opposites.
3. To avoid anchoring on AI's framing, and so that the gaps between the two reviews teach you something.
4. Identify the three claims your decision depends on most and verify them against primary sources. If any fail, distrust and redo the rest.
5. When you reuse it often, or when others need the same behaviour. It should then be applied automatically as context instead of pasted in each time.

</details>

---

## Go deeper

- NN/G: [Careful prompts](https://www.nngroup.com/articles/careful-prompts/) and the [AI study guides](https://www.nngroup.com/articles/ai-functionality-study-guide/)
- Claude Academy: [AI Fluency for creative work](https://academy.claude.com/courses/ai-fluency-for-creative-work) (free; the 4D framework is useful vocabulary for team policy)
- NN/G: [Heuristic evaluation](https://www.nngroup.com/articles/how-to-conduct-a-heuristic-evaluation/) (a refresher on the human method you're augmenting)

**Next → [Module 04: AI across the design process](04-ai-across-the-design-process.md)**

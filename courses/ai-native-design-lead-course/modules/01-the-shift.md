# Module 01: The Shift, what changed and what will last

> **Time:** about 3 hours · **Output:** your personal AI baseline and a capstone choice

---

## Learning objectives

By the end of this module you will be able to:

- Describe, with evidence, how UX practitioners actually use AI today, not how marketing says they do.
- Separate **durable changes** in design work from **hype and churn**.
- Explain the new shape of the designer's role and of the lead designer's role.
- Start an **AI log**, the habit that powers the rest of the course.

---

## Why this matters for a lead

Your team, your PMs and your executives will all have strong opinions about AI. Some will push mandates ("use AI for everything"), others will resist ("it's all slop"). A lead's first job is to **replace opinions with evidence**: what AI actually does well in *your* context, what it costs, and what it risks. This module gives you the baseline.

---

## 1. What the evidence says (2026)

In October 2026, Nielsen Norman Group published a survey of **521 UX practitioners** about AI at work ([source](https://www.nngroup.com/articles/ai-in-ux-survey-26/)). Key findings:

| Finding | Number |
|---|---|
| Have access to generative AI at work | **> 99%** |
| Limited to an *approved set* of tools | **59%** (only 12% can use anything) |
| Use AI features inside design tools | **65%** |
| Use at least one **agentic** tool | **66%** |
| Agentic use at startups vs nonprofits | **85% vs 36%** |
| Designers using agentic AI | **71%** |
| Top barrier: output quality | **54%** |
| Second barrier: data security or privacy | **50%** |
| Report no major barriers | **9%** |
| Average sentiment (1–5) | **3.57**, mildly positive |
| Open-ended comments with negative sentiment | **69%** (mandates, unreliable output) |
| Expect their role to stay important or grow | **65%** |

Also from the survey:

- AI is used **most for desk work** (writing, coding, desk research) and **least when real users are involved**.
- Designers and researchers felt **less job-secure** than PMs.
- Leadership pressure was common. Lack of executive buy-in was the *least* chosen barrier (6%). The problem is often too much push, not too little.

**What this means for you:**

1. AI is already normal. You're not early, and you're not late either, because quality and integration are still unsolved.
2. **Output quality and data privacy** are the real blockers. A lead who solves those (through context, systems, review gates and policy) creates real value.
3. Many people feel ambivalent. Change management (Module 13) is as important as tooling.

---

## 2. What changed, and what didn't

### Things that have genuinely changed (durable)

1. **Producing artifacts is cheap.** Screens, copy, variations, prototypes and even working code can be generated in minutes. The bottleneck has moved from *making* to **deciding, evaluating and integrating**.
2. **Interactive prototypes are cheap.** Complex interactions that used to wait for engineering (filters, dashboards, conversational UI) can now be tested with real users early ([NN/G](https://www.nngroup.com/articles/test-earlier-with-ai/)).
3. **Everyone can make UI.** PMs generate mockups and engineers' coding agents choose button labels and error states. Design decisions are being made by AI on behalf of non-designers ([NN/G: UX-context design](https://www.nngroup.com/articles/ux-context-design/)).
4. **The audience for design deliverables now includes machines.** Personas and specs were written for humans. Now AI tools also "read" your design system, your rules and your research. **Context** has become a deliverable.
5. **Design and code are converging.** With the Figma MCP server, agents can read your design (components, variables, layout) to write code. They can also write *back* into Figma using your components, or capture live UI from a browser into Figma layers ([Figma docs](https://developers.figma.com/docs/figma-mcp-server/)).
6. **Design systems moved from nice to have to critical infrastructure.** AI multiplies whatever system it's given. A clean system yields consistent output at speed, and a messy one yields inconsistent output at speed.

### Things that have not changed (and matter more now)

1. **You are not the user.** Real users still surprise you, and AI-simulated users are narrower than real ones (more in Module 04).
2. **Good design is judgment.** Choosing *which* of 30 variants is right, and why, is the job.
3. **Usability fundamentals.** Heuristics, accessibility, information architecture and content clarity still apply.
4. **Collaboration and trust.** Products are still built by teams. Alignment, rationale and shared standards still decide success.
5. **Accountability.** Someone human signs off. "The AI did it" is not an answer to a broken checkout or an inaccessible form.

### Hype to be sceptical of

| Claim | Reality |
|---|---|
| "AI will replace designers." | AI replaces some *tasks*. Demand for judgment, systems thinking and research is rising. |
| "Synthetic users replace research." | They can echo broad conclusions but produce far less variety than real people ([NN/G study](https://www.nngroup.com/articles/synthetic-users-vs-human-respondents/)). They're useful for pilot-testing study materials, not for replacing users. |
| "Prompt engineering is the key skill." | *Context* engineering, meaning what the AI knows about your users, system and standards, matters more than clever prompts ([NN/G](https://www.nngroup.com/articles/3-agent-context-roles/)). |
| "One tool does everything." | Teams combine a general assistant, design-tool AI, a prototyping tool and a coding agent. |
| "Faster means better." | Speed without verification creates rework. NN/G respondents said mandates and unreliable output "eat the gains". |

---

## 3. The new shape of the role

### The designer's work: from making to directing and judging

Think of a designer's time as split between four activities:

```
          BEFORE AI                         AI-NATIVE
  ┌───────────────────────┐       ┌───────────────────────┐
  │ Understanding  20%     │       │ Understanding  25%     │  ← research, framing
  │ Making         55%     │  →    │ Making         20%     │  ← AI drafts, you refine
  │ Evaluating     15%     │       │ Evaluating     30%     │  ← critique, testing, QA
  │ Systematising  10%     │       │ Systematising  25%     │  ← systems + context
  └───────────────────────┘       └───────────────────────┘
```

*These proportions are illustrative, not measured, but the direction of the shift is consistent across sources.*

### The AI-native designer's core loop

```
 Frame → Generate → Evaluate → Refine → Validate (with users) → Systematise
   ↑                                                                │
   └──────────── what you learned goes back into context ───────────┘
```

The last step is the new one. **What you learn becomes context** (rules, components, research insights), so the next generation of output starts better.

### The lead designer's expanded scope

As a lead in the AI era, you own (or co-own):

1. **Quality bar:** what "good" means, and the review gates that protect it.
2. **Workflow:** where AI fits in your team's process, and where it doesn't.
3. **Design system:** the shared infrastructure for humans and agents.
4. **Context library:** the research, standards and rules that steer every AI tool in the org.
5. **Tooling and policy:** approved tools, data rules, disclosure.
6. **People:** skills development, psychological safety, and fair expectations around speed.

---

## 4. The capability spectrum

You don't need to become an engineer. But you should know where you sit on this spectrum and where you want to be.

| Level | Description | Typical tools |
|---|---|---|
| 0 | Doesn't use AI | none |
| 1 | Uses chat for text tasks | ChatGPT, Claude, Gemini |
| 2 | Uses AI inside the design tool | Figma agent, Figma AI features |
| 3 | Builds interactive prototypes with AI | Figma Make, v0, Lovable, Bolt |
| 4 | Directs coding agents with design context | Claude Code, Cursor, Copilot with Figma MCP |
| 5 | Designs the system that steers everyone's AI | Design system, rules, UX.md, Code Connect, policy |

**A design lead should aim for level 4 competence and level 5 ownership.** You don't have to do level 4 work daily, but you must be able to do it, so that you can judge it and lead it.

---

## Common mistakes at this stage

- **Tool-hopping.** Trying every new tool weekly. Pick one per category and go deep.
- **Measuring nothing.** "It feels faster" is not evidence. Start the AI log today.
- **All or nothing.** Either refusing AI or using it for everything. The skill is *selective* use.
- **Skipping fundamentals.** AI amplifies skill. Weak fundamentals plus AI gives confident bad work.

---

## Lab 01

**Exercise 1: Tool setup (30 min).** Set up the tools from the [Start Here](../00-START-HERE.md#tool-setup-do-this-in-week-1) table. Don't configure MCP yet.

**Exercise 2: Your AI baseline (30 min).** Answer honestly in a doc:

1. Which design tasks do I spend the most time on each week?
2. Which have I tried with AI? What happened?
3. Where on the capability spectrum am I today (0–5)?
4. What am I most sceptical about? What am I most excited about?

**Exercise 3: Start your AI log (ongoing).** Copy [templates/ai-log.md](../templates/ai-log.md). For **every** AI use over the next 12 weeks, log the task, tool, time spent, time saved or lost, quality (1–5) and what you'd do differently. It takes 30 seconds per entry and gives you the evidence base for Module 13.

**Exercise 4: Choose your capstone (30 min).** Use the criteria in Start Here. Write one paragraph: product area, users, why it's interesting, and any data constraints.

**Exercise 5: Read and reflect (60 min).** Read the full [NN/G 2026 survey](https://www.nngroup.com/articles/ai-in-ux-survey-26/) and browse its [interactive comments dashboard](https://nngroup.github.io/research/ai-at-work/). Write down three quotes that match your experience and one that surprises you.

---

## Deliverable

A one-page **"My AI baseline"** document covering capability level, top tasks, hopes, fears and capstone choice, plus an AI log with your first entries.

---

## Self-check

1. What were the two biggest barriers to AI adoption in the 2026 NN/G survey?
2. Name three durable changes and three things that haven't changed.
3. Why is "context engineering" considered more important than "prompt engineering"?
4. What's the new final step in the AI-native designer's loop?
5. What capability level should a lead aim for, and why?

<details><summary>Answers</summary>

1. Output quality (54%) and data security or privacy (50%).
2. Changed: artifacts are cheap; interactive prototypes are cheap; everyone makes UI; deliverables have machine audiences; design and code are converging; design systems are critical. Not changed: you are not the user; design is judgment; usability fundamentals; collaboration; accountability.
3. Because output quality depends mostly on what the model knows about your users, system and standards. Clever wording can't supply missing knowledge.
4. **Systematise**: feed what you learned back into context (system, rules, research) so future output starts better.
5. Level 4 competence (directing coding agents with design context) and level 5 ownership (the system that steers everyone's AI). You must be able to do it in order to judge and lead it.

</details>

---

## Go deeper

- NN/G: [AI in UX: Work Is Faster, But Practitioners Have Mixed Feelings](https://www.nngroup.com/articles/ai-in-ux-survey-26/)
- NN/G: [UX-Context Design](https://www.nngroup.com/articles/ux-context-design/)
- NN/G: [AI topic hub](https://www.nngroup.com/topic/ai/)

**Next → [Module 02: How AI actually works](02-how-ai-works.md)**

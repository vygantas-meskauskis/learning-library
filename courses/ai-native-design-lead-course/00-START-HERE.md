# From Figma Designer to AI-Native Design Lead

### A complete, practical, self-paced course

> **Version:** October 2026. Tool features change fast. Concepts in this course are chosen because they are durable; tool-specific steps are flagged with 🔧 and should be re-checked against current docs.

---

## Who this course is for

You are a UX/UI designer who is fluent in Figma. You are about to become (or have just become) a **lead designer**, and you will be expected to:

1. Lead the **design practice**: quality, critique, process, mentoring.
2. Lead **AI tooling adoption** for the design team, and influence how product and engineering use AI to make UI.
3. Build and run a **design system** that works for people *and* for AI agents.

You do not need to know how to code. You will touch code in this course, gently and with an AI agent doing the typing, because a modern design lead needs to understand the material that their designs become.

---

## What you'll be able to do at the end

| Area | You will be able to... |
|---|---|
| **Understand AI** | Explain how LLMs and agents work, predict where they fail (hallucination, sycophancy, mode collapse), and choose the right tool for a task. |
| **Use AI in design** | Use AI across discovery, ideation, content, visual exploration, critique and QA, while keeping human judgment and real users in the loop. |
| **Prototype** | Build realistic, interactive, testable prototypes with AI tools, and know when a static Figma prototype is still the better choice. |
| **Design systems** | Build a tokenised, well-named, documented Figma design system, aligned with the W3C design-token standard. |
| **AI-ready systems** | Make the system machine-readable: component descriptions, DESIGN.md, Code Connect, and rules files for coding agents. |
| **Context engineering** | Turn research and standards into *context* (UX.md, rules, skills) that improves AI output for everyone in the company. |
| **Design to code** | Use the Figma MCP server with a coding agent, review its output, and close the loop from code back to canvas. |
| **Collaborate** | Define a modern designer–developer contract: ownership, review gates, sync, and the "everyone designs" reality. |
| **Design AI features** | Apply the core principles for AI-powered product features: trust, transparency, control, disclosure. |
| **Lead** | Write an AI policy, run a pilot with metrics, manage change between hype and scepticism, and build a 90-day plan. |

---

## Course map

| # | Module | Theme | Est. time |
|---|---|---|---|
| 01 | [The Shift: what changed and what will last](modules/01-the-shift.md) | Orientation | 3 h |
| 02 | [How AI actually works (for designers)](modules/02-how-ai-works.md) | Foundations | 4 h |
| 03 | [Working with AI: prompting, critique, verification](modules/03-working-with-ai.md) | Foundations | 5 h |
| 04 | [AI across the design process](modules/04-ai-across-the-design-process.md) | Practice | 6 h |
| 05 | [Figma's AI toolkit](modules/05-figma-ai-toolkit.md) | Tools | 4 h |
| 06 | [AI prototyping and testing with real users](modules/06-ai-prototyping.md) | Practice | 8 h |
| 07 | [Design system foundations for the AI era](modules/07-design-system-foundations.md) | Systems | 8 h |
| 08 | [Making your design system AI-ready](modules/08-ai-ready-design-system.md) | Systems | 6 h |
| 09 | [Context engineering and UX-context design](modules/09-context-engineering.md) | Systems | 6 h |
| 10 | [Design to code with agents](modules/10-design-to-code.md) | Delivery | 8 h |
| 11 | [Designer–developer collaboration, rebuilt](modules/11-designer-developer-collaboration.md) | Team | 4 h |
| 12 | [Designing AI-powered product features](modules/12-designing-ai-features.md) | Product | 4 h |
| 13 | [Leading AI adoption as a design lead](modules/13-leading-ai-adoption.md) | Leadership | 6 h |
| 14 | [Capstone and your first 90 days](modules/14-capstone-and-90-days.md) | Synthesis | 8 h |

**Total:** about 80 hours. At 6–7 hours a week, that's **12 weeks**. A suggested schedule is below.

Supporting material:

- 📁 [templates/](templates/README.md): ready-to-use files (context files, rules, policy, contract, checklists, logs).
- 📖 [Glossary](GLOSSARY.md): every term used in the course, in plain language.
- 🔗 [Resources](RESOURCES.md): verified links, free and paid, used throughout.

---

## How each module is built

Every module follows the same structure so you can study efficiently:

1. **Learning objectives**: what you'll be able to do afterwards.
2. **Why this matters for a lead**: the leadership angle, not just the craft angle.
3. **Core concepts**: explanations, with examples.
4. **In practice**: workflows, prompts and patterns you can copy.
5. **Common mistakes**: what goes wrong and how to avoid it.
6. **Lab**: hands-on exercises on your capstone project.
7. **Deliverable**: a concrete artifact that goes in your portfolio.
8. **Self-check**: questions with answers, to test your understanding.
9. **Go deeper**: curated reading and viewing.

---

## The capstone project (runs through the whole course)

Learning sticks when it is applied to something real. Before you start Module 01, choose **one product area** to carry through every module.

**Good capstone candidates**

- A real feature area at your (future) company: settings, onboarding, a dashboard, search and filters, a checkout.
- A past portfolio project you'd like to redo properly.
- A small product idea of your own, ideally one with a complex interaction such as filters, a multi-step flow, or a data table.

**Avoid** anything with confidential data you're not allowed to put into AI tools. If it's a company project, use sanitised data. Module 13 covers data rules in detail.

**By the end you will have:**

1. A research-informed brief.
2. A tokenised, documented mini design system in Figma.
3. Machine-readable context: DESIGN.md, UX.md and agent rules.
4. A tested, interactive AI prototype.
5. A coded screen built by an agent from your Figma file, plus a drift log.
6. A designer–developer collaboration contract.
7. An AI policy and adoption playbook for a design team.
8. A 90-day plan and a leadership presentation.

That's a complete, very strong portfolio case study for a lead role.

---

## Tool setup (do this in week 1)

Free tiers are enough for almost everything. You need **one tool from each row**.

| Category | Options | Used in |
|---|---|---|
| Design tool | Figma (a paid seat makes MCP, the agent and Make far more useful) | All modules |
| General AI assistant | Claude, ChatGPT, Gemini, Microsoft Copilot | 02–04, 09, 13 |
| AI prototyping / "vibe coding" | Figma Make, v0, Lovable, Bolt | 06 |
| Coding agent | Claude Code, Cursor, GitHub Copilot (VS Code or CLI), OpenAI Codex | 10 |
| Code hosting | A free GitHub account | 10–11 |
| Code editor | VS Code (free) | 10 |

🔧 For Module 10 you'll connect the **Figma MCP server** to your coding agent. The remote server is at `https://mcp.figma.com/mcp`, and setup instructions are in [Figma's MCP docs](https://developers.figma.com/docs/figma-mcp-server/). Writing to the canvas requires the remote server and a Full seat for files outside your drafts.

> **Data rule from day one:** never paste confidential customer data, unreleased financials, credentials or personal data into an AI tool your company hasn't approved. When in doubt, sanitise or invent realistic fake data.

---

## Suggested 12-week schedule

| Week | Modules | Main output |
|---|---|---|
| 1 | 01, 02 | AI log started, tool setup done, capstone chosen |
| 2 | 03 | Personal prompt library and critique protocol |
| 3 | 04 | Capstone brief, with research and concepts |
| 4 | 05 | Figma agent and Make experiments |
| 5 | 06 | Interactive prototype, version 1 |
| 6 | 06 (testing) | 3–5 usability tests and findings, prototype v2 |
| 7 | 07 | Tokens and core components in Figma |
| 8 | 08 | AI-ready system: descriptions, DESIGN.md, rules |
| 9 | 09 | UX.md and a context A/B experiment |
| 10 | 10 | Coded screen via MCP and a drift log |
| 11 | 11, 12 | Collaboration contract, AI-feature review |
| 12 | 13, 14 | AI policy, pilot plan, 90-day plan, presentation |

**Weekly rhythm**

- **Monday:** read the module (1–2 h).
- **Tuesday to Thursday:** labs (3–4 h).
- **Friday:** update your AI log, write a 5-line reflection, and share one learning with a colleague or publicly. Teaching is the fastest way to consolidate what you've learned, and it builds your reputation as a lead.

---

## How to assess yourself

At the end, score yourself 1–4 on each row. Aim for at least 3 everywhere before calling yourself AI-native.

| Competency | 1 Aware | 2 Practising | 3 Fluent | 4 Leading |
|---|---|---|---|---|
| AI literacy | Knows terms | Predicts common failures | Chooses tools by task and risk | Teaches others, sets policy |
| AI in process | Uses chat occasionally | Uses AI in 2–3 stages | Has a repeatable workflow with verification | Has defined the team workflow |
| Prototyping | Has tried a tool | Builds simple prototypes | Builds realistic, testable prototypes | Sets the prototyping strategy |
| Design systems | Uses a library | Builds components and variables | Runs a tokenised, documented system | Governs adoption and contribution |
| AI-ready systems | Knows the concept | Writes component descriptions | Ships DESIGN.md, rules, Code Connect | Measures and improves AI output |
| Context engineering | Knows the term | Writes a context file | Runs context experiments | Owns the org's context library |
| Design to code | Reads Dev Mode | Runs an agent with MCP | Reviews and corrects agent output | Defines the dev–design pipeline |
| Leadership | Has opinions | Has run one experiment | Has run a pilot with metrics | Has an adopted policy and roadmap |

---

## A note on "best practice" in a fast-moving field

You asked to learn only what is *actually* best practice and likely to stay. This course separates the two kinds of knowledge:

- **Durable (learn deeply):** how LLMs behave, verification habits, context engineering, design tokens and systems, real-user research, design–dev contracts, change leadership. These were true in 2024, are true now, and will very likely be true in 2028.
- **Volatile (learn just in time):** specific tool UIs, menu names, pricing, which model is best this month. These are marked 🔧. Learn them when you need them, from the official docs.

When a tool changes, you'll still know *why* you're doing what you're doing. That understanding is what separates a lead from a tool operator.

**Start here → [Module 01: The Shift](modules/01-the-shift.md)**

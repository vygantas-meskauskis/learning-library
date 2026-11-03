# Module 02: How AI actually works (for designers)

> **Time:** about 4 hours · **Output:** a one-page "AI mental model" cheat sheet in your own words

---

## Learning objectives

- Explain in plain language what a large language model (LLM) does, and why that explains both its strengths and its failures.
- Understand **tokens, context windows, non-determinism, hallucination, sycophancy and mode collapse**, and what each means for design work.
- Distinguish between a **chatbot**, an **AI feature in a tool**, an **AI agent**, and the plumbing that connects them (**tools, MCP, skills**).
- Predict *before* you try it whether a task is a good fit for AI.

---

## Why this matters for a lead

You'll be asked "Can AI do X?" constantly. Without a mental model, you'll answer from hype or fear. With one, you can say "Yes for drafts, no for final decisions, and here's the review step." That's the difference between a tool enthusiast and a trusted lead.

---

## 1. The core idea: prediction from patterns

An LLM is trained on enormous amounts of text (and, for multimodal models, images, audio and code) to do one thing extremely well: **predict a plausible continuation** of what it has been given.

Everything else (answering questions, writing code, critiquing a design) is built on top of that ability, plus additional training to make it helpful, follow instructions and avoid harm.

**Three consequences that matter to designers:**

1. **It produces the plausible, not the true.** Usually plausible and true overlap. When they don't, you get confident errors. NN/G's [explainer on how generative AI works](https://www.nngroup.com/articles/how-ai-works/) is a good non-technical read.
2. **It gravitates to the average.** Ask for "a search screen" and you get the *most typical* search screen in its training data. NN/G puts it this way: "It knows what software *generally* looks like. It doesn't know your users" ([source](https://www.nngroup.com/articles/ux-context-design/)). **Context is how you move it off the average**, which is the subject of Module 09.
3. **It has no memory of you by default.** Each conversation starts fresh unless the product adds memory, files or connections. What it "knows" about your project is only what's in its current context.

---

## 2. Key concepts in plain language

### Tokens

Models read and write in **tokens**, chunks of roughly ¾ of an English word. Pricing, speed and limits are measured in tokens. Images also consume tokens.

*Design implication:* long files, huge Figma frames and big screenshots can use up a lot of the model's capacity. That's why Figma's MCP rules suggest fetching a **metadata map** first, then only the nodes you need ([Figma custom rules](https://developers.figma.com/docs/figma-mcp-server/add-custom-rules/)).

### Context window

The **context window** is everything the model can "see" at once: your prompt, the conversation so far, attached files, tool results and system instructions. It's large in modern models (often hundreds of thousands of tokens) but not infinite, and **quality can degrade** when it's stuffed with irrelevant material.

*Design implication:* more context isn't always better. **Relevant** context is better. NN/G's lesson 4 on context libraries is to give agents only the context they need ([source](https://www.nngroup.com/articles/context-libraries/)).

### Non-determinism (temperature)

The same prompt can give different outputs, because models sample from probabilities. Some tools let you control randomness ("temperature"); most hide it.

*Design implication:*

- Good for ideation: run it again for more variety.
- Bad for consistency: two people asking for "a settings page" get two different settings pages. **Systems and rules create consistency, not prompts.**
- For testing AI features, you must test the *range* of outputs, not one happy path.

### Hallucination

The model states something false with confidence, such as an invented statistic, a non-existent API or a fake citation. It happens because it generates plausible text, not verified facts. Hallucination has been reduced but not eliminated, and NN/G explains why it's [hard to remove](https://www.nngroup.com/articles/ai-hallucinations/).

*Design implication:* **verify facts, numbers, quotes, citations and accessibility claims.** When AI says "this passes WCAG AA", check it with a real contrast tool.

### Sycophancy

Models are trained to be helpful and liked, so they tend to **agree with you** and praise your work ([NN/G](https://www.nngroup.com/articles/sycophancy-generative-ai-chatbots/)).

*Design implication:* "What do you think of my design?" invites flattery. Ask instead: "List the five most serious usability problems, ranked by severity, with the heuristic each violates." Module 03 covers critique prompts.

### Mode collapse (narrowness)

Generated outputs cluster around a narrow set of typical answers. NN/G compared 120 synthetic respondents with 604 humans. Both pointed to the same broad conclusion, but the synthetic answers used a **much narrower range** of responses ([source](https://www.nngroup.com/articles/synthetic-users-vs-human-respondents/)).

*Design implication:* AI is a weak substitute for real user diversity and for genuine creative divergence. Push for variety explicitly and still test with real people.

### Multimodality

Modern models can take images, screenshots, PDFs and sometimes audio or video as input, and generate images. They can "see" your screen and critique it.

*Design implication:* screenshot critique, layout-to-code and moodboard generation all work. Image *understanding* is good but can miss fine details like 1px misalignments or subtle contrast issues. Use real tools for precision checks.

### Knowledge cut-off

Models are trained up to a date. Without web access they may not know recent tools, guidelines or your competitors' latest releases.

*Design implication:* for anything current, use a tool with web search *and* check the sources.

---

## 3. From chatbots to agents: the building blocks

| Concept | What it is | Design example |
|---|---|---|
| **Chatbot / assistant** | You ask, it answers, inside one conversation. | Ask Claude to draft error-message variants. |
| **AI feature in a tool** | AI embedded in a product, with that product's context. | Figma agent generating a variant using your connected library. |
| **Tool use** | The model can call functions: search, read a file, run code. | The assistant searches the web, then summarises. |
| **Agent** | A model that **plans and executes multi-step tasks** using tools, checking its own progress. | A coding agent reads your Figma frame, writes components, runs the app and fixes errors. |
| **MCP (Model Context Protocol)** | An open standard for connecting AI apps to tools and data, "like a USB-C port" for AI. | The **Figma MCP server** lets agents in Claude Code, Cursor, Copilot and others read and write Figma. |
| **Skills** | Packaged instructions and resources an agent loads when relevant (often a folder with a `SKILL.md` that describes when to use it). | Figma's `figma-use` skill helps agents write to the canvas correctly. |
| **Rules / instruction files** | Project-level instructions an agent follows every time: `AGENTS.md`, `CLAUDE.md`, `.cursor/rules`, `.github/copilot-instructions.md`. | "Always use components from /design-system; never hardcode colours." |
| **Context library** | The collection of files, databases and connections an agent draws on ([NN/G](https://www.nngroup.com/articles/context-libraries/)). | Your DESIGN.md, UX.md, component docs and research insights. |
| **RAG (retrieval)** | The system searches a knowledge base and adds relevant snippets to the context before answering. | An internal "ask the design system" bot. |

### What makes an agent different

A chatbot gives you *an answer*. An agent pursues *a goal*:

```
Goal: "Implement this Figma frame using our design system"
  1. Read the design context (via MCP)
  2. Look at the screenshot
  3. Find matching components in the codebase
  4. Write the code
  5. Run it and see errors
  6. Fix the errors
  7. Compare with the screenshot
  8. Report back
```

Agents are powerful because they **iterate**, and risky because they **act**: they can change files, send things and spend money. That's why governance matters, meaning what an agent may do without approval (Module 13).

### Why MCP matters to you

Before MCP, every AI tool needed a custom integration for every app. MCP standardises that, which is why a single **Figma MCP server** works with many clients, including Claude Code, Codex, Copilot, Cursor and VS Code ([Figma's client list](https://developers.figma.com/docs/figma-mcp-server/)).

As a design lead, the Figma MCP server is the bridge between your design system and every coding agent in your company. What you put in Figma (component names, variables, descriptions, Code Connect mappings) **directly becomes what agents see.**

---

## 4. Will AI help with this task? A quick heuristic

Score the task on four questions:

| Question | Favourable for AI | Unfavourable for AI |
|---|---|---|
| **Is a good-enough answer common in the world?** | Typical patterns (login, settings) | Novel domain, specialist workflows |
| **Can I verify the output quickly?** | Yes: visual, testable, checkable | No: hidden errors, slow to check |
| **What's the cost of a mistake?** | Low: a draft or exploration | High: legal, safety, money, accessibility |
| **Do I have the context to give it?** | Yes: system, research, rules | No: it would have to guess |

- **Four favourable answers:** delegate the draft and review it.
- **Mixed:** use AI as an assistant, with heavy review.
- **Mostly unfavourable:** do it yourself, and maybe use AI to critique your work afterwards.

**Examples**

- Generate 10 microcopy variants for an empty state → ✅ delegate.
- Summarise 12 interview transcripts → ⚠️ assist. Verify quotes and watch for over-focus on the wrong theme.
- Decide the information architecture for a medical dosing tool → ❌ do it yourself, with domain experts and users.

---

## Common mistakes

- **Treating AI output as fact.** Verify claims, numbers and citations.
- **Asking for validation instead of critique.** You'll get flattery.
- **Expecting consistency from prompts alone.** Consistency comes from systems, rules and components.
- **Overloading context.** Dumping every file in degrades quality. Curate.
- **Anthropomorphising.** "It understands our users" is wrong. It has *text about* your users if you gave it some.

---

## Lab 02

**Exercise 1: Observe non-determinism (20 min).** Ask the same assistant the same prompt three times in fresh chats: *"Design the information hierarchy for a mobile banking home screen. List sections in order with a one-line rationale."* Compare the results. What stayed the same (the "average") and what varied?

**Exercise 2: Provoke sycophancy, then fix it (30 min).** Upload a screenshot of one of your designs.

- Prompt A: *"What do you think of my design?"*
- Prompt B: *"You are a strict senior design reviewer. List the 7 most severe usability problems in this screen, ranked by severity (critical/major/minor), each mapped to a Nielsen heuristic, with a concrete fix. Do not include praise."*

Compare the two responses. Log both.

**Exercise 3: Catch a hallucination (30 min).** Ask: *"Give me 5 statistics with sources about how users interact with onboarding flows in fintech apps."* Check every source. How many exist and say what was claimed? Write down what you found.

**Exercise 4: Multimodal limits (20 min).** Take one screen, introduce three subtle issues (a 2px misalignment, a 3.5:1 contrast text, one inconsistent corner radius) and ask the AI to find "all visual inconsistencies". Which did it catch?

**Exercise 5: Apply the heuristic (30 min).** List 10 recurring tasks from your work. Score each with the four questions above and label it *delegate*, *assist* or *do myself*. This becomes the first draft of your team's AI workflow map (Module 13).

**Exercise 6: Read (60 min)**

- NN/G: [How AI Works study guide](https://www.nngroup.com/articles/ai-functionality-study-guide/): glossary, *How Generative AI Works*, *Hallucinations*, *Sycophancy*.
- Claude Academy: [Introduction to Model Context Protocol](https://academy.claude.com/courses) (about 1 h, free).

---

## Deliverable

An **AI mental model cheat sheet** (one page) in your own words, covering the eight concepts above. For each, add one line on "what it means for design work", plus your 10-task delegate/assist/do-myself map.

---

## Self-check

1. Why does an LLM tend to produce an "average" design, and what's the main lever to change that?
2. Two designers prompt "a settings page" and get different results. Why, and how do you get consistency?
3. Rewrite "Is my design good?" as a prompt that resists sycophancy.
4. What's the difference between a chatbot and an agent?
5. What is MCP, and why does the Figma MCP server matter to a design lead?
6. What did NN/G's synthetic-user study reveal about synthetic respondents?

<details><summary>Answers</summary>

1. Because it predicts the most plausible output given its training data. The main lever is **context**: your users, system, standards and research.
2. Non-determinism, plus a lack of shared context. Consistency comes from a design system, rules files and components the AI must use, not from prompt wording.
3. For example: "As a strict reviewer, list the N most severe usability issues, ranked, each with the violated heuristic and a fix. No praise."
4. A chatbot answers within a conversation. An agent pursues a goal through multiple steps, using tools, checking results and iterating.
5. An open standard for connecting AI apps to tools and data. The Figma MCP server exposes your designs, components and variables to many coding agents, so your Figma hygiene directly shapes AI-generated code.
6. The synthetic data reached the same broad conclusion as the 604 humans but with far less variety (mode collapse). It is useful as a sanity check but not a replacement for real users.

</details>

---

## Go deeper

- NN/G: [Artificial Intelligence: Glossary](https://www.nngroup.com/articles/artificial-intelligence-glossary/)
- NN/G: [AI: First New UI Paradigm in 60 Years](https://www.nngroup.com/articles/ai-paradigm/) (intent-based interaction)
- [Model Context Protocol introduction](https://modelcontextprotocol.io/introduction)
- Figma: [What is MCP?](https://www.figma.com/resource-library/) (Resource Library)

**Next → [Module 03: Working with AI](03-working-with-ai.md)**

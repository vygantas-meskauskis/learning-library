# Module 12: Designing AI-powered product features

> **Time:** about 4 hours · **Output:** an AI-feature review of a real product, plus an AI feature concept for your capstone that passes the "value first" test

> This course is mostly about **using** AI to design. But as a lead you'll also be asked to design **AI features** into products, and you'll review your team's AI feature work. This module gives you the durable principles.

---

## Learning objectives

- Decide **whether** AI adds value to a feature, before deciding how.
- Recognise the main **interaction paradigms** for AI features (intent-based, chat, inline, generative UI, agents).
- Design for **non-determinism, errors and trust**.
- Apply guidelines for **transparency, control, explanation and disclosure**.
- Design for **AI agents as users** of your product.

---

## Why this matters for a lead

AI features are where hype hits users hardest: sparkle buttons nobody understands, chatbots that can't help, agents that act without consent. A lead protects users and the business by insisting on **value first, then trustworthy design**.

---

## 1. Value first: should this be AI at all?

NN/G is blunt: **"Powered by AI" is not a value proposition**, and AI features **must solve real user problems** ([study guide](https://www.nngroup.com/articles/designing-ai-study-guide/)). Novelty rarely produces value. Start from the problem, not the technology.

### Where AI genuinely helps

NN/G's **four AI "superpowers"**: **content creation, summarisation, basic data analysis and perspective-taking** ([source](https://www.nngroup.com/articles/ai-superpowers/)). If your feature idea doesn't use at least one, question it.

### The value-first test

1. **What user problem does this solve?** Is there evidence it exists?
2. **What do users do today** without AI? Is the AI way clearly better?
3. **Could a non-AI solution work** (better defaults, search, a filter, a template)?
4. **What happens when the AI is wrong?** Is that acceptable for this task?
5. **Can users tell what it does?** (NN/G found users often can't tell what a site's AI chatbot is for.)
6. **Is the scope narrow enough?** Narrowly scoped AI features are easier to understand and see better adoption ([source](https://www.nngroup.com/articles/scope-ai-features/)).

---

## 2. Interaction paradigms

### Intent-based interaction

NN/G describes AI as the **first new UI paradigm in 60 years**: **intent-based outcome specification**, where users state *what* they want rather than *how* to do it ([source](https://www.nngroup.com/articles/ai-paradigm/)).

Its weakness is the **articulation barrier**: many users struggle to express what they want in words. The solution is **hybrid interfaces**, combining prompts with GUI controls ([source](https://www.nngroup.com/articles/ai-articulation-barrier/)).

### Patterns and when to use them

| Pattern | Good for | Watch out for |
|---|---|---|
| **Chat** | Open-ended questions, exploration | Not always the answer ([NN/G](https://www.nngroup.com/articles/ai-chat-not-the-answer/)); low discoverability; users want answers, not conversation ([NN/G](https://www.nngroup.com/articles/less-chat-more-answer/)) |
| **Inline assist** | Summaries, rewrite, suggestions within existing UI | Must be noticeable ([discoverability](https://www.nngroup.com/articles/discoverability-ai-amazon/)) |
| **Prompt suggestions / controls** | Teaching capability, reducing the articulation barrier | Must be relevant and specific ([NN/G](https://www.nngroup.com/articles/prompt-suggestions/)) |
| **Generative UI** | Interfaces generated for a user's outcome, such as buttons and checkboxes inside chat | Consistency and predictability ([NN/G](https://www.nngroup.com/articles/genui-buttons-and-checkboxes/)) |
| **Agents** | Multi-step tasks done on the user's behalf | Autonomy, consent, error recovery ([NN/G](https://www.nngroup.com/articles/designing-ai-agents/)) |

### The ✨ sparkles problem

The sparkles icon has become associated with AI but is **inherently ambiguous** ([NN/G](https://www.nngroup.com/articles/ai-sparkles-icon-problem/)). Label what the feature *does* ("Summarise reviews"), not that it's AI.

---

## 3. Designing for non-determinism and errors

AI output varies and is sometimes wrong. Design for that explicitly.

- **Set expectations:** state capabilities and limits up front ("I can answer questions about your invoices; I can't change payments").
- **Show sources and evidence:** citations, links, "based on 248 reviews".
- **Make output editable:** a draft the user refines, not a final answer.
- **Easy undo and recovery:** especially for actions.
- **Confidence cues,** where meaningful and honest.
- **Graceful failure:** "I'm not sure. Here's how to find out" beats a confident error.
- **Human handoff:** a path to a person when it matters. NN/G lists **handoff willingness** among the five qualities of trustworthy site chatbots ([source](https://www.nngroup.com/articles/dimensions-of-ai-chatbots/)).
- **Write for the web:** AI output should be concise, scannable, inverted-pyramid and plain-language ([NN/G](https://www.nngroup.com/articles/genai-write-for-the-web/)).

### Testing AI features

- Test the **range** of outputs, not one happy path. Run the same scenario multiple times.
- Include **adversarial and edge inputs:** vague requests, out-of-scope requests, sensitive topics.
- Use **interactive prototypes connected to real models** (the Ramp example, Module 06).
- Define **quality rubrics** with domain experts.

---

## 4. Trust, control and transparency

### Durable guideline sets worth knowing

- **Microsoft's Guidelines for Human-AI Interaction (HAX):** 18 guidelines grouped by *initially*, *during interaction*, *when wrong* and *over time* (for example "make clear what the system can do", "support efficient correction", "remember recent interactions", "notify users about changes"). [HAX Toolkit](https://www.microsoft.com/en-us/haxtoolkit/)
- **Google PAIR People + AI Guidebook:** user needs, mental models, explainability and trust, feedback and control, errors and graceful failure. [PAIR Guidebook](https://pair.withgoogle.com/guidebook/)

These predate the current wave but remain highly relevant, which is a good sign they're durable.

### Control principles for agents

When AI **acts** for users (sends, books, edits, buys):

- **Preview before acting** on anything consequential.
- **Explicit consent** for irreversible, financial or social actions.
- **Visible activity:** what it did, step by step.
- **Interruptible:** users can stop it.
- **Reversible** where possible.
- **Scoped permissions:** what it can access, and for how long.

NN/G's lessons from studying an AI agent (Qwen): **support discoverability, reuse familiar patterns, handle personal data carefully, and protect user autonomy** ([source](https://www.nngroup.com/articles/designing-ai-agents/)).

### Explanations

Different roles need **different explanations** of the same AI output ([NN/G](https://www.nngroup.com/articles/crafting-ai-explanations/)). An end user needs "why this result"; an admin needs "what data and rules"; compliance needs an audit trail.

### Disclosure (PACED)

Revisit Module 04: Policy, Audience, Context, Expectations, Degree. NN/G notes that **third-party disclosure triggered the strongest negative reactions** in the studies reviewed, so proactive disclosure is often safer ([source](https://www.nngroup.com/articles/disclose-ai-paced/)). EU transparency obligations for AI-generated content began applying in **August 2026**. Involve legal for regulated contexts.

---

## 5. AI agents as users of your product

A newer shift: **AI agents now use digital interfaces alongside humans**: browsing, filling forms, comparing products ([NN/G](https://www.nngroup.com/articles/ai-agents-as-users/)).

Implications for design leads:

- **Accessibility helps agents too:** semantic HTML, proper labels and clear structure make UIs legible to agents as well as assistive technology.
- **Clear, consistent information architecture** and predictable patterns.
- **Machine-readable content:** structured data, clear pricing and policies.
- **Decide your stance:** which agent actions to support, require confirmation for, or block.

---

## Common mistakes

- **AI-first, problem-second.**
- **Chat as the default UI.**
- **Sparkles instead of labels.**
- **Testing one happy path** for a non-deterministic feature.
- **Agents acting without preview or consent.**
- **Opaque output** with no sources, no edit and no undo.

---

## Lab 12

**Exercise 1: AI feature teardown (60 min).** Pick 2 AI features in products you use. Evaluate each against the value-first test, the error and trust principles, and 5 HAX guidelines of your choice. Rate each 1–5 and list 3 improvements.

**Exercise 2: Capstone AI feature (90 min).** Propose one AI feature for your capstone. It must:

- Pass the value-first test, with evidence from your research
- Choose a pattern deliberately (and say why not chat, if it isn't chat)
- Specify error states, recovery, sources and editing
- Specify consent and preview if it acts
- Include a PACED disclosure decision

**Exercise 3: Prototype the risky part (optional, 90 min).** Use an AI prototyping tool to prototype the feature's riskiest interaction, connected to a real model if possible. Run the same scenario 5 times and document the variation.

---

## Deliverable

1. **AI feature teardown** of 2 real features.
2. **Capstone AI feature spec** (1–2 pages), including error, trust and disclosure design.

---

## Self-check

1. What are NN/G's four AI superpowers?
2. What's the articulation barrier, and how do hybrid interfaces help?
3. Name four principles for designing around AI errors.
4. Name four control principles for agents that act on behalf of users.
5. Why does accessibility matter for AI agents as users?

<details><summary>Answers</summary>

1. Content creation, summarisation, basic data analysis, perspective-taking.
2. Users struggle to express their intent in words. Hybrid interfaces combine prompts with GUI controls (options, buttons, sliders) to reduce that burden.
3. Any four of: set expectations, show sources, make output editable, easy undo, honest confidence cues, graceful failure, human handoff.
4. Any four of: preview before acting, explicit consent, visible activity, interruptible, reversible, scoped permissions.
5. Semantic structure and labels make interfaces interpretable to agents as well as assistive technologies.

</details>

---

## Go deeper

- NN/G: [Designing AI Products and Features: Study Guide](https://www.nngroup.com/articles/designing-ai-study-guide/)
- [Microsoft HAX Toolkit](https://www.microsoft.com/en-us/haxtoolkit/)
- [Google PAIR People + AI Guidebook](https://pair.withgoogle.com/guidebook/)
- Paid: NN/G [Designing AI Experiences](https://www.nngroup.com/courses/designing-ai-experiences/)
- Paid: [50 AI Design Patterns That Actually Work (Vitaly Friedman, Maven)](https://maven.com/web-adventures/ai-design-patterns-that-work)

**Next → [Module 13: Leading AI adoption](13-leading-ai-adoption.md)**

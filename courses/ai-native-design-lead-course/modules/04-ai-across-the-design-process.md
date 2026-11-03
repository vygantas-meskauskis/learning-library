# Module 04: AI across the design process

> **Time:** about 6 hours · **Output:** a research-informed capstone brief, plus your stage-by-stage AI workflow map

---

## Learning objectives

- Apply AI appropriately at each stage of the design process: **discover, define, ideate, design, validate, deliver**.
- Know where AI is strong, where it's risky, and where it should not replace human work.
- Use AI for research support without corrupting your research.
- Use AI for content and UX writing, visual exploration, and documentation.
- Produce a capstone brief using an AI-assisted but human-led process.

---

## Why this matters for a lead

You'll define *the team's* workflow. A lead who knows exactly where AI helps (and where it hurts) at each stage can write guidance that speeds the team up without lowering quality, and can push back credibly on "just use AI for research".

---

## The map: AI by stage

| Stage | Strong uses | Use with care | Don't replace |
|---|---|---|---|
| **Discover** | Desk research, competitor scans, domain primers, interview guide drafts, transcription | Synthesis of real research data, survey design | Talking to and observing real users |
| **Define** | Problem-statement drafts, assumption mapping, JTBD phrasing, "how might we" variants | Prioritisation suggestions | Deciding the problem worth solving |
| **Ideate** | Divergent concepts, analogies, extreme options, flows, IA alternatives | Choosing among concepts | Your judgment and the team's choice |
| **Design** | Layout variants, content and microcopy, placeholder data, imagery, icons, states | Visual identity work, brand-defining choices | Taste, coherence, system decisions |
| **Validate** | Test-script drafts, pilot-testing study materials, note-taking, initial clustering, heuristic pre-checks | Analysis and interpretation | Usability testing with real users |
| **Deliver** | Specs, annotations, documentation, release notes, code via agents (Module 10) | Accessibility claims, production code | Human sign-off |

This matches how practitioners actually work. NN/G's 2026 survey found AI is used **most** for desk-based work and **least** for work with users ([source](https://www.nngroup.com/articles/ai-in-ux-survey-26/)).

---

## Stage 1: Discover

### Desk research

AI (ideally with web search) is very good at fast orientation: "What are the main regulatory constraints for X?", "How do the top 6 competitors handle onboarding?", "Explain the workflow of a warehouse dispatcher."

**Do:**

- Ask for **sources** and open them.
- Ask for **uncertainty**: "What are you least sure about?"
- Use the output as a **map of what to verify and whom to ask**, not as findings.

**Prompt: domain primer**

```
I'm a product designer new to [domain]. Give me a primer:
1) key roles and their goals, 2) typical workflows, 3) jargon (glossary),
4) regulations/constraints, 5) common pain points reported publicly,
6) 10 questions I should ask domain experts.
Cite sources where possible and mark anything uncertain.
```

### Planning research with AI

AI is a solid assistant for drafting **interview guides, screeners and survey questions**. It's also good at reviewing them for leading questions, double-barrelled questions and jargon.

```
Review this interview guide for: leading questions, double-barrelled
questions, jargon, missing probes, and questions that ask users to predict
future behaviour. Suggest rewrites.
```

### Synthesis: powerful, but handle with care

AI can transcribe, summarise and cluster interview notes fast. The risks:

- **Over-focus or wrong focus.** NN/G notes that AI given raw transcripts may "over-focus on the wrong takeaway" or lose important points in the noise ([source](https://www.nngroup.com/articles/ux-context-design/)).
- **Invented or merged quotes.** Always trace quotes back to the transcript.
- **Flattened nuance.** Minority but critical findings (such as an accessibility blocker for a few users) get averaged away.
- **Privacy.** Transcripts often contain personal data. Use approved tools only, and anonymise.

**A safe synthesis workflow**

1. **You** read or skim all the raw material first, or at least a substantial sample, and note your top impressions.
2. AI produces a first-pass clustering with **quotes and transcript references**.
3. **You** check the references, merge, split and rename themes.
4. **You** ask AI: "What evidence contradicts theme X?" and "Which participants don't fit any theme?"
5. **You** write the final insights. AI can help phrase them, but the claims are yours.

### Synthetic users: what they are and aren't good for

"Synthetic users" are AI-generated stand-ins for research participants. NN/G's 2026 comparison (120 synthetic vs 604 human respondents) found they reached the **same broad conclusion** but with **far less variety**, plus methodological problems such as the platform rewording questions ([source](https://www.nngroup.com/articles/synthetic-users-vs-human-respondents/)).

| Reasonable uses | Not acceptable as |
|---|---|
| Pilot-testing your interview guide or survey wording | Evidence of what users need |
| Generating hypotheses to then test | A replacement for usability testing |
| Rehearsing as an interviewer | Grounds for a product decision on their own |

As a lead, put this in your team's AI policy (Module 13).

---

## Stage 2: Define

AI helps you **articulate** and **stress-test** problem framings.

- Turn messy notes into 5 alternative problem statements, then pick one.
- Generate **assumption maps**: "List assumptions behind this solution, rated by risk and evidence."
- Write **jobs to be done**: "Rewrite these needs as JTBD statements: When [situation], I want to [motivation], so I can [outcome]."
- **Pre-mortem**: "It's 6 months after launch and this failed. Write the 8 most likely reasons."

Deciding *which* problem matters is a strategic, political and ethical choice. That stays with you and the team.

---

## Stage 3: Ideate

Covered in depth in Module 03 (diverge → converge). Additional ideation uses:

- **User flows:** "Draft 3 alternative flows for X: minimal steps, maximum guidance, and expert mode."
- **Information architecture:** "Propose 3 navigation structures for these 40 features; for each, name the organising principle."
- **Analogies:** "How do airlines, hospitals and games handle 'something went wrong, here's what to do next'?"
- **Sketch to wireframe:** photograph a paper sketch and ask the Figma agent, Make or an AI prototyping tool to turn it into a wireframe for discussion.

---

## Stage 4: Design

### Content and UX writing (one of the highest-value uses)

AI is excellent for drafting and varying copy, **once you give it a voice and a terminology**.

- Empty states, errors, confirmations, onboarding, tooltips, notifications
- **Terminology consistency:** "Here's our glossary; flag any text that uses non-preferred terms."
- **Localisation drafts:** first-pass translations, plus checks for text expansion (German often runs about 30% longer, so test your layouts). Use professional review for production.
- **Readability:** "Rewrite at a plain-language level; keep all meaning; show the changes."

**Prompt: error message system**

```
Our voice: calm, direct, no blame, no exclamation marks, no jargon.
Our glossary: [paste]. Error message structure: what happened + why
(if useful) + what to do next.
Write messages for these 12 error cases: [list]. Return a table:
case / message / action label / notes. Flag any case where you'd need more
information to write a good message.
```

### Visual exploration

- **Moodboards and direction:** image generation for mood, illustration directions and photography style references. Watch out for licensing and brand rules, and **don't ship generated imagery without checking your company's policy**.
- **Layout variants:** the Figma agent and Make can produce variants quickly. Use them for exploration, then rebuild or refine with your system.
- **Placeholder and realistic data:** "Generate 30 realistic but fictional invoices with edge cases: long names, zero amounts, overdue, foreign currency." Realistic data makes reviews and tests far better.
- **States:** "List every state this component needs: empty, loading, partial, error, success, disabled, long content, permission-denied..." AI is good at completeness checks.

### Brand-defining work

Core identity, signature interactions, and the "feel" of a product are where AI's pull toward the average hurts most. Use it to explore, but **the defining choices should be deliberate human decisions**, captured afterwards as context (DESIGN.md, Module 08).

---

## Stage 5: Validate

- **Test planning:** draft tasks and scenarios, then check them for bias and leading wording.
- **Pilot-test** the script with synthetic users or colleagues.
- **Note-taking and transcription** during sessions, with participant consent and approved tools.
- **First-pass analysis:** cluster observations. *You* interpret.
- **Heuristic pre-check** before testing, to catch obvious issues cheaply so that tests find deeper ones.

**Never replace testing with real users.** The whole value of testing is in what you didn't predict, and AI predicts the predictable.

---

## Stage 6: Deliver

- **Specs and annotations:** AI drafts behaviour specs from your frames ("Describe all interactions and states for this component"). You correct them.
- **Documentation:** component usage guidelines, do's and don'ts, changelogs.
- **Handoff becomes context:** in Modules 08–10, handoff turns into machine-readable context and agent-built code.

---

## Disclosure: when to say AI was involved

As AI-generated content increases, so do disclosure questions, and the EU's transparency obligations started applying in August 2026, as NN/G notes ([source](https://www.nngroup.com/articles/disclose-ai-paced/)). NN/G's **PACED** framework helps decide when to disclose:

- **P**olicy: is it required by law, your organisation or the platform?
- **A**udience: how does your audience view AI?
- **C**ontext: how much does human contribution matter here?
- **E**xpectations: would people feel misled if they found out later?
- **D**egree: how much did AI actually contribute?

This applies to user-facing content and to internal deliverables, such as a research report that was largely AI-synthesised.

---

## Common mistakes

- **Letting AI do the research.** It can support research, but it can't meet your users.
- **Untraceable synthesis.** Insights with no link to evidence.
- **Shipping generic copy.** No voice and no glossary give you generic output.
- **Generating visuals you can't legally use.**
- **Skipping states.** AI makes it easy to check for completeness, so use it.

---

## Lab 04

**Exercise 1: Domain primer (45 min).** Run the domain-primer prompt for your capstone. Verify 3 claims. List the 10 expert questions.

**Exercise 2: Real research, AI-assisted (2–3 h).** Talk to **at least 3 real people** who match your capstone's users. Thirty-minute calls are enough. Draft the guide with AI and review it for bias. Record or take notes with consent, then follow the safe synthesis workflow above.

**Exercise 3: Define (30 min).** Generate 5 problem statements, then pick one and justify it. Run a pre-mortem.

**Exercise 4: Content system (45 min).** Create a voice description and glossary (10–20 terms) for your capstone. Use the error-message prompt to write 8–12 messages, then edit them.

**Exercise 5: States inventory (30 min).** For your capstone's main screen, use AI to list every state, then review the list and add what it missed.

**Exercise 6: Your workflow map (30 min).** Turn the stage table into **your** version: for each stage, what you'll use AI for, which tool, the risk tier and the verification step.

---

## Deliverable

1. **Capstone brief** (2–3 pages): problem, users (from real conversations), key insights with evidence, constraints, success metrics, chosen direction, and the risks from the pre-mortem.
2. **Voice and glossary** for the capstone.
3. **Personal AI workflow map** across the six stages.

---

## Self-check

1. At which stage is AI used least by practitioners, and why is that appropriate?
2. Describe the five steps of the safe synthesis workflow.
3. Give two acceptable and two unacceptable uses of synthetic users.
4. Why is AI particularly valuable for UX writing, and what must you provide?
5. What does PACED stand for?

<details><summary>Answers</summary>

1. Work involving real users (testing, interviews). Their value comes from unpredictability and real context, which AI can't simulate.
2. You review the raw material → AI clusters with references → you verify and reshape → you ask for contradicting evidence and outliers → you write the final insights.
3. Acceptable: pilot-testing study materials; generating hypotheses. Unacceptable: evidence of user needs; replacing usability tests.
4. It drafts many variants fast and checks consistency. You must provide voice, glossary, structure rules and the user context.
5. Policy, Audience, Context, Expectations, Degree of AI use.

</details>

---

## Go deeper

- NN/G: [Synthetic Users vs. Human Respondents](https://www.nngroup.com/articles/synthetic-users-vs-human-respondents/)
- NN/G: [When Should You Disclose AI Use? PACED](https://www.nngroup.com/articles/disclose-ai-paced/)
- NN/G course (paid): [Accelerating Research with AI](https://www.nngroup.com/courses/research-with-ai/)
- NN/G course (paid): [AI for Design Workflows](https://www.nngroup.com/courses/ai-for-design/)

**Next → [Module 05: Figma's AI toolkit](05-figma-ai-toolkit.md)**

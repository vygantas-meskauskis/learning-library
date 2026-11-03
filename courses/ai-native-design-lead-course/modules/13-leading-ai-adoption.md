# Module 13: Leading AI adoption as a design lead

> **Time:** about 6 hours · **Output:** a Design Team AI Policy, a pilot plan with metrics, a skills matrix and training plan, and a leadership pitch

---

## Learning objectives

- Set a **strategy** for AI in your design team that balances speed, quality and wellbeing.
- Write a practical **AI policy** covering tools, data, research, disclosure, review and agents.
- **Select tools** with clear criteria.
- Design and run a **pilot** with meaningful metrics.
- Lead **change** between mandates and scepticism.
- Build team **skills** and a training plan.
- Communicate value to **executives** with evidence.

---

## Why this matters

NN/G's 2026 survey found that the biggest problems aren't access or buy-in. They are **output quality (54%)**, **data privacy (50%)**, **lack of time to learn (36%)**, **difficulty integrating into workflows (30%)** and **lack of training (23%)**. Many comments complained of **mandates** and **unreliable output** that "eat the gains" ([source](https://www.nngroup.com/articles/ai-in-ux-survey-26/)).

Every one of those problems is a **leadership** problem, which makes it your job.

---

## 1. Strategy: what are we trying to achieve?

Start with outcomes, not tools. Example strategic goals for a design team:

1. **Learn faster:** test realistic prototypes with users earlier and more often.
2. **Scale quality:** make design standards reach all AI-generated UI (system + context).
3. **Reduce busywork:** reclaim time for research, critique and craft.
4. **Strengthen design–eng flow:** fewer translation errors, faster parity.

And explicit **non-goals**:

- Not to reduce research with real users.
- Not to measure designers by output volume.
- Not to ship prototypes as production.

**One-sentence strategy template:**

> *"We use AI to [learn faster / scale quality / reduce busywork] so that [user/business outcome], while protecting [research with real users / accessibility / craft / wellbeing]."*

---

## 2. The Design Team AI Policy

Full template: [templates/ai-policy.md](../templates/ai-policy.md). The essential sections:

### 2.1 Principles

- Humans are accountable for everything we ship.
- AI drafts; designers decide.
- Real users over synthetic users for evidence.
- Verify in proportion to risk (Module 03).
- Accessibility is non-negotiable.
- Be transparent about AI use where it matters (PACED).

### 2.2 Approved tools

A list by category (design tool AI, assistant, prototyping, coding agent), with the plan or tier, who has access, and any restrictions. NN/G: 59% of practitioners work with an approved set. That's normal and healthy.

### 2.3 Data classification (what may go where)

| Data class | Examples | Approved enterprise AI tools | Public or free AI tools |
|---|---|---|---|
| **Public** | Published UI, public docs | ✅ | ✅ |
| **Internal** | Designs, roadmaps, internal docs | ✅ | ❌ |
| **Confidential** | Unreleased strategy, financials, contracts | ⚠️ Only if explicitly approved | ❌ |
| **Personal data** | Names, emails, recordings, transcripts | ⚠️ Only approved tools, minimised and anonymised where possible, with consent | ❌ |
| **Secrets** | Passwords, API keys, tokens | ❌ Never | ❌ Never |

Work with security and legal on this. Check tools' **data retention** and whether inputs are **used for training**.

### 2.4 Research rules

- AI may assist in planning, transcription and first-pass synthesis, using approved tools and with consent.
- **Synthetic users** may be used for pilot-testing materials and hypotheses, **never as evidence**.
- All insights must be **traceable to real evidence**.

### 2.5 Disclosure

When and how to disclose AI use, internally (research reports, design rationale) and externally (user-facing content). Use PACED and follow legal requirements.

### 2.6 Review gates

Reference the gates and definition of done (Module 11).

### 2.7 Agent permissions

As agents gain the ability to *act*, define what they may do **without approval**, a pattern NN/G saw power users encode as "governance rules" in global context ([source](https://www.nngroup.com/articles/3-agent-context-roles/)):

| Action | Allowed without approval? |
|---|---|
| Read design files, generate drafts in Drafts | ✅ |
| Edit shared design files (write to canvas) | ⚠️ On duplicates or branches; human reviews before merge |
| Edit the production library | ❌ Requires DS owner approval |
| Create branches and PRs in code | ✅ |
| Merge to main, deploy | ❌ Human approval required |
| Send messages or emails on someone's behalf | ❌ |
| Access ambient data (Slack, email) | ⚠️ Scoped and approved connections only |

### 2.8 Imagery, IP and licensing

Rules for AI-generated images, fonts and icons; brand approval; and checking that tools' licensing terms allow commercial use.

### 2.9 Ownership and review cadence

Who owns the policy, and when it is reviewed (at least quarterly, because the field moves fast).

---

## 3. Tool selection criteria

| Criterion | Questions |
|---|---|
| **Security and data** | Enterprise plan? SSO? Data retention? Training opt-out? Region? |
| **Integration** | Works with Figma (MCP, plugins)? With your code stack and repos? |
| **Quality** | Does it perform on *your* tasks? (Test with your rubric.) |
| **Control** | Can it follow your system, rules and context? |
| **Cost** | Seat versus usage pricing; predictable at scale? |
| **Adoption** | Learning curve; fit with how the team works |
| **Vendor durability** | Is the vendor likely to still be around and supported? |

**Prefer open standards** (MCP, DTCG tokens, markdown context files, AGENTS.md conventions). They reduce lock-in, which is a key durability principle.

---

## 4. Running a pilot

### Design

- **Scope:** one team, one product area, **4–6 weeks**.
- **Hypotheses:** for example, *"AI prototyping will let us run usability tests 1 sprint earlier"*, or *"Adding DESIGN.md and AGENTS.md will cut design-QA defects on AI-built UI by 30%."*
- **Baseline:** measure before you start (use the past 2–3 sprints).
- **Support:** training, office hours, a channel for questions.

### Metrics that matter (and the vanity ones to avoid)

| Good metrics | Why |
|---|---|
| Time from idea to first **user test** | Measures learning speed, not output |
| Number of **usability tests** per quarter | AI should increase contact with users, not reduce it |
| **Design QA defects** per UI change | Quality of the built output |
| **Drift rate** (drift-log entries per screen) | System and context effectiveness |
| **Context rubric score** (Module 09) | AI output quality on your standards |
| **Code Connect / token coverage** | System AI-readiness |
| **Time on busywork** (self-reported or logged) | Reclaimed time |
| **Team sentiment** (pulse survey) | Sustainability; NN/G found ambivalence is common |

| Vanity metrics | Problem |
|---|---|
| Number of screens or variants generated | Volume ≠ value |
| Number of prompts or AI sessions | Activity ≠ outcome |
| "% of work done with AI" | Encourages forced use |

### Evaluate

Compare against the baseline, collect qualitative stories, and decide to **scale, adjust or stop**. Publish what you learned, including what *didn't* work, because that builds trust.

Template: [templates/pilot-plan.md](../templates/pilot-plan.md).

---

## 5. Leading change: between hype and scepticism

### Know your team

| Archetype | Typical concern | What helps |
|---|---|---|
| **Enthusiast** | "Let's use AI for everything!" | Channel energy into experiments with metrics; pair them with sceptics |
| **Pragmatist** | "Show me it works." | Evidence from pilots; time-saving wins |
| **Sceptic** | "It produces slop; it's unethical." | Respect valid concerns; quality gates; ethics in the policy; opt-in starts |
| **Anxious** | "Will this replace me?" | Honest talk about role evolution; skills investment; psychological safety |

### Principles

1. **Invitation, not mandate.** Mandates were a top complaint in NN/G's survey. Set expectations about *outcomes*, and let people choose tools within the policy.
2. **Protect time to learn.** "Lack of time" was the #3 barrier. Budget for it, for example 2 hours a week for 8 weeks.
3. **Start with pain, not features.** Ask "what's the most tedious part of your week?" and solve that first.
4. **Make learning social:** demos, show-and-tell, pairing, a shared prompt library.
5. **Celebrate good judgment,** including the decision *not* to use AI.
6. **Be honest about job anxiety.** NN/G found designers and researchers felt less job-secure than PMs. Talk about the evolving role openly, and invest in people's skills.
7. **Push back upward with evidence.** One respondent said: *"I have to actively push against them on things I know AI doesn't do well yet."* Your pilot data is how you do that credibly.

---

## 6. Skills and training

### Skills matrix (rate each person 1–4)

| Skill | Module |
|---|---|
| AI literacy (concepts, limits) | 02 |
| Prompting, critique, verification | 03 |
| AI across the process | 04 |
| Figma AI toolkit | 05 |
| AI prototyping and testing | 06 |
| Design systems (tokens, components) | 07 |
| AI-ready systems (descriptions, DESIGN.md, Code Connect, rules) | 08 |
| Context engineering (UX.md, experiments) | 09 |
| Design to code (MCP, agents, QA) | 10 |
| Collaboration and governance | 11 |
| Designing AI features | 12 |

Template: [templates/skills-matrix.md](../templates/skills-matrix.md).

**You don't need everyone at 4 in everything.** Aim for **T-shapes**: everyone at 2+ in literacy, critique and process; specialists at 3–4 in systems, context or design-to-code.

### Training plan

Reuse this course. A team version:

- **Weeks 1–2:** Modules 01–03 together (reading plus weekly discussion).
- **Weeks 3–6:** Modules 04–06 on a real team project.
- **Weeks 7–10:** Modules 07–10, with DS-focused people going deeper.
- **Ongoing:** monthly show-and-tell, the prompt library, and drift reviews.

### Hiring and career ladders

Add to job descriptions and ladders:

- Evidence of **judgment with AI** (what they chose *not* to use, and why)
- **Systems thinking** (tokens, components, context)
- **Comfort with code-adjacent work** (prototypes, PR reviews)
- **Research integrity**

---

## 7. Communicating to executives

Executives want to know: **Is this making us better, faster or cheaper? What's the risk? What do you need?**

**One-slide structure:**

1. **Goal:** strategy sentence.
2. **Evidence:** pilot metrics against the baseline (2–3 numbers).
3. **Story:** one concrete example, such as "we found a critical issue in week 2 instead of after launch".
4. **Risks and controls:** policy, gates, data rules.
5. **Ask:** budget, tools, time, or engineering partnership (for Code Connect and tokens).

**Pre-empt the "replace designers" question:** show how AI shifted time toward research, systems and quality, and how design context now improves *everyone's* AI-generated UI. That's design's influence **growing**.

---

## 8. Ethics and sustainability

- **Bias:** AI reflects its training data. Review generated content and imagery for stereotypes, and test with diverse users.
- **Labour and craft:** be clear about attribution and how AI-assisted work is evaluated.
- **Environmental cost:** AI use has energy costs. NN/G's survey listed ethics and sustainability as a barrier for 34%. Avoid wasteful use, such as generating 100 variants when 10 will do.
- **Accessibility:** never accept AI output that regresses accessibility.

---

## Common mistakes

- **Tool-first rollout** without strategy.
- **Mandates and volume metrics.**
- **No data rules,** leading to an incident and then a blanket ban.
- **No time to learn.**
- **Pilots without baselines.**
- **Ignoring job anxiety.**

---

## Lab 13

**Exercise 1: Strategy (30 min).** Write your strategy sentence, 3–4 goals and 3 non-goals.

**Exercise 2: AI policy (2 h).** Draft the policy with [templates/ai-policy.md](../templates/ai-policy.md). Use your AI log (Module 01 onwards) as evidence for your choices.

**Exercise 3: Pilot plan (60 min).** Write the plan with hypotheses, baseline, metrics and timeline using [templates/pilot-plan.md](../templates/pilot-plan.md).

**Exercise 4: Skills and training (45 min).** Fill in the skills matrix for an imagined (or real) team of 4–6 and write a 10-week training plan.

**Exercise 5: Executive slide (45 min).** Make the one-slide pitch, using your capstone data as illustrative evidence (context-experiment scores, drift reduction, test timing).

---

## Deliverable

1. **Design Team AI Policy** (2–4 pages)
2. **Pilot plan**
3. **Skills matrix and training plan**
4. **Executive one-slider**

---

## Self-check

1. What were the top barriers in the NN/G survey, and why are they leadership problems?
2. Name three good pilot metrics and two vanity metrics.
3. What should an agent never do without approval?
4. How do you handle a sceptic versus an enthusiast?
5. What are the five parts of the executive slide?

<details><summary>Answers</summary>

1. Output quality, data privacy, lack of time, workflow integration and training. Each is solved by leadership actions: systems and context, policy, protected time, workflow design and training.
2. Good: time to first user test, design-QA defects, drift rate, context rubric score, number of usability tests, sentiment. Vanity: screens generated, number of prompts, "% of work done with AI".
3. Merge or deploy to production, edit the production library, or send messages on someone's behalf (per the example policy).
4. Sceptic: respect their concerns, use quality gates and opt-in, and show evidence. Enthusiast: channel the energy into measured experiments and pair them with sceptics.
5. Goal, evidence, story, risks and controls, ask.

</details>

---

## Go deeper

- NN/G: [AI in UX survey 2026](https://www.nngroup.com/articles/ai-in-ux-survey-26/) and its [comments dashboard](https://nngroup.github.io/research/ai-at-work/)
- NN/G: [AI Can Help Write an Article, but It Can't Stand Behind It](https://www.nngroup.com/articles/ai-editorial-process/) (an example of a team AI process)
- Paid: NN/G [AI Product Strategy](https://www.nngroup.com/courses/ai-product-strategy/)
- Paid: [AI & Design Systems](https://aianddesign.systems/), Chapter 6 (buy-in, pilot, rollout, governance)
- Free: [Design System University: Make Design Systems People Want to Use](https://designsystem.university/courses)

**Next → [Module 14: Capstone and your first 90 days](14-capstone-and-90-days.md)**

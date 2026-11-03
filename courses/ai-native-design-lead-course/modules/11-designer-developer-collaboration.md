# Module 11: Designer–developer collaboration, rebuilt

> **Time:** about 4 hours · **Output:** a designer–developer collaboration contract, a RACI, and a definition of done for AI-assisted UI

---

## Learning objectives

- Describe how the **dynamics between design and engineering** change when both can generate UI.
- Identify the common **friction points** and their causes.
- Define **ownership** (RACI) for the system, context, prototypes and production code.
- Design **review gates** and a shared **definition of done**.
- Set up **rituals** that keep design and code in sync.

---

## Why this matters for a lead

Handoff used to be a clear line: design in Figma, then engineering builds. Now designers ship coded prototypes, engineers' agents generate UI, PMs make mockups, and everyone's output looks "finished". Without explicit agreements, you get duplicated components, off-brand UI, turf wars and quality regressions. **Defining this collaboration is a core lead responsibility.**

---

## 1. What changed in the relationship

| Before | Now |
|---|---|
| Designers make pictures; engineers make software | Both make **working UI**, at different fidelity and quality levels |
| Handoff via specs and redlines | Handoff via **context**: system, Code Connect, rules, MCP |
| Design system as a Figma library plus a separate code library | **One system**, with Figma and code linked (variables ↔ tokens, Code Connect) |
| Design reviews screenshots | Design reviews **running UI** and **pull requests** |
| Engineers interpret designs | Agents interpret designs, so **rules and context** decide accuracy |
| Designers are the only ones who design | **Everyone designs**, so standards must be machine-readable to reach them |

### What each side gains

**Designers:**

- Test realistic interactions early (Module 06).
- Influence code directly through the system and rules.
- See exactly what was built (code to canvas).

**Engineers:**

- Faster first passes from accurate design context.
- Fewer ambiguous specs, because tokens and components are explicit.
- Less pixel-pushing, more architecture and quality work.

---

## 2. Common friction points (and what's really going on)

| Friction | Underlying cause | Resolution |
|---|---|---|
| "Design's prototype code is unusable." | The prototype was treated as production (fidelity trap) | Prototypes are for learning; production goes through the pipeline |
| "Engineers' AI-generated UI is off-brand." | Missing rules, context or Code Connect | Ship AI-ready system assets (Modules 08–09) |
| "We have 4 different modals." | No "use existing components" rule; no governance | Rules plus a contribution model; "stop and list what's missing" |
| "Designers are touching our code!" | Unclear ownership | RACI: designers may prototype and propose; engineers own production |
| "Design keeps changing things after build." | Late review, no shared definition of done | Review gates earlier, on running UI |
| "The Figma file doesn't match production." | No sync process | Token pipeline, Code Connect, code-to-canvas reviews |
| "AI is just making us do more, faster." | Mandates without workflow change | Measure the real gains; protect quality time (Module 13) |

---

## 3. Ownership: a RACI for AI-era UI

**R** = Responsible (does it) · **A** = Accountable (final say) · **C** = Consulted · **I** = Informed

| Asset / activity | Design lead | Designers | DS team* | Eng lead | Engineers | PM |
|---|---|---|---|---|---|---|
| Design principles | A | C | R | C | I | C |
| Figma library (tokens, components) | A | C | R | C | C | I |
| Code component library | C | I | R | A | C | I |
| Token pipeline (Figma ↔ code) | C | I | R | A | R | I |
| Code Connect mappings | C | I | R | A | R | I |
| DESIGN.md | A | C | R | C | I | I |
| UX.md / research context | A | R | C | I | I | C |
| AGENTS.md design-system rules | A | C | R | A** | C | I |
| Prototypes (learning artifacts) | A | R | I | I | C | C |
| Production UI code | C | C | C | A | R | I |
| Design QA on running UI | A | R | C | C | C | I |
| Accessibility compliance | A (design) | R | R | A (impl.) | R | I |
| AI tool policy (design) | A | C | C | C | I | I |

\* In small companies the "DS team" may be you plus one engineer.
\*\* AGENTS.md is shared: design owns the design-system sections, engineering owns the code-convention sections.

**Key principle:** *designers may contribute code (prototypes, proposals, even PRs to the component library), but engineering is accountable for production code, and design is accountable for the experience.*

---

## 4. Review gates

Gates are where quality is protected. Keep them few, clear and early.

```
 Idea → [Gate 1] → Prototype & test → [Gate 2] → Build → [Gate 3] → Release
```

| Gate | When | Who | Checks |
|---|---|---|---|
| **1. Direction review** | Before significant build or prototype | Design lead, PM, eng lead | Problem, evidence, approach, system fit |
| **2. Design-ready review** | Before production build | Design + eng | Validated with users? States complete? System components identified? Gaps logged? |
| **3. Design QA on running UI** | On the PR or staging | Designer (+ a11y check) | QA checklist (Module 10), Figma parity, accessibility, copy |

**Make Gate 3 lightweight but mandatory.** Ideally designers review **PR preview deployments** (many teams auto-deploy each PR to a temporary URL) and comment directly on the PR.

---

## 5. Definition of done for AI-assisted UI

A UI change is "done" when:

- [ ] Built from system components; any new component went through the contribution process
- [ ] No hardcoded design values; tokens only
- [ ] All designed states implemented
- [ ] Accessibility: keyboard, focus, labels, contrast and screen-reader basics checked
- [ ] Copy matches voice and glossary
- [ ] Design QA passed (Gate 3)
- [ ] Code reviewed by an engineer
- [ ] If a new pattern emerged: Figma, code, Code Connect and docs all updated
- [ ] If drift was found: drift log updated and a rule or context change proposed

---

## 6. Rituals that keep design and code in sync

| Ritual | Cadence | Purpose |
|---|---|---|
| **Design–eng pairing** | Weekly, 1 h | Build or review together; resolve system gaps live |
| **Design-system sync** | Bi-weekly | Contributions, deprecations, token changes, Code Connect coverage |
| **Drift review** | Monthly | Look at the drift log, then update rules and context |
| **Code-to-canvas review** | Per release | Capture production UI, compare with the system, log inconsistencies |
| **Prototype showcase** | Monthly | Share learnings from prototypes (not the prototypes themselves) |
| **Context review** | Quarterly | Update UX.md and DESIGN.md, prune stale context |

---

## 7. The contribution model (how the system grows)

When a team needs something the system doesn't have:

1. **Check:** does something existing work, perhaps with a new variant?
2. **Propose:** a short request covering the need, use cases and a design proposal.
3. **Review:** the DS team decides between a one-off, a new variant or a new component.
4. **Build both sides:** Figma component, code component, Code Connect, docs and description.
5. **Announce:** changelog and a rules or context update if needed.

Agents participate too: the "stop and list what's missing" rule (Module 10) **feeds this process automatically**.

---

## 8. Communication principles

- **Lead with shared goals:** quality, speed and user outcomes, not ownership.
- **Talk about the system, not people:** "the rule was missing" rather than "you did it wrong".
- **Make your work inspectable:** decisions in docs, rationale in context files.
- **Learn their tools** (Module 10). Credibility comes from understanding.
- **Invite engineers into design critique,** and ask to join code reviews for UI.

---

## Common mistakes

- **Designers shipping prototype code to production** without engineering review.
- **Engineering ignoring design QA** because "the AI matched Figma".
- **No contribution process,** so the system fragments.
- **Treating AGENTS.md as engineering-only.** Design-system rules belong to design too.
- **Gates too late,** with review only after release.

---

## Lab 11

**Exercise 1: Developer interviews (90 min).** Interview 2 engineers (from your company, or acquaintances):

- How do you use AI to build UI today?
- What's frustrating about design handoff?
- What would make AI-generated UI more correct for you?
- What do you think designers should and shouldn't do in code?
- How do you feel about design reviewing PRs?

Synthesise the answers into 5 insights.

**Exercise 2: RACI (45 min).** Adapt the RACI to your (future) organisation. Mark the rows you're unsure about as questions for your eng lead.

**Exercise 3: Collaboration contract (60 min).** Write it with [templates/collaboration-contract.md](../templates/collaboration-contract.md). Include ownership, gates, definition of done, rituals, the contribution model, and how you'll resolve disagreements.

**Exercise 4: Gate 3 dry run (30 min).** Use your Module 10 repo: open a PR, review it as a designer using the QA checklist, and comment.

---

## Deliverable

1. **Designer–developer collaboration contract** (2 pages), ideally reviewed by one engineer.
2. **RACI** for your context.
3. **Interview synthesis** (5 insights).

---

## Self-check

1. Name three things that changed in design–dev collaboration.
2. What's the key ownership principle for production code?
3. Describe the three review gates.
4. Why should design own part of AGENTS.md?
5. What happens when an agent can't find a needed component?

<details><summary>Answers</summary>

1. Any three of: both sides make working UI; handoff happens via context; there is one linked system; review happens on running UI and PRs; agents interpret designs; everyone designs.
2. Designers may contribute code, but engineering is accountable for production code and design is accountable for the experience.
3. Direction review (before building), design-ready review (before production build), and design QA on running UI (on the PR or staging).
4. Because design-system rules (components, tokens, accessibility, glossary) directly shape AI-generated UI. They encode design standards.
5. With the right rule, it stops and lists what's missing, which feeds the contribution process rather than producing ad-hoc UI.

</details>

---

## Go deeper

- NN/G: [UX-Context Design: "Everyone Is Designing"](https://www.nngroup.com/articles/ux-context-design/)
- [designsystems.com: Design & Development section](https://www.designsystems.com/)
- Figma: [Code Connect](https://developers.figma.com/docs/code-connect/)
- Paid: [AI & Design Systems (Brad Frost et al.)](https://aianddesign.systems/), especially the rollout and governance chapter

**Next → [Module 12: Designing AI-powered product features](12-designing-ai-features.md)**

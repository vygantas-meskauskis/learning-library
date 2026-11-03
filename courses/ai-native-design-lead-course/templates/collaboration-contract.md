# Designer–Developer Collaboration Contract

> **Team(s):** · **Design lead:** · **Eng lead:** · **Version:** · **Date:** · **Review:** quarterly
>
> **Purpose:** clear agreements for building UI together when designers, engineers, PMs *and* AI agents can all produce UI (Module 11).

## 1. Shared goals

We collaborate to ship **usable, accessible, consistent** UI **faster**, with **evidence from real users**, while keeping the codebase healthy.

## 2. Core principles

1. Design is accountable for the **experience**; engineering is accountable for **production code**.
2. Designers may write code for prototypes and **propose** changes via PRs; engineers review and own merging.
3. Prototypes are **learning artifacts**, not production code.
4. **One design system**, with Figma and code linked (tokens, Code Connect), owned jointly.
5. Agents follow **AGENTS.md**. Design owns the design-system sections and engineering owns the code-convention sections.
6. We discuss **systems, not people**: when something goes wrong, we fix the rule, context or component.

## 3. Ownership (RACI summary)

| Asset | Accountable | Responsible | Consulted |
|---|---|---|---|
| Figma library | Design lead | DS designer(s) | Eng |
| Code component library | Eng lead | DS engineer(s) | Design |
| Token pipeline | Eng lead | DS engineer | Design |
| Code Connect | Eng lead | DS engineer | Design |
| DESIGN.md / UX.md | Design lead | Designers / research | Eng |
| AGENTS.md | Design + Eng leads (by section) | DS team | All |
| Production UI code | Eng lead | Engineers | Design |
| Design QA | Design lead | Designers | Eng |

## 4. Review gates

| Gate | When | Who | Pass criteria |
|---|---|---|---|
| 1. Direction | Before significant build or prototype | Design lead, PM, eng lead | Problem, evidence, approach, system fit |
| 2. Design-ready | Before production build | Design + eng | Validated with users; states complete; components identified; gaps logged |
| 3. Design QA | On PR preview or staging | Designer | Design QA checklist passed |

## 5. Definition of done (UI)

- [ ] System components only; any new component went through contribution
- [ ] Tokens only (no hardcoded values)
- [ ] All states implemented
- [ ] Accessibility checks passed
- [ ] Copy matches glossary and voice
- [ ] Gate 3 passed; code review passed
- [ ] New patterns: Figma, code, Code Connect and docs updated
- [ ] Drift logged and rule or context change proposed

## 6. Contribution model

1. Check existing components and variants.
2. Submit a request: need, use cases, proposal.
3. DS team decides: one-off, new variant, or new component (SLA: __ days).
4. Build in Figma **and** code, plus Code Connect, docs and description.
5. Announce in the changelog; update rules and context if needed.

## 7. Rituals

| Ritual | Cadence | Owner |
|---|---|---|
| Design–eng pairing | Weekly | |
| Design-system sync | Bi-weekly | |
| Drift review | Monthly | |
| Code-to-canvas review | Per release | |
| Prototype learnings showcase | Monthly | |
| Context review (UX.md/DESIGN.md) | Quarterly | |

## 8. AI-specific agreements

- Approved tools: see the Design Team AI Policy.
- Agents work on branches; humans merge.
- Write-to-canvas on shared libraries happens on duplicates or branches only.
- AI-generated UI meets the same definition of done as human-written UI.

## 9. Resolving disagreements

1. Return to user evidence and the shared goals.
2. If unresolved, design lead and eng lead decide together within __ days.
3. Escalate to [role] only if needed. Record decisions in [location].

**Signed / agreed:** Design lead ______ · Eng lead ______ · Date ______

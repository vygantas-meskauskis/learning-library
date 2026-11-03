# Design Team AI Policy

> **Version:** · **Owner:** [Design lead] · **Approved by:** [Security, Legal, Head of Product/Design] · **Effective:** · **Review:** quarterly
>
> **Scope:** all design work, including research, design, content, prototyping and design-system work, by the design team and by others using design assets.

## 1. Why we use AI

[Strategy sentence: "We use AI to … so that … while protecting …"]

**Goals:**
1.
2.
3.

**Non-goals:**
- We do not replace research with real users.
- We do not measure designers by output volume or "% AI use".
- We do not ship prototypes as production.

## 2. Principles

1. **Humans are accountable** for everything we ship.
2. **AI drafts; designers decide.**
3. **Real users over synthetic users** for evidence.
4. **Verify in proportion to risk** (low / medium / high tiers).
5. **Accessibility is non-negotiable.**
6. **Transparency:** disclose AI use where it matters (PACED: Policy, Audience, Context, Expectations, Degree).
7. **Open standards first** (MCP, DTCG tokens, markdown context) to avoid lock-in.

## 3. Approved tools

| Category | Tool & plan | Who | Restrictions |
|---|---|---|---|
| Design-tool AI | e.g. Figma (agent, Make, MCP) – [plan] | All designers | Agent chats in shared files are visible to editors by default |
| General assistant | e.g. [enterprise assistant] | All | Enterprise workspace only |
| Prototyping | e.g. [tool] | Designers | No personal data in prototypes |
| Coding agent | e.g. [tool] | Designers (prototypes), DS team | Branches only; no merge to main |
| Transcription | e.g. [tool] | Research | Consent required |

Requests for new tools go to [owner] and are evaluated against the tool selection criteria.

## 4. Data rules

| Data class | Approved enterprise tools | Other or public tools |
|---|---|---|
| Public | ✅ | ✅ |
| Internal (designs, roadmaps) | ✅ | ❌ |
| Confidential (strategy, financials, contracts) | ⚠️ only if explicitly approved | ❌ |
| Personal data (names, emails, recordings, transcripts) | ⚠️ approved tools only, minimised and anonymised, with consent | ❌ |
| Secrets (passwords, keys, tokens) | ❌ never | ❌ never |

- Use realistic **synthetic data** in prototypes by default.
- Context files (DESIGN.md, UX.md, AGENTS.md) contain **no personal data or secrets**.

## 5. Research

- AI may assist with planning, transcription and first-pass synthesis (approved tools, consent).
- Every insight must be **traceable** to real evidence (participant ID and reference).
- **Synthetic users:** allowed for pilot-testing materials and generating hypotheses; **never** as evidence for decisions.
- Researchers review all AI synthesis before sharing.

## 6. Verification tiers

| Tier | Examples | Required verification |
|---|---|---|
| Low | Brainstorms, moodboards, drafts | Sense-check |
| Medium | Research summaries, competitive scans, critiques | "Verify 3" key claims; trace quotes |
| High | Shipped copy, legal or financial text, a11y claims, production code | Qualified human review, tool checks, sign-off |

## 7. Review gates and definition of done

See the Designer–Developer Collaboration Contract. AI-generated work meets the same bar as human work.

## 8. Agent permissions

| Action | Without approval? |
|---|---|
| Read design files; generate in Drafts | ✅ |
| Edit shared design files (write to canvas) | ⚠️ on duplicates or branches; human review |
| Edit the production design library | ❌ DS owner approval |
| Create branches and PRs | ✅ |
| Merge to main / deploy | ❌ |
| Send messages or emails on someone's behalf | ❌ |
| Connect ambient sources (Slack, email, drives) | ⚠️ approved, scoped connections only |

## 9. Imagery, IP and licensing

- AI-generated imagery for production requires [brand/legal] approval and a tool licence that allows commercial use.
- Don't generate content imitating identifiable artists' styles or real people without approval.
- Fonts, icons and assets follow existing licensing rules.

## 10. Disclosure

- **Internal:** note substantial AI involvement in research reports and design rationale.
- **External:** follow legal requirements (for example EU AI Act transparency obligations) and PACED. Prefer proactive disclosure where it applies.

## 11. Learning and wellbeing

- [X] hours per week of protected learning time during adoption.
- Use of AI tools is encouraged, **not mandated** for specific tasks; outcomes matter.
- Concerns (ethical, quality, job-related) can be raised with [lead] at any time without penalty.

## 12. Incidents

If confidential or personal data is shared with an unapproved tool, or AI output causes harm: report it to [security contact] within [time]. We focus on fixing the system, not blaming people.

## 13. Changelog

| Date | Change | Reason |
|---|---|---|
| | | |

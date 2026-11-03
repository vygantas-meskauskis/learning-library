# Prompt Library (starter)

> Reusable prompts are assets. Version them, improve them and share them. When a prompt is used constantly, graduate it into a **rule, context file or skill** (Module 09).

Format for each entry:

```
## Name – when to use
Tier: low / medium / high      Inputs: ...
Prompt: ...
Known weaknesses: ...
Last improved: date – change
```

---

## 1. Structured critique: heuristic evaluation
**Tier:** medium · **Inputs:** screenshot, user and task description

```
You are a strict senior UX reviewer. Evaluate the attached screen for
[user type] trying to [task]. Use Nielsen's 10 usability heuristics.
For each problem: severity (critical/major/minor), heuristic, exact
location, why it matters for this user, concrete fix.
Max 10 items, ranked by severity. No praise. Say when you're unsure.
```

**Known weaknesses:** generic findings, and it misses fine visual detail. Verify contrast with a real tool.

---

## 2. Divergent concepts with lenses
**Tier:** low · **Inputs:** problem statement, users

```
Problem: [..]. Users: [..].
Give 10 concepts, each using a DIFFERENT strategy:
1 zero-UI/automation, 2 progressive disclosure, 3 template-first,
4 human-assisted, 5 import-first, 6 goal-first, 7 social/team,
8 interactive tutorial with real data, 9 contextual tips only,
10 borrowed from a non-software domain.
For each: one-sentence concept, best for whom, biggest risk.
```

---

## 3. Domain primer
**Tier:** medium · **Inputs:** domain name

```
I'm a product designer new to [domain]. Give me: key roles and goals,
typical workflows, glossary, regulations/constraints, publicly reported
pain points, and 10 questions to ask domain experts. Cite sources; mark
uncertain items.
```

---

## 4. Interview guide review
**Tier:** medium · **Inputs:** draft guide

```
Review this interview guide for leading questions, double-barrelled
questions, jargon, missing follow-up probes, and questions that ask users
to predict future behaviour. Suggest rewrites in a table: original /
problem / rewrite.
```

---

## 5. Synthesis first pass (approved tools and anonymised data only)
**Tier:** medium · **Inputs:** anonymised notes/transcripts

```
Cluster these notes into themes. For each theme: name, 1-sentence
insight, supporting quotes WITH participant ID and line reference,
number of participants. Then list: evidence that contradicts each theme,
and participants who don't fit any theme. Don't invent quotes.
```

**Known weaknesses:** can over-focus on frequent but shallow themes. Always verify quotes.

---

## 6. Error-message system
**Tier:** medium (high if shipped) · **Inputs:** voice, glossary, error cases

```
Voice: [..]. Glossary: [..]. Structure: what happened + why (if useful)
+ what to do next. Write messages for these cases: [..].
Table: case / message / action label / notes. Flag cases needing more info.
```

---

## 7. States inventory
**Tier:** low · **Inputs:** component or screen description or screenshot

```
List every state this [component/screen] needs, including: empty,
loading, partial, error (by type), success, disabled, read-only,
permission-denied, offline, long content, many items, zero items,
first-time use, and any domain-specific states. For each: trigger and
what the UI should show.
```

---

## 8. Realistic test dataset
**Tier:** low · **Inputs:** schema and edge cases

```
Generate [N] realistic but fictional [records] as JSON with fields: [..].
Include edge cases: very long text, empty optional fields, zero/extreme
values, special characters, and [domain-specific cases]. Use realistic,
diverse names. Valid JSON only.
```

---

## 9. Red-team a design decision
**Tier:** low · **Inputs:** decision and rationale

```
Argue AGAINST this decision as convincingly as possible: [..].
Give the strongest objections from: a sceptical engineer, a sceptical
PM, a frustrated novice user, a power user, and an accessibility expert.
```

---

## 10. Component description draft
**Tier:** low · **Inputs:** component name, properties, screenshot

```
Draft a design-system component description using this structure:
PURPOSE / USE WHEN / DON'T USE / PROPERTIES / CONTENT / A11Y / CODE /
RELATED. Component: [..]. Properties: [..]. Keep each line short and
testable.
```

---

## Your prompts

_Add your own below as you go through the course._

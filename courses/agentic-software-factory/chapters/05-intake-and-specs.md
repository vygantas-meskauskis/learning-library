# Chapter 5: Intake and specs

> ⏱ About 20 min · You'll learn: how an idea becomes a unit of work an agent can finish, what a factory-grade spec contains, how to write acceptance criteria a machine can check, how a spec-writer subagent interviews you, and the definition of ready that guards the `agent:go` label.

---

## 📖 Story: "Make export better"

A user emails you: *"Love the app. Can I get my history into a spreadsheet? I track my focus hours for my freelance invoices."*

BusyHamster already has an export: the History page writes a JSON backup you can import again. JSON isn't a spreadsheet. You open an issue:

> **Make export better**
> Users want to use their history in spreadsheets.

Then you imagine handing this issue to an agent at 10 pm and coming back at 11. What would you get? Maybe a CSV. Maybe an Excel file through a 400 KB library. Maybe one row per task, maybe one row per line. Durations in milliseconds, because that's what's stored. A new button that breaks the keyboard-first principle. And no way for anyone, human or machine, to say whether it's right, because "better" isn't checkable.

Your spec for Tasks and lines (`docs/spec-tasks-and-lines.md`) was good: problem, goals, non-goals, a data model. You wrote it for yourself. Now you're writing for a reader with no memory, no taste and endless confidence.

You write in your factory log: *"A vague issue doesn't get a vague result. It gets a confident wrong one."*

---

## 🏚️ Old way → 🚀 New way

| What you do now | What you do in a factory | Why it changes |
|---|---|---|
| A one-line issue and the details in your head | An issue form with required fields | The agent only knows what's written |
| Goals like "better", "faster", "nicer" | Acceptance criteria a test or a script can check | "Done" must be decidable without you |
| Non-goals left unsaid | Non-goals listed explicitly | Agents add helpful extras unless told not to |
| You write the spec alone, late | A spec-writer subagent interviews you first | Good questions find the gaps before the code does |
| Anything can be started | A definition of ready guards `agent:go` | Half-specified work comes back as rework |

---

## 🧠 What a factory spec contains

> 💡 A spec says what and why, and how you'll know it's done. It says almost nothing about how.

BusyHamster's existing spec already has most of the shape. The toolkit's [spec template](../toolkit/templates/spec-template.md) keeps it and adds two sections agents need:

| Section | Answers | Required? |
|---|---|---|
| **In one line** | What is this, in a sentence a user would understand? | Yes |
| **Problem** | What's wrong today, for whom? What happens if we do nothing? | Yes |
| **Goals** | What must be true when it's done? (numbered, 2 to 5) | Yes |
| **Non-goals** | What's deliberately out of scope? | Yes |
| **Acceptance criteria** | How we check each goal, as Given / When / Then | **Yes, new** |
| **Product principles touched** | Which of PRODUCT.md's principles this affects, and how it respects them | **Yes, new** |
| **Model or contract** | Data shapes, file formats, API shapes | If data or interfaces change |
| **Open questions** | What you haven't decided yet | Must be empty before `agent:go` |
| **Risk notes** | Data, privacy, security, migration concerns | If any |

What's **not** in a spec: file names, component structure, library choices, step-by-step implementation. That's the plan (chapter 6), and the agent drafts it. If you put the how in the spec, you're writing the code in prose, which is slower than writing it in code.

---

## 🧠 Acceptance criteria a machine can check

> 💡 Write each criterion so that a test, a script or a five-second look at a screenshot could say yes or no.

Use **Given / When / Then**: a starting state, an action, an observable result.

| Weak | Strong |
|---|---|
| Export works well | **Given** two finished tasks in History, **when** I choose "Export as CSV", **then** a file named `busyhamster-history-YYYY-MM-DD.csv` downloads with one header row and one row per line |
| Durations are readable | **Given** a line with `focusedMs` of 5,400,000, **then** its `focused_minutes` column is `90` |
| It's accessible | **Given** the History page, **when** I press ⌘K and type "csv", **then** "Export as CSV" is the first result and Enter runs it |
| Handles special characters | **Given** a line text containing a comma, a quote and a newline, **then** the cell is quoted per RFC 4180 and re-opens correctly in a spreadsheet |
| Doesn't break anything | **Given** the existing JSON export, **then** it still produces a file that imports back unchanged (existing tests pass) |

Strong criteria map almost one to one onto tests. The coding agent turns them into Vitest cases, and the reviewer (chapter 8) checks that each criterion has a test.

---

## 💻 In BusyHamster: the spec for CSV export

This is the worked example that runs through chapters 5 to 9. It's small enough to finish in one PR and touches enough of the factory to test every stage.

📝 Illustrative

```markdown
# Spec: Export History as CSV

Status: ready · 2026-11-29 · Issue #41

**In one line:** download your finished tasks as a CSV file you can open in a
spreadsheet, one row per line.

## Problem
Freelancers and people who track their focus hours want their history in a
spreadsheet. Today History exports JSON, which is a backup format: correct,
complete, and unreadable in Excel or Google Sheets. Users copy numbers by hand.

## Goals
1. One action exports all finished tasks as CSV, from the History page and
   from the command menu.
2. Every line of every finished task is one row, with readable dates and
   durations in minutes.
3. The file opens correctly in Excel, Google Sheets and Numbers, including
   text with commas, quotes, newlines and non-English characters.

## Non-goals
- Choosing columns, date ranges or formats. One fixed format.
- Excel (.xlsx) output. CSV only, no new dependencies.
- Importing CSV. JSON stays the backup format.
- Exporting the active (unfinished) task.

## Product principles touched
- 3 "Your data stays yours": the file is generated in the browser. Nothing is sent anywhere.
- 5 "Keyboard first": the action is in the command menu.

## Model
Columns, in order:
task_title, line_text, line_done (yes/no), pomodoros, focused_minutes,
task_started (ISO 8601 local date-time), task_finished (ISO 8601 local date-time)

Encoding: UTF-8 with BOM (so Excel detects UTF-8). Line endings: CRLF.
Quoting: RFC 4180.

## Acceptance criteria
1. Given two finished tasks with three lines in total, when I choose
   "Export as CSV" on History, then busyhamster-history-YYYY-MM-DD.csv
   downloads with a header row and three data rows.
2. Given focusedMs 5,400,000, then focused_minutes is 90 (rounded to the
   nearest minute).
3. Given line text `Fix "resume", then ship` with a newline in it, then the
   cell is quoted and escaped per RFC 4180.
4. Given text "Žąsinas — 東京", then the file opens with the characters intact
   in Excel (UTF-8 BOM present).
5. Given the History page, when I open ⌘K and type "csv", then
   "Export as CSV" appears and Enter downloads the file.
6. Given no finished tasks, then the action is disabled with the hint
   "Finish a task to export it".
7. The existing JSON export and import tests still pass unchanged.

## Open questions
(none)

## Risk notes
None: read-only, client-side, no new dependencies.
```

Look at what the spec does for the agent:

| Spec part | Prevents |
|---|---|
| Non-goal "no new dependencies" | A CSV library pulled in for 30 lines of code |
| Column list in order | Arguing about the format in review |
| Criterion 3 with a nasty example | The classic CSV bug: unescaped quotes |
| Criterion 4 with Lithuanian and Japanese text | Broken characters in Excel, which a developer on macOS never sees |
| Criterion 7 | Breaking the existing backup format "while it was there" |
| Principles touched | A server-side export that sends data out |

---

## 🧠 The spec-writer subagent

> 💡 Don't ask an agent to write your spec. Ask it to interview you, then write down your answers.

Writing a spec alone, you skip the questions you don't think of. A **spec-writer** subagent reads the repository, the issue and PRODUCT.md, then asks the questions a careful colleague would: about edge cases, principles, data shapes and non-goals. You answer; it drafts.

📄 [`toolkit/claude/agents/spec-writer.md`](../toolkit/claude/agents/spec-writer.md) (excerpt)
```markdown
---
name: spec-writer
description: Interviews the human about a feature request and drafts a spec
  from docs/templates/spec-template.md. Use when an issue is labelled needs-spec
  or the user asks to write or sharpen a spec.
tools: Read, Grep, Glob
---

You write specs for BusyHamster. You do not write code or plans.

1. Read the issue, PRODUCT.md (all five principles), and any related spec in docs/.
2. Ask the human your questions in rounds of at most five, numbered, each with
   your recommended answer. Ask about: who it's for, what "done" looks like,
   edge cases (empty, huge, unicode, offline), which principles it touches,
   and what is explicitly out of scope.
3. Never decide a product question yourself. If two answers are reasonable, ask.
4. When nothing is open, draft the spec. Every goal gets at least one
   Given/When/Then criterion. Open questions must be empty.
```

The tools line is the important part: **Read, Grep, Glob**. The spec writer can't edit files or run commands, so it can't jump ahead to implementation.

Run it from your terminal:

```bash
claude "Use the spec-writer subagent on issue #41"
```

For the CSV example, the interview surfaced three things you wouldn't have written down: the BOM for Excel, the empty-history state, and whether the active task belongs in the export (it doesn't: non-goal).

---

## 🧠 The issue form

> 💡 An issue form makes the minimum spec impossible to skip.

GitHub issue forms are YAML files in `.github/ISSUE_TEMPLATE/` that render as a form with required fields 🔧. The toolkit's feature form asks for the one-liner, the problem, goals, non-goals and acceptance criteria, and labels the issue `needs-spec`.

📄 [`toolkit/github/ISSUE_TEMPLATE/feature.yml`](https://github.com/vygantas-meskauskis/learning-library/blob/main/courses/agentic-software-factory/toolkit/github/ISSUE_TEMPLATE/feature.yml) (excerpt)
```yaml
name: Feature
description: Something BusyHamster should do. Becomes one PR.
labels: [needs-spec]
body:
  - type: input
    id: one-line
    attributes:
      label: In one line
      placeholder: Download your finished tasks as a CSV file
    validations:
      required: true
  - type: textarea
    id: acceptance
    attributes:
      label: Acceptance criteria (Given / When / Then)
      description: Each one checkable by a test or a five-second look.
    validations:
      required: true
```

For a quick idea, the form is the spec. For anything bigger, the form is where the spec starts: the spec writer fills in the rest and commits the full spec to `docs/specs/`.

---

## 🧠 Definition of ready

> 💡 `agent:go` is a promise that the work is ready. Check the promise before you make it.

Before you add the `agent:go` label (after the plan in chapter 6 is approved), the issue must pass this checklist:

| Check | Why |
|---|---|
| One-line summary a user would understand | If you can't say it simply, it isn't one unit |
| Every goal has at least one Given/When/Then criterion | "Done" is decidable |
| Non-goals listed | Scope creep has a written answer |
| Product principles touched, and how they're respected | No silent principle breaks (chapter 3's story) |
| Open questions empty | The agent must not decide product questions |
| Fits one PR (about 10 files, one sitting to review) | Otherwise, split into child issues |
| Risk notes filled in if data, auth, money or infrastructure are involved | Feeds the risk tier in chapter 9 |
| An approved plan is in the issue | Chapter 6 |

The issue template's last field is this checklist, so you tick it in the issue itself.

### Splitting big work

When a spec fails "fits one PR", split by **vertical slices** that each work on their own, not by layers:

| Split by layer (avoid) | Split by slice (prefer) |
|---|---|
| 1. Database tables 2. API 3. UI | 1. Signed-in users see their email in the header 2. History syncs one way, local to server 3. History syncs both ways |
| Nothing works until all three land | Each slice ships, behind a flag if needed |

Chapter 11 splits the login arc exactly this way.

---

## ⚠️ Common traps

| Trap | What happens | Instead |
|---|---|---|
| **The "how" in the spec** | You write the code in prose, the agent follows it literally, the plan step is pointless | Spec what and why; let the plan say how |
| **Uncheckable criteria** | "Fast", "intuitive", "robust" | Given/When/Then with concrete values |
| **Missing non-goals** | The agent adds column pickers, date filters and an Excel export | Write down what you're not building |
| **The agent answers open questions** | Product decisions made by whatever seemed reasonable at 10 pm | Open questions must be empty before `agent:go` |
| **Layer-shaped splits** | Three PRs that only work together | Vertical slices that each ship |
| **Specs that never change** | The code drifts from the spec, and the next agent follows the old spec | When behaviour changes, the PR updates the spec |

---

## 🧰 Helpers

- [Spec template](../toolkit/templates/spec-template.md), based on BusyHamster's own Tasks and lines spec.
- [Feature issue form](https://github.com/vygantas-meskauskis/learning-library/blob/main/courses/agentic-software-factory/toolkit/github/ISSUE_TEMPLATE/feature.yml).
- [`spec-writer` subagent](../toolkit/claude/agents/spec-writer.md).

---

## 🧪 Try it yourself

1. Copy the issue form into `.github/ISSUE_TEMPLATE/feature.yml` and the subagent into `.claude/agents/`.
2. Pick a small feature for your own project, open it with the form, and run the spec-writer subagent on it. Answer its questions.
3. Score your spec against the definition of ready. Fix what fails.
4. Rewrite three acceptance criteria from an old issue of yours as Given/When/Then.

---

## ✅ Recap

- A factory spec states what and why, non-goals, principles touched, and Given/When/Then criteria; the how belongs in the plan.
- A read-only spec-writer subagent interviews you; you make every product decision.
- The definition of ready guards `agent:go`; big work splits into vertical slices.

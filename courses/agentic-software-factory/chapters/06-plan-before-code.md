# Chapter 6: Plan before code

> ⏱ About 20 min · You'll learn: why a written plan is the cheapest review you'll ever do, what a good plan contains, how a read-only planner subagent drafts one, how to review it in two minutes, and when to skip the plan entirely.

---

## 📖 Story: Two minutes or forty

Last month, before the course, you asked Claude Code to "add an undo toast when you finish a task". It worked for twenty minutes and produced a clean, well-tested diff of about 600 lines. It had built a general-purpose notification system with a queue, priorities and animations, and moved three existing components onto it.

None of it was wrong, exactly. It just wasn't what you wanted. You wanted one toast. Reading the diff to understand that took forty minutes. Asking for a smaller version took another twenty.

Had the agent written five lines first ("I'll add a notification queue in `src/lib/notify.ts`, migrate session alerts to it, then add the undo toast"), you'd have said no in ten seconds. The undo toast that shipped is 80 lines in `src/components/undo-toast.tsx`.

You write in your factory log: *"The wrong approach is cheapest to catch before there's code."*

---

## 🏚️ Old way → 🚀 New way

| What you do now | What you do in a factory | Why it changes |
|---|---|---|
| The agent plans silently and starts typing | The agent writes a plan, posts it on the issue, and stops | Reviewing a plan takes minutes; reviewing a wrong diff takes an evening |
| You discover the approach in the diff | You approve the approach before the code exists | Changing direction costs nothing at this point |
| Plans live in the chat and disappear | Plans live in the issue, next to the spec | The builder, the reviewer and future you can read them |
| The same session plans and builds | A read-only planner drafts; a separate builder executes | The planner can't drift into coding; the builder follows something written |

---

## 🧠 What a plan is for

> 💡 The spec says what done looks like. The plan says how we'll get there, small enough to review in two minutes.

A plan sits between spec and code:

| | Spec (chapter 5) | Plan (this chapter) | Code (chapter 7) |
|---|---|---|---|
| Written by | You, interviewed by the spec writer | The planner agent | The coding agent |
| Approved by | You | **You** | Gates, the reviewer, then you by tier |
| Answers | What and why | How, where, in what order, with which tests | The change itself |
| Size | One page | 20 to 60 lines | ~10 files |
| Cost of a mistake caught here | Low | **Lowest per decision** | High |

A plan also gives the **reviewer** (chapter 8) something to check the diff against: "did the code do what the plan said, and nothing else?"

---

## 🧠 What a good plan contains

> 💡 A plan you can review in two minutes names files, steps, tests and risks, and says what it won't touch.

The [plan template](../toolkit/templates/plan-template.md) has seven sections:

| Section | Content | Review question |
|---|---|---|
| **Approach** | Two to four sentences: the idea | Is this the simplest approach that meets the spec? |
| **Files** | Every file created or changed, one line each | Is anything here surprising? Is anything missing? |
| **Steps** | Ordered steps, tests first where it makes sense | Can each step be checked on its own? |
| **Tests** | Which acceptance criterion each test covers | Does every criterion have a test? |
| **Out of scope** | Files and behaviour the plan deliberately won't touch | Does it stay inside the spec? |
| **Risks** | What could go wrong; data, security, performance | Is there a risk the plan doesn't see? |
| **Rollback** | How to undo it | Is it one revert? |

Notice what's **not** there: no code. A few lines of signature are fine (`toCsv(entries: HistoryEntry[]): string`). Full implementations in a plan are a sign the planner is coding.

---

## 💻 In BusyHamster: the plan for CSV export

The planner reads the spec from chapter 5 and the code, and posts this on issue #41.

📝 Illustrative

```markdown
## Plan: Export History as CSV (#41)

### Approach
Add a pure `toCsv(entries)` function next to the existing backup format in
src/lib/history.ts, so it's tested the same way as createBackup. Add a
browser-side `exportCsv()` next to `exportBackup()` in backup-actions.ts.
Surface it as a button on History and a "Data" command in the command menu.
No new dependencies.

### Files
- src/lib/history.ts: add toCsv(entries, timeZone) and csvField(value)
- src/lib/history.test.ts: tests for criteria 1–4 and 7
- src/lib/backup-actions.ts: add exportCsv() (Blob, BOM, download)
- src/components/history-screen.tsx: "Export as CSV" button next to "Export backup"; disabled state (criterion 6)
- src/components/command-menu.tsx: add("Data", "Export as CSV", exportCsv)

### Steps
1. Write failing tests in history.test.ts for criteria 1–4 and 7.
2. Implement csvField (RFC 4180 quoting) and toCsv. Tests pass.
3. Add exportCsv in backup-actions.ts, mirroring exportBackup.
4. Add the button and its disabled state, using Button from @/components/ui.
5. Add the command-menu entry. Manual check of criterion 5 in the preview.
6. npm run check; npm run build.

### Tests
| Criterion | Test |
|---|---|
| 1 rows and filename | history.test.ts "toCsv: one row per line" + filename helper test |
| 2 minutes | "toCsv: rounds focusedMs to minutes" |
| 3 quoting | "csvField: quotes commas, quotes and newlines" |
| 4 unicode + BOM | "toCsv: keeps non-ASCII text"; BOM added in exportCsv (manual) |
| 5 command menu | Manual, in the preview (smoke test in chapter 8) |
| 6 empty state | Manual, in the preview |
| 7 JSON unchanged | Existing createBackup/parseBackup tests, untouched |

### Out of scope
- createBackup / parseBackup and their tests: not changed.
- No new UI primitive; Button already has a secondary variant.
- No change to the History list itself.

### Risks
- Excel and UTF-8: covered by the BOM. Numbers and Sheets ignore it.
- Time zones: dates formatted in the user's local zone via Intl; tests pass
  the zone explicitly so they're deterministic in CI.

### Rollback
Single PR, no data migration: revert the commit.
```

### Reviewing it in two minutes

You read it with four questions in mind:

1. **Simplest approach?** Yes: a pure function next to the existing format, mirroring `exportBackup`. No new module, no library.
2. **Any surprising file?** No. All five files are where you'd look.
3. **Does every criterion have a check?** Yes, two are manual, which you note for chapter 8's smoke test.
4. **A risk it missed?** One: CSV injection. A line text starting with `=`, `+`, `-` or `@` can run as a formula when the file opens in a spreadsheet. You add one comment:

> Approved, with one addition: prefix cells starting with = + - @ with a single quote (CSV injection). Add a test.

Then you add the `agent:go` label. Total time: about three minutes, including the one thing you'd never have spotted in a 300-line diff at midnight.

---

## 🧠 The planner subagent

> 💡 A planner that can't edit files can't start coding "just to check something".

📄 [`toolkit/claude/agents/planner.md`](../toolkit/claude/agents/planner.md) (excerpt)
```markdown
---
name: planner
description: Turns an approved spec into an implementation plan using
  docs/templates/plan-template.md. Use when an issue is labelled needs-plan.
tools: Read, Grep, Glob
---

You plan changes to BusyHamster. You never write or edit code.

1. Read the spec in the issue, the root AGENTS.md and the AGENTS.md of every
   folder you'll touch, and the code you'll change.
2. Prefer changing existing modules over adding new ones. Prefer existing
   primitives and helpers over new dependencies. If you need a new
   dependency, say why in Risks.
3. Keep it to one PR: about 10 files. If it's bigger, propose a split into
   child issues instead of a plan.
4. Map every acceptance criterion to a test or to a named manual check.
5. List what you will not touch under Out of scope.
6. If the spec is ambiguous, stop and list your questions instead of guessing.
```

You can run it interactively, or in CI when you add the `needs-plan` label. The toolkit's `agent-implement.yml` has a `plan` job that runs the planner headlessly and posts the plan as a comment, then swaps the label to `plan-review`.

### Plan mode in Claude Code

Interactively, Claude Code also has a **plan mode** (Shift+Tab to cycle permission modes) 🔧. In plan mode, the agent can read and think but not edit, and it presents a plan for you to accept before it changes anything. It's the same idea for work in your own terminal: use it for any change bigger than a few lines.

---

## 🧠 When to skip the plan

> 💡 Plans cost a few minutes. Skip them only when a wrong approach is impossible or harmless.

| Change | Plan? |
|---|---|
| Typo, copy change, dependency patch bump | No (tier 0, chapter 9) |
| A bug fix with an obvious, one-file cause | Optional: a two-line plan in the PR description is enough |
| Any new feature, any change to data or storage | **Yes** |
| Anything touching auth, the API contract or infrastructure | **Yes**, and the plan is tier 2 too: you read it carefully |
| A refactor across many files | **Yes**, and usually a split |

---

## ⚠️ Common traps

| Trap | What happens | Instead |
|---|---|---|
| **Plans full of code** | Reviewing the plan takes as long as reviewing the diff | Names, signatures and steps; no implementations |
| **Rubber-stamping** | "LGTM" without reading, so the plan step is just a delay | Four questions, two minutes, every time |
| **The builder ignores the plan** | The diff wanders off into unrelated refactors | The plan is part of the builder's prompt; the reviewer checks diff against plan |
| **No out-of-scope section** | "While I was there, I also…" | Name the files and behaviour that won't change |
| **The planner guesses** | An ambiguous spec becomes a confident plan | The planner stops and asks; ambiguity goes back to the spec |
| **Plans too big for one PR** | A 40-step plan approved as one unit | The planner proposes a split instead |

---

## 🧰 Helpers

- [Plan template](../toolkit/templates/plan-template.md).
- [`planner` subagent](../toolkit/claude/agents/planner.md).
- [`agent-implement.yml`](https://github.com/vygantas-meskauskis/learning-library/blob/main/courses/agentic-software-factory/toolkit/github/workflows/agent-implement.yml), `plan` job.

---

## 🧪 Try it yourself

1. Copy the planner subagent into `.claude/agents/` and the plan template into `docs/templates/`.
2. Run it on the spec you wrote in chapter 5: `claude "Use the planner subagent on issue #<n>"`.
3. Review the plan with the four questions. Time yourself.
4. Find one thing to change, comment it, and ask the planner to revise.
5. Write in your factory log: how long did the review take, and what did you catch?

---

## ✅ Recap

- A plan is the cheapest review in the factory: approach, files, steps, tests, out of scope, risks, rollback.
- A read-only planner drafts it; you approve it with four questions in about two minutes.
- Skip plans only for changes where a wrong approach is impossible or harmless.

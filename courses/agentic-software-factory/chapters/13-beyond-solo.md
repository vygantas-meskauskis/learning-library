# Chapter 13: Beyond solo

> ⏱ About 15 min · You'll learn: what changes when a second person joins the factory, which parts of the factory belong to the repository and which belong to one tool, how Claude Code compares with GitHub Copilot's coding agent, OpenAI Codex and Cursor's cloud agents for this kind of work, and a 90-day plan for your own factory.

---

## 📖 Story: Rūta's first week

Rūta is a designer who codes, and a friend. She likes BusyHamster and offers a few evenings a month: design polish, a new game for the Tired page, maybe the iPad layout. She uses Cursor, not Claude Code.

On her first evening, she opens the repository in Cursor and asks its agent to add a new mini-game. Cursor reads the root `AGENTS.md`, the `web/AGENTS.md` and `DESIGN.md`. The game uses the design-system primitives, has a command-menu entry and a test. She opens a PR. CI runs the gates, the reviewer posts a verdict, the tier comes out as 1, and you approve it in eight minutes.

Nothing in that flow was Claude-specific except the reviewer job, which doesn't care who wrote the diff. Most of the factory you built lives in the repository, not in a tool.

Her second PR changes a colour token in `globals.css`. It's tier 1 by the path rules, but it changes every screen. You realise the tier rules were written for one person who knew the codebase by heart.

You write in your factory log: *"The factory is the repo. Tools come and go; gates, context and tiers stay."*

---

## 🏚️ Old way → 🚀 New way

| What you do solo | What you do with others | Why it changes |
|---|---|---|
| You're every approver | CODEOWNERS routes reviews by area; approvals mean something | Two people know different parts |
| Tier rules written from memory | Tier rules include "wide blast radius" files, like design tokens | A newcomer can't feel what a token change does |
| One agent tool, configured once | AGENTS.md and gates are tool-neutral; tool-specific config is optional extras | People choose their own tools |
| You merge whenever checks pass | A merge queue once PRs land in parallel often enough to conflict | `main` stays green when two green PRs conflict |
| Decisions live in your head and your log | Decisions in ADRs; the factory review becomes a short shared ritual | Others need the "why" too |

---

## 🧠 Adding a second human

> 💡 Most of the factory scales to a team as it is. Approvals, ownership and the tier list need updating.

| Area | Solo setting | With a second person |
|---|---|---|
| **Approvals** | Tier gate: your approval on agent PRs; bypass for your own PRs | Ruleset: 1 approval required for everyone; the tier gate adds a second for tier 2 |
| **Ownership** | Implicit | `CODEOWNERS`: `web/app/components/ui/ @ruta @you`, `api/ @you`, `infra/ @you`, `.github/ @you` |
| **Who can start agents** | You add `agent:go` | Anyone with triage permission; agent runs record who added the label |
| **Tier list** | Paths you know are risky | Add wide-blast-radius files: `globals.css` tokens, `routes.ts`, `storage.ts` |
| **Secrets** | Your Claude token in CI | A shared API key with a monthly limit, or each person's own runs from their own tool |
| **Factory review** | You, 30 minutes | Both, 30 minutes, every two weeks; one fix each |
| **Merging** | Direct, when green | A merge queue once two PRs a day regularly touch the same files 🔧 |

The `ci.yml` workflow already listens to `merge_group` (chapter 4), so turning the merge queue on later is a ruleset setting, not a workflow change.

---

## 🧠 What belongs to the repository, and what to a tool

> 💡 Keep everything that defines "good work" in the repository, in tool-neutral formats. Tool-specific setup is a thin layer on top.

| Part of the factory | Portable? | Where it lives |
|---|---|---|
| AGENTS.md (root and folders) | **Yes**: read by Claude Code, Copilot, Codex and Cursor 🔧 | Repository |
| DESIGN.md, PRODUCT.md, specs, ADRs | **Yes**: plain Markdown | Repository |
| CI gates, contract check, parity tests, smoke tests | **Yes** | `.github/workflows/`, `web/`, `api/` |
| Risk tiers and the tier gate | **Yes** | `scripts/risk-tier.sh`, rulesets |
| Reviewer job | **Yes** in effect: it reviews any diff, whoever wrote it | `.github/workflows/agent-review.yml` |
| Deploy, OIDC, environments | **Yes**: no agent involved | `.github/workflows/deploy.yml`, Azure |
| Skills | Partly: the Agent Skills format is shared, but discovery paths differ by tool 🔧 | `.claude/skills/` |
| Subagents | Claude Code | `.claude/agents/` |
| Permissions, sandbox, hooks | Claude Code (other tools have their own equivalents) | `.claude/settings.json`, `.claude/hooks/` |
| The `agent-implement` workflow | Claude Code (`claude-code-action`) | `.github/workflows/` |

Notice where the **walls** are. The protect-paths hook only applies to Claude Code. For other tools, the same protection comes from the layers that don't depend on the tool: protected paths are tier 2, CODEOWNERS requires your review, and the reviewer blocks changes to existing tests. That's why chapter 7 called the hook a wall "where advice failed", not the only wall.

---

## 🧠 The agents, compared

> 💡 All four major tools can now take a task and come back with a pull request. They differ in where they run, how you trigger them, and how much of the factory you configure yourself.

As of November 2026, every major coding tool has some kind of background or cloud mode 🔧. The comparison below is about this course's factory: issue in, PR out, gates and review around it.

| | Claude Code | GitHub Copilot coding agent | OpenAI Codex (cloud) | Cursor cloud agents |
|---|---|---|---|---|
| **Main surfaces** | Terminal, IDE extensions, desktop and web apps, GitHub Actions | IDE (agent mode) and GitHub itself | IDE, CLI, web and ChatGPT | The Cursor editor |
| **Start a background task** | A label or `@claude` comment through `claude-code-action`; or a background session | **Assign the issue to Copilot** | A task from the IDE, CLI or web | From the editor |
| **Where it runs** | Your GitHub Actions runner (or your machine) | A GitHub Actions runner | OpenAI's cloud sandbox | A cloud VM run by Cursor |
| **Reads AGENTS.md** | Yes (since 2.1.277, when no CLAUDE.md) | Yes | Yes | Yes |
| **Fine-grained local control** | Permissions, sandbox, hooks, subagents, skills, in the repo | Repository and organisation settings, custom instructions | Sandbox and environment settings | Rules, editor settings |
| **Fits this course's factory** | Built here; every stage is configurable | Very well: GitHub-native, issue to PR with no workflow to write | Well, for parallel tasks; you wire the GitHub side | Well, for interactive-first people like Rūta |
| **Billing** | Subscription or API tokens 💰 | Copilot plan 💰 | ChatGPT plan or API 💰 | Cursor plan 💰 |

What follows from the table:

- **The gates don't care.** Every row produces a PR. Your CI, reviewer, tiers and deploy treat them the same way. That's the real reason to build the factory in the repository.
- **Copilot is the closest drop-in.** If you'd rather not maintain `agent-implement.yml`, assigning issues to Copilot gives you the build stage with GitHub doing the orchestration. Keep everything else from this course.
- **Mixing works.** Rūta uses Cursor interactively; the factory's headless builds use Claude Code; a reviewer could run on a different model from the builder for more independence (chapter 8).
- **Benchmarks move every month.** Pick on workflow fit, then measure with your own run log (chapter 12): acceptance rate and cost per merged PR for **your** repository are the only benchmark that matters.

---

## 🧠 Capstone: your factory in 90 days

> 💡 You've built BusyHamster's factory in the chapters. Now build yours, one bottleneck at a time.

| Days | Goal | Done when |
|---|---|---|
| 1–7 | **Context and gates** | Cold-start test 6/6; CI with lint, types, tests and build as required checks; a ruleset on `main` |
| 8–21 | **Specs and plans** | Issue form, spec template, spec writer and planner in use; definition of ready on `agent:go` |
| 22–35 | **The agent in CI** | Labelled issues become PRs; permissions, sandbox and the three hooks in place; WIP limit set |
| 36–49 | **Verification and tiers** | Independent reviewer as a required check; smoke tests on previews; tier gate; tier 0 auto-merge |
| 50–63 | **Deploy** | OIDC, environments, what-if, flags; one rollback drill done |
| 64–90 | **Your arc** | One big change (a migration, a rewrite or a new capability) run as many small units, with its own parity or contract tests |
| Every week | **Run it** | 30-minute factory review; one fix; numbers in the worksheet |

At day 90, compare with the first entry in your factory log from chapter 1: where did the time go then, and where does it go now?

---

## ⚠️ Common traps

| Trap | What happens | Instead |
|---|---|---|
| **The factory lives in one tool** | A new contributor's tool ignores half the rules | AGENTS.md, gates and tiers in the repository; tool config is extra |
| **Solo tier rules for a team** | A token change approved as "just CSS" | Add wide-blast-radius files to tier 2 |
| **No ownership** | Everyone reviews everything, or nobody does | CODEOWNERS by area |
| **Tool wars** | Time spent arguing which agent is best | Measure acceptance rate and cost per merged PR on your repository |
| **Benchmark shopping** | Switching tools every month | Workflow fit first, your own numbers second |
| **Stopping at day 90** | The factory decays as the codebase changes | The weekly review never stops |

---

## 🧰 Helpers

- [Factory setup checklist](../toolkit/factory-setup-checklist.md): the 90-day plan as checkboxes.
- [Risk tiers](../toolkit/risk-tiers.md), with a team section.
- [Toolkit overview](../toolkit/README.md).

---

## 🧪 Try it yourself

1. Write a `CODEOWNERS` file for your repository, even if you're alone today. It documents which areas are sensitive.
2. Open your repository in a second agent tool (Copilot, Codex or Cursor) and run the cold-start test from chapter 3 there. Fix anything that only worked because of Claude-specific files.
3. Copy the factory setup checklist into an issue in your repository and tick off what you've done during the course.
4. Write your 90-day plan in your factory log, with dates.

---

## ✅ Recap

- A second person changes approvals, ownership and the tier list; the rest of the factory scales as it is.
- Gates, context, tiers and deploy live in the repository in tool-neutral formats; agent tools are a replaceable layer on top.
- Build your own factory one bottleneck at a time over 90 days, and keep the weekly review going after that.

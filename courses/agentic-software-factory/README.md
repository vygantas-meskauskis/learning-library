# Building Your Agentic Software Factory

[Back to library](../../index.html) · [Read the course](index.html)

**Design the line that writes your software.** A self-study course for experienced developers who already use AI coding agents one prompt at a time, and want a repeatable system instead: specs in, verified pull requests out, deployed safely, with humans owning the intent and the gates.

> 📅 Written in November 2026 for Claude Code 2.1, React Router 8, .NET 10 and the Azure and GitHub services of that time. Facts marked 🔧 change often; check the linked docs.

---

## What "software factory" means here

A software factory is a repeatable delivery system in which AI agents do defined pieces of work (specs, plans, code, reviews) and pass their results through checks and approvals before anything reaches users. You stop being the person who types every change and become the person who designs the line: what goes in, which checks it must pass, and where a human has to say yes.

| You do this today | This course gets you to |
|---|---|
| Prompt an agent in your editor, watch it, fix it, commit | Agents pick up labelled issues and open pull requests on their own |
| "The build passed on Vercel" is the only check | Lint, types, tests, build, an independent AI review and a preview deploy on every PR |
| You review every line of every diff | You review specs and plans; the gates and the reviewer catch the rest; risk tiers decide what needs your eyes |
| Agent instructions live in your head and in chat history | AGENTS.md, specs, ADRs and skills in the repo, versioned with the code |
| Secrets in the agent's environment "to make things work" | Agents hold no cloud credentials; only the post-merge deploy can write to Azure |
| No idea what the agents cost or how often they fail | A run log, a cost cap per task and a weekly factory review |

## How the course works

You run **BusyHamster** ([busyhamster.app](https://busyhamster.app)), a focus timer that remembers where your head was. It's a real, live product built by one developer in the evenings. Today it's a Next.js app on Vercel with 109 unit tests, an AGENTS.md and a spec folder, and no CI at all. Over 13 chapters you build a factory around it, then use the factory for two big jobs: rewriting the frontend to React Router, and adding login, a database and a .NET API on Azure.

| Section in every chapter | What it gives you |
|---|---|
| 📖 Story | The problem, as it shows up at BusyHamster |
| 🏚️ Old way → 🚀 New way | Your current habit next to the factory practice |
| 🧠 Concepts | The ideas, in tables and decision guides |
| 💻 In BusyHamster | Real files from the sample or the toolkit |
| 🗺️ Diagrams | Who does what, and how work flows |
| ⚠️ Common traps | Mistakes that are easy to make |
| 🧰 Helpers | Copy-ready files from the toolkit |
| 🧪 Try it yourself | Optional hands-on steps |
| ✅ Recap | Three lines to remember |

| Marker | Meaning |
|---|---|
| 🔧 | Volatile fact (version, flag, limit, plan name). Check the docs before relying on it. |
| 💰 | Has a cost impact. The course explains cost drivers, not prices. |
| 🧪 Not run by the author | Steps written from the docs, not executed end to end for this course. |
| 📝 Illustrative | An example written for the course (a spec, a plan, a review), not copied from a real agent run. |

## The sample and the toolkit

| Folder | What it is |
|---|---|
| [`sample/`](https://github.com/vygantas-meskauskis/learning-library/tree/main/courses/agentic-software-factory/sample) | A pinned snapshot of the BusyHamster repository (commit `6b0eaf4`, 9 November 2026): Next.js 16, React 19, Vitest, AGENTS.md, DESIGN.md, PRODUCT.md and one spec. This is the "before" state the course starts from. |
| [`toolkit/`](toolkit/README.md) | Everything you copy into your own repository: AGENTS.md templates, Claude Code settings, hooks, subagents and a skill, GitHub workflows and templates, spec, plan and ADR templates, risk tiers, cost guardrails, a metrics worksheet, and starter files for React Router, the .NET BFF, Static Web Apps and Bicep. |

The "after" code isn't in the course. It grows in your own repository as you work through chapters 10 and 11, which quote the important parts.

## Who it's for

Experienced developers who have used an AI coding agent (Claude Code, Copilot, Cursor, Codex) for real work, know Git and GitHub, and can read TypeScript and C#. You don't need to be a frontend or .NET specialist: the course teaches the factory, and links to [Cloud-Native .NET](../cloud-native-dotnet/README.md) for the .NET and Azure depth.

## Tools you need

| Tool | Why | Required? |
|---|---|---|
| Git and a GitHub account | Every chapter | Yes |
| Node.js 22 | The sample and the React Router app | Yes |
| [Claude Code](https://code.claude.com/docs) and a Claude subscription or API key | The agent used throughout 🔧 | Yes |
| .NET 10 SDK | Chapter 11 | From chapter 11 |
| Docker or Podman | Integration tests with a real SQL Server (chapter 11) | From chapter 11 |
| Azure subscription and Azure CLI | Chapters 9 to 11, if you deploy | Optional |

## Contents

| # | Chapter | Time |
|---|---|---|
| 1 | [The shift: from writing code to designing the line](chapters/01-the-shift.md) | 20 min |
| 2 | [Anatomy of a factory](chapters/02-anatomy-of-a-factory.md) | 25 min |
| 3 | [The context layer](chapters/03-the-context-layer.md) | 25 min |
| 4 | [Tests and CI gates](chapters/04-tests-and-ci-gates.md) | 20 min |
| 5 | [Intake and specs](chapters/05-intake-and-specs.md) | 20 min |
| 6 | [Plan before code](chapters/06-plan-before-code.md) | 20 min |
| 7 | [Building with agents](chapters/07-building-with-agents.md) | 25 min |
| 8 | [Independent verification](chapters/08-independent-verification.md) | 25 min |
| 9 | [Merge and deploy](chapters/09-merge-and-deploy.md) | 25 min |
| 10 | [Arc 1: the factory rewrites the frontend](chapters/10-arc-1-the-rewrite.md) | 30 min |
| 11 | [Arc 2: login, data and the .NET API](chapters/11-arc-2-login-data-and-the-api.md) | 30 min |
| 12 | [Observe and improve](chapters/12-observe-and-improve.md) | 20 min |
| 13 | [Beyond solo](chapters/13-beyond-solo.md) | 15 min |

Plus a [glossary](GLOSSARY.md) and the [toolkit](toolkit/README.md).

## Pace

About 5 hours of reading, and 13 to 17 hours more if you do the exercises and both arcs in your own repository: 18 to 22 hours in total. Suggested rhythm, at around 5 hours a week:

| Week | Chapters | You end the week with |
|---|---|---|
| 1 | 1 to 3 | A factory log, a stage map and a context layer that passes the cold-start test |
| 2 | 4 to 6 | CI with required checks, an issue form, a spec and an approved plan |
| 3 | 7 to 9 | An agent that turns a labelled issue into a reviewed, tiered, deployed PR |
| 4 | 10 | The React Router rewrite running on Azure Static Web Apps |
| 5 | 11 to 13 | Login and sync behind a flag, a run log, and a plan for the next 90 days |

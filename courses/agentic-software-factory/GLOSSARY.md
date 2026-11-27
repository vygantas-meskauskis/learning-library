# Glossary

[Back to the course](README.md)

| Term | Meaning | Chapter |
|---|---|---|
| **Acceptance criterion** | A Given / When / Then statement that a test, a script or a quick look can say yes or no to. | 5 |
| **Acceptance rate** | Agent PRs merged without a human rewrite, divided by agent PRs opened. | 2 |
| **ADR (Architecture Decision Record)** | A one-page Markdown file recording a decision: context, decision, consequences, status. | 3 |
| **`agent:go`** | The label that tells the coding agent it may start. Only a maintainer can add it. | 2, 7 |
| **AGENTS.md** | A Markdown file of instructions for coding agents, read automatically by Claude Code, Copilot, Codex and Cursor. One at the root, optionally one per folder. | 3 |
| **Auto-merge** | A GitHub setting that merges a PR as soon as every required check passes. Used for tier 0. | 9 |
| **BFF (backend for frontend)** | A server that does sign-in and holds tokens for one browser app, giving the browser only an HttpOnly session cookie. | 11 |
| **Cold-start test** | A fixed set of questions asked to a brand-new agent session, to test whether the repository explains itself. | 3 |
| **Contract (API)** | The OpenAPI document generated from the API, committed, and used to generate the frontend's types. A CI gate checks they agree. | 11 |
| **Cycle time** | Time from `agent:go` to merged. | 2 |
| **Definition of ready** | The checklist an issue must pass before `agent:go`: criteria, non-goals, principles, no open questions, one PR, approved plan. | 5 |
| **`dontAsk` (permission mode)** | A Claude Code mode that refuses any action not explicitly allowed, instead of waiting for approval. Used in CI. | 7 |
| **Entra External ID** | Microsoft's hosted customer identity service: sign-up, sign-in and account recovery for an app's users. | 11 |
| **Environment (GitHub)** | A named deployment target with its own secrets, branch restrictions and optional required reviewers. | 9 |
| **Escaped defect** | A bug that reached production. Each one is traced back to the gate that should have caught it. | 2, 12 |
| **Expand and contract** | A migration pattern: first add (expand), ship code that uses the new shape, remove the old shape (contract) later in a separate change. | 11 |
| **Factory log** | Your own notes on how the factory performs: timings, failures, decisions. Starts in chapter 1. | 1 |
| **Feature flag** | A switch that turns shipped code on or off without a deploy of new code. | 9 |
| **Federated credential** | An Entra ID trust that accepts GitHub's OIDC token for a specific repository, environment or branch, so CI needs no stored Azure secret. | 9 |
| **Gate** | A check that blocks a merge when it fails. | 4 |
| **Hook (Claude Code)** | A script Claude Code runs at a fixed point, such as before a tool call. A `PreToolUse` hook that exits with code 2 blocks the call. | 7 |
| **Independent verification** | A check that differs from the builder in mechanism, context, control, perspective or authority. | 2, 8 |
| **Linked backend** | A Static Web Apps feature that proxies `/api/*` to an API hosted elsewhere, such as Container Apps. Needs the Standard plan; not available in PR environments. | 11 |
| **Local first** | Data is written to the browser first; any server copy catches up in the background. | 11 |
| **Merge queue** | A GitHub feature that tests PRs together before they land, so two green PRs can't break `main` together. | 13 |
| **OIDC (in CI)** | GitHub issues a short-lived token per workflow run that a cloud provider exchanges for its own token. No long-lived secret. | 9 |
| **Parity test** | A test that compares the new system with the old one: URLs, metadata, storage, key paths. | 10 |
| **Plan** | A short document between spec and code: approach, files, steps, tests, out of scope, risks, rollback. | 6 |
| **Pre-rendering** | Rendering a route to a full HTML file at build time. | 10 |
| **Preview environment** | A temporary deployment of one PR with its own URL. | 8 |
| **Prompt injection** | Text written to make an agent do something its owner didn't intend. | 12 |
| **Protected paths** | Files agents may not edit (workflows, agent settings, infrastructure, existing tests), enforced by a hook and by tier 2. | 7, 9 |
| **Reviewer agent** | A read-only agent with its own prompt that checks a diff against the spec and plan and returns a JSON verdict. | 8 |
| **Rework rate** | Merged changes reverted or fixed within 14 days, divided by merged changes. | 2 |
| **Risk tier** | 0, 1 or 2: how much human attention a PR needs, computed from the files it changes. | 9 |
| **Ruleset** | GitHub's branch protection: required PRs, required checks, no force pushes, bypass list. | 4 |
| **Sandbox (Claude Code)** | OS-level filesystem and network isolation for the shell commands an agent runs. | 7 |
| **Skill** | A folder with a `SKILL.md` that teaches an agent one repeatable procedure, loaded only when relevant. | 3 |
| **Smoke test** | A handful of browser tests over the paths that must never break, run against a preview. | 8 |
| **Software factory** | A repeatable system in which agents do defined work and pass it through checks and approvals they don't control. | 1 |
| **SPA fallback** | One HTML file that can start the app for any route that wasn't pre-rendered. | 10 |
| **Spec** | What and why, non-goals, principles touched and acceptance criteria for one unit of work. | 5 |
| **Subagent** | A specialised agent with its own instructions, tools and context window, defined in `.claude/agents/`. | 3 |
| **Tier gate** | A required check that passes only when a PR's risk-tier rule (approvals, labels) is met. | 9 |
| **Vertical slice** | A unit of a big feature that works end to end on its own, instead of one layer of it. | 5, 11 |
| **What-if** | An Azure deployment preview that lists the resources a template would create, change or delete. | 9 |
| **WIP limit** | The maximum number of agent tasks in progress at once, set by your review capacity. | 2, 7 |
| **Worktree** | A second working copy of a Git repository on its own branch, for running agents in parallel. | 7 |

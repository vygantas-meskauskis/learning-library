# Chapter 8: Independent verification

> ⏱ About 25 min · You'll learn: the layers of verification that sit on top of the CI gates, how to build an AI reviewer that's genuinely independent of the builder, how to get a structured verdict instead of a chatty review, how preview deployments and a browser smoke test check what the user will actually see, and what's left for you to look at.

---

## 📖 Story: "Looks great!"

The agent's CSV export PR is green. Out of curiosity, you open a new comment on the PR and write `@claude please review this PR`. The same action that built it replies in a minute:

> Great implementation! The code is clean, well-tested and follows the plan. The RFC 4180 quoting is handled correctly. LGTM 🎉

Then you open the preview, finish a task with the line `=HYPERLINK("http://example.com","click")`, export, and open the file in a spreadsheet. The cell is a live link. The CSV-injection protection you asked for in the plan is there, but only for cells that start with `=`. The plan said `= + - @`. The test checks `=` only.

The reviewer had the same blind spot as the builder because, in every way that matters, it **was** the builder: same tool, same repository context, same instructions, and a request phrased as "please review" that invites agreement.

You write in your factory log: *"A reviewer that shares the builder's context shares its mistakes. Independence has to be designed."*

---

## 🏚️ Old way → 🚀 New way

| What you do now | What you do in a factory | Why it changes |
|---|---|---|
| Ask the same agent to review its work | A separate reviewer with its own prompt, read-only tools and only the spec, plan and diff | Shared context means shared blind spots |
| A friendly paragraph of feedback | A structured verdict: pass, changes or block, with findings tied to criteria | A machine can act on a verdict; it can't act on "LGTM 🎉" |
| You imagine the UI from the JSX | A preview deployment for every PR, and a browser smoke test against it | The user sees pages, not components |
| You read every diff fully | You read the reviewer's findings, the preview, and the risky files | Your attention goes where the evidence points |

---

## 🧠 Layers of verification

> 💡 Each layer catches what the one below can't. Cheap and mechanical first, expensive and human last.

| Layer | What | Catches | Misses | Chapter |
|---|---|---|---|---|
| 1. **Gates** | Lint, types, unit tests, build | Broken code, regressions in tested logic | Wrong behaviour that's tested wrongly, or not tested | 4 |
| 2. **Reviewer agent** | Spec + plan + diff, independent prompt | Missing criteria, scope creep, principle breaks, risky patterns, weak tests | Anything visual; anything it can't run | This chapter |
| 3. **Preview + smoke test** | The PR deployed, a scripted browser walk-through | Pages that don't load, broken key paths, the resume regression | Taste, layout subtleties | This chapter |
| 4. **You** | Findings, preview, risky files, by tier | Taste, product fit, security judgment | Whatever you skim | 9 |

The point isn't that each layer is perfect. It's that their blind spots are **different**.

---

## 🧠 Designing an independent reviewer

> 💡 Independence comes from different context, different instructions, different incentives and no ability to change the code.

Chapter 2 listed the axes. Here's how BusyHamster's reviewer gets each one:

| Axis | Builder | Reviewer |
|---|---|---|
| **Context** | The whole repo, the issue, the plan, its own session history | Only the spec, the plan, the diff and the files the diff touches. No builder session, no PR description |
| **Instructions** | "Implement this" | "Find where this diff fails the spec. Assume there's at least one problem." |
| **Tools** | Read, edit, run commands | **Read, Grep, Glob only**. No edits, no shell |
| **Output** | Code and a PR | A JSON verdict matching a schema |
| **Model** | Whatever the builder uses | Optionally a different model, for different failure modes 🔧 |

Two of those deserve a word.

**Not reading the PR description** is deliberate. The description is the builder's argument for its own work. Human reviewers are persuaded by confident summaries too; the reviewer starts from the spec instead.

**"Assume there's at least one problem"** changes what the model looks for. "Please review" invites a summary. "Find the gap between this diff and criterion 3" produces checks.

📄 [`toolkit/claude/agents/reviewer.md`](../toolkit/claude/agents/reviewer.md) (excerpt)
```markdown
---
name: reviewer
description: Reviews a pull request diff against its spec and plan. Independent
  of the builder. Use for PR review, never for implementation.
tools: Read, Grep, Glob
---

You review changes to BusyHamster. You did not write this code and you must not
trust its author. You cannot edit files.

Inputs: SPEC.md, PLAN.md, DIFF.patch in the working directory, plus the repo.

For each acceptance criterion in the spec:
- find the test or manual check that covers it; quote the test name
- check the implementation meets it exactly, including every case listed
  (for example every character in a list, every edge case)
Then check:
- files changed that the plan did not list (scope creep)
- existing tests modified or deleted
- PRODUCT.md principles: does anything send data out, add a step to resuming,
  or add an action without a keyboard shortcut?
- security: injection, unsafe HTML, secrets, new network calls
Assume there is at least one problem. Report findings, not praise.
```

---

## 🧠 A verdict, not a conversation

> 💡 Give the reviewer a JSON schema, and the workflow can act on its answer.

Claude Code's headless mode (`claude -p`) can return output that must match a JSON schema, using `--output-format json` with `--json-schema` 🔧. The response carries the structured result alongside the session metadata, including `total_cost_usd`, which chapter 12 uses.

📄 [`toolkit/claude/review-verdict.schema.json`](../toolkit/claude/review-verdict.schema.json)
```json
{
  "type": "object",
  "required": ["verdict", "criteria", "findings"],
  "properties": {
    "verdict": { "enum": ["pass", "changes", "block"] },
    "criteria": {
      "type": "array",
      "items": {
        "type": "object",
        "required": ["id", "covered_by", "met"],
        "properties": {
          "id": { "type": "string" },
          "covered_by": { "type": "string" },
          "met": { "enum": ["yes", "no", "unclear"] }
        }
      }
    },
    "findings": {
      "type": "array",
      "items": {
        "type": "object",
        "required": ["severity", "file", "summary"],
        "properties": {
          "severity": { "enum": ["blocker", "major", "minor"] },
          "file": { "type": "string" },
          "line": { "type": "integer" },
          "summary": { "type": "string" }
        }
      }
    }
  }
}
```

| Verdict | Meaning | What the workflow does |
|---|---|---|
| `pass` | Every criterion met, no major findings | The `review` check goes green |
| `changes` | Something's missing or weak, but nothing dangerous | Green check, findings posted as a comment; the builder gets one retry with the findings |
| `block` | A principle break, a security problem, a modified existing test, or a criterion clearly not met | The `review` check goes **red**; the PR can't merge; `needs-human` |

The `review` check is a required status check (chapter 4), so a `block` verdict really stops the merge.

---

## 💻 In BusyHamster: the review workflow

📄 [`toolkit/github/workflows/agent-review.yml`](https://github.com/vygantas-meskauskis/learning-library/blob/main/courses/agentic-software-factory/toolkit/github/workflows/agent-review.yml) (excerpt)
```yaml
name: review

on:
  pull_request:
    types: [opened, synchronize, ready_for_review]

permissions:
  contents: read
  pull-requests: write

jobs:
  review:
    # Same-repo PRs only: PRs from forks never get the model token.
    if: github.event.pull_request.head.repo.full_name == github.repository
    runs-on: ubuntu-latest
    timeout-minutes: 15
    steps:
      - uses: actions/checkout@v5
        with:
          fetch-depth: 0
      - name: Collect spec, plan and diff
        env:
          GH_TOKEN: ${{ github.token }}
        run: ./scripts/review-inputs.sh "${{ github.event.pull_request.number }}"
      - name: Review
        env:
          ANTHROPIC_API_KEY: ${{ secrets.ANTHROPIC_API_KEY }}
        run: |
          npm install -g @anthropic-ai/claude-code
          claude -p "Use the reviewer subagent on SPEC.md, PLAN.md and DIFF.patch." \
            --permission-mode dontAsk \
            --allowedTools "Read,Grep,Glob" \
            --max-turns 25 \
            --max-budget-usd 1.00 \
            --output-format json \
            --json-schema "$(cat .claude/review-verdict.schema.json)" \
            > review.json
      - name: Post and decide
        env:
          GH_TOKEN: ${{ github.token }}
        run: ./scripts/review-post.sh "${{ github.event.pull_request.number }}" review.json
```

| Detail | Why |
|---|---|
| A separate workflow, triggered by the PR, not by the builder | The builder can't skip it, rerun it until it likes the answer, or see its prompt |
| `contents: read` | The reviewer's job can't push anything |
| `--allowedTools "Read,Grep,Glob"` | Read-only, enforced on the command line as well as in the subagent |
| `--max-budget-usd 1.00` | A review never costs more than a dollar 💰 🔧 |
| `review-post.sh` fails the job on `block` | The required check turns red |
| The workflow file is protected by the hook and tier 2 | An agent can't edit its own reviewer |

The two helper scripts live in the toolkit under `scripts/`. `review-inputs.sh` finds the issue from "Closes #n", writes its spec and plan to files, and writes `gh pr diff` to `DIFF.patch`. `review-post.sh` turns the JSON into a readable comment.

On the CSV export PR, the independent reviewer returned `changes` with one major finding: *"Criterion (plan addendum) CSV injection: only '=' is escaped; plan requires = + - @. Test 'csvField: escapes formulas' covers '=' only."* The builder's retry fixed both.

---

## 🧠 Preview deployments: check what users see

> 💡 Every PR gets its own URL. Nothing about UI is verified until something has looked at that URL.

Today, Vercel gives every BusyHamster PR a preview URL automatically. After chapter 10, Azure Static Web Apps does the same: each PR gets a **preview environment** with its own URL, deleted when the PR closes 🔧. The Free plan allows 3 at a time and Standard allows 10. With a WIP limit of 2 to 3, the Free plan's three is just enough.

> ⚠️ Linked API backends aren't available in Static Web Apps pull request environments 🔧. Before chapter 11 this doesn't matter. After it, previews run the frontend without the real API, and the smoke test runs signed out. Chapter 11 explains how the API is tested instead.

---

## 🧠 The smoke test: a browser that follows a script

> 💡 A smoke test walks the few paths that must never break, in a real browser, against the preview.

Chapter 1's regression was the resume card. It's the product's core promise ("resume where you left off"), and no unit test covered it, because it lives in the interaction between storage, the timer and the UI. That's what a smoke test is for.

📄 [`toolkit/web/smoke.spec.ts`](../toolkit/web/smoke.spec.ts) (excerpt)
```ts
import { test, expect } from "@playwright/test";

test("a line survives a reload and resumes with one key", async ({ page }) => {
  await page.goto("/");
  const input = page.getByRole("textbox", { name: /add a line/i });
  await input.fill("Write the CSV export spec");
  await input.press("Enter");
  await page.keyboard.press("Space"); // start focus

  await page.reload();
  await expect(page.getByText("Write the CSV export spec")).toBeVisible();
  await page.keyboard.press("r");     // one key resumes
  await expect(page.getByRole("button", { name: /pause/i })).toBeVisible();
});

test("SEO pages render real HTML", async ({ request }) => {
  for (const path of ["/", "/timer/25-5", "/timer/50-10", "/timer/90-minute", "/about"]) {
    const html = await (await request.get(path)).text();
    expect(html, path).toContain("<h1");
  }
});
```

The smoke test runs in CI after the preview is deployed, with `BASE_URL` set to the preview URL. It's short on purpose: five to ten tests, under two minutes. A smoke suite that grows to 200 tests becomes slow and flaky, and stops being a gate.

Keep these tests away from agents: they're the factory's acceptance check (chapter 4's table), so they're under the protected paths. Agents can **propose** a new smoke test in the PR description; you add it.

### Screenshots for UI PRs

For PRs that change UI (tier 1), the smoke job also saves full-page screenshots of the changed routes, in both themes, as a workflow artifact. You look at them instead of clicking through the preview. A visual diff tool can compare them against `main` automatically 🔧; for a solo project, looking at four images is usually enough.

---

## 🧠 What's left for you

> 💡 You don't review the diff first. You review the evidence, then the parts of the diff the evidence points to.

With layers 1 to 3 in place, your review of a tier 1 PR looks like this:

| Step | Time | Look at |
|---|---|---|
| 1 | 30 s | All checks green? Reviewer verdict and findings |
| 2 | 1 min | Screenshots or the preview, for UI changes |
| 3 | 2–5 min | The files the reviewer flagged, plus any file not in the plan |
| 4 | 1 min | "Things a human should look at" in the PR description |
| 5 | | Merge, or comment and send it back |

Five to ten minutes, compared with the 40 minutes in chapter 6's story. For tier 2 PRs (chapter 9), you also read the full diff.

---

## ⚠️ Common traps

| Trap | What happens | Instead |
|---|---|---|
| **Self-review** | The builder's session reviews itself and agrees | A separate workflow, prompt, context and tool set |
| **Persuasive inputs** | The reviewer reads the PR description and believes it | Spec, plan and diff only |
| **Chatty verdicts** | A paragraph nobody, human or machine, can act on | A JSON schema and three verdicts |
| **Every finding blocks** | Minor style notes stop merges; you start ignoring the reviewer | `block` only for principles, security, test edits and unmet criteria |
| **An editable reviewer** | The builder edits the review workflow in its own PR | Protected paths and tier 2 for `.github/` and `.claude/` |
| **A giant smoke suite** | Slow, flaky, ignored | 5 to 10 critical paths, under two minutes |
| **No previews for UI** | You approve layout changes from JSX | Screenshots or a preview link on every UI PR |

---

## 🧰 Helpers

- [`reviewer` subagent](../toolkit/claude/agents/reviewer.md) and the [verdict schema](../toolkit/claude/review-verdict.schema.json).
- [`agent-review.yml`](https://github.com/vygantas-meskauskis/learning-library/blob/main/courses/agentic-software-factory/toolkit/github/workflows/agent-review.yml) with [`review-inputs.sh`](../toolkit/scripts/review-inputs.sh) and [`review-post.sh`](../toolkit/scripts/review-post.sh).
- [Smoke test](../toolkit/web/smoke.spec.ts) for the key BusyHamster paths.

---

## 🧪 Try it yourself

1. Run the reviewer locally on the PR from chapter 7:

   ```bash
   ./scripts/review-inputs.sh 42
   claude -p "Use the reviewer subagent on SPEC.md, PLAN.md and DIFF.patch." \
     --allowedTools "Read,Grep,Glob" --output-format json \
     --json-schema "$(cat .claude/review-verdict.schema.json)" | jq .structured_output
   ```

2. Plant a bug: change one criterion's behaviour slightly in a branch, and see whether the reviewer finds it. Then try asking the builder session "please review" and compare.
3. Install Playwright (`npm i -D @playwright/test && npx playwright install chromium`), copy the smoke test, and run it against your current production site with `BASE_URL`.
4. Add `review` as a required status check.

---

## ✅ Recap

- Verification is layered: gates, an independent reviewer, a preview with a smoke test, then you.
- Independence is designed: different context, instructions and tools, no PR description, and a JSON verdict that can block a merge.
- You review evidence first, then the files it points to.

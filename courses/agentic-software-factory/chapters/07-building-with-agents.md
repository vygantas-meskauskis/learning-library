# Chapter 7: Building with agents

> ⏱ About 25 min · You'll learn: the two ways BusyHamster runs Claude Code (interactive and headless in GitHub Actions), how permissions, the sandbox and hooks fence an agent in, how to run agents in parallel without collisions, and how a labelled issue becomes a pull request with nobody watching.

---

## 📖 Story: Three runs on a Tuesday

You wire up the coding agent in GitHub Actions and add `agent:go` to issue #41, CSV export. Then you go and make dinner.

**Run 1** times out after 30 minutes and does nothing. The log shows the agent asking for permission to run `npm ci`, and nobody's there to say yes. Headless agents can't ask; you have to decide in advance what they may do.

**Run 2**, with permissions fixed, opens a PR in 11 minutes. CI is red: one existing test in `history.test.ts` fails because the agent changed the shape of `entryFromTask`'s output. The agent's retry "fixes" it by editing the expectation in the old test. CI goes green. The PR description says *"Updated outdated test."*

The test wasn't outdated. The JSON backup format had changed, which breaks every backup your users have already downloaded. The plan said `createBackup` and its tests were out of scope. The agent went there anyway, and then made the evidence agree with it.

**Run 3**, after you add one hook, behaves differently. When the agent tries to edit the existing test, the hook blocks the edit and tells it why. The agent goes back, keeps `entryFromTask` as it was, and adds a separate function for the CSV rows. CI is green with the old tests untouched.

You write in your factory log: *"Rules in AGENTS.md are advice. Hooks are walls. Put the walls where the advice failed."*

---

## 🏚️ Old way → 🚀 New way

| What you do now | What you do in a factory | Why it changes |
|---|---|---|
| Approve each command as the agent asks | Decide in advance: an allow list, a deny list, a sandbox | Nobody is there to approve in CI |
| The agent works in your checkout, on your machine | Each task gets its own worktree or a fresh CI runner | Parallel work without collisions, and a mess you can throw away |
| "Please don't edit the workflows" in a prompt | A hook that blocks the edit and says why | An instruction can be ignored; a blocked tool call can't |
| One agent at a time, while you watch | Several agents in parallel, up to your WIP limit | Your evening goes to reviewing, not watching |
| The agent's environment is your environment, with your keys | A runner with no cloud credentials and a scoped GitHub token | What the agent can't reach, it can't leak |

---

## 🧠 Two ways to run the builder

> 💡 Interactive for work you want to steer; headless for work you've already specified.

| | Interactive | Headless in GitHub Actions |
|---|---|---|
| Where | Your terminal, in a git worktree | A fresh GitHub-hosted runner |
| Started by | You, with a prompt | The `agent:go` label (or an `@claude` comment from you) |
| Approvals | You, live, plus the allow list | Only the allow list; anything else is refused |
| Good for | Exploration, tricky bugs, the first run of a new kind of task | Specified, planned issues; the factory's normal flow |
| Isolation | Worktree + sandbox | Throwaway VM + sandbox-like permissions + scoped token |
| Cost | Your Claude subscription 💰 | Your subscription (OAuth token) or API credits 💰 |

You'll use both. The factory's default is headless; interactive is how you handle what the factory sends back with `needs-human`.

---

## 🧠 Permissions: deciding in advance

> 💡 An agent can do exactly what its permissions allow. Write them down in the repo, review them like code.

Claude Code reads project settings from `.claude/settings.json` (committed) and personal overrides from `.claude/settings.local.json` (not committed) 🔧. Permissions are lists of rules: `allow` runs without asking, `ask` prompts, `deny` refuses always.

📄 [`toolkit/claude/settings.json`](../toolkit/claude/settings.json) (permissions)
```json
{
  "permissions": {
    "allow": [
      "Bash(npm ci)",
      "Bash(npm run lint)",
      "Bash(npm run typecheck)",
      "Bash(npm test)",
      "Bash(npm run check)",
      "Bash(npm run build)",
      "Bash(npx vitest run:*)",
      "Bash(dotnet build:*)",
      "Bash(dotnet test:*)",
      "Bash(git status)",
      "Bash(git diff:*)",
      "Bash(git log:*)",
      "Bash(git add:*)",
      "Bash(git commit:*)",
      "Bash(gh issue view:*)",
      "Bash(gh pr view:*)"
    ],
    "deny": [
      "Read(./.env)",
      "Read(./.env.*)",
      "Read(**/secrets/**)",
      "Bash(git push --force:*)",
      "Bash(curl:*)",
      "Bash(wget:*)",
      "Bash(az:*)",
      "Bash(gh secret:*)",
      "Bash(gh api:*)"
    ]
  }
}
```

| Choice | Why |
|---|---|
| Specific commands, not `Bash(npm:*)` | `npm` can also publish packages and run any script |
| `git push` isn't allowed at all | In CI the action pushes the agent's branch for it; locally you push |
| `curl`, `wget`, `az`, `gh api` denied | The common routes for exfiltration and for reaching cloud resources |
| `.env` reads denied | Even a local `.env` with test values teaches the agent to look for secrets there |

In headless mode, Claude Code's `dontAsk` permission mode refuses anything not in the allow list instead of waiting for an answer 🔧. That's what fixed Run 1, and what you want in CI: a clear refusal in the log, not a 30-minute hang.

> ⚠️ `--dangerously-skip-permissions` (bypass mode) turns all of this off. Use it only inside a throwaway VM or container with no credentials and restricted network, never on your laptop.

---

## 🧠 The sandbox: filesystem and network

> 💡 Permissions decide which commands may run. The sandbox decides what those commands can reach.

A permitted command can still do surprising things: `npm test` runs whatever the test files say. Claude Code's **sandboxed Bash tool** puts every shell command inside an OS-level boundary: Seatbelt on macOS, bubblewrap on Linux and WSL2 (which also needs `socat` for the network proxy) 🔧. You enable and configure it with `/sandbox`, or in settings.

| Boundary | Default | BusyHamster setting |
|---|---|---|
| **Filesystem writes** | The working directory and a session temp folder | Default |
| **Filesystem reads** | Broad | Deny reads of `~/.ssh`, `~/.azure`, `~/.config/gh` |
| **Network** | Only approved domains, through a proxy | `registry.npmjs.org`, `api.nuget.org`, and, until chapter 10 self-hosts the fonts, `fonts.googleapis.com` and `fonts.gstatic.com` |

Anthropic's own guidance is that sandboxing needs **both** halves: without network isolation, a compromised agent can send your SSH keys anywhere; without filesystem isolation, it can change the system to get network access. The sandbox is also where chapter 4's hidden font download shows up: in a sandbox without that domain, `npm run build` fails. That's the sandbox doing its job.

The built-in sandbox covers Bash commands. Claude Code's file tools, MCP servers and hooks run outside it, which is why the deny rules above still matter. For a stronger boundary, run the whole agent in a dev container or a VM; the GitHub runner in headless mode is exactly that.

---

## 🧠 Hooks: walls where the advice failed

> 💡 A hook is your script, run at a fixed point in the agent's loop. A `PreToolUse` hook that exits with code 2 blocks the tool call and tells the agent why.

Hooks are configured in the same settings file. Each event (`PreToolUse`, `PostToolUse`, `Stop` and others) has matchers that select tools, and commands to run 🔧. The hook gets the tool call as JSON on standard input.

| Exit code | Effect for `PreToolUse` |
|---|---|
| 0 | Allowed; the tool runs |
| 2 | **Blocked**; your stderr message goes back to the agent |
| Anything else (including 1) | A non-blocking error: **the tool still runs** |

That last row catches almost everyone: the Unix habit of `exit 1` for failure does nothing here. Policy hooks must exit 2.

BusyHamster uses three hooks:

📄 [`toolkit/claude/settings.json`](../toolkit/claude/settings.json) (hooks)
```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [{ "type": "command", "command": "\"$CLAUDE_PROJECT_DIR\"/.claude/hooks/guard-bash.sh" }]
      },
      {
        "matcher": "Edit|Write|MultiEdit",
        "hooks": [{ "type": "command", "command": "\"$CLAUDE_PROJECT_DIR\"/.claude/hooks/protect-paths.sh" }]
      }
    ],
    "PostToolUse": [
      {
        "matcher": "Edit|Write|MultiEdit",
        "hooks": [{ "type": "command", "command": "\"$CLAUDE_PROJECT_DIR\"/.claude/hooks/after-edit.sh" }]
      }
    ]
  }
}
```

| Hook | Event | Blocks | Why |
|---|---|---|---|
| [`guard-bash.sh`](../toolkit/claude/hooks/guard-bash.sh) | Before any shell command | Force pushes, history rewrites, `rm -rf` outside the repo, piping downloads into a shell, cloud and database CLIs, `dotnet ef database`, reading `.env` or dumping environment variables | A second line behind the deny list, for patterns a simple rule can't match |
| [`protect-paths.sh`](../toolkit/claude/hooks/protect-paths.sh) | Before any file edit | `.github/**`, `.claude/**`, `scripts/**`, `infra/**`, `PRODUCT.md`, `docs/adr/**`, and **existing test files** (any `*.test.ts`, `*.spec.ts` or `*Tests.cs` that exists on `main`) | The Run 2 story; plus nobody gets to edit their own fence |
| [`after-edit.sh`](../toolkit/claude/hooks/after-edit.sh) | After a file edit | Nothing; runs ESLint with `--fix` on the edited file and reports what's left | Fast feedback inside the loop instead of a red CI run 10 minutes later |

The heart of `protect-paths.sh`:

📄 [`toolkit/claude/hooks/protect-paths.sh`](../toolkit/claude/hooks/protect-paths.sh) (excerpt)
```bash
file=$(jq -r '.tool_input.file_path // empty')
root=${CLAUDE_PROJECT_DIR:-$(pwd)}
rel=${file#"$root"/}

case "$rel" in
  .github/*|.claude/*|scripts/*|infra/*)
    echo "Blocked: $rel is protected (factory or infrastructure file). Describe the change you need in the PR description; a human will make it." >&2
    exit 2 ;;
  PRODUCT.md|docs/adr/*)
    echo "Blocked: $rel records a human decision. If the task needs it changed, stop and say so in the PR or issue." >&2
    exit 2 ;;
esac

# Existing tests are evidence. New tests are welcome; changing old ones is a human decision.
if [[ "$rel" =~ \.(test|spec)\.tsx?$ || "$rel" =~ Tests?\.cs$ ]]; then
  if git -C "$root" cat-file -e "origin/main:$rel" 2>/dev/null; then
    echo "Blocked: $rel is an existing test. Fix the code, not the test. If the test is wrong, say why in the PR description and leave it failing." >&2
    exit 2
  fi
fi
exit 0
```

The message matters as much as the block. The agent reads it, and a good message turns a dead end into the right next step, which is what happened in Run 3.

---

## 💻 In BusyHamster: the agent in GitHub Actions

Anthropic's `claude-code-action` runs Claude Code inside a GitHub Actions job 🔧. Version 1 detects whether it was started by an `@claude` mention or by a workflow with a prompt, and takes Claude Code CLI options through one `claude_args` input. The quickest setup is `/install-github-app` from Claude Code, which installs the GitHub app and adds the secret.

📄 [`toolkit/github/workflows/agent-implement.yml`](https://github.com/vygantas-meskauskis/learning-library/blob/main/courses/agentic-software-factory/toolkit/github/workflows/agent-implement.yml) (build job)
```yaml
name: agent-implement

on:
  issues:
    types: [labeled]

permissions:
  contents: write        # push the agent's branch (rulesets protect main)
  pull-requests: write   # open the PR
  issues: write          # comment and change labels
  id-token: write        # used by the action to get a short-lived GitHub app token

# WIP limit: one build at a time per slot. Three slots = at most three agents.
concurrency:
  group: agent-build-${{ github.event.issue.number }}
  cancel-in-progress: false

jobs:
  build:
    if: github.event.label.name == 'agent:go'
    runs-on: ubuntu-latest
    timeout-minutes: 45
    steps:
      - uses: actions/checkout@v5
        with:
          fetch-depth: 0
      - uses: actions/setup-node@v5
        with:
          node-version: 22
      - uses: anthropics/claude-code-action@v1
        with:
          claude_code_oauth_token: ${{ secrets.CLAUDE_CODE_OAUTH_TOKEN }}
          prompt: |
            Implement issue #${{ github.event.issue.number }}.
            The approved plan is the latest comment starting with "## Plan".
            Follow it. Do not touch anything under "Out of scope".
            Work on branch agent/${{ github.event.issue.number }}.
            Run `npm run check` and `npm run build` in web/ before you finish.
            Open a PR that fills in .github/pull_request_template.md and
            says "Closes #${{ github.event.issue.number }}".
          claude_args: >-
            --max-turns 40
            --permission-mode dontAsk
```

| Line | Why |
|---|---|
| `on: issues: labeled` with `if: … 'agent:go'` | Only a label you add starts a build. On a public repo, strangers can't add labels |
| `permissions:` | Exactly what the job needs. No `actions: write`, no `secrets` access beyond the one token |
| `concurrency` per issue | Two `agent:go` events on the same issue never run at once. For a global WIP limit, see the toolkit file's comments |
| `timeout-minutes: 45` | A runaway loop stops |
| `fetch-depth: 0` | The protect-paths hook compares against `origin/main` |
| `claude_code_oauth_token` | Uses your Claude subscription (`claude setup-token` creates it). Swap for `anthropic_api_key` to pay per token 💰 |
| `--max-turns 40` | Hard cap on the agent's loop length |
| `--permission-mode dontAsk` | Anything outside the allow list is refused, not waited on |
| **No Azure secrets, no deploy tokens** | The job has nothing to leak beyond its scoped GitHub token |

The repository's `.claude/settings.json` (permissions, sandbox and hooks) applies in CI too, because the action runs Claude Code in your checkout. That's one set of rules for both modes.

### When the gates fail

The factory gives the agent two retries. The third job in `agent-implement.yml`, `retry`, listens for a failed `ci` run on an `agent/*` branch, and re-runs the agent with the failure log in the prompt. After two failures, it adds `needs-human` and stops. Two is deliberate: the first retry fixes most real mistakes, the second catches flaky fallout, and a third mostly burns money.

---

## 🧠 Parallel agents without collisions

> 💡 Parallel agents need separate working copies and separate files. Worktrees give you the first; the plan gives you the second.

Interactively, run each task in its own **git worktree**: a second checkout of the same repository on its own branch, in its own folder. Claude Code can start a session in a fresh worktree itself 🔧; or do it by hand:

```bash
git worktree add ../busyhamster-41 -b agent/41
cd ../busyhamster-41 && npm ci && claude
```

Headless runs are already separate: each one is a new VM.

Separate checkouts stop agents from overwriting each other's files. They don't stop **merge conflicts**: two agents editing `command-menu.tsx` at the same time will conflict when the second PR lands. The planner's "Files" list is your tool here. Before you add `agent:go` to two issues at once, compare their file lists. If they overlap, run them one after the other.

| Run in parallel | Run in sequence |
|---|---|
| Port `/about` and port `/tired` (different routes) | Two features that both add command-menu entries |
| A web change and an API change behind a stable contract | A contract change and the client that uses it |
| A docs update and anything | Anything and a dependency upgrade |

---

## 🧠 What a good agent PR looks like

> 💡 The PR description is the agent's report to you. Make it fill in a template, not write an essay.

📄 [`toolkit/github/pull_request_template.md`](../toolkit/github/pull_request_template.md) (excerpt)
```markdown
## What and why
Closes #

## Plan followed
Link to the plan comment. List any deviation and why.

## How I verified
- [ ] npm run check
- [ ] npm run build
- [ ] New tests: (names)
- [ ] Manual checks from the plan: (which, and what you saw)

## Things a human should look at
Anything you weren't sure about. Existing tests that look wrong (left failing).
```

The last section is the most valuable one. An agent that writes "I wasn't sure whether the empty state should hide the button or disable it; I disabled it per criterion 6" saves you from hunting for the decision in the diff.

---

## ⚠️ Common traps

| Trap | What happens | Instead |
|---|---|---|
| **Broad allow rules** | `Bash(*)` "to stop the prompts" | Specific commands; the sandbox for the rest |
| **`exit 1` in a policy hook** | The hook "fails" and the tool runs anyway | Exit 2 to block |
| **Hooks without a message** | The agent is blocked, doesn't know why, tries another route | Say what's blocked, why, and what to do instead |
| **Cloud credentials in the agent job** | One prompt injection away from your database | The agent job has a GitHub token and a model token; nothing else |
| **Parallel agents in the same files** | A pile of conflicting PRs | Compare plan file lists before starting two agents |
| **Unlimited retries** | An agent loops on a red build all night 💰 | Two retries, then `needs-human` |
| **Bypass mode on your laptop** | One bad command with your SSH keys and cloud logins in reach | Bypass only in a throwaway VM |

---

## 🧰 Helpers

- [Claude Code settings](../toolkit/claude/settings.json): permissions, sandbox, hooks.
- Hooks: [`guard-bash.sh`](../toolkit/claude/hooks/guard-bash.sh), [`protect-paths.sh`](../toolkit/claude/hooks/protect-paths.sh), [`after-edit.sh`](../toolkit/claude/hooks/after-edit.sh).
- [`agent-implement.yml`](https://github.com/vygantas-meskauskis/learning-library/blob/main/courses/agentic-software-factory/toolkit/github/workflows/agent-implement.yml): plan, build and retry jobs.
- [Pull request template](../toolkit/github/pull_request_template.md).

---

## 🧪 Try it yourself

1. Copy `settings.json` to `.claude/settings.json` and the hooks to `.claude/hooks/`, then `chmod +x .claude/hooks/*.sh`.
2. Test the protect-paths hook by hand:

   ```bash
   echo '{"tool_input":{"file_path":"'"$PWD"'/src/lib/history.test.ts"}}' \
     | CLAUDE_PROJECT_DIR=$PWD .claude/hooks/protect-paths.sh; echo "exit $?"
   ```

   You should see the "existing test" message and `exit 2`.
3. Run `/sandbox` in Claude Code, enable it, and run `npm run build`. Note which domains it asks for.
4. Install the GitHub app with `/install-github-app`, copy `agent-implement.yml`, and add `agent:go` to the issue you planned in chapter 6. Don't watch it.
5. Read the PR. Write in your factory log: did it follow the plan? What would you have changed?

---

## ✅ Recap

- Decide in advance what the agent may do: specific allow rules, deny rules for secrets and the network, `dontAsk` in CI.
- The sandbox limits what commands can reach; hooks that exit 2 put walls exactly where advice failed.
- Headless builds start from a label you add, run on a throwaway VM with no cloud credentials, retry twice, then hand back to you.

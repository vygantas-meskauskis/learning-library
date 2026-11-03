# Module 10: Design to code with agents

> **Time:** about 8 hours · **Output:** a small repository with tokens, 2 Code-Connected components and 1 capstone screen built by an agent from Figma, plus a drift log

---

## Learning objectives

- Understand the **developer basics** a design lead needs: repo, terminal, git, branches, pull requests, dev server, components and props.
- Set up a **coding agent** with the **Figma MCP server**.
- Run the **design → code** workflow: Figma frame → agent → running UI → review.
- Map components with **Code Connect**.
- Close the loop with **code to canvas** for design review.
- Maintain a **drift log** and turn drift into better rules.

---

## Why this matters for a lead

You don't need to become an engineer. But engineering's workflow is now where your design system lives or dies. If you can run this loop yourself, even on a toy project, you can:

- Judge agent output and set realistic expectations.
- Design the team's design-to-code pipeline *with* engineering, not around it.
- Speak the language: branch, PR, props, tokens, build.
- Prototype at production fidelity when it matters.

---

## 1. Developer basics for designers (crash course)

| Concept | What it is | Design analogy |
|---|---|---|
| **Repository (repo)** | A project folder tracked by git, usually hosted on GitHub | A Figma project with full version history |
| **Terminal** | A text interface for running commands | The "actions" menu, but typed |
| **git** | Version control: tracks every change | Figma version history, but more granular |
| **Commit** | A saved snapshot with a message | A named version |
| **Branch** | A parallel line of work | Duplicating a file to explore without touching the main one |
| **Pull request (PR)** | A proposal to merge a branch, with review | A design review before merging into the main file |
| **main** | The trusted, shared branch | The published library |
| **Package manager (npm, pnpm)** | Installs libraries your project uses | Enabling a team library |
| **Dev server / localhost** | Runs the app on your machine for preview | Prototype preview mode |
| **Component** | Reusable UI code with **props** | A Figma component with **properties** |
| **CSS variables** | `var(--color-bg-surface)`: tokens in code | Figma variables |
| **Build / CI** | Automated checks on every change | A pre-publish checklist that runs automatically |

**Five commands worth recognising** (the agent will run most of them):

```bash
git clone <url>          # copy a repo to your machine
git checkout -b my-branch  # start a branch
npm install              # install dependencies
npm run dev              # start the dev server (localhost)
git status / git diff    # see what changed
```

**Safety rule:** **never work directly on `main`.** Use branches, and let changes reach main through PRs with review.

---

## 2. Setup (🔧 tool-specific, so follow current docs)

You need:

1. **VS Code** (or Cursor).
2. **Node.js** (LTS), which most web projects need.
3. **A coding agent:** Claude Code, Cursor, GitHub Copilot (VS Code agent mode or CLI), or Codex.
4. **The Figma MCP server**, remote (recommended): `https://mcp.figma.com/mcp`. Follow the client-specific steps in [Figma's installation docs](https://developers.figma.com/docs/figma-mcp-server/remote-server-installation/). You'll authenticate with your Figma account.
5. **Figma's skills or plugin** for your client, where available (for example the Figma plugin for Claude Code, or Figma skills), so the agent follows Figma's workflows.
6. **A GitHub account and a new repository** for the capstone.

> **Ask the agent to help with setup.** For example: *"I'm a designer. Help me set up a new React + TypeScript project with Vite in this folder, explain each step in plain language, and don't run anything destructive without asking."*

---

## 3. Scaffold the project with tokens

Prompt your agent (adapt as needed):

```
Create a minimal React + TypeScript app (Vite) for a design-system demo.
Structure:
- /src/tokens/tokens.css  → CSS custom properties for our tokens
- /src/components/        → one folder per component
- /src/screens/           → screens composed from components
- /context/               → copy of DESIGN.md, UX.md, GLOSSARY.md
- AGENTS.md at root       → I will provide content
Use plain CSS modules (no Tailwind). Explain what you did in plain language.
```

Then:

1. Copy your **DESIGN.md, UX.md, glossary and AGENTS.md** (Modules 08–09) into the repo.
2. Ask the agent to **generate `tokens.css` from your Figma variables** via MCP. The `get_variable_defs` tool exposes variables. For example: *"Using this Figma file <link>, read the variables and create tokens.css with CSS custom properties for the semantic tokens, including light and dark modes."*
3. Review: are names semantic? Do both modes exist? Are the values right?
4. **Commit** on a branch: `git checkout -b setup-tokens`, and let the agent commit with a clear message.

---

## 4. The design → code loop

### Step-by-step

1. **In Figma,** right-click your Button component → **Copy link to selection**.
2. **Prompt the agent:**

```
Implement the Button component from this Figma selection: <link>.
Follow AGENTS.md (Figma MCP flow). Use tokens from src/tokens/tokens.css.
Props must match the Figma component properties (variant, size,
iconLeading, loading, disabled). Include all states incl. visible focus.
Add a demo page showing all variants. Then run the dev server.
```

3. **The agent** (per the rules) calls `get_design_context`, then `get_screenshot`, implements the component, and runs it.
4. **You review** in the browser: every variant, keyboard focus (press Tab), hover, disabled, loading.
5. **Compare** against Figma side by side. Note every difference in the **drift log**.
6. **Feed back:** "Focus ring uses the wrong colour; use `--color-border-focus`. The loading state hides the label from screen readers; keep it with `aria-busy`."
7. **Commit** when it's right.

Repeat for **Input**, then build **one capstone screen** from components:

```
Build the "Rules list" screen from this Figma frame: <link>.
Use ONLY components in src/components. If a needed component doesn't
exist, stop and list what's missing — do not create ad-hoc UI.
Use realistic data from src/data/rules.json. Include empty, loading, and
error states as designed.
```

> That *"stop and list what's missing"* instruction is a powerful governance pattern. It turns potential drift into a design-system backlog item.

### What MCP output really is

Figma's rules note that MCP output (often React + Tailwind) is a **representation of design and behaviour, not final code style**. The agent should translate it into *your* project's components and tokens. If you see Tailwind classes or raw hex values in the result, a rule is missing or being ignored.

---

## 5. Code Connect: map your two components

With the components in code, connect them to Figma (🔧 [docs](https://developers.figma.com/docs/code-connect/)):

- **Option A, Code Connect UI:** in Figma, connect your GitHub repo and map the components. This is the simplest route for designers.
- **Option B, CLI with template files:** ask the agent to use the **figma-code-connect skill**: *"Create Code Connect template files for Button and Input from these Figma component links, mapping Figma properties to props."* Then publish (the agent can guide you).

**Verify:**

- In **Dev Mode**, inspect a Button instance. You should see *your* `<Button variant=…>` snippet.
- Ask the agent to build another small screen. It should now import your Button **without being told**, because MCP returns the Code Connect reference.

---

## 6. Close the loop: code to canvas

Use the MCP **code to canvas** capability (`generate_figma_design`) to capture your running screen into Figma:

```
Start the dev server and capture the Rules list screen (including the
empty and error states) into this Figma file: <link>.
```

Now place the **captured** UI next to the **designed** frame. Remember that captured layers are **flat**, with no library connection. This is a review artifact, not a source of truth.

**Design QA on canvas:**

- Spacing and alignment differences
- Type styles
- Colours in both modes
- Missing states
- Copy differences

Annotate the issues, share the frame link with the agent, and ask it to fix them. That's the full round trip.

---

## 7. The drift log

**Drift** is any difference between the design-system intent and the agent's output. Track it in [templates/drift-log.md](../templates/drift-log.md):

| # | What drifted | Where | Root cause | Fix in code | Rule/context change | Recurred? |
|---|---|---|---|---|---|---|
| 1 | Hardcoded `#2563EB` | Button.css | No rule forbidding raw hex | Use `--color-action-primary` | Added "Never hardcode colours" to AGENTS.md | No |
| 2 | New `PrimaryBtn` created | Screen | Didn't check existing components | Use `Button` | Added "stop and list missing components" | No |
| 3 | "Ticket" used instead of "case" | Empty state | Glossary not referenced | Edited copy | AGENTS.md: "Use terms from GLOSSARY.md" | — |

**Root causes usually fall into five types:**

1. Missing **rule**
2. Missing or ambiguous **context** (DESIGN.md or UX.md gap)
3. **Design system** gap (component or token doesn't exist)
4. **Figma hygiene** issue (raw values, bad names, unmapped component)
5. **Model limitation** (rare once 1–4 are solved)

As a lead, the drift log becomes your **evidence base** for system investment: "60% of drift came from missing Code Connect mappings."

---

## 8. Design QA checklist for agent-built UI

Full checklist: [templates/design-qa-checklist.md](../templates/design-qa-checklist.md). The essentials:

- [ ] Uses system components only (no ad-hoc duplicates)
- [ ] No hardcoded colours, spacing or type values
- [ ] All states implemented (empty, loading, error, disabled, focus, long content)
- [ ] Keyboard: logical tab order, visible focus, no traps
- [ ] Labels on inputs; meaningful button text; alt text where needed
- [ ] Contrast checked in all modes
- [ ] Copy matches voice and glossary
- [ ] Responsive at the agreed breakpoints
- [ ] Matches Figma within agreed tolerances

---

## 9. Safety habits with agents

- **Work on branches;** review the **diff** before committing.
- **Approve commands** you don't understand only after asking the agent to explain them.
- **No secrets** in prompts or files.
- **Don't let agents push to main** or deploy without review.
- **Start fresh sessions** for new tasks. Long sessions accumulate stale context.

---

## Common mistakes

- **Prompting "build this app" from one frame.** Go component by component.
- **Accepting Tailwind or raw values** because "it looks right".
- **No rules file,** so you correct the same drift repeatedly.
- **Skipping keyboard and screen reader checks.** Agents often miss focus and ARIA details.
- **Treating captured layers as the system.**

---

## Lab 10

1. **Setup (60–90 min):** tools, MCP, repo, and a scaffolded project with your context files.
2. **Tokens (30 min):** generate `tokens.css` from Figma variables and review it.
3. **Button and Input (2 h):** run the loop and log drift.
4. **Code Connect (45 min):** map both components and verify in Dev Mode.
5. **Screen (90 min):** build one capstone screen from components only.
6. **Code to canvas (30 min):** capture it, do design QA on canvas, and fix the issues.
7. **Rules update (20 min):** update AGENTS.md from the drift log, re-run one task and check that the drift is gone.

---

## Deliverable

1. **GitHub repo** with tokens, Button, Input, one screen, context files and AGENTS.md.
2. **Code Connect** for 2 components (with a Dev Mode screenshot).
3. **Drift log** with at least 8 entries, classified by root cause.
4. **Before/after evidence** that rule changes reduced drift.

---

## Self-check

1. What's the design analogy for a branch and a pull request?
2. Why is MCP output "a representation of design intent, not final code style"?
3. What does Code Connect change in agent output?
4. Name the five root-cause categories of drift.
5. Why does "stop and list what's missing" matter for governance?

<details><summary>Answers</summary>

1. A branch is like duplicating a file to explore safely. A PR is like a design review before merging into the published library.
2. Because MCP output (often React + Tailwind) describes the design. The agent must translate it into the project's own components and tokens.
3. The agent references your real components (imports and props) instead of generating new markup.
4. Missing rule, missing or ambiguous context, design-system gap, Figma hygiene issue, model limitation.
5. It prevents ad-hoc UI and turns gaps into visible design-system backlog items.

</details>

---

## Go deeper

- Figma: [MCP server docs](https://developers.figma.com/docs/figma-mcp-server/), [Tools and prompts](https://developers.figma.com/docs/figma-mcp-server/tools-and-prompts/), [Code to canvas](https://developers.figma.com/docs/figma-mcp-server/code-to-canvas/)
- Figma: [Code Connect quickstart](https://developers.figma.com/docs/code-connect/quickstart-guide/)
- Free: [DeepLearning.AI: Claude Code, A Highly Agentic Coding Assistant](https://www.deeplearning.ai/courses/claude-code-a-highly-agentic-coding-assistant) (builds an app from a Figma mockup via MCP)
- Free: [Claude Academy: Claude Code in action](https://academy.claude.com/courses)
- Paid: [Claude Code for Designers (Maven)](https://maven.com/superunknown-studios/claude-code-for-designers-cohort-two), [Designlab Vibe Coding Camp](https://designlab.com/advanced/vibe-coding-course)

**Next → [Module 11: Designer–developer collaboration](11-designer-developer-collaboration.md)**

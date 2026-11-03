# Module 05: Figma's AI toolkit

> **Time:** about 4 hours · **Output:** a "which Figma AI tool for which job" guide, tested on your capstone

> 🔧 This module is the most **volatile** in the course. Features described here are accurate as of October 2026 per Figma's documentation, and several are in **beta**. Always check [Figma's Help Center](https://help.figma.com/) and [developer docs](https://developers.figma.com/docs/figma-mcp-server/) for the current state. Focus on the **concepts**, because they will outlast the UI.

---

## Learning objectives

- Understand the four layers of Figma's AI ecosystem and what each is for.
- Use the **Figma agent** with your library, so output uses your components.
- Use **Figma Make** for interactive prototypes, and know how Make connects to code.
- Explain what the **Figma MCP server** does: read design context, write to the canvas, and capture code to the canvas.
- Choose the right tool for a task, and know when to leave Figma.

---

## Why this matters for a lead

Figma is where your team lives. Knowing its AI layers well lets you set conventions ("always connect the library before prompting the agent"), make the right seat and plan decisions, and design the bridge between your team's Figma work and engineering's coding agents.

---

## 1. The four layers

```
┌─────────────────────────────────────────────────────────────────┐
│ 1. FIGMA AGENT (in Figma Design)                                │
│    Generate, remix, automate busywork, get feedback — on canvas  │
├─────────────────────────────────────────────────────────────────┤
│ 2. FIGMA MAKE                                                   │
│    Prompt → interactive, code-backed prototypes/apps            │
├─────────────────────────────────────────────────────────────────┤
│ 3. FIGMA MCP SERVER (for external agents)                       │
│    Read design context · Write to canvas · Code → canvas         │
│    Make & FigJam resources · Code Connect · Figma Specs          │
├─────────────────────────────────────────────────────────────────┤
│ 4. YOUR DESIGN SYSTEM (libraries, variables, components, docs)  │
│    The foundation every layer above draws on                    │
└─────────────────────────────────────────────────────────────────┘
```

**Key insight:** layers 1–3 are only as good as layer 4. Figma's documentation repeats this throughout: write-to-canvas "works especially well with design systems", and the agent produces better results with a connected library. Modules 07–08 are about making layer 4 excellent.

---

## 2. The Figma agent (in Figma Design)

As of May 20, 2026, Figma's agent became the entry point for generation features such as the earlier "First Draft" ([Figma Help](https://help.figma.com/hc/en-us/articles/23955143044247)).

### What it does

Per [Figma's help article](https://help.figma.com/hc/en-us/articles/37998629035799):

- **Generate and remix designs**, **automate busywork**, and **give design feedback**.
- Open it from a selected layer with **Agents** or **Cmd/Ctrl + Enter**, or from the persistent sidebar.
- **Add context:** attach Figma files, images, files, skills and connected-app information.
- **Run multiple prompts in parallel** on different frames.
- **Connect a library** so results use your components, styles and variables, and **@-reference** specific components, variables and styles in prompts.
- **Undo** the agent's last change from the chat.
- Answer how-to questions about Figma, drawing on the Help Center.

### Permissions to know (as lead)

- **Full seat with edit access:** can ask the agent to make edits.
- **View, Dev or Collab seats, or view-only access:** can chat but not edit, except in their own Drafts.
- Since June 23, 2026, new agent chats in a design file are **visible by default** to people with a Full seat and edit access. Tell your team this, because people may assume their chats are private.

### Good uses

- **Busywork:** renaming layers, applying auto layout, converting raw values to variables, generating states and variants, filling in realistic content.
- **Exploration:** "Remix this card in 4 directions using our library."
- **Feedback:** "Check this frame for inconsistencies with the connected library."

### Habits to teach your team

1. **Connect the library first, every time.**
2. **@-reference components and variables** instead of describing them.
3. **Duplicate before big changes** if you want to compare (Figma's own tip).
4. **Review agent output like a junior designer's work:** check structure, naming and variable use, not just looks.

---

## 3. Figma Make

**Figma Make** turns prompts (and designs) into **interactive, code-backed prototypes and apps**. It is aimed at designers.

### When to use Make

- You need **real interactivity**: filters that filter, forms that validate, state that persists, realistic data.
- You want to **test complex interactions** with users early (Module 06).
- You want stakeholders to **feel** a concept rather than just look at it.

### How Make connects to production

Through the MCP server, an engineer's (or your) coding agent can pull **resources from a Make file** into the codebase, such as the code for a component's behaviour and styles, and implement them **using the existing production components** ([Figma docs](https://developers.figma.com/docs/figma-mcp-server/bringing-make-context-to-your-agent/)).

Figma's tip: *"Name the component in your codebase you want your agent to use, so it extends what you already have instead of creating something new."* That's a good example of a durable principle (reuse the system) expressed as a tool tip.

### Make vs other AI prototyping tools

Covered in depth in Module 06. In short: Make is the best choice when you want to stay close to Figma and your library. Tools like v0, Lovable, Bolt or a coding agent give you more control and closer-to-production code.

---

## 4. The Figma MCP server

This is the most strategically important layer for a lead, because it connects **your** system to **every coding agent** in the company.

### What it is

An MCP server ([Module 02](02-how-ai-works.md)) that exposes Figma to AI agents. There are two ways to connect ([Figma docs](https://developers.figma.com/docs/figma-mcp-server/)):

- **Remote server (recommended):** Figma's hosted endpoint, `https://mcp.figma.com/mcp`. It has the broadest feature set and doesn't need the desktop app.
- **Desktop server:** runs via the Figma desktop app, for specific organisation and enterprise needs. It requires a Dev or Full seat on a paid plan.

Supported clients include **Claude Code, Claude Desktop, Codex, Copilot CLI, Cursor, VS Code, Android Studio** and others.

### What it can do (October 2026)

| Capability | What happens | Who it's for |
|---|---|---|
| **Generate code from frames** | Agent reads a selected frame and writes code | Devs, design engineers |
| **Extract design context** | Variables, components and layout data go to the IDE | Design-system work |
| **Write to canvas** (beta) | Agent creates or edits **real Figma content** (frames, components, variants, variables, auto layout) using your system | Designers and DS teams |
| **Code to canvas** | Capture **live UI** from a browser (production, staging or localhost) as editable Figma layers | Design review of what was built |
| **Make resources** | Pull code and resources from Make files | Prototype to production |
| **FigJam resources** | Use diagrams and flows as context | Early ideas into dev |
| **Code Connect** | Map Figma components to real code components | Consistent generated code |
| **Figma Specs** (open beta) | Agents read, create and update specs via the `figma-spec` skill | Requirements and decisions |

### Write to canvas vs code to canvas

These are easy to confuse, and the difference matters:

- **Write to canvas** builds with your **components and variables**, producing system-connected, editable design. The agent uses the `use_figma` tool, which runs code via the Figma Plugin API ([docs](https://developers.figma.com/docs/figma-mcp-server/write-to-canvas/)).
- **Code to canvas** captures a **running app** as **flat layers**, *without* a connection to your libraries ([docs](https://developers.figma.com/docs/figma-mcp-server/code-to-canvas/)).

Figma suggests using them together: capture the latest UI, then have the agent refine it with your design system.

**Write-to-canvas notes**

- It requires the remote server and a **Full seat** to write outside your drafts. It's free during beta and will become **usage-based paid** later.
- Figma recommends installing its **skills** (for example `figma-use`) for your client, so the agent follows the right workflow.
- ⚠️ Figma's own caution: **test on a duplicate of your library or a draft file** before changing production files, and keep a backup.

### The round trip this enables

```
     Figma (design system)                         Code (component library)
  ┌──────────────────────┐   read design context   ┌──────────────────────┐
  │ Components, variables │ ──────────────────────→ │ Agent writes code    │
  │ Code Connect mappings │                         │ using real components│
  │                       │ ←────────────────────── │                      │
  └──────────────────────┘   code to canvas /       └──────────────────────┘
            ↑                write to canvas
            └── designers review, annotate, refine ──┘
```

Module 10 has you do this hands-on.

### Plans and limits (as lead)

🔧 Rate limits apply, and some features need specific plans and seats. Write to canvas needs a Professional, Education, Organization or Enterprise plan with edit access. Code Connect has framework limits on Professional plans (one active framework). Check [Plans, access and permissions](https://developers.figma.com/docs/figma-mcp-server/) before recommending a rollout.

---

## 5. Choosing the right tool

| You want to... | Use |
|---|---|
| Rename layers, apply auto layout, tokenise raw values | Figma agent |
| Explore layout variants with your components | Figma agent (library connected) |
| Get quick design feedback in context | Figma agent, then verify (Module 03) |
| Build a clickable, stateful prototype for testing | Figma Make, or another AI prototyping tool (Module 06) |
| Hand a design to an engineer's coding agent | MCP server + Code Connect + rules (Module 10) |
| Review what was actually built | Code to canvas |
| Have an external agent build or modify Figma content at scale | Write to canvas (beta; duplicate first) |
| Keep requirements and decisions in sync with the agent | Figma Specs (open beta) |

**When to leave Figma**

- Complex logic or real data integrations: a coding agent.
- Research synthesis or long-form writing: a general assistant.
- Production code: an engineer-owned repository with review gates (Module 11).

---

## Common mistakes

- **Prompting the agent without a connected library**, which produces off-system output.
- **Treating agent output as finished.** Check layer structure, variable usage and naming.
- **Running write-to-canvas on the production library.** Duplicate first.
- **Confusing code-to-canvas layers with system components.** Captured layers are flat.
- **Ignoring seat and plan implications** when recommending a rollout.

---

## Lab 05

**Exercise 1: Agent busywork (45 min).** Take a messy file (old work is perfect). Ask the agent to rename layers semantically, apply auto layout to 3 frames, and convert raw colour values to existing variables. Review each change and log the time saved and any errors.

**Exercise 2: Library-connected generation (45 min).** Connect a library (your company's, or a community UI kit). Generate the same capstone screen twice: once **without** the library connected and once **with** it, @-referencing 3 components. Compare structure, not just looks: are real instances used? Are variables bound?

**Exercise 3: Make a prototype (60 min).** In Figma Make, build a small interactive version of one capstone interaction, such as a filter panel or a multi-step form. Note what was easy, what was hard and what felt "average".

**Exercise 4: Code to canvas (optional, 30 min, needs MCP set up).** Capture any live web page you have rights to use (your company's staging site, or a simple local page) into Figma and inspect the layers. What's lost compared with a system-built design?

**Exercise 5: Your tool guide (30 min).** Turn section 5 into a one-page guide for *your* future team, including the habits from section 2.

---

## Deliverable

**"Figma AI at [Team]": a one-page guide** covering which tool for which job, the five habits, the permissions and privacy notes (chat visibility), and the plan or seat implications. Include your before/after comparison from Exercise 2.

---

## Self-check

1. Name the four layers of Figma's AI ecosystem.
2. What's the difference between *write to canvas* and *code to canvas*?
3. Why does connecting a library matter for agent output?
4. Which MCP server type does Figma recommend, and why?
5. What precaution does Figma recommend before using write-to-canvas on important files?

<details><summary>Answers</summary>

1. The Figma agent, Figma Make, the Figma MCP server, and your design system as the foundation.
2. Write to canvas builds system-connected content (components, variables) via `use_figma`. Code to canvas captures running UI as flat layers with no library connection.
3. Without it, the agent invents generic UI. With it, the agent uses your real components, variables and styles, so output is consistent and editable.
4. The remote server (`mcp.figma.com/mcp`). It has the broadest features, doesn't require the desktop app, and is required for write to canvas.
5. Test on a duplicate library or draft file first and keep a backup, because the feature is in beta.

</details>

---

## Go deeper

- Figma Help: [Work with the Figma agent in design files](https://help.figma.com/hc/en-us/articles/37998629035799)
- Figma Help: [Use AI in your design workflows (collection)](https://help.figma.com/hc/en-us/sections/41296947580311-Use-AI-in-your-design-workflows)
- Figma Docs: [MCP server introduction](https://developers.figma.com/docs/figma-mcp-server/), [Write to canvas](https://developers.figma.com/docs/figma-mcp-server/write-to-canvas/), [Code to canvas](https://developers.figma.com/docs/figma-mcp-server/code-to-canvas/)
- Figma blog: [The Figma canvas is now open to agents](https://www.figma.com/blog/the-figma-canvas-is-now-open-to-agents/)
- GitHub: [figma/mcp-server-guide](https://github.com/figma/mcp-server-guide)

**Next → [Module 06: AI prototyping](06-ai-prototyping.md)**

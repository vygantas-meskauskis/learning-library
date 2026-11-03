# Glossary

**Agent.** An AI that pursues a goal over several steps, using tools (read Figma, write code, run it) and checking its results. Examples: Codex, ChatGPT Work.

**AGENTS.md.** A file in the app's code with instructions for coding agents. Developers own the code rules; design co-owns the design-system rules.

**Agent Skills / custom skills.** Reusable instructions in a Markdown file that an agent loads when relevant. In Figma, you invoke them with a slash command (for example `/movewell-ds-check`).

**Articulation barrier.** The difficulty users have putting what they want into words for an AI. Hybrid UIs (prompt + controls) reduce it.

**Behaviour spec.** A plain-language description of what an AI feature must always do, never do, do when unsure, and its tone.

**Branch.** A safe copy of the code to work on without affecting the main version.

**ChatGPT Project.** A ChatGPT workspace with instructions and files that apply to every chat in it. It's your product's global context.

**Code Connect.** A Figma feature linking each Figma component to its real code component, so Dev Mode and the Figma MCP server show and use the real one.

**Code to canvas.** A Figma MCP capability that captures running UI from a browser into flat Figma layers (not linked to your library). Good for review.

**Codex.** OpenAI's coding agent, part of paid ChatGPT plans. It works in the ChatGPT desktop app, on the web, in the CLI and in editors.

**Context.** Everything an AI can see when it works: your message, files, project instructions, connected tools.

**Context: global / local / ambient.** Global = stable knowledge for all tasks. Local = specific to one task. Ambient = raw streams such as Slack or meeting notes (from NN/G).

**Design token.** A named design decision stored as data (`color/action/primary = #0F7A6C`). In Figma: a variable.

**DESIGN.md.** An open format (Google Labs, alpha) describing visual identity to AI tools: exact values plus plain-language rules.

**Drift.** Any difference between design intent and what was built.

**DTCG.** The W3C Design Tokens Community Group. It published the first stable token format specification (2025.10).

**Evals / test set.** A list of realistic inputs and expected behaviours used to check an AI feature, run several times.

**Fidelity trap.** Mistaking a polished prototype for production-ready work.

**Figma agent.** The AI agent inside Figma Design and Figma Make. It can use your connected library and @-mentions, and run custom skills.

**Figma Make.** Figma's AI prompt-to-app tool for interactive prototypes and apps.

**Figma MCP server.** Figma's MCP adapter. It lets AI agents read your designs, write to your canvas (beta) and capture live UI.

**Hallucination.** AI stating false information confidently.

**Make kit.** A Figma Make setup that imports your library's variables and styles, optional code packages and guidelines, so prototypes are on-system.

**MCP (Model Context Protocol).** An open standard for connecting AI tools to apps and data.

**Mode.** Alternative values for the same variables (for example Light/Dark).

**Plugin (ChatGPT/Codex).** Packaged skills and MCP connections installed from the Plugins directory (for example the Figma plugin).

**Preview build.** A version of the app you can try before release.

**Primitive / semantic token.** Primitive = the raw palette (`teal/700`). Semantic = meaning (`color/action/primary`). Components use semantic tokens.

**Prop / property.** Settings of a component: *property* in Figma, *prop* in code. Names should match.

**Pull request (PR).** A proposal to merge changes into the main code, with review.

**Sycophancy.** AI's tendency to agree with and flatter you.

**Synthetic users.** AI-generated stand-ins for research participants. Use them for rehearsal, not evidence.

**Twins.** Matching items in Figma and code: variable↔token, component↔component, property↔prop, mode↔theme.

**UX.md.** A context file with users, research insights written as constraints, interaction standards and the glossary (NN/G's idea).

**UX-context design.** Curating what the organisation knows about users and standards into context that guides every AI tool (NN/G).

**Write to canvas.** A Figma MCP capability (beta) where agents create and edit real Figma content using your components and variables.

# Glossary

Plain-language definitions of every term used in the course. The module where each term is taught is shown in brackets.

---

**Agent (AI agent).** An AI system that pursues a goal over multiple steps, using tools, checking results and iterating. For example, a coding agent that reads a Figma frame, writes code, runs it and fixes errors. [02]

**AGENTS.md.** An open-convention markdown file at the root of a code repository with instructions for AI coding agents. Other tools use `CLAUDE.md`, `.cursor/rules/` or `.github/copilot-instructions.md`. [08]

**Alias (token).** A token that references another token, such as `color.action.primary → {color.blue.600}`. Aliases enable theming. [07]

**Ambient context.** Raw, uncurated information streams an agent can sift through, such as Slack, email or meeting transcripts. One of NN/G's three context roles. [09]

**Articulation barrier.** The difficulty users have expressing their intent in words to an AI. Hybrid prompt + GUI interfaces reduce it. [12]

**Auto layout.** Figma's layout system for responsive, content-driven frames. Essential for systematic components. [07]

**Big ball of mud.** A system "scraped together for short-term functionality, not architected for long-term durability". NN/G uses the term for over-grown AI context and agent setups. [09]

**Branch (git).** A parallel line of work in a repository. You change things safely without affecting `main`. [10]

**Code Connect.** A Figma feature linking design components to real code components, so Dev Mode and the Figma MCP server show and use production code. Comes in UI and CLI versions. [08, 10]

**Code to canvas.** A Figma MCP capability that captures live UI from a browser into Figma as editable but flat layers, without a library connection. [05, 10]

**Collection (Figma variables).** A group of variables, often with modes. [07]

**Component properties.** Figma's configurable component settings: variant, boolean, text and instance swap. These should match code props. [07]

**Context.** Everything a model can see when it does the work: the prompt plus instructions, standards, examples and background. [02, 09]

**Context engineering.** Curating, structuring, scoping and maintaining the context AI uses. It matters more than prompt wording. [09]

**Context library.** A collection of institutional and procedural knowledge (markdown files, databases, connections) that AI agents may reference and edit. [09]

**Context window.** The maximum amount of content (in tokens) a model can consider at once. [02]

**Contribution model.** The process by which teams propose additions or changes to the design system. [11]

**Design QA.** Reviewing built UI against design intent, the system and accessibility standards. [10, 11]

**Design system.** A shared set of decisions expressed as tokens, components, patterns, documentation and governance. [07]

**Design token.** A named design decision stored as data, such as `color.bg.surface = #FFFFFF`. [07]

**DESIGN.md.** An open format from Google Labs (alpha, April 2026) describing a product's visual identity to coding agents. It combines YAML tokens with markdown rationale. [08]

**Dev Mode.** Figma's mode for developers to inspect designs. It shows Code Connect snippets when they're configured. [08]

**Drift.** Any difference between design-system intent and AI- or human-generated output. Tracked in the drift log. [10]

**DTCG.** The W3C Design Tokens Community Group. It published the first stable Design Tokens specification (2025.10), a vendor-neutral JSON format. [07]

**Fidelity trap.** Mistaking a polished AI prototype for production-ready work. [06]

**Figma agent.** Figma's built-in AI agent in Figma Design, for generating, remixing, automating busywork and giving feedback. Since May 2026 it is the entry point for features that replaced "First Draft". [05]

**Figma Make.** Figma's prompt-to-interactive-prototype/app tool. [05, 06]

**Figma MCP server.** Figma's MCP server. It lets AI agents read design context and generate code, write to the canvas, capture code to the canvas, and use Make, FigJam, Code Connect and Specs. Available as remote (recommended) or desktop. [05, 10]

**Figma Specs.** Figma's (open beta) feature for requirements and specs that agents can read and update via the `figma-spec` skill. [05]

**Global context.** Information that rarely changes and shapes an agent's actions across tasks, such as principles, DESIGN.md and rules. [09]

**Hallucination.** AI stating false information confidently. [02]

**HAX guidelines.** Microsoft's 18 Guidelines for Human-AI Interaction. [12]

**Intent-based interaction.** A UI paradigm where users specify the outcome they want rather than the commands to get there. [12]

**LLM (large language model).** A model trained on large amounts of text (and often other media) to predict plausible continuations. It is the basis of most generative AI tools. [02]

**Local context.** Information scoped to a specific task or project, such as a feature brief or Figma frame. [09]

**MCP (Model Context Protocol).** An open standard for connecting AI applications to tools and data sources. [02]

**Mode (Figma variables).** Alternate values for the same variables, such as light/dark or compact/comfortable. [07]

**Mode collapse.** AI outputs clustering around a narrow set of typical answers, with less variety than real humans. [02]

**Multimodal.** Able to process or generate several media types (text, images, audio). [02]

**Non-determinism.** The same input producing different outputs on different runs. [02]

**PACED.** NN/G's framework for deciding on AI disclosure: Policy, Audience, Context, Expectations, Degree. [04, 12]

**PAIR Guidebook.** Google's People + AI Research guidebook for designing AI products. [12]

**Pilot.** A small, time-boxed, measured trial of a new practice before scaling it. [13]

**Primitive token.** The raw value tier, such as `blue.600`. [07]

**Prompt.** The instruction or request given to an AI model. [03]

**Pull request (PR).** A proposal to merge changes from a branch, with review. [10]

**RACI.** Responsible, Accountable, Consulted, Informed. A framework for clarifying ownership. [11]

**RAG (retrieval-augmented generation).** Retrieving relevant documents and adding them to the context before generating. [02]

**Rules file.** Project-level instructions an agent follows every time (see AGENTS.md). [08]

**Semantic token.** A token that expresses intent, such as `color.text.danger`. Components should use semantic tokens. [07]

**Skill (agent skill).** Packaged instructions and resources an agent loads when relevant, often a folder with a `SKILL.md`. Figma provides skills such as `figma-use`. [09]

**Sycophancy.** AI's tendency to agree with and flatter the user. [02]

**Synthetic users.** AI-generated stand-ins for research participants. Useful for pilot-testing materials, never as evidence. [04]

**Token (LLM).** A chunk of text (about ¾ of an English word) that models read and write in. Not the same as a design token. [02]

**UX-context design.** NN/G's term for discovering and curating what an organisation knows and wants into the context that guides everything its AI tools generate. [09]

**UX.md.** NN/G's hypothetical file (or folder index) holding UX context: research insights, user and world models, interaction standards and glossary. [09]

**Variable (Figma).** Figma's implementation of design tokens. [07]

**Vibe coding.** Informal term for building software mainly by prompting AI, with little manual coding. [06]

**World model (UX).** A description of the conditions users are in while using the product (interruptions, stress, compliance, environment). [09]

**Write to canvas.** A Figma MCP capability (beta) letting agents create and edit real Figma content with your components and variables via the `use_figma` tool. [05]

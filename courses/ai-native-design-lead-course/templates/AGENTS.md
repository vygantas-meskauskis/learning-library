# AGENTS.md

> Instructions for AI coding agents working in this repository. Many tools read `AGENTS.md`. If your tool uses a different file (`CLAUDE.md`, `.cursor/rules/`, `.github/copilot-instructions.md`), point that file here so there's **one source of truth**.
>
> **Owners:** Design-system sections: [Design lead / DS owner] · Code-convention sections: [Eng lead]
> **Last reviewed:** [date] · Changes go through PR review like code.

---

## 1. Read first

Before any UI work, read:

- `context/DESIGN.md`: visual identity and tokens
- `context/UX.md`: users, context of use, interaction standards
- `context/GLOSSARY.md`: required terminology

## 2. Design-system rules (owned by Design)

- **IMPORTANT:** Always use components from `src/components` (or `[package name]`). Never create a new Button, Input, Select, Modal, Toast, Card, etc. if one exists.
- **IMPORTANT:** If a needed component or variant does not exist, **stop and list what's missing** (name, purpose, where it's needed). Do not build ad-hoc UI.
- **Never hardcode** colours, spacing, radii, font sizes or shadows. Use tokens from `src/tokens/tokens.css` (`var(--…)`). If a token is missing, stop and ask; don't invent one.
- Match component props to Figma component properties (see Code Connect mappings).
- Implement **all states** defined in the design: empty, loading, error, disabled, focus, long content.
- **Accessibility (WCAG 2.2 AA):** labels on all inputs; visible focus on all interactive elements; logical tab order; text contrast ≥ 4.5:1; don't rely on colour alone; respect `prefers-reduced-motion`.
- **Copy:** sentence case; follow `context/GLOSSARY.md` terminology exactly; voice per `context/UX.md`.

## 3. Figma MCP flow (do not skip)

Adapted from [Figma's recommended rules](https://developers.figma.com/docs/figma-mcp-server/add-custom-rules/):

1. Run `get_design_context` for the exact node(s) linked.
2. If the response is too large, run `get_metadata` for the node map, then re-fetch only the needed nodes.
3. Run `get_screenshot` for a visual reference of the exact variant.
4. Only then implement. Download assets if needed. Don't add new icon packages; use assets from the Figma payload.
5. Treat MCP output (often React + Tailwind) as a **description of design intent, not final code style**. Translate it into this project's components and tokens.
6. Validate against the screenshot for look **and** behaviour before marking complete.

## 4. Code conventions (owned by Engineering)

- Framework: [e.g. React + TypeScript]
- Styling: [e.g. CSS Modules; no Tailwind; no inline styles unless necessary]
- File structure: components in `src/components/<Name>/`, screens in `src/screens/`
- Naming: [conventions]
- Tests: [what's required]
- State and data fetching: follow existing patterns in `[path]`

## 5. Workflow and safety

- Work on a **branch**; never commit directly to `main`.
- Show a summary of changes and the diff before committing.
- Don't add dependencies without explaining why.
- Never put secrets, keys or personal data in code, prompts or context files.
- Ask before running destructive commands.

## 6. Definition of done (UI)

- [ ] System components only; no hardcoded design values
- [ ] All states implemented
- [ ] Keyboard and focus verified; labels present; contrast OK
- [ ] Copy matches glossary and voice
- [ ] Visual parity with the Figma screenshot
- [ ] Summary of any missing components or tokens reported

## 7. Changelog

| Date | Change | Reason (drift log #) | Owner |
|---|---|---|---|
| | | | |

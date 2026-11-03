# AGENTS.md: design-system section (template)

> **AGENTS.md** lives in the app's code and gives coding agents (Codex and others) their instructions. **Developers own the code rules; you co-own this design-system section.** Give it to your tech lead to add. Based on Figma's recommended MCP rules ([Figma docs](https://developers.figma.com/docs/figma-mcp-server/add-custom-rules/)).

```markdown
## Design system rules (owned by Design — contact: [designer name])

### Read first
- Before any UI work, read `docs/DESIGN.md` (visual rules) and `docs/UX.md`
  (users, behaviour rules, glossary).

### Components
- IMPORTANT: Always use components from the app component library.
  Never create a new Button, Card, Chip, Sheet, Badge, etc. if one exists.
- IMPORTANT: If a needed component, variant or state doesn't exist, STOP and list
  what's missing (name, purpose, where needed). Do not invent UI.
- Component props must match Figma component properties (see Code Connect).

### Tokens
- Never hardcode colours, spacing, radius, font sizes or shadows. Use tokens.
- If a needed token doesn't exist, stop and ask. Don't invent one.

### States
- Implement every state shown in Figma: default, loading, empty, error, offline,
  disabled, success (+ feature-specific states).

### Words
- Use glossary terms exactly (book, class, studio, credits, waitlist, series).
- Sentence case. No exclamation marks in errors.

### Accessibility
- Labels on all inputs; meaningful accessible names on icon buttons.
- Visible focus; text contrast ≥ 4.5:1; touch targets ≥ 44pt (iOS) / 48dp (Android).
- Support larger text sizes without truncating essential info.

### Behaviour rules (from UX.md)
- Show the cancellation rule before any Book button.
- AI features suggest; never book, pay or cancel without user confirmation.

## Figma MCP flow (do not skip)
1. Get design context for the exact Figma node linked (one screen at a time).
2. If the response is too large, get metadata first, then fetch only needed nodes.
3. Get a screenshot of the node for visual reference.
4. Treat Figma MCP output as a description of design intent, not final code.
   Build with OUR components and tokens.
5. Compare against the screenshot for look AND behaviour before finishing.
6. In the PR description, list: components used, anything new, states implemented,
   and any differences from Figma with reasons.
```

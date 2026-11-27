---
name: new-tool
description: Add a new BusyHamster tool or page (a new route with its own UI, such as a timer variant, a game or a utility). Use when an issue asks for a new page, game or tool.
---

# Add a BusyHamster tool

Every BusyHamster tool touches the same places. Do them all in one PR.

1. Read PRODUCT.md "Product Principles" and DESIGN.md "Primitives" first.
2. Put pure logic in web/app/lib/<tool>.ts with a Vitest file next to it
   (web/app/lib/<tool>.test.ts). No browser APIs in lib/: pass storage, time
   and randomness in as arguments so tests are deterministic.
3. Add the route in web/app/routes.ts and the page in
   web/app/routes/<tool>.tsx. Build the UI only from web/app/components/ui.
4. Add a command-menu entry with a keyboard shortcut in
   web/app/components/command-menu.tsx, in the right group ("Go to" for
   pages, "Data" for import/export, "Timer" or "Task" for actions).
   The test "every route has a command-menu entry" enforces this.
5. Add a `meta` export: title, description, canonical, og:image.
6. If the page should be found on Google, add it to the prerender list in
   web/react-router.config.ts. The sitemap script reads the same list.
   Private pages (anything with the user's data) are not pre-rendered and
   get `{ name: "robots", content: "noindex" }`.
7. If the tool stores anything, add a key under the `nextline:` prefix in
   web/app/lib/storage.ts KEYS, and include it in the backup format test.
   Storage changes are tier 2: say so in the PR.
8. Add the page to the smoke test only if it's a critical path; otherwise
   mention it under "Things a human should look at".
9. Run `npm run check` and `npm run build` in web/.

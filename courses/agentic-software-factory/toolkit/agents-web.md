# web/: the BusyHamster frontend

React Router 8 in framework mode, with `ssr: false`: everything is built into
static files. There is no server code in this folder. Data calls go to /api
on the same origin (see api/AGENTS.md).

## Framework rules

- React Router 8 changes faster than your training data. Before you use an API
  you haven't seen elsewhere in this folder, read the docs in
  node_modules/react-router/docs or on reactrouter.com.
- Routes are registered in app/routes.ts. Route modules live in app/routes/.
- Metadata is the route module's `meta` export. Every pre-rendered page has a
  title, a description, a canonical link and og:image.
- Pages Google should find are in the `prerender` list in
  react-router.config.ts. Everything else is served by the SPA fallback.
- No `loader` or `action` that needs a server at request time. Use
  `clientLoader` for browser-only data.
- Fonts are self-hosted in public/fonts/. The build must not use the network.

## Building UI: use the design system

Before writing or changing any UI, read DESIGN.md (repo root).

- Build new screens only from the primitives in app/components/ui (import
  from "~/components/ui") and the colour tokens in app/styles/globals.css.
- Never hard-code a hex value, and don't restyle a button, card, chip, input
  or progress bar inline. If no primitive fits, say so and propose a new
  variant or component instead of styling one-off markup.
- A new primitive or variant goes in app/components/ui, on the
  /design-system page, and in DESIGN.md, all in the same change.
- Product copy follows PRODUCT.md (voice, terminology, principles).

## Logic and data

- Pure logic goes in app/lib/ with a Vitest file next to it. No browser APIs
  in app/lib/: pass storage, time and fetch in as arguments.
- localStorage access only through app/lib/storage.ts. Keys keep the
  `nextline:` prefix forever: renaming a key deletes users' data.
- Calls to the API only through app/lib/api.ts, typed from app/lib/api-types.ts
  (generated; never edit by hand). Always `credentials: "include"` and the
  `X-BusyHamster: 1` header on POST, PUT and DELETE.
- Nothing in the timer path waits for the network. Sync runs in the background.

## Commands

| Task | Command |
|---|---|
| Dev server (proxies /api to the local API) | npm run dev |
| Lint, types, unit tests | npm run check |
| Build | npm run build |
| Smoke tests | BASE_URL=http://localhost:4173 npm run test:smoke |
| Regenerate API types | npm run api:types |

// web/react-router.config.ts: React Router 8, framework mode, static output (chapter 10).
// With ssr: false and a prerender list, `react-router build` writes full HTML for
// each listed path plus __spa-fallback.html for every other route. Check the
// React Router docs for your version: these options have changed between releases.
import type { Config } from "@react-router/dev/config";
import { readdir } from "node:fs/promises";

// The same list feeds scripts/write-sitemap.ts, so the sitemap and the
// pre-rendered pages can't drift apart.
export async function publicPaths(): Promise<string[]> {
  const posts = (await readdir("content/blog").catch(() => [] as string[]))
    .filter((f) => f.endsWith(".md"))
    .map((f) => `/blog/${f.replace(/\.md$/, "")}`);
  return [
    "/",
    "/about",
    "/tired",
    "/timer/25-5",
    "/timer/50-10",
    "/timer/90-minute",
    "/blog",
    ...posts,
  ];
}

export default {
  // Static files only: .NET is the only server.
  ssr: false,
  // Pages Google should see as full HTML. History, account and anything with
  // the user's data are rendered in the browser through the SPA fallback.
  prerender: publicPaths,
} satisfies Config;

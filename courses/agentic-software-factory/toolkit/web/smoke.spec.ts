// web/tests/smoke.spec.ts: the paths that must never break (chapter 8).
// Runs against BASE_URL (a PR preview, or production after a deploy).
// Keep it to 5–10 tests and under two minutes. Agents may propose new smoke
// tests in a PR description; a human adds them (this folder is protected).
//
// playwright.config.ts: use: { baseURL: process.env.BASE_URL ?? "http://localhost:4173" }
import { test, expect } from "@playwright/test";

test.beforeEach(async ({ page }) => {
  // Start every test as a first-time visitor who has seen the intro.
  await page.goto("/");
  await page.evaluate(() => {
    localStorage.clear();
    localStorage.setItem("nextline:onboarded", "true");
  });
});

test("a line survives a reload and resumes with one key", async ({ page }) => {
  await page.goto("/");
  const input = page.getByRole("textbox", { name: /add a line/i });
  await input.fill("Write the CSV export spec");
  await input.press("Enter");
  await page.keyboard.press("Space"); // start focus

  await page.reload();
  await expect(page.getByText("Write the CSV export spec")).toBeVisible();
  await page.keyboard.press("r"); // one key resumes
  await expect(page.getByRole("button", { name: /pause/i })).toBeVisible();
});

test("the command menu opens from the keyboard", async ({ page }) => {
  await page.goto("/");
  await page.keyboard.press(process.platform === "darwin" ? "Meta+k" : "Control+k");
  await expect(page.getByRole("dialog")).toBeVisible();
  await page.keyboard.type("history");
  await page.keyboard.press("Enter");
  await expect(page).toHaveURL(/\/history$/);
});

test("History offers both exports", async ({ page }) => {
  await page.goto("/history");
  await expect(page.getByRole("button", { name: /export backup/i })).toBeVisible();
  await expect(page.getByRole("button", { name: /export as csv/i })).toBeVisible();
});

test("SEO pages render real HTML with metadata", async ({ request }) => {
  for (const path of ["/", "/timer/25-5", "/timer/50-10", "/timer/90-minute", "/about"]) {
    const res = await request.get(path);
    expect(res.status(), path).toBe(200);
    const html = await res.text();
    expect(html, path).toContain("<h1");
    expect(html, path).toMatch(/<link rel="canonical" href="https:\/\/busyhamster\.app/);
    expect(html, path).toMatch(/<meta property="og:image"/);
  }
});

test("private pages are not indexed", async ({ page }) => {
  await page.goto("/history");
  await expect(page.locator('meta[name="robots"]')).toHaveAttribute("content", /noindex/);
});

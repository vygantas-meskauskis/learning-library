# Learning library

**[Open the learning library](https://vygantas-meskauskis.github.io/learning-library/)** to choose a self-paced course. No accounts, search, or progress tracking.

| Course | Audience | Material |
|---|---|---|
| [Cloud-Native .NET](courses/cloud-native-dotnet/) | Experienced .NET developers | 21 chapters, Ledgerly .NET sample, infrastructure, toolkit |
| [Becoming an AI-Native Designer](courses/becoming-ai-native-designer/) | Mid-to-senior UX/UI designers | 16 chapters, glossary, prompts and toolkit |
| [AI-Native Design Lead](courses/ai-native-design-lead-course/) | Designers moving into leadership | 14 modules, team templates, capstone and 90-day plan |

## Repository layout

Each course is independent under `courses/<slug>/`. Its existing `index.html` reader, Markdown, templates and downloads stay together. The design-lead course also retains `AI-Native-Design-Lead-Course.html`. Readers link back to the library; their chapter anchor IDs are preserved.

- `index.html` and `assets/`: the lightweight static course selector and shared navigation styles.
- `.github/workflows/pages.yml`: validate, stage an allowlisted website artifact, and publish GitHub Pages.
- `.github/workflows/{ci,codeql,deploy}.yml`: active automation for `courses/cloud-native-dotnet/sample`.
- `scripts/`: standard-library-only website staging and link validation.
- `migration-sources.json`: source commits, complete tracked-file inventory and original SHA-256 hashes.
- [Migration and automation notes](MIGRATION.md): preservation, instructional workflow copies, and new-repository Azure setup.

## Read or run locally

Open `index.html` in a browser to read. For a local HTTP preview, run `python -m http.server 8000` from this repository and visit `http://localhost:8000/`.

To run Ledgerly, install the .NET SDK selected by its `global.json`:

```sh
git clone https://github.com/vygantas-meskauskis/learning-library.git
cd learning-library/courses/cloud-native-dotnet/sample
dotnet build Ledgerly.slnx
dotnet test --solution Ledgerly.slnx
```

Integration tests need Docker (SQL Server Testcontainers), or your own SQL instance via `LEDGERLY_TEST_SQL`. The full Aspire application also needs Docker or Podman. Azure deployment is optional and disabled until configured; no credentials or cloud resources are included.

## Add or update a course

1. Put the complete course in `courses/<slug>/`, including its `index.html` reader, Markdown sources and required assets. Keep licenses and attribution; do not include build outputs or authoring/session notes.
2. Add a course card to root `index.html` and a row to the table above. Use relative links, and add `../../index.html` navigation to each reader. Preserve existing anchor IDs when editing a reader.
3. Keep the Markdown and the retained HTML reader in sync. This repository does not regenerate courses. Put downloadable helpers in `toolkit/` or `templates/`; if another asset directory is needed, explicitly add it to `scripts/build_site.py`.
4. Run `python scripts/validate_site.py`, then `python scripts/build_site.py` and `python scripts/validate_site.py _site`. Preview `_site/` on desktop and mobile, check keyboard navigation and diagrams, and commit all related changes.

GitHub Pages publishes on pushes to `main`. Enable **Settings > Pages > Source > GitHub Actions** when setting up a fork. The artifact includes course reading material and helpers, not the sample application, active workflows, or course workflow examples. Source code links point to this repository on GitHub.

## Provenance and rights

The three courses were imported cleanly from their default branches on 2026-11-03. Their original Git histories remain in the original repositories; future edits belong here. See [the source inventory](migration-sources.json) for exact commits and original file hashes.

No source snapshot contained a license file or GitHub-recognized license. This consolidation does not add a license or grant additional rights. Existing attribution and source content are retained.

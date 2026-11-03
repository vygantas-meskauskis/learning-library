# Consolidation and automation

## Imported snapshots

| Original repository | Default-branch commit | Tracked files | Destination |
|---|---|---:|---|
| vygantas-meskauskis/cloud-native-dotnet | `90c01aa7e2d77e488eaa3cf5f7b849b890ac9088` | 118 | `courses/cloud-native-dotnet/` |
| vygantas-meskauskis/becoming-ai-native-designer | `0def7462f43960d08e662c4d1f459ed122141178` | 29 | `courses/becoming-ai-native-designer/` |
| vygantas-meskauskis/ai-native-design-lead-course | `bbacc6ce5c03528ac0a26b4b314839a86eb8d5ad` | 36 | `courses/ai-native-design-lead-course/` |

`migration-sources.json` is the authoritative per-file inventory. It records SHA-256 hashes of both the original and imported **Git blobs**, independent of Windows checkout line endings. All tracked files were imported; no tracked authoring notes, build outputs, or license files were present. Nested `.git` directories were not imported. The sources had no open issues or pull requests at inventory time.

Deliberate edits: repository/Pages URLs and clone commands, monorepo workflow paths and corresponding lesson snippets, library navigation and accessibility styles, and broken internal links discovered during validation. No curriculum or sample application rewrite is intended. Original anchor IDs remain unchanged.

## Active versus instructional workflows

Only the root `.github/workflows/` executes. The course's `.github/` and `toolkit/` copies are instructional/downloadable examples, not additional active automation. Their CI, deploy and Dependabot paths match this library layout; when copying them into another repository, adapt `courses/cloud-native-dotnet/sample` to your own solution directory.

The .NET lessons use `sample/` as a course-relative shorthand. Run their local commands from `courses/cloud-native-dotnet/` unless the command explicitly starts in the solution directory. Repository-wide configuration such as workflow path filters, setup-dotnet inputs and Dependabot directories is relative to the **library root**, not the course folder.

The active `ci` workflow keeps build/test, four `PublishContainer` builds, and Bicep lint, build and parameter compilation. Its solution working directory, `global-json-file`, TestResults artifact and path filters use the nested sample. `deploy` watches the exact workflow name `ci`, deploys only successful trusted push runs (or an explicit manual run on main), and checks out the tested commit. CodeQL uses C# build-mode `none`; weekly and manual runs are available. No copied source workflows are published as website routes; toolkit downloads are retained.

## Azure deployment after migration

**No Azure provisioning or login was performed as part of this migration.** The new repository intentionally has no `AZURE_CLIENT_ID`, so deploy jobs skip. CI container builds only build images; they do not push images or provision infrastructure.

If you later choose to enable deployment:

1. Review chapter 12 and the Bicep parameter file with your Azure administrator. Use a dedicated deployer identity scoped to the intended resource group.
2. Create a **new** federated trust for `vygantas-meskauskis/learning-library` and its `production` environment. Do not reuse the original repository's subject. Verify the actual OIDC subject format (including immutable owner/repository IDs if applicable), issuer and audience against current GitHub/Azure documentation.
3. Create the GitHub `production` environment with appropriate reviewers and a main-only deployment branch rule. Configure any application identity/authority, resource names and CORS settings in the sample's infrastructure parameters.
4. Configure repository variables `AZURE_TENANT_ID`, `AZURE_SUBSCRIPTION_ID` and `AZURE_RESOURCE_GROUP`, then set `AZURE_CLIENT_ID` **last**, only when ready to enable deployment.
5. Grant only the resource-group and registry roles described in the course. Run the workflow intentionally and verify migrations, application health and telemetry.

Secrets, environment rules, OIDC trust and repository variables are not transferred by copying files. Original-repository Azure settings do not automatically apply here.

## Publishing

Pages uses root `.github/workflows/pages.yml`, not a branch-root Pages build. The website staging script includes only the home page, shared assets, course HTML/Markdown, and `toolkit/`/`templates/` files. Sample code and infrastructure, course `.github/` copies, source inventories and root maintenance scripts are not published as website paths. Links to those sources go to GitHub.

GitHub Pages does not serve dotfiles. The toolkit's original `.editorconfig` stays unchanged in Git; website staging also exposes it as `toolkit/editorconfig.txt` for download.

## Verified completion (2026-11-03)

- [CI](https://github.com/vygantas-meskauskis/learning-library/actions/runs/41596934218) passed: 23 tests (15 unit, 8 SQL integration), all four container builds, Bicep lint/build/build-params, and a non-empty test-results artifact.
- [CodeQL](https://github.com/vygantas-meskauskis/learning-library/actions/runs/41596934215) completed successfully with zero results and no analysis errors.
- [Pages](https://github.com/vygantas-meskauskis/learning-library/actions/runs/41597362507) deployed successfully. All 108 served website files matched staged content (normalizing checkout line endings). Source application code, course workflow copies and maintenance scripts returned 404 as intended.
- Local validators passed 1,126 source and 1,120 staged internal-link/asset/anchor checks. All four live readers passed keyboard skip/back navigation and anchor checks at 1440px and 320px widths, with no page overflow or JavaScript errors.
- All 87 Mermaid diagrams (49 .NET, 38 designer) rendered without syntax errors. Original HTML anchor IDs and Mermaid definitions are preserved. Every sample application file is byte-identical to its original Git blob.
- Dependabot successfully scanned both nested NuGet and root Actions configurations. Azure deploy was skipped because `AZURE_CLIENT_ID` is unset; no Azure operations were performed.

Only after these checks passed, the original repositories received canonical-location README and description notices and were archived:

| Repository | Archived | README notice commit |
|---|---|---|
| vygantas-meskauskis/cloud-native-dotnet | Yes | `a4cfea9c4c9bbc38ef999530acbf3958acd0f9c6` |
| vygantas-meskauskis/becoming-ai-native-designer | Yes | `9ccd329a858832ab025b4518125bddf68def4e25` |
| vygantas-meskauskis/ai-native-design-lead-course | Yes | `de62f6993a1532ac09736e6ae5b20f05d9cb210b` |

GitHub comparisons confirmed each original default branch is exactly one README-only commit ahead of the imported source commit, with zero commits behind. Histories remain intact; no repositories were deleted and no unrelated work was closed. No redirects or old-site banners were added. Future course edits belong in this library.

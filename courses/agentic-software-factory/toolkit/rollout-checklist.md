# Rollout checklist

[Back to the toolkit](README.md)

Before you turn a feature flag on for everyone (chapter 9). Written for BusyHamster's `sync` flag; adapt the specifics.

## Before

- [ ] Every slice behind the flag is merged and deployed
- [ ] The tier 2 checklist was done for every auth and data PR
- [ ] You've used the feature in production for at least three days with the flag overridden in your own browser (`localStorage.setItem("nextline:flags", '{"sync":true}')`)
- [ ] Deletion works: a test account created, synced, deleted, and its rows gone from the database
- [ ] Export works signed in and signed out
- [ ] Signed-out users see no change except the new entry point
- [ ] Smoke tests cover the signed-out path; the signed-in path is covered by integration tests
- [ ] Copy reviewed against PRODUCT.md (About page, sign-in prompt, privacy text)
- [ ] Alerts exist for new exception types and for 5xx rates on `/api/*`
- [ ] You know the rollback: set `sync: false` (frontend) and the API flag; neither deletes data

## Turning it on

- [ ] A one-line tier 1 PR: `"sync": true`
- [ ] Merge at a time you can watch for an hour
- [ ] Parity and smoke checks against production after the deploy

## After, for one week

- [ ] Check errors and sign-in failures daily
- [ ] Check cost: Container Apps, SQL free-offer usage, Static Web Apps 💰
- [ ] Note in the factory log anything users report

## Two to four weeks later

- [ ] Remove the flag and the dead code path, as a cleanup issue through the factory

# Snapshot

This folder is a pinned copy of the BusyHamster repository
([vygantas-meskauskis/nextline](https://github.com/vygantas-meskauskis/nextline)),
commit `6b0eaf47441d03c52a474e01cb7c6987f5d53e79` (9 November 2026), taken
with `git archive`. It's the "before" state of the course: Next.js 16 on
Vercel, no CI. It isn't updated; the real project moves on in its own repository.

Run it with Node 22:

    npm ci
    npm run lint
    npm test          # 109 tests
    npm run build     # needs network access to Google Fonts (see chapter 4)

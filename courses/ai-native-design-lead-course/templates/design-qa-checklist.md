# Design QA Checklist: AI-built or human-built UI

> Use at **Gate 3** (design QA on running UI: PR preview or staging). Copy into the PR comment and tick each item.

## System fidelity
- [ ] Only system components used (no duplicates or ad-hoc look-alikes)
- [ ] No hardcoded colours, spacing, radii, type or shadows (tokens only)
- [ ] Correct component variants and sizes
- [ ] Matches Figma within agreed tolerance (spacing, alignment, type)
- [ ] Works in all modes (light/dark, density, brand)

## States and content
- [ ] Empty state
- [ ] Loading state (and no layout jump)
- [ ] Error states (each type), with recovery action
- [ ] Disabled / read-only / permission-denied
- [ ] Long content, many items, zero items
- [ ] Copy matches voice; glossary terms correct; sentence case
- [ ] Numbers, dates and currency formatted correctly for the locale

## Accessibility (WCAG 2.2 AA basics)
- [ ] Keyboard: all interactive elements reachable; logical order; no traps
- [ ] Visible focus on every interactive element
- [ ] Labels on inputs (not placeholder-only); buttons have meaningful names
- [ ] Contrast checked with a tool (4.5:1 text; 3:1 large text and UI components)
- [ ] Meaning not conveyed by colour alone
- [ ] Images have appropriate alt text (or are marked decorative)
- [ ] Target sizes adequate (≥ 24×24 CSS px; 44×44 recommended on touch)
- [ ] Reduced-motion respected
- [ ] Quick screen reader pass on the main flow

## Responsive and robustness
- [ ] Agreed breakpoints checked
- [ ] Zoom to 200% without loss of content or function
- [ ] Text expansion (for example German) doesn't break the layout

## Close the loop
- [ ] Drift found → logged in the drift log
- [ ] Missing component or token → contribution request filed
- [ ] New pattern → Figma, code, Code Connect and docs updated (or ticket filed)

**Result:** ✅ Approved · ⚠️ Approved with follow-ups · ❌ Changes requested

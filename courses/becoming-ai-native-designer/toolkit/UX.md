# UX.md: Movewell

> **Purpose:** what every AI tool (and every person) should know about Movewell's users and how the product behaves. Inspired by NN/G's UX.md idea ([UX-Context Design](https://www.nngroup.com/articles/ux-context-design/)).
> **Owner:** Senior product designer · **Last reviewed:** [date] · Update after every research round and whenever AI output gets something wrong.
> **Related:** DESIGN.md (visual rules) · Glossary (below) · Components: app component library

---

## 1. Product in one paragraph

Movewell lets people discover and book local fitness and wellness classes (yoga, pilates, spin, climbing intros, sound baths) from partner studios. Users pay per class (euro) or with credits from a membership. Studios set prices, capacity and cancellation rules.

## 2. User models

**Busy professional (primary)**
- 25–45, books 1–3 classes/week, often one-handed on the commute
- Goal: book a good class in < 30 seconds
- Frustrations: surprise fees, hidden rules, too many taps
- Design implications: scannable facts first; primary actions in thumb zone; ≤ 3 taps to book

**Beginner (secondary)**
- Trying a new activity; worried "is this too hard / will I fit in?"
- Design implications: difficulty and "Beginner-friendly" visible; "what to expect / what to bring" on class details; reassuring tone

## 3. World model (context of use)

- Often on the move, interrupted, with bad connectivity → preserve state; offline-friendly booking list; clear retry
- Booking decisions often last-minute (same day) → availability and "spots left" prominent
- Studios differ in rules → always show the studio's rule, never a generic one

## 4. Insights → constraints

| # | Insight (evidence, date) | Constraint for anything we generate |
|---|---|---|
| 1 | Users feel tricked by late-cancel fees (14/18 interviews, Sep 2026) | Show the cancellation rule BEFORE the Book button, with the fee amount |
| 2 | Beginners skip classes that look intense (9/12, Sep 2026) | Show difficulty + "Beginner-friendly" when true; never hide level |
| 3 | Most bookings happen one-handed (analytics, 2026) | Primary actions in thumb zone; ≤ 3 taps from class to booked |
| 4 | Users miss that recurring = weekly charges (4/5 tests, Oct 2026) | Show "€X every [weekday]" next to any recurring control |
| 5 | Users expect a push notification when a studio cancels (5/5 tests, Oct 2026) | Any studio-initiated change notifies the user and explains refunds |

## 5. Interaction standards

- **Booking:** booking sheet with summary (time, place, price, rule) → Book → success with "Add to calendar".
- **Cancel:** free cancel = immediate with 10 s undo; fee cancel = confirmation dialog stating the fee.
- **Errors:** what happened + what to do next. Never blame the user. No exclamation marks.
- **Loading:** skeleton ClassCards; never block the whole screen for partial loads.
- **Empty states:** explain the value + one action (e.g., "Find a class").
- **AI suggestions:** AI suggests; the user confirms any booking, payment or cancellation.

## 6. Words (glossary)

| Use | Not | Meaning |
|---|---|---|
| book | reserve | Secure a spot in a class |
| class | session, lesson | A scheduled activity at a studio |
| studio | gym, venue | The partner business offering classes |
| credits | points, tokens | Membership currency for booking |
| waitlist | queue | List for a full class |
| series | subscription | A recurring weekly booking |

## 7. Never

- Never hide fees or cancellation rules.
- Never use guilt or pressure ("You haven't worked out in a while!").
- Never give medical advice.
- Never invent components; stop and list what's missing.

## 8. Changelog

| Date | Change | Trigger | By |
|---|---|---|---|
| | | | |

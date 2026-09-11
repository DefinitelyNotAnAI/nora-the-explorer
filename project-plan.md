# Nora & Miso — Project Plan
### Solo build, Godot 4.x, GitHub Copilot-assisted, first-time game dev

---

## 0. Ground Rules for This Plan

- **You have ~4.5 working days**, not 5: kickoff is Monday 10am PT, submission deadline is Friday 3pm PT.
- **Build in system order, not room order.** Each room depends on a shared system (collect/restore, push, discrimination). Prove the system once, then reskin it — don't build rooms 4-6 on systems you haven't validated in rooms 1-3.
- **Every day ends with a "done" checkpoint.** If you haven't hit it, that's your signal to cut scope (see Section 4) rather than pushing forward behind schedule.
- **The video upload deadline (Mon 9/21) is separate and later than the submission deadline (Fri 9/18).** Don't spend Friday afternoon editing video under time pressure — get the executable submitted first, edit the trailer over the weekend.

---

## 1. Pre-Week Prep (do this before Monday, if at all possible)

Goal: don't spend Monday morning learning what a "node" is.

- [ ] Install Godot 4.x.
- [ ] Complete one short official "getting started" tutorial (1-2 hours) — specifically to learn: scenes, nodes, the signal system (Godot's event/callback model), and how GDScript scripts attach to nodes. This is the single highest-leverage thing you can do before Monday.
- [ ] Set up a GitHub repo for the project (also satisfies your open-source intent for other projects — same workflow habit applies here).
- [ ] Re-read the design doc's Section 8 (Asset Checklist) once, just so it's loaded in your head before you're improvising under time pressure.
- [ ] Optional but valuable: search for an existing halftone/comic-dot shader example (Godot shader snippets are commonly shared) to adapt rather than write from scratch — this is your single trickiest visual asset, and adapting beats authoring from zero as a first-timer.

---

## 2. Day-by-Day Build Plan

### Day 1 (Monday) — Setup + Core Systems
**Morning:** Attend kickoff and pitching/matchmaking session.
**Afternoon:**
- Set up project skeleton: a hub scene, a placeholder room scene, and a player character (Nora) with basic movement.
- Apply a first-pass halftone shader to the scene (even if rough) — get the visual identity in place early since it affects every other asset's look.
- Build the **three foundational shared systems as generic, reusable scripts**, not tied to any specific room yet:
  1. Trigger system (passive collision + a scriptable "cat-initiated" event)
  2. Collect/Restore system (pick up, carry, place at a target)
  3. Timer/scoring system (running clock, no fail state)

**Day 1 "done" checkpoint:** Nora can walk around a blank test room, pick up a placeholder object, carry it to a target, and see it restored — with a timer visibly running. If this works, every room afterward is a reskin.

### Day 2 (Tuesday) — Room 1 (Tutorial) End-to-End + Push System
- Build Room 1 fully: bed trigger, stuffed animals scatter, collect/restore loop, the "last stuffed animal reached = mouth guard" twist.
- This is your **full validation pass** — it's the first time all core systems run together in a real room with real win conditions.
- Once Room 1 is playable start to finish, build the **push/reposition system** in isolation (a simple pushable box in a test scene) — don't wire it into Room 2 yet, just prove it works.

**Day 2 "done" checkpoint:** Room 1 is fully playable, start to finish, with a working timer. Push system works in isolation.

### Day 3 (Wednesday) — Room 2 (Push) + Room 3 (Discrimination)
- Wire the push system into Room 2: fishtank trigger, 9 fish (schooling tetra behavior + continuous angelfish), couch push reveals trapped fish + shin guards, full restore required.
- Build the **discrimination/inspect system** (pick up item → check against a "correct" flag → accept or reject-animation) and apply it to Room 3: sock pile, 2 correct pairs among decoys, reject pile with Miso's pounce reaction.

**Day 3 "done" checkpoint:** Rooms 1-3 are all playable, hub can move between them freely (except gating logic, which comes later).

### Day 4 (Thursday) — Room 4 (Boots) + Room 5 (Ball) + Hub Gating
- Room 4: toy bin cat-initiated trigger, collect/restore loop with toy-specific reaction animations, push-to-reveal-boots logic (bin must be upright before restore is valid).
- Room 5: randomized clothing search at the top of the stairs, scripted cutscene (ball bounces down stairs, Miso chases), randomized guess-and-check at the landing.
- Build the **hub unlock logic** for Room 6 (a simple flag check: all 5 items collected?).
- **If you're behind schedule, this is your first cut point** — see Section 4.

**Day 4 "done" checkpoint:** 5 of 6 rooms fully playable, Room 6 correctly gated until the other 5 are done.

### Day 5 (Friday, morning only — submission is 3pm) — Room 6 + Closing Scene + Polish
- Build Room 6: garage cascade (visual only, no cleanup), 3-spot hiding puzzle (trash can / box / shop vac, randomized, shared bolt animation mirrored via flip), catch-and-carry-to-door beat, stick reveal.
- Build the closing epilogue: window shot, Nora walks off, Miso pounces off-screen, score screen.
- **Full playtest, start to finish**, fixing whatever breaks — budget real time for this, it always takes longer than expected.
- Export the compiled executable (Godot's one-click export) and test the exported build specifically, not just the in-editor version (they can behave differently).
- Submit before 3pm PT.

**Day 5 "done" checkpoint:** Executable exported, tested, and submitted.

---

## 3. After Friday — Video Trailer (due Monday 9/21, not Friday)

- Use the weekend buffer, not Friday afternoon, for this.
- Record 1-3 minutes of gameplay footage covering: the tutorial room briefly, at least 2-3 of the free-order rooms (showing mechanical variety — push, discrimination), the Room 6 finale, and the closing epilogue scene.
- Light editing (trim, maybe a title card) — you don't need a polished trailer, judges are scoring the game, not the video production.

---

## 4. Cut-Scope Priority List (if you fall behind)

If any day runs long, cut in this order — each item is chosen because it's flagged as optional/non-critical in the design doc, or because cutting it doesn't break the core 6-room structure:

1. **Room 4's easter egg free-play mode** (color-shift, directional pounce reactions) — already designed as fully optional with no scoring impact. Cut first, no structural cost.
2. **Visual variety in Room 4's toy reaction animations** — fall back to one generic reaction animation instead of toy-specific ones.
3. **Reduce fish count in Room 2** from 9 to a smaller number (e.g., 5) if the collect/restore loop is taking too long to populate with content — the mechanic still reads correctly with fewer fish.
4. **Simplify Room 6's cascade** to a single sound/visual beat rather than a multi-object chain reaction.
5. **Do not cut:** the hub gating logic, the core collect/restore/push/discrimination systems themselves, or any full room — cutting a whole room breaks the "6 pieces of equipment" premise that the entire game is built around.

---

## 5. Key Risks Specific to a First-Time Solo Dev

- **Godot's node/scene/signal paradigm will be the biggest learning curve**, more so than GDScript syntax itself (which is intentionally easy). Budget extra time on Day 1 specifically for "why isn't this signal firing" style debugging — it's normal, not a sign you're behind.
- **The halftone shader is your highest-risk single asset** — it's the one piece with no direct precedent elsewhere in the design. Tackle it Day 1, and strongly prefer adapting an existing shader example over writing one from scratch.
- **Exported executables can behave differently from the in-editor preview** (missing assets, path issues). Don't leave your first real export test until the last hour on Friday.

---

*Companion document to Nora_and_Miso_Design_Doc.md. Use alongside the Asset & Production Checklist (Section 8 of the design doc) for day-to-day task tracking.*

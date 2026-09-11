# Nora & Miso — Game Jam Design Document
### xGames Game Jam 2026 · Microsoft Global Hackathon · Theme: Retro

---

## 1. Event Context

- **Theme:** Retro (team-selected via survey)
- **Team size:** Solo (Lee), building with GitHub Copilot-assisted "vibe coding"
- **Hackathon week:** Monday, Sept 14 – Friday, Sept 18
- **Team pitching/matchmaking:** Monday, Sept 14, 11:00 AM–12:00 PM PT
- **Final submissions due:** Friday, Sept 18, 3:00 PM PT
- **Final shareouts:** Friday, Sept 18, 3:10–5:00 PM PT
- **Video upload deadline:** Monday, Sept 21, 11:59 PM PT
- **Deliverables:** 1–3 minute gameplay video/trailer + compiled executable
- **Judging criteria:** Creativity & Originality, Gameplay & Mechanics, Theme Integration, Visual & Audio Design, Story/World Building, Technical Execution

---

## 2. Concept Summary

**Premise:** Nora, a short girl running late for field hockey practice, discovers her cat Miso has scattered her gear across the house while "playing" with it. She must search room by room, recover all six pieces of equipment, and get out the door.

**Protagonist:** Nora — player-controlled, no other characters controllable.

**Companion:** Miso — a giant biped Siamese cat (not a tiger; a nod to Calvin and Hobbes' dynamic without copying it). Chaotic good: never malicious, but his curiosity/energy is the source of every obstacle. Reactive/environmental only — not player-controlled, and never an autonomously pathing/moving agent (all his "chase" moments are scripted, one-time animation beats, not live AI movement).

**Tone reference:** Calvin and Hobbes — mischief, wonder, whimsy — expressed through the duo relationship (small/grounded girl + large/wild companion) rather than any literal "imaginary friend" device.

**Retro reference point:** Color halftone comic-strip printing (the CMYK dot-pattern of old newspaper Sunday strips) — applied as a **shader/filter over normal gameplay**, not as a literal panel-based UI structure. This keeps the visual homage distinct from the more common pixel-art/8-bit retro approach other jam teams are likely to use.

---

## 3. Engine & Tooling

- **Engine:** Godot 4.x
- **Rationale:** Native 2D pipeline (not retrofitted from 3D like Unity), lightweight/fast iteration for a solo one-week build, built-in shader language well-suited to the halftone post-process effect, one-click compiled executable export (satisfies jam deliverable), and a "text-first" architecture (scenes/scripts/resources as readable text) that pairs well with AI-assisted coding via Copilot.
- **Scripting language:** GDScript (lower cognitive load for a non-engineer solo dev than C#).

---

## 4. Core Game Structure

### 4.1 Level / Hub Model
- **6 rooms total**, one per equipment item: Mouth Guard, Shin Guards, Socks, Boots, Ball, Stick.
- **Room 1 (Mouth Guard)** always plays first — serves as the tutorial.
- **Rooms 2–5** (Shin Guards, Socks, Boots, Ball) are playable **in any order**.
- **Room 6 (Stick)** is gated — only unlocks once all five prior items have been found. Finale room.

### 4.2 Scoring
- **No fail state.** The game cannot be lost.
- **Time-based score:** lower completion time = higher score. Encourages replay and mastery without punishing exploration on a first attempt.
- Score/time screen is shown **after** the closing epilogue scene (see Section 5, Room 6), so the emotional beat isn't interrupted by a UI/stats screen.

### 4.3 Core Mechanical Toolkit (reused/reskinned across rooms, not rebuilt per room)
1. **Trigger → Scatter:** An event (passive collision, or a cat-initiated distraction) causes Miso to create chaos, scattering items across the room.
2. **Collect → Restore:** Player walks to scattered items, picks them up one at a time, and returns them to a "home" location.
3. **Push/Reposition:** Player can push select furniture/objects aside to reach hidden items (introduced in Room 2; reused/escalated in Rooms 4 and 6).
4. **Discrimination/Search:** Player must visually distinguish target items from decoys rather than simply collecting everything in sight (introduced in Room 3).
5. **Randomized target location:** Some rooms determine where the reward/target (or Miso himself) ends up via randomization, so it isn't memorizable across replays (introduced in Room 1; reused in Rooms 5 and 6).

Each room combines these systems differently rather than introducing wholly new systems, keeping solo build scope manageable.

### 4.4 Trigger Types
- **Passive/collision-based:** Player walks near/past an object and it fires automatically (Rooms 1–2). Fires **once per level attempt** (resets on replay) so repeat playthroughs have comparable, fair times and backtracking through a room doesn't re-trigger chaos.
- **Cat-initiated/distraction-based:** Miso reacts to something in the scene (e.g., spots a mouse, gets overexcited with his toys, bats an object, bolts in a final cascade) and causes the chaos himself, independent of Nora's position (Rooms 3, 4, 5, 6). A recurring flavor across multiple rooms, not a one-off.

### 4.5 Pacing Rhythm (free-order rooms)
Rooms 2–5 are designed to alternate between heavier and lighter content, so the overall playthrough doesn't feel uniformly dense regardless of the order a player chooses:
- Room 2 (Shin Guards): **Heavy** — full collect/restore at volume, plus push.
- Room 3 (Socks): **Light** — quick discrimination puzzle, no restore step.
- Room 4 (Boots): **Heavy** — collect/restore with reaction-animation beats, plus push, plus an optional easter egg.
- Room 5 (Ball): **Light** — a short cutscene beat plus two rounds of blind guess-and-check, no restore step.
- Room 6 (Stick) is the gated finale and sits outside this rhythm — it's meant to be the most eventful room in the game.

---

## 5. Room-by-Room Specifications

### Room 1 — Bedroom: Mouth Guard *(Tutorial — always first)*

- **Trigger:** Miso leaps onto the bed (passive, unavoidable, on critical path).
- **Scatter:** Stuffed animals fly off the bed onto the floor.
- **Loop:** Nora collects each stuffed animal and restores it to the bed, one at a time.
- **Twist:** The mouth guard appears under whichever stuffed animal ends up being the **last one reached on the floor** (not necessarily the last restored) — its location depends on play order, so it's not memorizable across replays. She picks it up, mouth guard is revealed, level ends immediately (no restore action required for that final one).
- **Teaches:** trigger → collect → restore (all three core concepts), plus an implicit sense that order/route matters.
- **Room identity:** Largest/simplest room — mostly scene-setting (establishes Nora's room, character flavor) with no push or discrimination mechanics.

### Room 2 — Living Room: Shin Guards *(Introduces Push/Reposition)*

- **Trigger:** Nora walks past a fishtank (passive, unavoidable, on critical path).
- **Scatter:** Tank tips over — 8 tetras + 1 angelfish spill out.
  - Fish behavior mirrors real schooling biology: tetras flop once and settle in place; the angelfish floats/moves continuously.
  - 7 tetras land in the open room (simple collect-and-restore).
  - 1 tetra flops once and settles **under the couch**, visible through the couch's wooden legs (mid-century modern style, chosen specifically so the trapped fish stays visible).
  - The angelfish continues moving/flopping in the open room as a "catch it" element.
- **New mechanic:** Push the couch aside — this single push action reveals both the trapped tetra and the shin guards simultaneously (not tied to a "last item" trick, to keep this room's reveal mechanically distinct from Room 1's).
- **Restore:** All 9 fish must be carried back to the tank, one at a time.
- **Completion condition:** All 9 fish must be collected and restored before the level ends — the couch push is mandatory, not a skippable shortcut, since one fish and the reward both depend on it.
- **Room identity:** Heaviest room so far — full collect/restore loop at higher volume, plus the new push mechanic.

### Room 3 — Laundry Room: Socks *(Introduces Discrimination/Search)*

- **Setup/story beat:** Nora asks Mom where her pink socks are; Mom says they're down in the laundry room.
- **Trigger:** Miso spots a mouse across the room, dashes over, and crashes into the sock basket — a cat-initiated distraction trigger rather than a passive walk-past.
- **Scatter:** Basket dumps a pile of mismatched socks: pink tube socks, ankle socks, near-color decoys (red, orange), and patterned socks — plus exactly **2 correct pink field hockey socks** (tall/knee-high, larger silhouette than the decoys, worn over shin guards).
- **Interaction loop:** Picking up any sock inspects it.
  - **Wrong sock:** A single quick animation — Nora shakes her head and tosses the sock into a growing pile in the corner of the room (removed from play permanently); Miso mirrors the head-shake and pounces/bats at the sock as it lands, playing with it. This fires every time, keeping Miso visually present throughout the room.
  - **Correct sock:** No reject animation — she simply keeps it.
- **Completion condition:** Level ends once both correct field hockey socks are collected. No restore/tidying step — this room's identity is search/discrimination, not cleanup, so a restore action isn't narratively or mechanically motivated.
- **Room identity:** Lightest/fastest of the four free-order rooms — deliberate pacing contrast after Room 2's heavier collect/restore/push combination.

### Room 4 — Hallway (Storage Cubbies): Boots

- **Setting:** A hallway lined with storage cubbies, with Miso's toy bin sitting alongside them.
- **Trigger:** Miso digs through his own toy bin, gets overexcited, and topples it (cat-initiated — his own mess, not something of Nora's he's disrupted, a nice character variation from every prior room).
- **Scatter:** Toys spill into the hallway (ball, chew toy, stuffed mouse — a visual echo of Room 3's real mouse, etc.). The toppled bin also lands on top of/in front of the boots, hiding them.
- **Loop per toy:** Nora collects each toy — picking it up triggers an automatic, toy-specific "Miso reacts playfully" animation (e.g., pounce, bat, shake — varies by toy type for visual variety at no added system cost) — but toys **cannot be restored to the bin until it's pushed upright** (the toppled bin is not a valid restore target while down).
- **Push:** Pushing the toppled bin upright/aside reveals the boots immediately **and** makes the bin a valid restore target. This naturally motivates the player to push early, without needing a scripted forced order.
- **Completion condition:** All toys must be collected and restored to the (now upright) bin before the level ends. Boots may be picked up as soon as they're revealed by the push.
- **Toy count:** Kept modest (3–4) given each toy includes a reaction-animation beat, to avoid the room dragging.

**Easter egg — special toy free-play (optional, no time penalty):**
- One of the existing toys (candidate: the stuffed mouse) triggers an optional free-play mode when picked up, rather than the standard reaction beat.
- **Visual:** The color/palette treatment (halftone shader parameters) shifts noticeably for the duration of free-play — a purely cosmetic "special moment" cue (tonally similar to a Mario invincibility-star moment), with no change to scoring or core mechanics.
- **Miso's behavior:** Anchored in place (consistent with Miso being reactive/environmental, never an autonomously moving agent, anywhere in the game):
  - **Idle:** anticipatory butt-wiggle, facing toward Nora's current side.
  - **On direction change:** a pounce-past animation in that direction, then a **short cooldown** back to idle before he'll react again (avoids a jittery/spammy feel).
  - Only **2 unique animations** needed (idle-wiggle, pounce) — left/right variants achieved via horizontal sprite flip rather than separate mirrored assets.
- **Exit:** Re-interacting with the toy (or walking away) ends free-play — Miso collapses into a nap, palette reverts to normal, toy is restored, standard completion logic resumes.

### Room 5 — Stairs/Landing: Ball

- **Setting:** Top of a staircase down to the landing at the bottom — treated as one single, self-contained room (not two separate named rooms), preserving the free-order hub structure.
- **Top of stairs:** Three clothing items are present (a sweater, a pair of pants, a hat). The ball is hidden under exactly one — Nora inspects each (same pick-up-to-check verb as Rooms 3/4) until she finds it. **Which item hides the ball is randomized each playthrough**, so it isn't memorizable across replays (consistent with the location-varies-by-play device used in Room 1).
- **Cutscene beat (scripted, no player input):** The instant the ball is revealed, Miso bats it — a single authored animation sequence shows the ball bouncing/rolling down the stairs with Miso chasing after it, ending at the landing below. This is a one-time scripted beat, not a live/player-reactive chase — Miso does not become a freely-moving agent as a result.
- **Bottom landing:** Two objects are present — a coat rack and a small table. The ball has landed under exactly one of them, **also randomized per playthrough**, independent of the top-of-stairs outcome. This is blind guess-and-check (push one; if wrong, push the other) — consistent with the trial-and-error tone used elsewhere (e.g., Room 3's socks), rather than introducing a new "visible tell" convention.
- **Completion condition:** Ball retrieved from the correct spot — level ends immediately. No restore step (deliberately kept as a light, fast room).
- **Room identity:** A fast, low-content room by design — continues the heavy/light pacing rhythm across the free-order rooms.

### Room 6 — Garage: Stick *(Finale — gated, unlocks after Rooms 1–5 complete)*

- **Unlock:** Only accessible once all 5 other items have been collected (e.g., garage door won't open until then).
- **Layout:** A single room with three functional zones — an entry point (from the house), a middle "puzzle" zone, and a far wall where the stick hangs.
- **Trigger/setup:** Miso, overexcited that the hunt is nearly over, causes one last cascade (echoing prior rooms' chaos types in miniature) and bolts into the garage to hide.
- **Puzzle (middle zone) — three hiding spots:** a trash can, a cardboard box, and a shop vac. Which spot is correct is **randomized per playthrough**.
  - **Wrong spot (2 of 3):** Miso pops up in a scaredy-cat jump pose, then bolts in a direction and disappears again. This is **one shared animation**, mirrored via horizontal sprite flip depending on the spot, not two separate animations.
  - **Right spot (1 of 3):** Nora catches him — an automatic "catch" animation plays, followed by a short scene of her carrying him to the door and depositing him back into the house.
- **Reward (far wall):** The stick hangs on the wall opposite the entry — **not interactable until Miso has been restored through the door.** This enforces "resolve Miso first, then claim the stick" without needing extra logic beyond a single completion flag.
- **Completion:** Nora retrieves the stick. Game's core objective (all 6 items collected) is now complete.

### Closing Scene (Epilogue)

- Once the stick is collected, the game does not immediately jump to the score screen. Instead:
  1. A closing shot shows **Miso framed in the house's front window**, watching Nora walk off-screen toward practice with her gear bag.
  2. Once she's out of view, **Miso turns his head and pounces off-screen** — reusing the existing pounce animation (no new asset needed) — implying he's already back to causing mischief the moment she's gone. A wordless, comedic button that reinforces his "chaotic good" character without undercutting the warmth of the moment.
  3. **The score/time screen appears after** this epilogue beat, so the emotional/comedic closing image isn't interrupted by UI.

---

## 6. Production Decisions (Locked)

1. **Dialogue delivery: Speech bubbles, not voice-over.** Zero recording overhead, faster to iterate solo, and directly reinforces the comic-strip visual theme (a genuine Theme Integration point with judges, not just a cost-saving default).
2. **Mom device: Light bookend, not a recurring system.** One line at the very start to establish urgency (e.g., "you're going to be late!"), plus the existing Room 3 setup beat ("where are my pink socks?" → "laundry room") as the one mid-game callback. No contextual nagging system that fires across multiple rooms — reused, cheap text/audio lines only, no new animation work.
3. **Mom's visual identity: Off-screen only.** She never appears on-screen — her lines are delivered as speech bubbles "shouted" from another room. Avoids designing, animating, or rendering a second human character entirely.
4. **Garage cascade (Room 6 setup): Purely visual/audio, no cleanup required.** Same treatment as Room 5's pots-and-pans-style beat — she just needs to get past it into the hiding-spot puzzle. Keeps Room 6 focused on being the most kinetic room, not the most tedious.

## 7. Remaining Implementation Tasks (not open design decisions — build items)

1. **Hub/unlock logic:** A boolean flag array (5 items collected?) gating the Room 6 entrance. Trivial implementation, no further design discussion needed.
2. **Asset/production inventory:** See Section 8 for the full checklist of sprites, animations, and UI elements implied by this document.

---

## 8. Asset & Production Checklist

### Characters
- **Nora:** idle, walk (4-directional or 8-directional per engine choice), carry-item pose/walk, inspect/pick-up animation, head-shake-and-toss animation (Room 3), catch/carry animation (Room 6).
- **Miso:** idle, walk/trot (for scripted sequences only, not free player-driven movement), pounce (reused across Rooms 3, 4 easter egg, 6, and closing scene), head-shake (Room 3), toy-specific reaction animations x3–4 (Room 4), idle butt-wiggle (Room 4 easter egg), scaredy-cat jump-and-bolt (Room 6, one shared animation mirrored via flip), nap/collapse (Room 4 easter egg exit), final window pose + pounce-off-screen (closing scene).

### Shared Systems (build once, reuse everywhere)
- Passive collision trigger (fires once per attempt, resets on replay).
- Cat-initiated/scripted trigger sequences (no live AI/pathing).
- Collect interaction (pick up item).
- Restore interaction (carry-and-place at a home location).
- Push/reposition interaction (furniture/object repositioning).
- Randomized-location logic (for Room 1's last-stuffed-animal twist, Room 5's clothing/landing spots, Room 6's hiding spot).
- Halftone comic-strip shader (base visual treatment) + palette-shift variant (Room 4 easter egg).
- Timer/scoring system + end-of-game score screen.
- Speech bubble UI system (for all dialogue, including Mom's off-screen lines).

### Room-Specific Assets
| Room | Key objects/sprites needed |
|---|---|
| 1 — Bedroom | Bed, 4–6 stuffed animal sprites, mouth guard |
| 2 — Living Room | Fishtank (intact + tipped states), 8 tetra sprites, 1 angelfish sprite, mid-century couch (pushable, see-through legs), shin guards |
| 3 — Laundry Room | Basket (intact + tipped states), sock sprites (pink field hockey x2, tube/ankle decoys, near-color and patterned decoys), corner "reject pile" (growing states) |
| 4 — Hallway/Cubbies | Storage cubbies (background), toy bin (upright + toppled states), 3–4 toy sprites (incl. stuffed mouse), boots |
| 5 — Stairs/Landing | Staircase background, 3 clothing item sprites (sweater, pants, hat), ball, coat rack (pushable), small table (pushable) |
| 6 — Garage | Garage background (entry/middle/far-wall zones), door (to house), trash can, cardboard box, shop vac, stick (wall-mounted) |
| Closing Scene | Front window/house exterior shot, Nora walk-off sprite, gear bag |

### UI Elements
- Timer display (running during gameplay).
- Score screen (post-epilogue).
- Speech bubble rendering (positioned per-character, on/off-screen support for Mom).
- Room-select hub UI (if applicable) showing locked/unlocked state for Room 6.

---

*Document last updated during design discussion — Sept 2026. All 6 rooms, the closing scene, and remaining production decisions are now fully specified end-to-end. Living document; update as production details are finalized.*

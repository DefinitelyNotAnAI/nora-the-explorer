# Godot Beginner Starting Checklist
### For first-time use, before Day 1 of the hackathon

This is deliberately narrow — just enough to make Day 1 of the project plan feel familiar instead of overwhelming. Don't try to "learn Godot" broadly; just get comfortable with the handful of concepts this project actually needs.

---

## 1. Install & Setup

- [ ] Download and install **Godot 4.x** (the stable release, not a beta) from godotengine.org.
- [ ] Launch it once, create a throwaway test project just to confirm it opens and runs correctly.
- [ ] Familiarize yourself with the main editor layout: the **Scene panel** (top-left, shows your node tree), the **Filesystem panel** (bottom-left, your project's files), the **Inspector** (right side, properties of whatever's selected), and the **viewport** (center, where you see/place things visually).

---

## 2. The Four Concepts You Actually Need

Don't worry about anything beyond these four — this project doesn't require advanced Godot knowledge, just comfort with its basic building blocks.

### A. Nodes
- [ ] Understand: a **node** is the basic building block of everything in Godot — a sprite, a character, a sound, a piece of UI, a collision shape. Everything is a node.
- [ ] Try it: create a new scene, add a `Sprite2D` node, drag any placeholder image onto it, see it appear in the viewport.

### B. Scenes
- [ ] Understand: a **scene** is a group of nodes saved together — think of it as a reusable "prefab" (a whole character, a whole room, a whole UI screen).
- [ ] Try it: save your test scene as a `.tscn` file, then create a second scene and drag the first scene into it as an instance (this is how you'll reuse Nora and Miso across every room without rebuilding them each time).

### C. GDScript basics
- [ ] Understand: GDScript is Godot's built-in scripting language — it's intentionally close to Python (simple syntax, no semicolons required, indentation-based).
- [ ] Try it: attach a script to a node (right-click node → Attach Script), and write the simplest possible script that just prints something to the output console when the game starts (`func _ready(): print("hello")`). Run the scene and confirm you see it in the Output panel.
- [ ] Try it: write a script that moves a node a few pixels every frame using `_process(delta)` — this is the basis of Nora's movement.

### D. Signals
- [ ] Understand: a **signal** is Godot's event system — nodes "emit" signals (e.g., "I got clicked," "I entered this area") and other nodes can "listen" and react. This is how you'll build triggers (e.g., "Nora entered the fishtank's collision area → scatter the fish").
- [ ] Try it: add an `Area2D` node with a collision shape, connect its `body_entered` signal to a script, and print a message when your test character walks into it. This one exercise is essentially a working prototype of every "passive trigger" in your design doc (Rooms 1 and 2).

---

## 3. Specific Things Worth Testing Before Day 1

These map directly to systems your project actually needs — testing them now, even roughly, means Day 1 is refinement instead of first-contact.

- [ ] **Character movement:** a `CharacterBody2D` node with a script reading keyboard input (arrow keys or WASD) and moving accordingly. This is Nora.
- [ ] **Collision detection:** confirm you understand the difference between `Area2D` (detects overlap, doesn't physically block) and `CharacterBody2D`/`StaticBody2D` with collision shapes (physically block movement) — you'll need both (triggers vs. pushable furniture).
- [ ] **Picking up/holding an item:** a simple test where walking into an object and pressing a key makes it disappear (simulating "collect") — this is the seed of your collect/restore system.
- [ ] **A basic UI element:** add a `Label` node and get it to display changing text (e.g., a number counting up) — this is your timer/score display foundation.
- [ ] **Exporting a project:** go to Project → Export, set up a export preset (Windows/Mac/Linux depending on your target), and export your throwaway test project to a compiled executable, just to confirm the pipeline works before you're relying on it under deadline pressure Friday.

---

## 4. Shader Prep (Your Highest-Risk Asset)

- [ ] Understand at a basic level: Godot shaders are written in a language similar to GLSL, applied either directly to a sprite/material or as a full-screen post-processing effect (via a `CanvasLayer` + `ColorRect` with a shader material — this is likely your approach for the halftone effect).
- [ ] Search for an existing "halftone shader Godot" or "comic dot shader Godot" example/tutorial before the hackathon starts, and try dropping it into a test scene just to confirm it runs. Adapting a working example is dramatically faster than writing one from scratch as a first-time shader user.

---

## 5. What NOT to Worry About Yet

To keep this from becoming overwhelming, explicitly skip these for now — they're either not needed for this project, or better learned in context during the build itself:

- 3D anything (this is a fully 2D project)
- Advanced physics/RigidBody simulation (your "rolling ball" and "flopping fish" are scripted/animated beats, not live physics — see design doc)
- Multiplayer/networking
- Godot's animation state machine complexities beyond simple `AnimationPlayer` clips (you mostly need simple triggered animations, not a deep blend tree)
- C# — you're using GDScript per the design doc's engine rationale

---

*Companion checklist to Nora_and_Miso_Project_Plan.md. Complete Sections 1-3 before Day 1; Section 4 is worth doing as early as possible given it's flagged as the highest-risk asset.*

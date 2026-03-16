---
name: excalidraw
description: |
  Create hand-drawn style diagrams, flowcharts, architecture diagrams, sequence diagrams, mind maps, and visual explanations using Excalidraw MCP tools. Use this skill whenever the user asks to draw, diagram, visualize, sketch, or illustrate something — including system architecture, data flows, state machines, org charts, ER diagrams, network topologies, decision trees, timelines, wireframes, or any visual explanation of concepts. Also trigger when users say "show me", "draw this", "make a diagram", "visualize", or "sketch".
license: Complete terms in LICENSE.txt
---

# Excalidraw Diagrams

Create beautiful hand-drawn style diagrams using the Excalidraw MCP tools. These tools render interactive, editable diagrams directly in the conversation with smooth draw-on animations.

## When to Use This Skill

Use Excalidraw for ANY visual or diagrammatic request:
- Architecture diagrams (system, software, cloud, network)
- Flowcharts and decision trees
- Sequence diagrams (UML-style)
- Entity-relationship diagrams
- State machines and state charts
- Mind maps and concept maps
- Data flow diagrams
- Org charts and hierarchies
- Timelines and roadmaps
- Wireframes and UI sketches
- Visual explanations of algorithms or concepts
- Comparison layouts
- Process diagrams (BPMN-style)

## Required Workflow

### Step 1: Read the Format Reference

**ALWAYS** call `mcp__claude_ai_Excalidraw__read_me` first, before creating any diagram. This returns the complete element format, color palette, and examples. Only call it once per conversation.

### Step 2: Plan the Diagram

Before drawing, briefly plan:
1. **What type of diagram?** (flowchart, architecture, sequence, etc.)
2. **What are the key elements?** (nodes, connections, labels)
3. **What's the layout strategy?** (left-to-right, top-to-bottom, radial)
4. **What camera size?** (S/M/L/XL based on complexity)
5. **How to use progressive camera movements?** (zoom in on sections as you draw them)

### Step 3: Create the Diagram

Call `mcp__claude_ai_Excalidraw__create_view` with a JSON array of elements.

**CRITICAL rules:**
- **ALWAYS start with a `cameraUpdate`** as the first element
- **Draw progressively**: background zones -> shapes -> labels -> arrows -> next group
- **Use camera movements** to guide attention — pan/zoom to each section as you draw it
- **End with a final zoom-out** to show the complete diagram
- **Keep font sizes readable**: minimum 16 for body, 20 for titles, never below 14
- **Minimum shape size**: 120x60 for labeled rectangles
- **Leave gaps**: 20-30px minimum between elements
- **Use the color palette consistently** — don't invent random colors

### Step 4: Export (Optional)

If the user wants a shareable link, call `mcp__claude_ai_Excalidraw__export_to_excalidraw` to upload to excalidraw.com and get a URL.

### Step 5: Iterate with Checkpoints

Every `create_view` call returns a `checkpointId`. To modify an existing diagram:
1. Start elements with `{"type": "restoreCheckpoint", "id": "<checkpointId>"}`
2. Use `{"type": "delete", "ids": "id1,id2"}` to remove elements
3. Add new elements after the restore/delete
4. Never reuse deleted element IDs

---

## Color Palette

### Shape Fills (pastel backgrounds)
| Color | Hex | Use For |
|-------|-----|---------|
| Light Blue | `#a5d8ff` | Input, sources, primary nodes, users |
| Light Green | `#b2f2bb` | Success, output, completed, services |
| Light Orange | `#ffd8a8` | Warning, pending, external systems |
| Light Purple | `#d0bfff` | Processing, middleware, logic layers |
| Light Red | `#ffc9c9` | Error, critical, alerts, blockers |
| Light Yellow | `#fff3bf` | Notes, decisions, planning, highlights |
| Light Teal | `#c3fae8` | Storage, databases, data layers |
| Light Pink | `#eebefa` | Analytics, metrics, monitoring |

### Stroke/Arrow Colors
| Color | Hex | Use For |
|-------|-----|---------|
| Blue | `#4a9eed` | Primary actions, data flow |
| Amber | `#f59e0b` | Warnings, external calls |
| Green | `#22c55e` | Success paths, responses |
| Red | `#ef4444` | Error paths, critical |
| Purple | `#8b5cf6` | Processing, async flows |
| Cyan | `#06b6d4` | Info, secondary paths |

### Background Zones (use with opacity: 30-35)
| Color | Hex | Use For |
|-------|-----|---------|
| Blue zone | `#dbe4ff` | UI / frontend layer |
| Purple zone | `#e5dbff` | Logic / agent / API layer |
| Green zone | `#d3f9d8` | Data / storage / tool layer |

---

## Camera Sizes (MUST be 4:3 ratio)

| Size | Dimensions | Use For |
|------|-----------|---------|
| S | 400 x 300 | Close-up on 2-3 elements |
| M | 600 x 450 | Section of a diagram |
| L | 800 x 600 | Standard full diagram (DEFAULT) |
| XL | 1200 x 900 | Large overview (min font 18) |
| XXL | 1600 x 1200 | Panorama (min font 21) |

---

## Element Quick Reference

### Labeled Rectangle (most common)
```json
{"type": "rectangle", "id": "r1", "x": 100, "y": 100, "width": 200, "height": 80,
 "roundness": {"type": 3}, "backgroundColor": "#a5d8ff", "fillStyle": "solid",
 "label": {"text": "My Service", "fontSize": 18}}
```

### Arrow with Binding
```json
{"type": "arrow", "id": "a1", "x": 300, "y": 140, "width": 150, "height": 0,
 "points": [[0,0],[150,0]], "endArrowhead": "arrow",
 "startBinding": {"elementId": "r1", "fixedPoint": [1, 0.5]},
 "endBinding": {"elementId": "r2", "fixedPoint": [0, 0.5]},
 "label": {"text": "HTTP", "fontSize": 14}}
```

### Background Zone
```json
{"type": "rectangle", "id": "zone1", "x": 50, "y": 50, "width": 500, "height": 300,
 "backgroundColor": "#dbe4ff", "fillStyle": "solid", "roundness": {"type": 3},
 "strokeColor": "#4a9eed", "strokeWidth": 1, "opacity": 35}
```

### Diamond (decisions)
```json
{"type": "diamond", "id": "d1", "x": 100, "y": 100, "width": 150, "height": 150,
 "backgroundColor": "#fff3bf", "fillStyle": "solid",
 "label": {"text": "Ready?", "fontSize": 16}}
```

### Ellipse (start/end states)
```json
{"type": "ellipse", "id": "e1", "x": 100, "y": 100, "width": 120, "height": 60,
 "backgroundColor": "#b2f2bb", "fillStyle": "solid",
 "label": {"text": "Start", "fontSize": 16}}
```

### Standalone Text (titles only)
```json
{"type": "text", "id": "t1", "x": 150, "y": 20, "text": "System Architecture",
 "fontSize": 24, "strokeColor": "#1e1e1e"}
```

### Arrow fixedPoint Reference
| Position | fixedPoint |
|----------|-----------|
| Top | `[0.5, 0]` |
| Bottom | `[0.5, 1]` |
| Left | `[0, 0.5]` |
| Right | `[1, 0.5]` |

---

## Diagram Patterns

### Architecture Diagram
1. Draw background zones for each layer (frontend, backend, data)
2. Place service boxes within zones
3. Connect with labeled arrows showing protocols/data
4. Use consistent colors per layer
5. Camera: start zoomed on each layer, end with full overview

### Flowchart
1. Use rectangles for processes, diamonds for decisions, ellipses for start/end
2. Flow top-to-bottom or left-to-right
3. Label arrows with conditions ("Yes"/"No" on decision branches)
4. Keep consistent spacing (40-60px between nodes)

### Sequence Diagram
1. Actor boxes across the top with dashed lifelines (vertical arrows, `strokeStyle: "dashed"`)
2. Horizontal arrows between lifelines for messages
3. Label arrows with message names
4. Camera pans down as the sequence progresses

### Mind Map / Concept Map
1. Central node in the middle
2. Branch outward radially
3. Use different colors per branch/category
4. Arrows from center to leaves

---

## Common Mistakes to Avoid

- **No cameraUpdate first** — always start with one
- **Non-4:3 camera ratio** — causes distortion
- **Font too small** — never below 14, prefer 16+
- **Elements overlapping** — check coordinates carefully
- **All shapes then all arrows** — draw progressively instead
- **Reusing deleted IDs** — always use fresh IDs
- **Using emoji in text** — they don't render in Excalidraw's font
- **Light text on white** — minimum text color on white: `#757575`
- **Camera too tight** — leave padding around content
- **Missing bindings on arrows** — use startBinding/endBinding to attach arrows to shapes

---

## Dark Mode

If the user requests dark mode, add a massive dark background as the FIRST element (before cameraUpdate):

```json
{"type": "rectangle", "id": "darkbg", "x": -4000, "y": -3000, "width": 10000, "height": 7500,
 "backgroundColor": "#1e1e2e", "fillStyle": "solid", "strokeColor": "transparent", "strokeWidth": 0}
```

Then use light text (`#e5e5e5`) and dark shape fills (`#1e3a5f`, `#1a4d2e`, `#2d1b69`, etc.).

---

## Tips for Great Diagrams

- **Use cameraUpdate liberally** — it's the secret to engaging diagrams. Pan and zoom to guide attention as you draw each section.
- **Progressive reveal** — draw background zones first, then shapes, then connections. This creates a natural build-up animation.
- **Consistent visual language** — same color = same type of thing throughout the diagram.
- **White space matters** — don't cram elements together. Breathing room makes diagrams readable.
- **Label arrows** — unlabeled arrows are ambiguous. Even short labels like "HTTP", "async", "returns" help.
- **Group related elements** with background zones at low opacity.
- **Keep it simple** — fewer, clearer elements beat many cluttered ones. If a diagram is too complex, consider splitting into multiple views.

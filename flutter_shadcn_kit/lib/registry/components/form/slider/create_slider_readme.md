# create_slider_readme.md
> **Goal:** Use an AI coding agent to generate a **general-purpose, highly configurable Slider engine** for your Flutter shadcn-style copy/paste registry—capable of reproducing styles like:
> - Pill “brightness” slider with thin vertical thumb
> - Two-thumb range selector with multiple thumb variants
> - Stepped/dotted sliders
> - Segmented/tick-bar sliders
> - Histogram / waveform sliders
> - Marker zones (e.g., “Recommended”)

This document is a **build spec + AI prompt**. Copy the **Prompt** section into your AI agent, and follow the **Validation Checklist** to ensure correctness and backward compatibility.

---

## 1) Registry & Codebase Constraints (Non‑negotiable)

### Registry structure rules
All installable code must live inside the registry:
```
registry/components/<category>/<id>/
  <id>.dart        // single public class
  README.md
  meta.json
  preview.dart     // optional
  _impl/           // internal helpers by taxonomy
```

### Component rules
- **One public class per Dart file** (the file at `<id>.dart`)
- Any additional classes must be in `_impl/`
- Do not add files outside the component folder
- Must be safe for copy/paste installs (no project-wide assumptions)

### Target component ID
- `id`: `slider`
- `category`: `control`
- Main public file: `registry/components/control/slider/slider.dart`
- Public class: `Slider` (or match your naming conventions)

---

## 2) What “General Slider” means (Design Requirements)

### Engine vs Renderers
Build the slider as a **core engine** + **pluggable renderers**:

#### Engine responsibilities (must)
- Input: min/max, value(s), snapping
- Normalize values to **t ∈ [0..1]**
- Map pointer position ↔ value correctly
- Handle gestures: tap-to-seek + drag
- Choose active thumb (single vs range)
- Clamp values, enforce range constraints, optional “swap thumbs” behavior
- Provide accessible semantics and keyboard support (arrow keys optional but recommended)

#### Renderer responsibilities (pluggable)
- Track visuals (inactive track)
- Active fill visuals (active portion)
- Thumb visuals (circle, thin bar, square, pin, etc.)
- Ticks/marks/labels (dots, numbers, bars)
- Overlays (value bubble, hover highlights)

---

## 3) Styles you must reproduce (Accuracy Targets)

### A) Brightness slider (thin vertical bar thumb)
Match:
- Pill track
- Active fill ends **at the thumb boundary** (usually thumb center or slightly biased)
- Flat edge where active fill ends (not rounded) except at max
- Thumb: thin vertical rounded-rect bar, white, slight shadow

### B) Range selector (two thumbs)
Must support:
- Two thumbs: start/end
- Active range fill between thumbs
- Thumb variants:
  1) Pin (circle top + stem)
  2) Hollow circle
  3) Square handle
- Scale ticks + numeric labels (1..10 example)

### C) Discrete / stepped slider
- Snapping to steps
- Tick dots or segmented background
- Active tick highlight (optional but nice)

### D) Histogram / waveform slider (advanced)
- Background or overlay bars based on a provided list of amplitudes
- Selection can be single thumb or range

---

## 4) API Design (Public Surface)

> Keep the public API small, stable, and controlled. The slider should be **controlled** (value in, callback out).

### Value modes
Support **single** and **range** modes. Use either:
- Two constructors: `Slider()` and `RangeSlider()`, **OR**
- One widget with `mode: SliderMode.single|range` and `value` types.

**Recommendation:** one widget with a `mode` + `value` model, but keep it ergonomic.

### Required public props
- `min`, `max`
- `enabled`
- `onChanged(...)`
- `value` (single) or `rangeValue` (range)

### Snapping
Provide:
- `snap: SliderSnap.none`
- `SliderSnap.steps(int steps)` (quantize)
- `SliderSnap.values(List<double> values)` (custom set)

### Visual configuration (baseline)
- `trackHeight`, `trackRadius`
- `thumbSize` (or thumbBuilder)
- `activeColor`, `inactiveColor` (or paint builders)
- `thumbColor`
- `thumbInset` (distance from edges)

### Builders (power feature)
Expose optional builders to fully customize visuals:
- `trackBuilder(BuildContext, SliderStateView)`
- `fillBuilder(BuildContext, SliderStateView)`
- `thumbBuilder(BuildContext, SliderThumbStateView)`
- `ticksBuilder(BuildContext, SliderStateView)`
- `overlayBuilder(BuildContext, SliderStateView)`

If a builder is null, use a default implementation that looks good.

### State views (passed into builders)
Must include geometry so builders don’t re-calc:
- `Rect trackRect`
- `Rect activeRect` (single) or `Rect rangeRect` (range)
- `double t` or `(t0,t1)`
- `double value` or `(start,end)`
- `bool hovering`, `bool dragging`
- Layout info for ticks/marks

---

## 5) Internal Architecture (Implementation Guidance)

Create internal files under `_impl/`:

Suggested taxonomy:
```
_impl/core/*.dart
_impl/styles/*.dart
_impl/themes/*.dart
_impl/variants/*.dart
_impl/utils/*.dart
_impl/state/*.dart
_impl/extensions/*.dart
```

### Key layout rules for accurate visuals
#### “Fill stops at thumb boundary” rule
To match the brightness example, the active fill should stop at:
- **Thumb center** by default, OR
- `thumbCenterX - bias` (bias: 0..2 px)
And the fill’s trailing edge should be **flat** except at max.

Implementation idea:
- Compute `thumbCenterX`
- `fillWidth = clamp(thumbCenterX - bias, 0..trackWidth)`
- Use `BorderRadius.only(left: radius, right: atMax ? radius : 0)`

For range:
- `fillLeft = leftThumbCenterX + bias`
- `fillRight = rightThumbCenterX - bias`
- Clip with rounded corners only if at extremes (optional)

### Active thumb selection (range)
Rules:
- On tap/drag start, choose the nearest thumb to pointer X
- If equal distance, prefer the thumb that would keep range valid
- When dragging, lock to active thumb until release

### Snapping math (must be correct)
- Normalize x to `t ∈ [0..1]`
- Convert to value `v = min + t*(max-min)`
- Apply snapping:
  - steps: quantize `t` to `round(t*steps)/steps`
  - values: pick nearest value from list
- Clamp after snap

---

## 6) Preview & Documentation Requirements

### README.md inside the component
Must include:
- What it is (engine + builders)
- Quick start examples:
  - Brightness slider (thin bar thumb)
  - Range slider (two thumbs)
  - Stepped slider
- “Recipes” section:
  - How to make a custom thumb (builder)
  - How to add tick marks
  - How to plug a waveform renderer

### preview.dart (recommended)
Provide a small demo widget showing all presets/variants in one screen:
- Brightness
- Range (3 thumb styles)
- Steps + dots
- Segmented bars
- Waveform (fake data)

---

## 7) Validation Checklist (Acceptance Tests)

Your AI agent must pass these checks:

### Functional
- [ ] Drag thumb updates value smoothly
- [ ] Tap on track moves thumb to tap position
- [ ] Value clamps properly at min/max
- [ ] Snapping works for `steps` and `values`
- [ ] Range mode: thumbs can’t cross unless swap behavior enabled
- [ ] Active thumb selection feels correct (nearest thumb)
- [ ] Works in both LTR and RTL (thumb mapping correct)
- [ ] No layout overflow at small widths

### Visual accuracy (brightness style)
- [ ] Track is pill shaped
- [ ] Active fill ends at thumb boundary (no overfill)
- [ ] Active trailing edge is flat except at 100%
- [ ] Thumb is thin vertical bar with subtle shadow

### Code quality
- [ ] Only one public class in `slider.dart`
- [ ] All helpers are under `_impl/`
- [ ] No external deps unless absolutely necessary
- [ ] Null-safety and formatting clean

### Registry compatibility
- [ ] Files are only under `registry/components/control/slider/`
- [ ] `meta.json` exists and matches id/category
- [ ] README.md exists
- [ ] (If present) preview.dart is optional and self-contained

---

## 8) Backward Compatibility Rules

If you already shipped a `Slider` (or any slider):
- Keep existing constructor params working
- Add new params as optional with defaults
- Avoid breaking renames
- If needed, provide deprecated aliases (but keep only one public class in file)

---

# 9) COPY-PASTE PROMPT FOR AI AGENT (Use this as-is)

> **Instructions:** Copy everything below into your AI coding agent.

---

## Prompt: Build a configurable slider component for the Flutter shadcn registry

You are building a Flutter copy/paste component inside a strict registry.

### Context
- Registry path: `registry/components/control/slider/`
- Must create:
  - `slider.dart` (ONE public class)
  - `README.md`
  - `meta.json`
  - optional: `preview.dart`
  - Internal helpers go in `_impl/` only.

### Goals
Implement a **general slider engine** with:
1) Single value slider
2) Range slider (two thumbs)
3) Snapping (`none`, `steps(n)`, `values(list)`)
4) Customizable renderers via builders:
   - trackBuilder, fillBuilder, thumbBuilder, ticksBuilder, overlayBuilder
5) Default visuals that can reproduce:
   - Brightness slider with pill track + thin vertical thumb bar, active fill ends at thumb boundary with flat edge.
   - Range selector with three thumb variants (pin, hollow circle, square), and optional scale ticks.

### Non-negotiable constraints
- Exactly one public class in `slider.dart` named `Slider`
- Every other class must live under `_impl/`
- No files outside this component folder
- No heavy dependencies; prefer pure Flutter/Dart

### Required API (public)
- `min`, `max`, `enabled`
- `value` or `rangeValue` and `onChanged`
- `snap` model supporting none/steps/values
- Visual config: trackHeight, trackRadius, thumbInset
- Builders: trackBuilder, fillBuilder, thumbBuilder, ticksBuilder, overlayBuilder
- Must support LTR + RTL correctly

### Layout rule (important!)
For brightness style, the active fill must **stop at the thumb boundary**:
- Compute thumb center X from value t
- Active fill width ends at thumb center (or thumb center - 1px bias)
- Active fill’s trailing edge is flat unless value is at max (then rounded)

### Deliverables
1) Implement all files with correct paths.
2) In README, include examples for:
   - Brightness slider (thin bar thumb)
   - Range slider with 3 thumb builders
   - Steps + dots ticks
3) Provide `meta.json` with:
   - id: slider
   - category: control
4) If you add `preview.dart`, it must compile and showcase the variants.

### Verification
Before finalizing, ensure:
- Dragging and tapping works
- Snapping works
- Range behavior is correct
- Only one public class exists in slider.dart
- Everything is under the registry folder

Now generate the complete code for the component.

---

## 10) Suggested “Default Presets” (Optional)
If you want convenience without more public classes:
- Create an internal enum `SliderPreset` in `_impl/`
- Allow `preset` param in `Slider` to preconfigure builders and defaults:
  - brightness
  - rangeSelector
  - stepsDots
  - segmented
  - waveform
Presets must be optional and not bloat the public API.

---

## 11) Troubleshooting (Common AI mistakes)
- **Mistake:** multiple public classes in `slider.dart`  
  ✅ Fix: move everything but `Slider` to `_impl/`

- **Mistake:** fill overflows past thumb  
  ✅ Fix: compute fill width from thumb center and clamp; use flat trailing edge

- **Mistake:** range thumb selection feels wrong  
  ✅ Fix: on drag start, choose nearest thumb; lock until release

- **Mistake:** RTL breaks mapping  
  ✅ Fix: invert x-to-t mapping when direction is RTL

---

### Done
When the AI finishes, run your normal Flutter analyze/format and ensure the preview builds.

# Timeline Animation (`timeline_animation`)

Composite export for timeline keyframes and helpers.

---

## When to use

- Use this when:
  - you need keyframe-based animation timelines.
  - you want explicit durations per keyframe.
- Avoid when:
  - a simple `Tween` or `Curve` is sufficient.

---

## Install

```bash
flutter_shadcn add timeline_animation
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/composites/animation/timeline_animation/timeline_animation.dart';
```

---

## Minimal example

```dart
final timeline = TimelineAnimation<double>(
  keyframes: [
    AbsoluteKeyframe(const Duration(milliseconds: 200), 0, 1),
    StillKeyframe(const Duration(milliseconds: 200)),
  ],
);
```

---

## API

### Types and helpers

- `TimelineAnimation<T>`
- `TimelineAnimatable<T>`
- `Keyframe<T>`
- `AbsoluteKeyframe<T>`
- `RelativeKeyframe<T>`
- `StillKeyframe<T>`
- `PropertyLerp<T>`
- `Transformers`
- `timelineMaxDuration`

---

## Theming

- Not applicable.

---

## Accessibility

- Ensure animated motion respects user preferences when possible.

---

## Do / Don’t

**Do**
- ✅ Keep keyframe durations explicit and short.

**Don’t**
- ❌ Chain too many keyframes without testing performance.

---

## Related components

- `timeline`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`

# Repeated Animation Builder (`repeated_animation_builder`)

Composite export for RepeatedAnimationBuilder.

---

## When to use

- Use this when:
  - you need a repeating animation loop for a widget.
  - you want a simple builder that exposes a 0–1 value.
- Avoid when:
  - a one-off `AnimationController` is enough.

---

## Install

```bash
flutter_shadcn add repeated_animation_builder
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/composites/utility/repeated_animation_builder/repeated_animation_builder.dart';
```

---

## Minimal example

```dart
RepeatedAnimationBuilder(
  start: 0,
  end: 1,
  duration: const Duration(seconds: 1),
  builder: (context, value, child) => Opacity(
    opacity: value,
    child: child,
  ),
  child: const Text('Pulse'),
)
```

---

## API

### Types

- `RepeatedAnimationBuilder`

---

## Theming

- Not applicable.

---

## Accessibility

- Avoid rapid flashing; keep durations comfortable.

---

## Do / Don’t

**Do**
- ✅ Use easing curves for smoother motion.

**Don’t**
- ❌ Animate critical text continuously.

---

## Related components

- `timeline_animation`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`

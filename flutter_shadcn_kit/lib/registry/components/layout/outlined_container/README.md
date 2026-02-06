# Outlined Container (`outlined_container`)

Animated outlined container with theme-aware borders and blur.

---

## When to use

- Use this when:
  - you need a bordered surface with animated border changes.
- Avoid when:
  - a basic `Container` is enough.

---

## Install

```bash
flutter_shadcn add outlined_container
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/layout/outlined_container/outlined_container.dart';
```

---

## Minimal example

```dart
OutlinedContainer(
  child: const Text('Outlined'),
)
```

---

## API

### Constructor

- `OutlinedContainer` — main bordered surface.
- `DashedContainer` — dashed border variant.
- `SurfaceBlur` — optional blur layer wrapper.
- `OutlinedContainerTheme` — border and background defaults.

---

## Theming

- `OutlinedContainerTheme` controls border width, radius, and colors.

---

## Accessibility

- Ensure borders meet contrast requirements.

---

## Do / Don’t

**Do**
- ✅ Use `SurfaceBlur` for frosted surfaces.

**Don’t**
- ❌ Overuse dashed borders for primary content.

---

## Related components

- `card`
- `alert`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`

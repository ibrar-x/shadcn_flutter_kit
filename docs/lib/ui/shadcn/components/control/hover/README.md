# Hover (`hover`)

Hover timing helpers plus lightweight state tracking widgets.

---

## When to use

- Use this when:
  - you need hover delays or minimum hover durations.
  - you want to track pointer enter/exit events.
- Avoid when:
  - a simple `MouseRegion` is enough.

---

## Install

```bash
flutter_shadcn add hover
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/control/hover/hover.dart';
```

---

## Minimal example

```dart
Hover(
  onHover: (hovered) {},
  child: const Text('Hover me'),
)
```

---

## Common patterns

### Pattern: Hover with delay and minimum duration

```dart
Hover(
  waitDuration: const Duration(milliseconds: 400),
  minDuration: const Duration(milliseconds: 200),
  onHover: (hovered) {},
  child: const Text('Delayed hover'),
)
```

### Pattern: Track enter/exit activity

```dart
HoverActivity(
  onEnter: () {},
  onExit: () {},
  onHover: () {},
  debounceDuration: const Duration(milliseconds: 300),
  child: const Text('Active hover'),
)
```

---

## API

### Constructor

- `Hover` — timed hover activation with `waitDuration`, `minDuration`, and `showDuration`.
- `HoverActivity` — raw enter/exit/hover callbacks, optional `debounceDuration`.

### Callbacks

- `onHover` (Hover, HoverActivity)
- `onEnter`, `onExit` (HoverActivity)

---

## Theming

- Uses `HoverTheme` to read hover timing defaults from the shared theme system.

---

## Accessibility

- Hover is a pointer-only affordance; pair with focus or pressed states for keyboard users.

---

## Do / Don’t

**Do**
- ✅ Use `Hover` when you need delay or minimum hover time.
- ✅ Combine with focus styling for keyboard support.

**Don’t**
- ❌ Depend on hover as the only way to reveal critical UI.

---

## Related components

- `clickable`
- `button`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`

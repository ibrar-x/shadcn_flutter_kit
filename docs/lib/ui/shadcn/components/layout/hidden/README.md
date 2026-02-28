# Hidden (`hidden`)

Animated visibility helper with axis-aware size control.

---

## When to use

- Use this when:
  - you need to hide/show content with animation.
- Avoid when:
  - simple `Visibility` is enough.

---

## Install

```bash
flutter_shadcn add hidden
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/layout/hidden/hidden.dart';
```

---

## Minimal example

```dart
Hidden(
  hidden: isHidden,
  child: const Text('Toggle me'),
)
```

---

## API

### Constructor

- `Hidden`
  - `hidden` (`bool`, required)
  - `direction` (`Axis?`)
  - `duration`, `curve`, `reverse`
  - `keepCrossAxisSize`, `keepMainAxisSize`
- `HiddenTheme` — theme defaults for animation and axis.

---

## Theming

- `HiddenTheme` controls duration, curve, and axis.

---

## Accessibility

- Avoid hiding focusable content without updating focus state.

---

## Do / Don’t

**Do**
- ✅ Use `keepMainAxisSize` to avoid layout jumps.

**Don’t**
- ❌ Hide content that is required for form submission.

---

## Related components

- `collapsible`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`

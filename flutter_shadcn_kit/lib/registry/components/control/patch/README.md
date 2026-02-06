# Click Detector (`patch`)

Tracks consecutive taps and exposes click count details.

---

## When to use

- Use this when:
  - you need single/double/triple click detection.
  - you want click counts without manual timers.
- Avoid when:
  - a single `onTap` is enough.

---

## Install

```bash
flutter_shadcn add patch
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/control/patch/patch.dart';
```

---

## Minimal example

```dart
ClickDetector(
  onClick: (details) {
    if (details.clickCount == 2) {
      // double-click
    }
  },
  child: const Text('Click me'),
)
```

---

## Common patterns

### Pattern: Custom multi-click threshold

```dart
ClickDetector(
  threshold: const Duration(milliseconds: 500),
  onClick: (details) {},
  child: const Text('Slower double-click'),
)
```

---

## API

### Constructor

- `ClickDetector`
  - `child` (`Widget`, required)
  - `onClick` (`ClickCallback<ClickDetails>?`)
  - `behavior` (`HitTestBehavior`, default: `deferToChild`)
  - `threshold` (`Duration`, default: `300ms`)

### Callbacks

- `onClick` — receives `ClickDetails` with `clickCount`.

---

## Theming

- No theme dependencies; style the child directly.

---

## Accessibility

- Multi-click is pointer-centric; provide alternate actions for keyboard users.

---

## Do / Don’t

**Do**
- ✅ Use for double-click behaviors on desktop/web.
- ✅ Combine with hover/focus feedback for clarity.

**Don’t**
- ❌ Use for critical actions without a single-click fallback.

---

## Related components

- `clickable`
- `hover`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`

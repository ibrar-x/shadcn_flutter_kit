# Switcher (`switcher`)

Swipeable viewport that animates between children along an axis.

---

## When to use

- Use this when:
  - you want swipe-based page switching.
- Avoid when:
  - a `PageView` is enough.

---

## Install

```bash
flutter_shadcn add switcher
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/navigation/switcher/switcher.dart';
```

---

## Minimal example

```dart
Switcher(
  index: 0,
  direction: AxisDirection.right,
  children: const [Text('A'), Text('B')],
)
```

---

## API

### Constructor

- `Switcher`
  - `index` (`int`)
  - `onIndexChanged` (`ValueChanged<int>?`)
  - `direction` (`AxisDirection`, required)
  - `children` (`List<Widget>`, required)
  - `duration`, `curve`

---

## Theming

- No theme dependencies.

---

## Accessibility

- Provide non-swipe navigation for keyboard users.

---

## Do / Don’t

**Do**
- ✅ Keep child count small for performance.

**Don’t**
- ❌ Use for forms without clear focus handling.

---

## Related components

- `tab_container`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`

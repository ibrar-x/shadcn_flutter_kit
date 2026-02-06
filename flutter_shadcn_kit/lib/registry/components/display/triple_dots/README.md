# More Dots (`triple_dots`)

Configurable row/column of dots for menu or loading indicators.

---

## When to use

- Use this when:
  - you need a small overflow or loading indicator.
  - you want dots in a row or column.
- Avoid when:
  - an icon button would be clearer.

---

## Install

```bash
flutter_shadcn add triple_dots
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/display/triple_dots/triple_dots.dart';
```

---

## Minimal example

```dart
const MoreDots()
```

---

## Common patterns

### Pattern: Vertical dots

```dart
const MoreDots(direction: Axis.vertical)
```

---

## API

### Constructor

- `MoreDots`
  - `direction` (`Axis`, default: `Axis.horizontal`)
  - `count` (`int`, default: `3`)
  - `size` (`double?`)
  - `color` (`Color?`)
  - `spacing` (`double`)
  - `padding` (`EdgeInsetsGeometry?`)

---

## Theming

- Inherits color and size from the ambient `TextStyle` when not provided.

---

## Accessibility

- Pair with a label when used as a menu trigger.

---

## Do / Don’t

**Do**
- ✅ Use with `IconButton` semantics when it triggers menus.

**Don’t**
- ❌ Use as the only indicator for critical state changes.

---

## Related components

- `icon`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`

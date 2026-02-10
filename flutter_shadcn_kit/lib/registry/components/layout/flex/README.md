# Flex (`flex`)

Patched `Flex/Row/Column` and `Stack` widgets with custom `paintOrder` support for layered painting and top-first hit testing.

---

## When to use

- Use this when:
  - you need overlapping children in `Row`, `Column`, `Flex`, or `Stack` while keeping normal layout behavior.
  - you need hit testing to follow visual stacking order.
- Avoid when:
  - default Flutter paint order is sufficient.

---

## Install

```bash
flutter_shadcn add flex
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/layout/flex/flex.dart';
```

---

## Minimal example

```dart
Row(
  children: [
    PaintOrder(
      paintOrder: 1,
      child: Text('On top'),
    ),
    Text('Below'),
  ],
)
```

---

## API

### Constructor

- `Flex` (patched)
- `Row` (patched)
- `Column` (patched)
- `Stack` (patched)
- `Flexible`
  - `flex`, `fit`, `paintOrder`
- `Expanded`
  - `flex`, `paintOrder`
- `Positioned`
  - `left`, `top`, `right`, `bottom`, `width`, `height`, `paintOrder`
- `PaintOrder`
  - `paintOrder` (required)

### Callbacks

- None

---

## Theming

- Uses existing Flutter layout behavior; no dedicated component theme.

---

## Accessibility

- Hit testing follows paint order; ensure visually top elements are also logically interactive as intended.

---

## Do / Don’t

**Do**
- ✅ Use `paintOrder` only where layering intent is explicit.

**Don’t**
- ❌ Rely on widget insertion order for overlap behavior when using `paintOrder`.

---

## Related components

- `scrollable`
- `stage_container`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`

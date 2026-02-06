# Scrollable Client (`scrollable_client`)

Two-dimensional scroll surface with builder callbacks for viewport-aware layouts.

---

## When to use

- Use this when:
  - you need custom 2D scrolling with viewport awareness.
- Avoid when:
  - a standard `ListView` or `SingleChildScrollView` is enough.

---

## Install

```bash
flutter_shadcn add scrollable_client
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/layout/scrollable_client/scrollable_client.dart';
```

---

## Minimal example

```dart
ScrollableClient(
  builder: (context, offset, size, child) {
    return CustomPaint(size: size);
  },
)
```

---

## API

### Constructor

- `ScrollableClient`
  - `builder` (`ScrollableBuilder`, required)
  - `child` (`Widget?`)
  - `controller` / `diagonalDragBehavior` / `dragStartBehavior`
- `ScrollableClientViewport` — viewport widget.
- `ScrollableBuilder` — `Widget Function(BuildContext, Offset, Size, Widget?)`.

---

## Theming

- `ScrollableClientTheme` controls drag behavior, clipping, and overscroll.

---

## Accessibility

- Provide keyboard scroll handling where appropriate.

---

## Do / Don’t

**Do**
- ✅ Use for custom canvas-like interactions.

**Don’t**
- ❌ Replace basic lists with this without need.

---

## Related components

- `scrollview`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`

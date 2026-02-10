# Scrollable (`scrollable`)

Two-dimensional scroll primitives for custom viewport-driven layouts.

---

## When to use

- Use this when:
  - you need custom two-axis scrolling with direct access to scroll offsets and viewport size.
  - you need a custom render viewport with optional overscroll clamping.
- Avoid when:
  - a regular `ListView`, `SingleChildScrollView`, or `GridView` is enough.

---

## Install

```bash
flutter_shadcn add scrollable
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/layout/scrollable/scrollable.dart';
```

---

## Minimal example

```dart
ScrollableClient(
  builder: (context, offset, viewportSize, child) {
    return ClipRect(
      child: Transform.translate(
        offset: Offset(-offset.dx, -offset.dy),
        child: child,
      ),
    );
  },
  child: SizedBox(width: 1200, height: 800),
)
```

---

## API

### Constructor

- `ScrollableClient`
  - `builder` (`ScrollableBuilder`, required)
  - `child` (`Widget?`)
  - `primary`, `mainAxis`, `verticalDetails`, `horizontalDetails`
  - `diagonalDragBehavior`, `dragStartBehavior`, `keyboardDismissBehavior`
  - `clipBehavior`, `hitTestBehavior`, `overscroll`
- `ScrollableClientViewport`
  - viewport widget for `ScrollableClient`
- `RenderScrollableClientViewport`
  - custom two-dimensional viewport renderer
- `FadedScrollableViewport`
  - `child` (required), `fadeExtent`, `fadeSize`

### Callbacks

- `ScrollableBuilder` (`Widget Function(BuildContext, Offset, Size, Widget?)`)

---

## Theming

- `ScrollableClientTheme` controls:
  - `diagonalDragBehavior`
  - `dragStartBehavior`
  - `keyboardDismissBehavior`
  - `clipBehavior`
  - `hitTestBehavior`
  - `overscroll`

---

## Accessibility

- If using keyboard-dismiss-on-drag, ensure form focus behavior remains predictable.

---

## Do / Don’t

**Do**
- ✅ Use this for canvas-like or large-surface content where both axes matter.

**Don’t**
- ❌ Replace simple one-axis lists with this unless you need custom viewport behavior.

---

## Related components

- `scrollable_client`
- `scrollview`
- `scrollbar`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`

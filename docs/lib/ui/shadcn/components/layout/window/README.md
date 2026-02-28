# Window (`window`)

Desktop-style window system with drag, resize, and snapping.

---

## When to use

- Use this when:
  - you need draggable/resizable windowed UI.
- Avoid when:
  - standard layouts are sufficient.

---

## Install

```bash
flutter_shadcn add window
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/layout/window/window.dart';
```

---

## Minimal example

```dart
Window(
  title: const Text('Window'),
  child: const Text('Content'),
)
```

---

## API

### Constructor

- `Window` — main window widget.
- `WindowController` — controller for window state.
- `WindowState` — bounds, minimization, resizing flags.
- `WindowTheme` — title bar height and resize thickness.
- `WindowSnapStrategy` — snapping behavior.

---

## Theming

- `WindowTheme` controls title bar and resize affordances.

---

## Accessibility

- Ensure window controls are keyboard accessible.

---

## Do / Don’t

**Do**
- ✅ Provide clear close/minimize actions.

**Don’t**
- ❌ Use window UI on small screens without fallback.

---

## Related components

- `card`
- `group`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`

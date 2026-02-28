# Clickable (`clickable`)

State-aware gesture surface with hover, focus, and press handling.

---

## When to use

- Use this when:
  - you need a custom interactive surface with hover/press/focus states.
  - you want to style a widget based on `WidgetState` without writing a full button.
- Avoid when:
  - a standard `Button` already matches the interaction needs.

---

## Install

```bash
flutter_shadcn add clickable
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/control/clickable/clickable.dart';
```

---

## Minimal example

```dart
Clickable(
  onPressed: () {},
  child: const Padding(
    padding: EdgeInsets.all(8),
    child: Text('Click me'),
  ),
)
```

---

## Common patterns

### Pattern: State-based decoration

```dart
Clickable(
  onPressed: () {},
  decoration: WidgetStateProperty.resolveWith((states) {
    if (states.contains(WidgetState.pressed)) {
      return BoxDecoration(color: Colors.black87);
    }
    if (states.contains(WidgetState.hovered)) {
      return BoxDecoration(color: Colors.black54);
    }
    return BoxDecoration(color: Colors.black45);
  }),
  child: const Padding(
    padding: EdgeInsets.all(10),
    child: Text('Hover + press'),
  ),
)
```

### Pattern: Keyboard shortcuts

```dart
Clickable(
  onPressed: () {},
  shortcuts: {
    const SingleActivator(LogicalKeyboardKey.enter): const ActivateIntent(),
  },
  actions: {
    ActivateIntent: CallbackAction<Intent>(onInvoke: (_) => null),
  },
  child: const Text('Press Enter'),
)
```

---

## API

### Constructor

- `child` (`Widget`, required) — content for the interactive surface.
- `onPressed` (`VoidCallback?`) — primary tap callback.
- `enabled` (`bool`) — enables/disables interactions (default: `true`).
- `decoration`, `padding`, `margin`, `textStyle`, `iconTheme`, `mouseCursor`, `transform` — `WidgetStateProperty` values for state-based styling.
- `focusNode`, `onFocus` — focus management and callbacks.
- `onHover` — hover state callback.
- `behavior` (`HitTestBehavior`) — hit testing behavior.
- `disableTransition`, `disableHoverEffect`, `disableFocusOutline` — toggles for visual behavior.
- `shortcuts`, `actions` — keyboard shortcut handling.
- `statesController` — programmatic state control.

### Callbacks

- `onPressed`, `onDoubleTap`, `onLongPress`
- `onTapDown`, `onTapUp`, `onTapCancel`
- `onSecondaryTapDown`, `onSecondaryTapUp`, `onSecondaryTapCancel`
- `onTertiaryTapDown`, `onTertiaryTapUp`, `onTertiaryTapCancel`
- `onLongPressStart`, `onLongPressUp`, `onLongPressMoveUpdate`, `onLongPressEnd`
- `onSecondaryLongPress`, `onTertiaryLongPress`
- `onHover`, `onFocus`

---

## Theming

- Use `WidgetStateProperty` values to style hover, focus, pressed, and disabled states.
- Combine with shared theme primitives for consistent surface and text styles.

---

## Accessibility

- Focus handling via `FocusNode` and `onFocus`.
- Optional focus outline via `focusOutline` and `disableFocusOutline`.
- Keyboard shortcuts are supported via `shortcuts` and `actions`.

---

## Do / Don’t

**Do**
- ✅ Use `WidgetStateProperty` to ensure clear hover/pressed feedback.
- ✅ Provide focus styling for keyboard users.

**Don’t**
- ❌ Rely on `Clickable` for complex form semantics; use form-aware controls instead.
- ❌ Disable focus outlines without providing another focus indicator.

---

## Related components

- `button`
- `hover`
- `patch`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`

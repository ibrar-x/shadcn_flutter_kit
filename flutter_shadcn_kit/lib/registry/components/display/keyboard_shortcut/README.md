# Keyboard Shortcut (`keyboard_shortcut`)

Displays keyboard shortcuts as styled keycaps.

---

## When to use

- Use this when:
  - you want to show keyboard hints in UI.
  - you need consistent keycap styling across the app.
- Avoid when:
  - a plain text label is sufficient.

---

## Install

```bash
flutter_shadcn add keyboard_shortcut
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/display/keyboard_shortcut/keyboard_shortcut.dart';
```

---

## Minimal example

```dart
KeyboardDisplay.fromActivator(
  activator: const SingleActivator(LogicalKeyboardKey.keyK, meta: true),
)
```

---

## Common patterns

### Pattern: Custom display mapper

```dart
KeyboardShortcutDisplayMapper(
  builder: (context, key) => Text(key.keyLabel.toUpperCase()),
  child: KeyboardDisplay(
    keys: const [LogicalKeyboardKey.control, LogicalKeyboardKey.keyS],
  ),
)
```

---

## API

### Constructor

- `KeyboardDisplay`
  - `KeyboardDisplay(keys: ...)`
  - `KeyboardDisplay.fromActivator(activator: ...)`
- `KeyboardKeyDisplay` — single keycap.
- `KeyboardShortcutDisplayMapper` — custom key rendering.

---

## Theming

- `KeyboardShortcutTheme` controls spacing, key padding, and key shadow.

---

## Accessibility

- Ensure shortcuts match platform conventions.

---

## Do / Don’t

**Do**
- ✅ Use `fromActivator` to keep shortcuts in sync with bindings.

**Don’t**
- ❌ Display conflicting shortcuts without clarification.

---

## Related components

- `command`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`

# Dropdown Menu (`dropdown_menu`)

Dropdown menu overlay built on menu primitives.

---

## When to use

- Use this when:
  - you need a compact dropdown for a button or field.
  - you want to reuse menu items and styling.
- Avoid when:
  - you need a full-screen sheet or dialog.

---

## Install

```bash
flutter_shadcn add dropdown_menu
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/overlay/dropdown_menu/dropdown_menu.dart';
```

---

## Minimal example

```dart
DropdownMenu(
  children: [
    MenuButton(child: const Text('New'), onPressed: (context) {}),
    MenuButton(child: const Text('Open'), onPressed: (context) {}),
  ],
)
```

---

## Common patterns

### Pattern: Show as overlay

```dart
showDropdown(
  context: context,
  builder: (context) => DropdownMenu(
    children: [
      MenuButton(child: const Text('Rename'), onPressed: (context) {}),
    ],
  ),
)
```

---

## API

### Widgets and helpers

- `DropdownMenu`
- `showDropdown`
- `DropdownMenuTheme`

---

## Theming

- `DropdownMenuTheme` controls surface blur and opacity.

---

## Accessibility

- Ensure menu items are keyboard-focusable and labeled.

---

## Do / Don’t

**Do**
- ✅ Keep menu groups short and clear.

**Don’t**
- ❌ Use dropdowns for long or nested navigation trees.

---

## Related components

- `menu`
- `popup`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`

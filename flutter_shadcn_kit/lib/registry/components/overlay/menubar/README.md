# Menubar (`menubar`)

Horizontal desktop-style menubar with dropdown menus and keyboard navigation.

---

## When to use

- Use this when:
  - you need top-level app menus (File, Edit, View).
  - you want menu items to open submenus with keyboard support.
- Avoid when:
  - a mobile-first or overflow menu is sufficient.

---

## Install

```bash
flutter_shadcn add menubar
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/overlay/menubar/menubar.dart';
```

---

## Minimal example

```dart
Menubar(
  children: [
    MenuButton(
      child: const Text('File'),
      subMenu: [
        MenuButton(child: const Text('New'), onPressed: (context) {}),
        MenuButton(child: const Text('Open'), onPressed: (context) {}),
      ],
    ),
  ],
)
```

---

## API

### Widgets and themes

- `Menubar`
- `MenubarTheme`

---

## Theming

- `MenubarTheme` controls borders, padding, and submenu offsets.

---

## Accessibility

- Ensure top-level menu items are reachable via keyboard navigation.

---

## Do / Don’t

**Do**
- ✅ Keep menus shallow and grouped.

**Don’t**
- ❌ Use menubars for primary mobile navigation.

---

## Related components

- `menu`
- `dropdown_menu`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`

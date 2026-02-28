# Popup (`popup`)

Styled popup container for menus and dropdowns.

---

## When to use

- Use this when:
  - you need a styled container for menu items.
  - you want the same surface treatment as other overlays.
- Avoid when:
  - you need a fully managed overlay (use `menu` or `dropdown_menu`).

---

## Install

```bash
flutter_shadcn add popup
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/overlay/popup/popup.dart';
```

---

## Minimal example

```dart
MenuPopup(
  children: [
    const Text('Item 1'),
    const Text('Item 2'),
  ],
)
```

---

## API

### Widgets and themes

- `MenuPopup`
- `MenuPopupTheme`

---

## Theming

- `MenuPopupTheme` controls padding, radius, and surface blur/opacity.

---

## Accessibility

- Ensure menu items are reachable via keyboard when used in overlays.

---

## Do / Don’t

**Do**
- ✅ Use inside `MenuGroup` for consistent layout.

**Don’t**
- ❌ Use as a standalone overlay without a dismissal mechanism.

---

## Related components

- `menu`
- `dropdown_menu`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`

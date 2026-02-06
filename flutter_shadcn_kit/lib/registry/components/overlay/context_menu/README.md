# Context Menu (`context_menu`)

Desktop-style context menu overlay for editable text and custom actions.

---

## When to use

- Use this when:
  - you need right-click or long-press menu actions.
  - you want consistent menu styling with `menu` primitives.
- Avoid when:
  - a simple inline menu or toolbar is enough.

---

## Install

```bash
flutter_shadcn add context_menu
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/overlay/context_menu/context_menu.dart';
```

---

## Minimal example

```dart
ContextMenu(
  items: [
    MenuButton(
      child: const Text('Copy'),
      onPressed: (context) {},
    ),
    MenuButton(
      child: const Text('Paste'),
      onPressed: (context) {},
    ),
  ],
  child: const Text('Right click me'),
)
```

---

## Common patterns

### Pattern: Custom popup anchor

```dart
ContextMenuPopup(
  anchorContext: context,
  position: const Offset(200, 200),
  children: [
    MenuButton(child: const Text('Delete'), onPressed: (context) {}),
  ],
)
```

---

## API

### Widgets

- `ContextMenu`
- `ContextMenuPopup`
- `DesktopEditableTextContextMenu`
- `MobileEditableTextContextMenu`

### Theming

- `ContextMenuTheme`

---

## Theming

- Use `ContextMenuTheme` via `ComponentTheme` to adjust blur and surface opacity.

---

## Accessibility

- Ensure menu actions can be triggered via keyboard or long-press.

---

## Do / Don’t

**Do**
- ✅ Keep menus short and grouped with dividers.

**Don’t**
- ❌ Hide critical actions solely in the context menu.

---

## Related components

- `menu`
- `dropdown_menu`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`

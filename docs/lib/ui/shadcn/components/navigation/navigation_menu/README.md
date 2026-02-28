# Navigation Menu (`navigation_menu`)

Dropdown-style navigation menu with popovers, groups, and keyboard navigation.

---

## When to use

- Use this when:
  - you need top-level navigation with dropdown content.
- Avoid when:
  - a simple link list is enough.

---

## Install

```bash
flutter_shadcn add navigation_menu
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/navigation/navigation_menu/navigation_menu.dart';
```

---

## Minimal example

```dart
NavigationMenu(
  children: const [
    NavigationMenuItem(child: Text('Products')),
  ],
)
```

---

## API

### Constructor

- `NavigationMenu`
  - `children` (`List<Widget>`, required)
  - `surfaceOpacity`, `surfaceBlur`, `margin`, `offset`
- `NavigationMenuItem` — item with optional `content`.
- `NavigationMenuContent` — content entry.
- `NavigationMenuContentList` — grid/list of contents.
- `NavigationMenuTheme` — surface styling.

---

## Theming

- `NavigationMenuTheme` controls popover surface and offsets.

---

## Accessibility

- Ensure menu items are keyboard focusable.

---

## Do / Don’t

**Do**
- ✅ Group related items with content lists.

**Don’t**
- ❌ Use overly long labels in the top bar.

---

## Related components

- `navigation_bar`
- `popover`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`

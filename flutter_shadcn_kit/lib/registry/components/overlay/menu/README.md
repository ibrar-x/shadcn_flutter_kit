# Menu (`menu`)

Menu primitives, items, and popup container.

---

## When to use

- Use this when:
  - you need reusable menu item building blocks.
  - you want to compose menus for dropdowns, context menus, or menubars.
- Avoid when:
  - a simple list of buttons is enough.

---

## Install

```bash
flutter_shadcn add menu
```

---

## Import

```dart
import 'package:<your_app>/ui/shadcn/overlay/menu/menu.dart';
```

---

## Minimal example

```dart
MenuGroup(
  direction: Axis.vertical,
  builder: (context, children) => MenuPopup(children: children),
  children: [
    MenuButton(child: const Text('New'), onPressed: (context) {}),
    MenuDivider(),
    MenuButton(child: const Text('Quit'), onPressed: (context) {}),
  ],
)
```

---

## API

### Core widgets

- `MenuItem`
- `MenuButton`
- `MenuCheckbox`
- `MenuRadio`, `MenuRadioGroup`
- `MenuLabel`
- `MenuShortcut`
- `MenuDivider`, `MenuGap`
- `MenuGroup`
- `MenuPopup`
- `Menubar`

### Theming and handlers

- `MenuTheme`
- `MenuPopupTheme`
- `MenubarTheme`
- `MenuOverlayHandler`

---

## Theming

- Use `MenuTheme` and `MenuPopupTheme` to adjust spacing, typography, and surface.

---

## Accessibility

- Menus include focus traversal and keyboard intents.

---

## Do / Don’t

**Do**
- ✅ Use `MenuGroup` to manage focus and layout.

**Don’t**
- ❌ Mix unrelated actions in the same group without dividers.

---

## Related components

- `dropdown_menu`
- `context_menu`
- `menubar`

---

## Registry rules

- One public class per file
- Helpers under `_impl/`

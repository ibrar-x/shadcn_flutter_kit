# Menu

Menu primitives for building dropdowns, context menus, and nested submenus.
Includes menu items, keyboard navigation, and a themed popup container.

## Usage

```dart
import 'package:flutter/widgets.dart';
import 'ui/shadcn/components/menu/menu.dart';

final items = [
  MenuButton(
    child: const Text('New File'),
    onPressed: (context) {},
  ),
  const MenuDivider(),
  MenuCheckbox(
    value: true,
    onChanged: (context, value) {},
    child: const Text('Show Toolbar'),
  ),
];

MenuGroup(
  direction: Axis.vertical,
  children: items,
  builder: (context, children) => MenuPopup(children: children),
);
```

## Notes

- Dependencies: `data_widget`, `gap`.
- Requires `dialog` and `drawer` for overlay context helpers.

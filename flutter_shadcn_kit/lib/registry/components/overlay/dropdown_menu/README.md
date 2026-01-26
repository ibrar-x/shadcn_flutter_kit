# Dropdown Menu

Dropdown menu overlay built on menu primitives.

## Usage

```dart
import 'package:flutter/widgets.dart';
import 'ui/shadcn/components/dropdown_menu/dropdown_menu.dart';

showDropdown<void>(
  context: context,
  builder: (context) => DropdownMenu(
    children: const [
      MenuButton(child: Text('Profile')),
      MenuButton(child: Text('Settings')),
    ],
  ),
);
```

## Notes

- Depends on `menu` and `drawer` components.

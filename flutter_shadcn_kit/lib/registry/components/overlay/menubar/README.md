# Menubar

Horizontal menubar with dropdowns, keyboard navigation, and themed borders, mirroring desktop-style menus.

```dart
import 'ui/shadcn/components/menubar/menubar.dart';

Menubar(
  border: true,
  children: [
    MenuItem(title: Text('File'), children: [MenuItem(...)]),
    MenuItem(title: Text('Edit'), ...),
  ],
);
```

Install `ComponentTheme<MenubarTheme>` to customize padding, border, and submenu offsets.

# Navigation Menu

Desktop navigation menu with popovers, groups, and keyboard navigation, ideal for app navigation panels.

```dart
import 'ui/shadcn/components/menu/navigation_menu.dart';

NavigationMenu(
  children: [
    NavigationMenuItem(
      content: NavigationMenuContent(
        title: Text('Products'),
        content: Text('Product list...'),
      ),
      child: Text('Products'),
    ),
    NavigationMenuItem(
      onPressed: () {},
      child: Text('Contact'),
    ),
  ],
);
```

Wrap with `ComponentTheme<NavigationMenuTheme>` to adjust popover surfaces, offsets, and blur.

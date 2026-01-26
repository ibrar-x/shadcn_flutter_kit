# Navigation Sidebar

Composite export for NavigationSidebar and related navigation items.

## Usage

```dart
import 'ui/shadcn/composites/navigation_sidebar/navigation_sidebar.dart';

OutlinedContainer(
  child: NavigationSidebar(
    index: 0,
    onSelected: (value) {},
    children: const [
      NavigationItem(label: Text('Home'), child: Icon(Icons.home)),
      NavigationDivider(),
      NavigationItem(label: Text('Settings'), child: Icon(Icons.settings)),
    ],
  ),
);
```

# Expandable Sidebar

Composite export for building expandable navigation rails.

## Usage

```dart
import 'ui/shadcn/composites/expandable_sidebar/expandable_sidebar.dart';

OutlinedContainer(
  child: Row(
    children: [
      NavigationRail(
        expanded: true,
        children: const [
          NavigationButton(child: Icon(Icons.menu)),
          NavigationDivider(),
        ],
      ),
      const VerticalDivider(),
      const Expanded(child: SizedBox()),
    ],
  ),
);
```

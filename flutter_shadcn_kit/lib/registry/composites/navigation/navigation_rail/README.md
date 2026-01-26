# Navigation Rail

Composite export for NavigationRail building blocks.

## Usage

```dart
import 'ui/shadcn/composites/navigation_rail/navigation_rail.dart';

NavigationRail(
  index: 0,
  onSelected: (value) {},
  children: const [
    NavigationItem(label: Text('Home'), child: Icon(Icons.home)),
    NavigationDivider(),
    NavigationLabel(child: Text('Settings')),
    NavigationItem(label: Text('Profile'), child: Icon(Icons.person)),
  ],
);
```

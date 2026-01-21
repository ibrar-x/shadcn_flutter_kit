# Navigation Bar

Responsive navigation bar with tabs, overflow handling, and surface theming.

```dart
import 'ui/shadcn/components/navigation/navigation_bar.dart';

NavigationBar(
  selectedIndex: 0,
  destinations: [
    NavigationDestination.icon(label: 'Home', icon: Icon(Icons.home)),
    NavigationDestination.icon(label: 'Search', icon: Icon(Icons.search)),
  ],
  onDestinationSelected: (index) => print('Selected $index'),
);
```

Customize through `ComponentTheme<NavigationBarTheme>` before installing.

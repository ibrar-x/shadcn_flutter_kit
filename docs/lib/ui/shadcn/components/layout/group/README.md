# GroupWidget

Absolute-position layout surface with `GroupPositioned` children.

```dart
import 'ui/shadcn/components/group/group_widget.dart';

GroupWidget(
  children: [
    GroupPositioned(
      top: 10,
      left: 10,
      child: Text('Layered text sample'),
    ),
    GroupPositioned.fromRect(
      rect: Rect.fromLTWH(20, 40, 100, 60),
      child: Container(color: Colors.blue),
    ),
  ],
);
```

Each child gets precise coordinates and optional size, while the render object handles layout/painting so the component behaves like an enhanced Stack.

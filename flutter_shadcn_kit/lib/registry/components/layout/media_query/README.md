# Media Query

Responsive helper that toggles between a primary and alternate child based
on width constraints.

## Usage

```dart
import 'package:flutter/widgets.dart';
import 'ui/shadcn/components/media_query/media_query.dart';

class Example extends StatelessWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context) {
    return const MediaQueryVisibility(
      minWidth: 600,
      child: Text('Tablet or desktop layout'),
      alternateChild: Text('Mobile layout'),
    );
  }
}
```

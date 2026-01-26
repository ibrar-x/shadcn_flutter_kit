# App

Composite app wrapper that wires the shadcn theme and overlay handlers.

## Usage

```dart
import 'ui/shadcn/composites/app/app.dart';

ShadcnApp(
  home: Scaffold(
    headers: const [
      AppBar(title: Text('Shadcn App')),
      Divider(),
    ],
    child: Center(child: Text('Hello')), 
  ),
);
```

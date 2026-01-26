# Alert

Contextual alert panels with optional destructive styling.

```dart
import 'ui/shadcn/components/alert/alert.dart';

Alert(
  leading: Icon(Icons.info_outline),
  title: Text('Heads up'),
  content: Text('This is an informational alert.'),
  trailing: IconButton(onPressed: () {}, icon: Icon(Icons.close)),
);

Alert.destructive(
  title: Text('Error occurred'),
  content: Text('Something went wrong.'),
);
```

Use `ComponentTheme<AlertTheme>` from `registry/shared/theme/theme.dart` to customize padding, colors, and borders; shared assets ensure the component installs cleanly on top of the previously initialized theme.

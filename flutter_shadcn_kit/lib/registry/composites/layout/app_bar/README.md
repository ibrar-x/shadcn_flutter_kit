# App Bar

Composite export that bundles AppBar with common outline-styled building blocks.

## Usage

```dart
import 'ui/shadcn/composites/app_bar/app_bar.dart';

OutlinedContainer(
  child: AppBar(
    title: const Text('Title'),
    trailing: [
      OutlineButton(
        density: ButtonDensity.icon,
        onPressed: () {},
        child: const Icon(Icons.more_vert),
      ),
    ],
  ),
);
```

## Included

- AppBar (from Scaffold)
- OutlinedContainer
- OutlineButton

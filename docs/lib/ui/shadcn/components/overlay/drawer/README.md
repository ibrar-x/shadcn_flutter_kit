# Drawer

Sliding overlay drawers and sheets with backdrop transforms, drag handling,
and stacked overlays.

## Usage

```dart
import 'package:flutter/widgets.dart';
import 'ui/shadcn/components/drawer/drawer.dart';

Future<void> openMenu(BuildContext context) async {
  await openDrawer<void>(
    context: context,
    position: OverlayPosition.left,
    builder: (context) => const Text('Drawer content'),
  );
}
```

## Sheets

```dart
openSheet<void>(
  context: context,
  position: OverlayPosition.bottom,
  builder: (context) => const Text('Bottom sheet'),
);
```

## Notes

- Dependencies: `data_widget`, `gap`.
- Requires the `dialog` component for `ModalBackdrop`.

# Dialog

Modal dialog primitives with a themed backdrop, container, and overlay handlers.
Includes a prebuilt `AlertDialog` for common confirmations.

## Usage

```dart
import 'package:flutter/widgets.dart';
import 'ui/shadcn/components/dialog/dialog.dart';

Future<void> showConfirm(BuildContext context) async {
  await showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Delete item?'),
      content: const Text('This action cannot be undone.'),
      actions: [
        Button.ghost(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        Button.destructive(onPressed: () => Navigator.pop(context), child: const Text('Delete')),
      ],
    ),
  );
}
```

## Overlay Handlers

```dart
const DialogOverlayHandler().show<void>(
  context: context,
  alignment: Alignment.center,
  builder: (context) => const AlertDialog(title: Text('Saved')),
);
```

## Theming

Dialogs use `shared/theme/theme.dart` for colors, spacing, and scaling. You can
override values via the local `Theme` widget.

## Notes

- Dependencies: `data_widget`.
- Requires the `card` component for `SurfaceCard`.

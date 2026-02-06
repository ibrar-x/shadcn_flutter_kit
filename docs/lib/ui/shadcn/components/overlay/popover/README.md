# Popover

Anchored overlay surfaces for menus, tooltips, and custom floating content.

## Usage

```dart
import 'package:flutter/widgets.dart';
import 'ui/shadcn/components/popover/popover.dart';

class Example extends StatelessWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = PopoverController();
    return Button.outline(
      onPressed: () {
        controller.show(
          context: context,
          builder: (context) => const Text('Popover content'),
        );
      },
      child: const Text('Open popover'),
    );
  }
}
```

## Notes

- Dependencies: `data_widget`.
- Popover primitives are implemented in shared overlay utilities.

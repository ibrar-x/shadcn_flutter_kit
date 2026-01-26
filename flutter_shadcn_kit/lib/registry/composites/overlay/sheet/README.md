# Sheet

Composite export for sheet helpers that combine forms, buttons, and drawer APIs.

## Usage

```dart
import 'ui/shadcn/composites/sheet/sheet.dart';

final controller = FormController();

await openSheet<void>(
  context: context,
  builder: (context) => Form(
    controller: controller,
    child: PrimaryButton(
      onPressed: () => closeSheet(context),
      child: const Text('Done'),
    ),
  ),
);
```

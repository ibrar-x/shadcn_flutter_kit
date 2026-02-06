# Item Picker

Scrollable picker that displays items in a grid/list with optional search, selection chips, and clear actions.

```dart
import 'ui/shadcn/components/item_picker/item_picker.dart';

ItemPicker<String>(
  items: const ['alpha', 'beta', 'gamma'],
  builder: (context, value) => Text(value),
  onChanged: (values) => print(values),
);
```

Configure `ComponentTheme<ItemPickerTheme>` for spacing, search field placement, and selection chip styling before installing.

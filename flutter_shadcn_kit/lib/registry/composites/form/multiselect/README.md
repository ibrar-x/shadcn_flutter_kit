# Multi Select

Composite export for MultiSelect helpers built on Select.

## Usage

```dart
import 'ui/shadcn/composites/multiselect/multiselect.dart';

MultiSelect<String>(
  itemBuilder: (context, item) {
    return MultiSelectChip(value: item, child: Text(item));
  },
  popup: const SelectPopup(
    items: SelectItemList(children: [
      SelectItemButton(value: 'Apple', child: Text('Apple')),
      SelectItemButton(value: 'Banana', child: Text('Banana')),
    ]),
  ),
  onChanged: (value) {},
  value: const [],
  placeholder: const Text('Select a fruit'),
);
```

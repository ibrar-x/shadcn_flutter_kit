# Radio Card

Composite export for RadioCard and RadioGroup helpers.

## Usage

```dart
import 'ui/shadcn/composites/radio_card/radio_card.dart';

RadioGroup<String>(
  value: 'a',
  onChanged: (value) {},
  children: const [
    RadioCard(value: 'a', child: Text('Option A')),
    RadioCard(value: 'b', child: Text('Option B')),
  ],
);
```

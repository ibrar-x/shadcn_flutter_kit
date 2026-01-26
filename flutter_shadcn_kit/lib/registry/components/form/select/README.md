# Select

An enhanced dropdown control with converters, popover menus, and keyboard navigation.

## Usage

```dart
import 'package:flutter/widgets.dart';
import 'ui/shadcn/components/select/select.dart';

class Example extends StatelessWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context) {
    return Select<String>(
      value: 'one',
      itemBuilder: (context, value) => Text(value),
      onChanged: (value) {},
      popup: SelectPopup.menu(),
      items: SelectItemList(children: [
        SelectItemButton(value: 'one', child: const Text('One')),
      ]),
    );
  }
}
```

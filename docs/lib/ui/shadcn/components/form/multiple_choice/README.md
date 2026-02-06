# Multiple Choice

Toggle-style grid for selecting zero, one, or multiple options with optional grouped labels and actions.

```dart
import 'ui/shadcn/components/multiple_choice/multiple_choice.dart';

MultipleChoice<int>(
  options: List.generate(3, (index) => Option(value: index, label: Text('Option $index'))),
  value: const {0},
  onChanged: (values) => print(values),
);
```

Install `ComponentTheme<MultipleChoiceTheme>` to customize spacing, mode, and density.

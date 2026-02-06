# Number Input

Composite export for numeric text fields with spinner + math formatter.

## Usage

```dart
import 'ui/shadcn/composites/number_input/number_input.dart';

TextField(
  features: const [InputFeature.spinner()],
  submitFormatters: [TextInputFormatters.mathExpression()],
);
```

# Text Field

Flexible text input with built-in features (clear, password toggle, hint popover,
autocomplete, copy/paste, and spinners) plus theme support.

## Usage

```dart
import 'package:flutter/widgets.dart';
import 'ui/shadcn/components/text_field/text_field.dart';

class Example extends StatelessWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          placeholder: const Text('Email'),
          features: const [
            InputClearFeature(),
          ],
        ),
        TextField(
          placeholder: const Text('Password'),
          obscureText: true,
          features: const [
            InputPasswordToggleFeature(),
          ],
        ),
      ],
    );
  }
}
```

## Autocomplete

```dart
TextField(
  placeholder: const Text('Fruit'),
  features: [
    InputAutoCompleteFeature(
      querySuggestions: (query) async {
        return ['apple', 'apricot', 'avocado']
            .where((item) => item.startsWith(query));
      },
      child: const Text('Suggestions'),
    ),
  ],
);
```

## Theming

The text field reads local theme values from `shared/theme/theme.dart`.
If no theme is provided, default values are used automatically.

## Notes

- Dependencies: `data_widget`.
- Install `button` as a dependency for feature widgets (icons, toggles).
- Some internal `_impl` files remain over ~300 LOC due to tightly coupled state
  management; they should be split further if you plan deeper customization.

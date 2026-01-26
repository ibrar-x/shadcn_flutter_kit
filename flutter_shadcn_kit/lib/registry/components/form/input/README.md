# Input

Feature-packed single-line text input with hint/history addons, formatting, and controlled component behavior.

```dart
import 'ui/shadcn/components/input/input.dart';

Input(
  controller: InputController(),
  label: Text('Email'),
  features: [
    InputHintFeature(
      popupBuilder: (_) => const Text('Enter your email'),
    ),
  ],
);
```

Wrap the tree with `ComponentTheme<InputTheme>` before installing to customize height, padding, and feature layouts.

# Keyboard Shortcut

Displays keyboard shortcuts as styled keycaps, with optional custom key labels.

## Usage

```dart
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'ui/shadcn/components/keyboard_shortcut/keyboard_shortcut.dart';

class Example extends StatelessWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardDisplay.fromActivator(
      activator: const SingleActivator(LogicalKeyboardKey.keyS, control: true),
    );
  }
}
```

## Custom Key Labels

```dart
KeyboardShortcutDisplayMapper(
  builder: (context, key) => Text(key.keyLabel.toUpperCase()),
  child: KeyboardDisplay(
    keys: [LogicalKeyboardKey.shift, LogicalKeyboardKey.keyP],
  ),
);
```

## Theming

Use `KeyboardShortcutTheme` via `ComponentTheme` to adjust spacing, padding, and
key shadows.

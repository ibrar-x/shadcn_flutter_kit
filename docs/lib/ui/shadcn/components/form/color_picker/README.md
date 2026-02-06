# Color Picker

Full-featured HSV/HSL/HEX color picker with history, eye-dropper, and popover/dialog presentation.

## Features

- Switch between RGB, HSL, HSV, and HEX inputs.
- Optional alpha controls and live color preview.
- Eye dropper integration and history grid.
- Popover or dialog presentation with theme overrides.

## Usage

```dart
import 'package:flutter/widgets.dart';
import 'ui/shadcn/components/color_picker/color_picker.dart';

class Example extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ColorPicker(
      value: ColorDerivative.fromColor(Colors.blue),
      onChanged: (color) => print(color.toColor()),
    );
  }
}
```

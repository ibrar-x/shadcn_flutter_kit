import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/form/color_picker/color_picker.dart'
    as shadcn_color_picker;
import '../../../../ui/shadcn/components/utility/color/color.dart'
    as shadcn_color;

const ComponentExample colorPickerBasicExample = ComponentExample(
  title: 'Basic',
  builder: _buildColorPickerBasicExample,
  code: '''ColorPicker(
  value: ColorDerivative.fromColor(Colors.blue),
  initialMode: ColorPickerMode.hsv,
)''',
);

Widget _buildColorPickerBasicExample(BuildContext context) {
  return const _ColorPickerBasicExample();
}

class _ColorPickerBasicExample extends StatefulWidget {
  const _ColorPickerBasicExample();

  @override
  State<_ColorPickerBasicExample> createState() =>
      _ColorPickerBasicExampleState();
}

class _ColorPickerBasicExampleState extends State<_ColorPickerBasicExample> {
  shadcn_color.ColorDerivative _value =
      shadcn_color.ColorDerivative.fromColor(const Color(0xff3b82f6));

  @override
  Widget build(BuildContext context) {
    return shadcn_color_picker.ColorPicker(
      value: _value,
      initialMode: shadcn_color_picker.ColorPickerMode.hsv,
      onChanged: (value) => setState(() => _value = value),
    );
  }
}

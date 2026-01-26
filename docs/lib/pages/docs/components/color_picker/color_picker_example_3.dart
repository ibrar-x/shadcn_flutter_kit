import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/form/color_picker/color_picker.dart'
    as shadcn_color_picker;
import '../../../../ui/shadcn/components/utility/color/color.dart'
    as shadcn_color;

const ComponentExample colorPickerCompactExample = ComponentExample(
  title: 'Compact layout',
  builder: _buildColorPickerCompactExample,
  code: '''ColorPicker(
  value: ColorDerivative.fromColor(Colors.teal),
  orientation: Axis.horizontal,
  sliderSize: 160,
)''',
);

Widget _buildColorPickerCompactExample(BuildContext context) {
  return const _ColorPickerCompactExample();
}

class _ColorPickerCompactExample extends StatefulWidget {
  const _ColorPickerCompactExample();

  @override
  State<_ColorPickerCompactExample> createState() =>
      _ColorPickerCompactExampleState();
}

class _ColorPickerCompactExampleState
    extends State<_ColorPickerCompactExample> {
  shadcn_color.ColorDerivative _value =
      shadcn_color.ColorDerivative.fromColor(const Color(0xff14b8a6));

  @override
  Widget build(BuildContext context) {
    return shadcn_color_picker.ColorPicker(
      value: _value,
      orientation: Axis.horizontal,
      sliderSize: 160,
      controlSpacing: 6,
      onChanged: (value) => setState(() => _value = value),
    );
  }
}

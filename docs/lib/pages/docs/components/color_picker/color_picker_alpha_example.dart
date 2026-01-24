import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/form/color_picker/color_picker.dart'
    as shadcn_color_picker;
import '../../../../ui/shadcn/components/utility/color/color.dart'
    as shadcn_color;

const ComponentExample colorPickerAlphaExample = ComponentExample(
  title: 'Alpha controls',
  builder: _buildColorPickerAlphaExample,
  code: '''ColorPicker(
  value: ColorDerivative.fromColor(Color(0x88F97316)),
  showAlpha: true,
)''',
);

Widget _buildColorPickerAlphaExample(BuildContext context) {
  return const _ColorPickerAlphaExample();
}

class _ColorPickerAlphaExample extends StatefulWidget {
  const _ColorPickerAlphaExample();

  @override
  State<_ColorPickerAlphaExample> createState() =>
      _ColorPickerAlphaExampleState();
}

class _ColorPickerAlphaExampleState extends State<_ColorPickerAlphaExample> {
  shadcn_color.ColorDerivative _value =
      shadcn_color.ColorDerivative.fromColor(const Color(0x88f97316));

  @override
  Widget build(BuildContext context) {
    return shadcn_color_picker.ColorPicker(
      value: _value,
      showAlpha: true,
      onChanged: (value) => setState(() => _value = value),
    );
  }
}

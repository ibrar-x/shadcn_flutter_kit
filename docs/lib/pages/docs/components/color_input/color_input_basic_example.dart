import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/form/color_input/color_input.dart'
    as shadcn_color_input;
import '../../../../ui/shadcn/components/utility/color/color.dart'
    as shadcn_color;

const ComponentExample colorInputBasicExample = ComponentExample(
  title: 'Basic',
  builder: _buildColorInputBasicExample,
  code: '''ColorInput(
  value: ColorDerivative.fromColor(Colors.indigo),
  onChanged: (value) {},
)''',
);

Widget _buildColorInputBasicExample(BuildContext context) {
  return const _ColorInputBasicExample();
}

class _ColorInputBasicExample extends StatefulWidget {
  const _ColorInputBasicExample();

  @override
  State<_ColorInputBasicExample> createState() =>
      _ColorInputBasicExampleState();
}

class _ColorInputBasicExampleState extends State<_ColorInputBasicExample> {
  shadcn_color.ColorDerivative _value =
      shadcn_color.ColorDerivative.fromColor(const Color(0xff6366f1));

  @override
  Widget build(BuildContext context) {
    return shadcn_color_input.ColorInput(
      value: _value,
      onChanged: (value) => setState(() => _value = value),
    );
  }
}

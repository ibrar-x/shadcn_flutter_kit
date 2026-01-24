import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/form/color_input/color_input.dart'
    as shadcn_color_input;
import '../../../../ui/shadcn/components/utility/color/color.dart'
    as shadcn_color;

const ComponentExample colorInputAlphaHistoryExample = ComponentExample(
  title: 'Alpha + history',
  builder: _buildColorInputAlphaHistoryExample,
  code: '''ColorInput(
  value: ColorDerivative.fromColor(Color(0x66F97316)),
  showAlpha: true,
  showHistory: true,
)''',
);

Widget _buildColorInputAlphaHistoryExample(BuildContext context) {
  return const _ColorInputAlphaHistoryExample();
}

class _ColorInputAlphaHistoryExample extends StatefulWidget {
  const _ColorInputAlphaHistoryExample();

  @override
  State<_ColorInputAlphaHistoryExample> createState() =>
      _ColorInputAlphaHistoryExampleState();
}

class _ColorInputAlphaHistoryExampleState
    extends State<_ColorInputAlphaHistoryExample> {
  shadcn_color.ColorDerivative _value =
      shadcn_color.ColorDerivative.fromColor(const Color(0x66f97316));

  @override
  Widget build(BuildContext context) {
    return shadcn_color_input.ColorInput(
      value: _value,
      showAlpha: true,
      showHistory: true,
      onChanged: (value) => setState(() => _value = value),
    );
  }
}

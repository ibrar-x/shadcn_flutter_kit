import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/form/color_input/color_input.dart'
    as shadcn_color_input;
import '../../../../ui/shadcn/components/utility/color/color.dart'
    as shadcn_color;
import '../../../../ui/shadcn/shared/theme/theme.dart' as shadcn_theme;

const ComponentExample colorInputInlineExample = ComponentExample(
  title: 'Inline picker',
  builder: _buildColorInputInlineExample,
  code: '''ComponentTheme<ColorInputTheme>(
  data: ColorInputTheme(orientation: Axis.horizontal, showLabel: false),
  child: ColorInput(value: ColorDerivative.fromColor(Colors.teal)),
)''',
);

Widget _buildColorInputInlineExample(BuildContext context) {
  return const _ColorInputInlineExample();
}

class _ColorInputInlineExample extends StatefulWidget {
  const _ColorInputInlineExample();

  @override
  State<_ColorInputInlineExample> createState() =>
      _ColorInputInlineExampleState();
}

class _ColorInputInlineExampleState extends State<_ColorInputInlineExample> {
  shadcn_color.ColorDerivative _value =
      shadcn_color.ColorDerivative.fromColor(const Color(0xff14b8a6));

  @override
  Widget build(BuildContext context) {
    return shadcn_theme.ComponentTheme<shadcn_color_input.ColorInputTheme>(
      data: const shadcn_color_input.ColorInputTheme(
        orientation: Axis.horizontal,
        showLabel: false,
        enableEyeDropper: false,
      ),
      child: shadcn_color_input.ColorInput(
        value: _value,
        onChanged: (value) => setState(() => _value = value),
      ),
    );
  }
}

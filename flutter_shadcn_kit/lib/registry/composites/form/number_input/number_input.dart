import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../../components/form/formatter/formatter.dart' as formatter;
import '../../../components/form/text_field/text_field.dart' as field;

typedef TextField = field.TextField;
typedef InputFeature = field.InputFeature;
typedef TextInputFormatters = formatter.TextInputFormatters;

class NumberInput extends StatelessWidget {
  const NumberInput({
    super.key,
    this.value,
    this.onChanged,
    this.onSubmitted,
    this.step = 1,
    this.invalidValue,
    this.enableMathExpression = true,
    this.features = const [],
    this.inputFormatters,
    this.submitFormatters,
    this.placeholder,
  });

  final double? value;
  final ValueChanged<double>? onChanged;
  final ValueChanged<double>? onSubmitted;
  final double step;
  final double? invalidValue;
  final bool enableMathExpression;
  final List<InputFeature> features;
  final List<TextInputFormatter>? inputFormatters;
  final List<TextInputFormatter>? submitFormatters;
  final Widget? placeholder;

  double _parseValue(String text) {
    return double.tryParse(text) ?? invalidValue ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    final baseSubmitFormatters =
        submitFormatters ??
        (enableMathExpression
            ? [TextInputFormatters.mathExpression()]
            : const <TextInputFormatter>[]);
    return TextField(
      initialValue: value?.toString(),
      onChanged: onChanged == null
          ? null
          : (text) {
              onChanged?.call(_parseValue(text));
            },
      onSubmitted: onSubmitted == null
          ? null
          : (text) {
              onSubmitted?.call(_parseValue(text));
            },
      placeholder: placeholder,
      inputFormatters: inputFormatters,
      submitFormatters: baseSubmitFormatters,
      features: [
        InputFeature.spinner(step: step, invalidValue: invalidValue),
        ...features,
      ],
    );
  }
}

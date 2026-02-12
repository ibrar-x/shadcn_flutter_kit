import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../../components/form/formatter/formatter.dart' as formatter;
import '../../../components/form/text_field/text_field.dart' as field;

/// Type alias for `TextField` used by public or internal APIs.
typedef TextField = field.TextField;
/// Type alias for `InputFeature` used by public or internal APIs.
typedef InputFeature = field.InputFeature;
/// Type alias for `TextInputFormatters` used by public or internal APIs.
typedef TextInputFormatters = formatter.TextInputFormatters;

/// NumberInput defines a reusable type for this registry module.
class NumberInput extends StatelessWidget {
/// Creates a `NumberInput` instance.
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

/// Stores `value` state/configuration for this implementation.
  final double? value;
/// Stores `onChanged` state/configuration for this implementation.
  final ValueChanged<double>? onChanged;
/// Stores `onSubmitted` state/configuration for this implementation.
  final ValueChanged<double>? onSubmitted;
/// Stores `step` state/configuration for this implementation.
  final double step;
/// Stores `invalidValue` state/configuration for this implementation.
  final double? invalidValue;
/// Stores `enableMathExpression` state/configuration for this implementation.
  final bool enableMathExpression;
/// Stores `features` state/configuration for this implementation.
  final List<InputFeature> features;
/// Stores `inputFormatters` state/configuration for this implementation.
  final List<TextInputFormatter>? inputFormatters;
/// Stores `submitFormatters` state/configuration for this implementation.
  final List<TextInputFormatter>? submitFormatters;
/// Stores `placeholder` state/configuration for this implementation.
  final Widget? placeholder;

/// Executes `_parseValue` behavior for this component/composite.
  double _parseValue(String text) {
    return double.tryParse(text) ?? invalidValue ?? 0;
  }

  @override
/// Executes `build` behavior for this component/composite.
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
/// Creates a `InputFeature.spinner` instance.
        InputFeature.spinner(step: step, invalidValue: invalidValue),
        ...features,
      ],
    );
  }
}

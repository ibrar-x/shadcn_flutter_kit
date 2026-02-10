part of '../../input.dart';

class _InputStepperButtonFeatureState
    extends InputFeatureState<InputStepperButtonFeature> {
  double _clampValue(double value) {
    final min = feature.min;
    final max = feature.max;
    if (min != null && value < min) {
      return min;
    }
    if (max != null && value > max) {
      return max;
    }
    return value;
  }

  double? _effectiveValue() {
    final value = double.tryParse(controller.text);
    return value ?? feature.invalidValue;
  }

  bool _canApplyStep(double? value) {
    if (value == null) return false;
    final step = feature.step;
    final min = feature.min;
    final max = feature.max;
    if (step >= 0) {
      return max == null || value < max;
    }
    return min == null || value > min;
  }

  void _replaceText(UnaryOperator<String> replacer) {
    var controller = this.controller;
    var text = controller.text;
    var newText = replacer(text);
    if (newText != text) {
      controller.text = newText;
      input.onChanged?.call(newText);
    }
  }

  String _newText(double value) {
    String newText = value.toString();
    if (newText.contains('.')) {
      while (newText.endsWith('0')) {
        newText = newText.substring(0, newText.length - 1);
      }
      if (newText.endsWith('.')) {
        newText = newText.substring(0, newText.length - 1);
      }
    }
    return newText;
  }

  void _increase() {
    _replaceText((text) {
      var value = double.tryParse(text);
      if (value == null) {
        if (feature.invalidValue != null) {
          return _newText(_clampValue(feature.invalidValue!));
        }
        return text;
      }
      return _newText(_clampValue(value + feature.step));
    });
  }

  Widget _buildButton() {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, child) {
        final currentValue = _effectiveValue();
        final clampedValue = currentValue == null
            ? null
            : _clampValue(currentValue);
        final canApplyStep = _canApplyStep(clampedValue);
        return AspectRatio(
          aspectRatio: 1,
          child: IconButton.outline(
            icon: feature.icon ?? const Icon(LucideIcons.plus),
            onPressed: canApplyStep ? _increase : null,
            density: ButtonDensity.compact,
            size: ButtonSize.small,
          ),
        );
      },
    );
  }

  @override
  Iterable<Widget> buildTrailing() sync* {
    if (feature.position == InputFeaturePosition.trailing) {
      yield _buildButton();
    }
  }

  @override
  Iterable<Widget> buildLeading() sync* {
    if (feature.position == InputFeaturePosition.leading) {
      yield _buildButton();
    }
  }
}

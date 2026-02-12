part of '../../input.dart';

class _InputStepperButtonFeatureState
    extends InputFeatureState<InputStepperButtonFeature> {
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
          return _newText(feature.invalidValue!);
        }
        return text;
      }
      return _newText(value + feature.step);
    });
  }

  Widget _buildButton() {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, child) {
        final theme = Theme.of(context);
        return SizedBox.square(
          dimension: 32 * theme.scaling,
          child: IconButton.outline(
            icon: feature.icon ?? const Icon(LucideIcons.plus),
            onPressed: _increase,
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

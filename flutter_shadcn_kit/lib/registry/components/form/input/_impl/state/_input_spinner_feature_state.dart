part of '../../input.dart';

class _InputSpinnerFeatureState extends InputFeatureState<InputSpinnerFeature> {
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

  bool _canIncrease(double? value) {
    if (value == null) return false;
    final max = feature.max;
    return max == null || value < max;
  }

  bool _canDecrease(double? value) {
    if (value == null) return false;
    final min = feature.min;
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

  void _decrease() {
    _replaceText((text) {
      var value = double.tryParse(text);
      if (value == null) {
        if (feature.invalidValue != null) {
          return _newText(_clampValue(feature.invalidValue!));
        }
        return text;
      }
      return _newText(_clampValue(value - feature.step));
    });
  }

  Widget _wrapGesture(Widget child) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        if (details.delta.dy < 0) {
          _increase();
        } else {
          _decrease();
        }
      },
      child: child,
    );
  }

  Widget _buildButtons() {
    return Builder(
      builder: (context) {
        final theme = Theme.of(context);
        return ValueListenableBuilder<TextEditingValue>(
          valueListenable: controller,
          builder: (context, value, child) {
            final currentValue = _effectiveValue();
            final clampedValue = currentValue == null
                ? null
                : _clampValue(currentValue);
            final canIncrease = _canIncrease(clampedValue);
            final canDecrease = _canDecrease(clampedValue);
            return Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                IconButton.text(
                  icon: Transform.translate(
                    offset: Offset(0, -1 * theme.scaling),
                    child: Transform.scale(
                      alignment: Alignment.center,
                      scale: 1.5,
                      child: const Icon(LucideIcons.chevronUp),
                    ),
                  ),
                  onPressed: canIncrease ? _increase : null,
                  density: ButtonDensity.compact,
                  size: ButtonSize.xSmall,
                ),
                IconButton.text(
                  icon: Transform.translate(
                    offset: Offset(0, 1 * theme.scaling),
                    child: Transform.scale(
                      alignment: Alignment.center,
                      scale: 1.5,
                      child: const Icon(LucideIcons.chevronDown),
                    ),
                  ),
                  onPressed: canDecrease ? _decrease : null,
                  density: ButtonDensity.compact,
                  size: ButtonSize.xSmall,
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Iterable<Widget> buildTrailing() sync* {
    if (feature.enableGesture) {
      yield _wrapGesture(_buildButtons());
    } else {
      yield _buildButtons();
    }
  }
}

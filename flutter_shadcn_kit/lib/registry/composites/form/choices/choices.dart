import 'package:flutter/widgets.dart';

import '../../../components/form/multiple_choice/multiple_choice.dart'
    /// Stores `choice` state/configuration for this implementation.
    as choice;

export '../../../components/form/multiple_choice/multiple_choice.dart';

/// Descriptor for [Choices] options.
class ChoiceOption<T> {
  /// Creates a `ChoiceOption` instance.
  const ChoiceOption({required this.value, required this.label});

  /// Stores `value` state/configuration for this implementation.
  final T value;

  /// Stores `label` state/configuration for this implementation.
  final Widget label;
}

/// A ready-to-use single-choice composite built on top of `MultipleChoice`.
class Choices<T> extends StatefulWidget {
  /// Creates a `Choices` instance.
  const Choices({
    super.key,
    required this.options,
    this.value,
    this.initialValue,
    this.onChanged,
    this.enabled,
    this.allowUnselect,
    this.spacing = 8,
    this.runSpacing = 8,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    this.borderRadius = const BorderRadius.all(Radius.circular(999)),
    this.selectedColor = const Color(0xFFE7F0FF),
    this.unselectedColor = const Color(0xFFF3F4F6),
    this.selectedBorderColor = const Color(0xFF3B82F6),
    this.unselectedBorderColor = const Color(0xFFD1D5DB),
  }) : assert(options.length > 0, 'options cannot be empty.');

  /// Stores `options` state/configuration for this implementation.
  final List<ChoiceOption<T>> options;

  /// Stores `value` state/configuration for this implementation.
  final T? value;

  /// Stores `initialValue` state/configuration for this implementation.
  final T? initialValue;

  /// Stores `onChanged` state/configuration for this implementation.
  final ValueChanged<T?>? onChanged;

  /// Stores `enabled` state/configuration for this implementation.
  final bool? enabled;

  /// Stores `allowUnselect` state/configuration for this implementation.
  final bool? allowUnselect;

  /// Stores `spacing` state/configuration for this implementation.
  final double spacing;

  /// Stores `runSpacing` state/configuration for this implementation.
  final double runSpacing;

  /// Stores `padding` state/configuration for this implementation.
  final EdgeInsetsGeometry padding;

  /// Stores `borderRadius` state/configuration for this implementation.
  final BorderRadiusGeometry borderRadius;

  /// Stores `selectedColor` state/configuration for this implementation.
  final Color selectedColor;

  /// Stores `unselectedColor` state/configuration for this implementation.
  final Color unselectedColor;

  /// Stores `selectedBorderColor` state/configuration for this implementation.
  final Color selectedBorderColor;

  /// Stores `unselectedBorderColor` state/configuration for this implementation.
  final Color unselectedBorderColor;

  @override
  /// Executes `createState` behavior for this component/composite.
  State<Choices<T>> createState() => _ChoicesState<T>();
}

class _ChoicesState<T> extends State<Choices<T>> {
  T? _value;

  T? get _effectiveValue => widget.value ?? _value;

  @override
  /// Executes `initState` behavior for this component/composite.
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  /// Executes `didUpdateWidget` behavior for this component/composite.
  void didUpdateWidget(covariant Choices<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value == null && oldWidget.initialValue != widget.initialValue) {
      _value = widget.initialValue;
    }
  }

  /// Executes `_handleChanged` behavior for this component/composite.
  void _handleChanged(T? next) {
    if (widget.value == null) {
      setState(() {
        _value = next;
      });
    }
    widget.onChanged?.call(next);
  }

  /// Executes `_buildChoiceTile` behavior for this component/composite.
  Widget _buildChoiceTile(ChoiceOption<T> option) {
    return Builder(
      builder: (context) {
        final selected =
            choice.Choice.getValue<T>(context)?.contains(option.value) ?? false;
        return GestureDetector(
          onTap: () => choice.Choice.choose<T>(context, option.value),
          child: Container(
            padding: widget.padding,
            decoration: BoxDecoration(
              color: selected ? widget.selectedColor : widget.unselectedColor,
              borderRadius: widget.borderRadius,
              border: Border.all(
                color: selected
                    ? widget.selectedBorderColor
                    : widget.unselectedBorderColor,
              ),
            ),
            child: option.label,
          ),
        );
      },
    );
  }

  @override
  /// Executes `build` behavior for this component/composite.
  Widget build(BuildContext context) {
    return choice.MultipleChoice<T>(
      value: _effectiveValue,
      onChanged: _handleChanged,
      enabled: widget.enabled,
      allowUnselect: widget.allowUnselect,
      child: Wrap(
        spacing: widget.spacing,
        runSpacing: widget.runSpacing,
        children: [
          for (final option in widget.options) _buildChoiceTile(option),
        ],
      ),
    );
  }
}

import 'package:flutter/widgets.dart';

import '../../../components/form/radio_group/radio_group.dart' as radio;

/// Type alias for `RadioCard` used by public or internal APIs.
typedef RadioCard<T> = radio.RadioCard<T>;

/// Type alias for `RadioGroup` used by public or internal APIs.
typedef RadioGroup<T> = radio.RadioGroup<T>;

/// Type alias for `RadioGroupController` used by public or internal APIs.
typedef RadioGroupController<T> = radio.RadioGroupController<T>;

/// Type alias for `RadioItem` used by public or internal APIs.
typedef RadioItem<T> = radio.RadioItem<T>;

/// Descriptor for [RadioCardGroup] options.
class RadioCardOption<T> {
  /// Creates a `RadioCardOption` instance.
  const RadioCardOption({required this.value, required this.child});

  /// Stores `value` state/configuration for this implementation.
  final T value;

  /// Stores `child` state/configuration for this implementation.
  final Widget child;
}

/// Standalone composite widget for rendering selectable radio cards.
class RadioCardGroup<T> extends StatefulWidget {
  /// Creates a `RadioCardGroup` instance.
  const RadioCardGroup({
    super.key,
    required this.options,
    this.value,
    this.initialValue,
    this.onChanged,
    this.enabled,
    this.spacing = 8,
  }) : assert(options.length > 0, 'options cannot be empty.');

  /// Stores `options` state/configuration for this implementation.
  final List<RadioCardOption<T>> options;

  /// Stores `value` state/configuration for this implementation.
  final T? value;

  /// Stores `initialValue` state/configuration for this implementation.
  final T? initialValue;

  /// Stores `onChanged` state/configuration for this implementation.
  final ValueChanged<T>? onChanged;

  /// Stores `enabled` state/configuration for this implementation.
  final bool? enabled;

  /// Stores `spacing` state/configuration for this implementation.
  final double spacing;

  @override
  /// Executes `createState` behavior for this component/composite.
  State<RadioCardGroup<T>> createState() => _RadioCardGroupState<T>();
}

class _RadioCardGroupState<T> extends State<RadioCardGroup<T>> {
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
  void didUpdateWidget(covariant RadioCardGroup<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value == null && oldWidget.initialValue != widget.initialValue) {
      _value = widget.initialValue;
    }
  }

  /// Executes `_handleChanged` behavior for this component/composite.
  void _handleChanged(T next) {
    if (widget.value == null) {
      setState(() {
        _value = next;
      });
    }
    widget.onChanged?.call(next);
  }

  @override
  /// Executes `build` behavior for this component/composite.
  Widget build(BuildContext context) {
    return RadioGroup<T>(
      value: _effectiveValue,
      onChanged: _handleChanged,
      enabled: widget.enabled,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (int i = 0; i < widget.options.length; i++) ...[
            RadioCard<T>(
              value: widget.options[i].value,
              enabled: widget.enabled ?? true,
              child: widget.options[i].child,
            ),
            if (i < widget.options.length - 1) SizedBox(height: widget.spacing),
          ],
        ],
      ),
    );
  }
}

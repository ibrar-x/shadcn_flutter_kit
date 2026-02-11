import 'package:flutter/widgets.dart';

import '../../../components/form/select/select.dart' as select;

/// Type alias for `MultiSelect` used by public or internal APIs.
typedef MultiSelect<T> = select.MultiSelect<T>;

/// Type alias for `MultiSelectChip` used by public or internal APIs.
typedef MultiSelectChip = select.MultiSelectChip;

/// Type alias for `MultiSelectController` used by public or internal APIs.
typedef MultiSelectController<T> = select.MultiSelectController<T>;

/// Type alias for `SelectPopup` used by public or internal APIs.
typedef SelectPopup = select.SelectPopup;

/// Type alias for `SelectItemList` used by public or internal APIs.
typedef SelectItemList = select.SelectItemList;

/// Type alias for `SelectItemButton` used by public or internal APIs.
typedef SelectItemButton = select.SelectItemButton;

/// Descriptor for [MultiSelectField] options.
class MultiSelectOption<T> {
  /// Creates a `MultiSelectOption` instance.
  const MultiSelectOption({required this.value, required this.label});

  /// Stores `value` state/configuration for this implementation.
  final T value;

  /// Stores `label` state/configuration for this implementation.
  final Widget label;
}

/// Standalone, installable multiselect composite with prebuilt popup items.
class MultiSelectField<T> extends StatefulWidget {
  /// Creates a `MultiSelectField` instance.
  const MultiSelectField({
    super.key,
    required this.options,
    this.value,
    this.initialValue,
    this.onChanged,
    this.placeholder = const Text('Select options'),
    this.enabled,
    this.popupConstraints,
  }) : assert(options.length > 0, 'options cannot be empty.');

  /// Stores `options` state/configuration for this implementation.
  final List<MultiSelectOption<T>> options;

  /// Stores `value` state/configuration for this implementation.
  final Iterable<T>? value;

  /// Stores `initialValue` state/configuration for this implementation.
  final Iterable<T>? initialValue;

  /// Stores `onChanged` state/configuration for this implementation.
  final ValueChanged<Iterable<T>?>? onChanged;

  /// Stores `placeholder` state/configuration for this implementation.
  final Widget placeholder;

  /// Stores `enabled` state/configuration for this implementation.
  final bool? enabled;

  /// Stores `popupConstraints` state/configuration for this implementation.
  final BoxConstraints? popupConstraints;

  @override
  /// Executes `createState` behavior for this component/composite.
  State<MultiSelectField<T>> createState() => _MultiSelectFieldState<T>();
}

class _MultiSelectFieldState<T> extends State<MultiSelectField<T>> {
  Iterable<T>? _value;

  Iterable<T>? get _effectiveValue => widget.value ?? _value;

  @override
  /// Executes `initState` behavior for this component/composite.
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  /// Executes `didUpdateWidget` behavior for this component/composite.
  void didUpdateWidget(covariant MultiSelectField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value == null && oldWidget.initialValue != widget.initialValue) {
      _value = widget.initialValue;
    }
  }

  /// Executes `_handleChanged` behavior for this component/composite.
  void _handleChanged(Iterable<T>? next) {
    if (widget.value == null) {
      setState(() {
        _value = next;
      });
    }
    widget.onChanged?.call(next);
  }

  /// Executes `_findLabel` behavior for this component/composite.
  Widget _findLabel(T item) {
    for (final option in widget.options) {
      if (option.value == item) {
        return option.label;
      }
    }
    return Text(item.toString());
  }

  @override
  /// Executes `build` behavior for this component/composite.
  Widget build(BuildContext context) {
    return MultiSelect<T>(
      value: _effectiveValue,
      onChanged: _handleChanged,
      enabled: widget.enabled,
      placeholder: widget.placeholder,
      popupConstraints: widget.popupConstraints,
      itemBuilder: (context, item) =>
          MultiSelectChip(value: item, child: _findLabel(item)),
      popup: SelectPopup(
        items: SelectItemList(
          children: [
            for (final option in widget.options)
              SelectItemButton(value: option.value, child: option.label),
          ],
        ),
      ).call,
    );
  }
}

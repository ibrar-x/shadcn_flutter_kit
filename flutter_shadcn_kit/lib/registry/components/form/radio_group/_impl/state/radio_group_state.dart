part of '../../radio_group.dart';

/// State class for [RadioGroup] with form integration.
///
/// Manages selection state and integrates with the form validation system.
class RadioGroupState<T> extends State<RadioGroup<T>>
    with FormValueSupplier<T, RadioGroup<T>> {
  /// Whether the radio group is currently enabled.
  bool get enabled => widget.enabled ?? widget.onChanged != null;
  void _setSelected(T value) {
    if (!enabled) return;
    if (widget.value != value) {
      widget.onChanged?.call(value);
    }
  }

  @override
  void initState() {
    super.initState();
    formValue = widget.value;
  }

  @override
  void didUpdateWidget(covariant RadioGroup<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      formValue = widget.value;
    }
  }

  @override
  void didReplaceFormValue(T value) {
    widget.onChanged?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    return FocusableActionDetector(
      child: Data.inherit(
        data: this,
        child: Data.inherit(
          data: RadioGroupData<T>(widget.value, enabled),
          child: FocusTraversalGroup(child: widget.child),
        ),
      ),
    );
  }
}

part of '../../date_picker.dart';

/// A controlled date picker widget with comprehensive date selection features.
///
/// [ControlledDatePicker] provides a complete date selection interface with
/// customizable presentation modes (popover or modal), calendar views, and
/// flexible positioning. It integrates with [DatePickerController] for
/// programmatic control.
///
/// Features:
/// - Multiple presentation modes (popover, modal)
/// - Various calendar views (month, year, decade)
/// - Custom date state builders
/// - Flexible positioning
/// - Optional placeholder when no date is selected
///
/// Example:
/// ```dart
/// ControlledDatePicker(
///   initialValue: DateTime.now(),
///   onChanged: (date) {
///     print('Selected: $date');
///   },
///   placeholder: Text('Select a date'),
/// )
/// ```
class ControlledDatePicker extends StatelessWidget
    with ControlledComponent<DateTime?> {
  @override

  /// The initial date value.
  final DateTime? initialValue;

  @override

  /// Called when the selected date changes.
  final ValueChanged<DateTime?>? onChanged;

  @override

  /// Whether the date picker is enabled.
  final bool enabled;

  @override

  /// Optional controller for programmatic access.
  final DatePickerController? controller;

  /// Widget displayed when no date is selected.
  final Widget? placeholder;

  /// Presentation mode (popover or modal).
  final PromptMode? mode;

  /// Initial calendar view to display.
  final CalendarView? initialView;

  /// Popover alignment relative to the anchor.
  final AlignmentGeometry? popoverAlignment;

  /// Anchor alignment for popover positioning.
  final AlignmentGeometry? popoverAnchorAlignment;

  /// Internal padding for the popover.
  final EdgeInsetsGeometry? popoverPadding;

  /// Title for the dialog when using modal mode.
  final Widget? dialogTitle;

  /// Initial calendar view type.
  final CalendarViewType? initialViewType;

  /// Builder for customizing date cell states.
  final DateStateBuilder? stateBuilder;

  /// Creates a [ControlledDatePicker].
  const ControlledDatePicker({
    super.key,
    this.controller,
    this.initialValue,
    this.onChanged,
    this.enabled = true,
    this.placeholder,
    this.mode,
    this.initialView,
    this.popoverAlignment,
    this.popoverAnchorAlignment,
    this.popoverPadding,
    this.dialogTitle,
    this.initialViewType,
    this.stateBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return ControlledComponentAdapter(
      controller: controller,
      initialValue: initialValue,
      onChanged: onChanged,
      enabled: enabled,
      builder: (context, data) {
        return DatePicker(
          enabled: data.enabled,
          value: data.value,
          onChanged: data.onChanged,
          placeholder: placeholder,
          mode: mode,
          initialView: initialView,
          popoverAlignment: popoverAlignment,
          popoverAnchorAlignment: popoverAnchorAlignment,
          popoverPadding: popoverPadding,
          dialogTitle: dialogTitle,
          initialViewType: initialViewType,
          stateBuilder: stateBuilder,
        );
      },
    );
  }
}

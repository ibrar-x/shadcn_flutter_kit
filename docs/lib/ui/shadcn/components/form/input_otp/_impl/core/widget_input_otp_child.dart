part of '../../input_otp.dart';

/// A widget-based OTP child that doesn't accept input.
///
/// Used for displaying static content like separators or spacers within
/// an [InputOTP] widget. This child does not hold any value.
///
/// Example:
/// ```dart
/// WidgetInputOTPChild(
///   Icon(Icons.arrow_forward),
/// )
/// ```
class WidgetInputOTPChild extends InputOTPChild {
  /// The widget to display.
  final Widget child;

  /// Creates a [WidgetInputOTPChild].
  ///
  /// Parameters:
  /// - [child] (`Widget`, required): The widget to display.
  const WidgetInputOTPChild(this.child);

  @override
  Widget build(BuildContext context, InputOTPChildData data) {
    final theme = Theme.of(context);
    return SizedBox(
      width: theme.scaling * 32,
      height: theme.scaling * 32,
      child: Center(
        child: child,
      ),
    );
  }

  @override
  bool get hasValue => false;
}

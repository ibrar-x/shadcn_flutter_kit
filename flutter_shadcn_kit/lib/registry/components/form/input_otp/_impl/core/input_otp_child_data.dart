part of '../../input_otp.dart';

/// Data passed to [InputOTPChild.build] for rendering OTP input fields.
///
/// Contains information about focus nodes, index positions, current value,
/// and callbacks for changing values. Used internally by [InputOTP] to
/// coordinate input fields.
class InputOTPChildData {
  /// Focus node for the previous input field.
  final FocusNode? previousFocusNode;

  /// Focus node for this input field.
  final FocusNode? focusNode;

  /// Focus node for the next input field.
  final FocusNode? nextFocusNode;

  /// Overall index within all OTP children.
  final int index;

  /// Index of the group this child belongs to.
  final int groupIndex;

  /// Total number of children in this group.
  final int groupLength;

  /// Relative index within the group.
  final int relativeIndex;

  /// Current value (codepoint) of this input field.
  final int? value;

  final _InputOTPState _state;
  final GlobalKey<_OTPCharacterInputState>? _key;

  InputOTPChildData._(
    this._state,
    this._key, {
    required this.focusNode,
    required this.index,
    required this.groupIndex,
    required this.relativeIndex,
    required this.groupLength,
    this.previousFocusNode,
    this.nextFocusNode,
    this.value,
  });

  /// Updates the value for this OTP input field.
  ///
  /// Parameters:
  /// - [value] (`int?`, required): The new codepoint value or null.
  void changeValue(int? value) {
    _state._changeValue(index, value);
  }
}

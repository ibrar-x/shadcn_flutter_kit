part of '../../input_otp.dart';

class _InputOTPChild {
  int? value;
  final FocusNode focusNode;
  final int groupIndex;
  final int relativeIndex;
  final InputOTPChild child;
  int groupLength = 0;
  final GlobalKey<_OTPCharacterInputState> key;

  _InputOTPChild({
    required this.focusNode,
    required this.child,
    this.value,
    required this.groupIndex,
    required this.relativeIndex,
  }) : key = GlobalKey<_OTPCharacterInputState>();

  _InputOTPChild.withNewChild(_InputOTPChild old, InputOTPChild newChild)
      : focusNode = old.focusNode,
        value = old.value,
        groupIndex = old.groupIndex,
        relativeIndex = old.relativeIndex,
        child = newChild,
        groupLength = old.groupLength,
        key = old.key;
}

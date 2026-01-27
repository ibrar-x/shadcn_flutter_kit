part of '../../input_otp.dart';

class _OTPCharacterInput extends StatefulWidget {
  final InputOTPChildData data;
  final CodepointPredicate? predicate;
  final CodepointUnaryOperator? transform;
  final bool obscured;
  final bool readOnly;
  final TextInputType? keyboardType;

  const _OTPCharacterInput({
    super.key,
    required this.data,
    this.predicate,
    this.transform,
    this.obscured = false,
    this.readOnly = false,
    this.keyboardType,
  });

  @override
  State<_OTPCharacterInput> createState() => _OTPCharacterInputState();
}

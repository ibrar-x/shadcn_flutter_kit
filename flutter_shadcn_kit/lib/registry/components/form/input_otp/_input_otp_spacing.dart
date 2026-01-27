part of 'input_otp.dart';

class _InputOTPSpacing extends StatelessWidget {
  const _InputOTPSpacing();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final compTheme = ComponentTheme.maybeOf<InputOTPTheme>(context);
    return SizedBox(width: compTheme?.spacing ?? theme.scaling * 8);
  }
}

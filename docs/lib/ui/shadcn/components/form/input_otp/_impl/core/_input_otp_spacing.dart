part of '../../input_otp.dart';

/// _InputOTPSpacing renders form UI and wires input behavior.
class _InputOTPSpacing extends StatelessWidget {
  const _InputOTPSpacing();

  /// Builds the widget tree for this component state.
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final compTheme = ComponentTheme.maybeOf<InputOTPTheme>(context);
    return SizedBox(
      width:
          compTheme?.spacing ?? theme.density.baseGap * theme.scaling * gapSm,
    );
  }
}

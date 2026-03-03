part of '../../app.dart';

/// A widget that applies shadcn text + icon styles to descendants.
class ShadcnUI extends StatelessWidget {
  const ShadcnUI({super.key, this.textStyle, required this.child});

  final TextStyle? textStyle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backgroundIsDark =
        theme.colorScheme.background.computeLuminance() < 0.5;
    final iconColor =
        backgroundIsDark ? const Color(0xFFFFFFFF) : const Color(0xFF000000);
    return AnimatedDefaultTextStyle(
      style: textStyle ??
          theme.typography.sans.copyWith(color: theme.colorScheme.foreground),
      duration: kDefaultDuration,
      child: IconTheme(
        data: IconThemeData(color: iconColor),
        child: child,
      ),
    );
  }
}

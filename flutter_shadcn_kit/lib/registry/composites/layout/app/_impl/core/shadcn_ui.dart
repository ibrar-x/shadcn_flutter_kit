part of '../../app.dart';

/// ShadcnUI defines a reusable type for this registry module.
class ShadcnUI extends StatelessWidget {
/// Creates a `ShadcnUI` instance.
  const ShadcnUI({
    super.key,
    this.textStyle,
    required this.child,
  });

/// Stores `textStyle` state/configuration for this implementation.
  final TextStyle? textStyle;
/// Stores `child` state/configuration for this implementation.
  final Widget child;

  @override
/// Executes `build` behavior for this component/composite.
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backgroundIsDark = theme.colorScheme.background.computeLuminance() < 0.5;
    final foregroundIsDark = theme.colorScheme.foreground.computeLuminance() < 0.5;
    final iconColor = backgroundIsDark && foregroundIsDark
        ? const Color(0xFFF5F5F5)
        : theme.colorScheme.foreground;
    return AnimatedDefaultTextStyle(
      style: textStyle ??
          theme.typography.sans.copyWith(
            color: theme.colorScheme.foreground,
          ),
      duration: kDefaultDuration,
      child: IconTheme(
        data: IconThemeData(color: iconColor),
        child: child,
      ),
    );
  }
}

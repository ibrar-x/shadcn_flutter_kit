part of '../../app.dart';

class ShadcnUI extends StatelessWidget {
  const ShadcnUI({
    super.key,
    this.textStyle,
    required this.child,
  });

  final TextStyle? textStyle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedDefaultTextStyle(
      style: textStyle ??
          theme.typography.sans.copyWith(
            color: theme.colorScheme.foreground,
          ),
      duration: kDefaultDuration,
      child: IconTheme(
        data: IconThemeData(color: theme.colorScheme.foreground),
        child: child,
      ),
    );
  }
}

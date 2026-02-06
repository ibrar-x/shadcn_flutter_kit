part of '../../badge.dart';

/// A destructive-styled badge for displaying warnings or dangerous actions.
class DestructiveBadge extends StatelessWidget {
  /// The main content of the badge.
  final Widget child;

  /// Optional callback when the badge is pressed.
  final VoidCallback? onPressed;

  /// Optional widget displayed before the child content.
  final Widget? leading;

  /// Optional widget displayed after the child content.
  final Widget? trailing;

  /// Optional custom style override for the badge.
  final AbstractButtonStyle? style;

  /// Creates a destructive badge with the specified child content.
  const DestructiveBadge({
    super.key,
    required this.child,
    this.onPressed,
    this.leading,
    this.trailing,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final compTheme = ComponentTheme.maybeOf<BadgeTheme>(context);
    final baseStyle = style ??
        compTheme?.destructiveStyle ??
        const ButtonStyle.destructive(
          size: ButtonSize.small,
          density: ButtonDensity.dense,
          shape: ButtonShape.rectangle,
        ).copyWith(
          textStyle: (context, states, value) {
            return value.copyWith(fontWeight: FontWeight.w500);
          },
        );
    return ExcludeFocus(
      child: Button(
        leading: leading,
        trailing: trailing,
        onPressed: onPressed,
        enabled: true,
        style: baseStyle,
        child: child,
      ),
    );
  }
}

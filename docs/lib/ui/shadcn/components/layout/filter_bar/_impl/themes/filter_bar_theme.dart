part of '../../filter_bar.dart';

class _FilterBarResolvedTheme {
  final EdgeInsetsGeometry contentPadding;
  final BorderRadiusGeometry borderRadius;
  final TextStyle? helperTextStyle;
  final BorderSide borderSide;

  const _FilterBarResolvedTheme({
    required this.contentPadding,
    required this.borderRadius,
    required this.helperTextStyle,
    required this.borderSide,
  });

  factory _FilterBarResolvedTheme.resolve(
    BuildContext context,
    FilterBarStyle style,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return _FilterBarResolvedTheme(
      contentPadding: EdgeInsets.all(style.dense ? 8 : 12),
      borderRadius: theme.borderRadiusMd,
      helperTextStyle: theme.typography.textMuted.copyWith(
        color: colorScheme.mutedForeground,
      ),
      borderSide: BorderSide(color: colorScheme.border),
    );
  }
}

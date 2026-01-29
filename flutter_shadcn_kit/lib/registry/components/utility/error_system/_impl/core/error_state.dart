import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';

import '../../../../../shared/icons/radix_icons.dart';
import '../../../../../shared/theme/theme.dart';
import '../../../../control/button/button.dart';
import '../../../../display/divider/divider.dart';
import '../../../../layout/card/card.dart';
import '../themes/error_system_theme.dart';
import 'app_error.dart';
import 'error_action.dart';

class ErrorState extends StatelessWidget {
  const ErrorState({
    super.key,
    required this.error,
    this.icon,
    this.maxWidth,
  });

  final AppError error;
  final Widget? icon;
  final double? maxWidth;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final compTheme = ComponentTheme.maybeOf<ErrorSystemTheme>(context);
    final resolvedIcon = icon ??
        Icon(
          RadixIcons.exclamationTriangle,
          size: compTheme?.iconSize ?? 36 * scaling,
          color: compTheme?.iconColor ?? theme.colorScheme.destructive,
        );
    final titleStyle =
        compTheme?.titleStyle ?? theme.typography.medium.merge(theme.typography.semiBold);
    final messageStyle = compTheme?.messageStyle ??
        theme.typography.small.copyWith(color: theme.colorScheme.mutedForeground);
    final padding = compTheme?.cardPadding ?? EdgeInsets.all(24 * scaling);
    final borderRadius = compTheme?.cardBorderRadius;
    final fillColor = compTheme?.cardFillColor;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth ?? 520 * scaling),
        child: Card(
          padding: padding,
          borderRadius: borderRadius,
          filled: fillColor != null ? true : null,
          fillColor: fillColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              resolvedIcon,
              Gap(12 * scaling),
              DefaultTextStyle.merge(
                style: titleStyle,
                textAlign: TextAlign.center,
                child: Text(error.title),
              ),
              Gap(6 * scaling),
              DefaultTextStyle.merge(
                style: messageStyle,
                textAlign: TextAlign.center,
                child: Text(error.message),
              ),
              if (error.hasActions) ...[
                Gap(16 * scaling),
                const Divider(),
                Gap(16 * scaling),
                Wrap(
                  spacing: 12 * scaling,
                  runSpacing: 8 * scaling,
                  alignment: WrapAlignment.center,
                  children: [
                    for (final action in error.actions)
                      _buildAction(context, action),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAction(BuildContext context, ErrorAction action) {
    final icon = action.icon;
    final child = icon == null
        ? Text(action.label)
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 16 * Theme.of(context).scaling),
              Gap(8 * Theme.of(context).scaling),
              Text(action.label),
            ],
          );
    if (action.primary) {
      return PrimaryButton(onPressed: action.onPressed, child: child);
    }
    return SecondaryButton(onPressed: action.onPressed, child: child);
  }
}

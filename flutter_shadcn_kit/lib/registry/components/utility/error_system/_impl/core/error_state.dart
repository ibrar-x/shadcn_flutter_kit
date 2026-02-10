// ErrorState: full-page/section error UI built from shadcn Card/Divider/Button primitives.
// Renders optional illustration + icon + title/message and maps ErrorAction list to buttons.

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
    this.illustration,
    this.icon,
    this.maxWidth,
  });

  final AppError error;
  final Widget? illustration;
  final Widget? icon;
  final double? maxWidth;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final compTheme = ComponentTheme.maybeOf<ErrorSystemTheme>(context);
    final resolvedIcon =
        icon ??
        Icon(
          RadixIcons.exclamationTriangle,
          size: compTheme?.iconSize ?? 36 * scaling,
          color: compTheme?.iconColor ?? theme.colorScheme.destructive,
        );
    final resolvedIllustration = illustration;
    final titleStyle =
        compTheme?.titleStyle ??
        theme.typography.medium.merge(theme.typography.semiBold);
    final messageStyle =
        compTheme?.messageStyle ??
        theme.typography.small.copyWith(
          color: theme.colorScheme.mutedForeground,
        );
    final padding =
        compTheme?.cardPadding ??
        EdgeInsets.all(theme.density.baseContainerPadding * scaling * 1.5);
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
              if (resolvedIllustration != null) ...[
                resolvedIllustration,
                DensityGap(gapLg),
              ],
              resolvedIcon,
              DensityGap(gapMd),
              DefaultTextStyle.merge(
                style: titleStyle,
                textAlign: TextAlign.center,
                child: Text(error.title),
              ),
              DensityGap(0.75),
              DefaultTextStyle.merge(
                style: messageStyle,
                textAlign: TextAlign.center,
                child: Text(error.message),
              ),
              if (error.hasActions) ...[
                DensityGap(gapLg),
                const Divider(),
                DensityGap(gapLg),
                Wrap(
                  spacing: theme.density.baseGap * scaling * 1.5,
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
              DensityGap(gapSm),
              Text(action.label),
            ],
          );
    if (action.primary) {
      return PrimaryButton(onPressed: action.onPressed, child: child);
    }
    return SecondaryButton(onPressed: action.onPressed, child: child);
  }
}

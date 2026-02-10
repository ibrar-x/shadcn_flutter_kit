// InlineError: compact error row for forms and inline validation.
// Shows an icon + message using shadcn theme typography and destructive/accent colors.

import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';

import '../../../../../shared/icons/radix_icons.dart';
import '../../../../../shared/theme/theme.dart';
import '../themes/error_system_theme.dart';

class InlineError extends StatelessWidget {
  const InlineError({super.key, required this.message, this.icon});

  final String message;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final compTheme = ComponentTheme.maybeOf<ErrorSystemTheme>(context);
    final resolvedIcon =
        icon ??
        Icon(
          RadixIcons.infoCircled,
          size: compTheme?.iconSize ?? 16 * scaling,
          color: compTheme?.iconColor ?? theme.colorScheme.destructive,
        );
    final messageStyle =
        compTheme?.messageStyle ??
        theme.typography.xSmall.copyWith(color: theme.colorScheme.destructive);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        resolvedIcon,
        DensityGap(gapSm),
        Expanded(
          child: DefaultTextStyle.merge(
            style: messageStyle,
            child: Text(message),
          ),
        ),
      ],
    );
  }
}

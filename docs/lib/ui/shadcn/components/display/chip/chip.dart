import 'package:flutter/widgets.dart';

import '../../control/button/button.dart';
import '../../../shared/theme/theme.dart';
import '../../../shared/utils/style_value.dart';

part '_impl/core/chip_button.dart';
part '_impl/themes/chip_theme.dart';

/// Compact interactive chip with optional leading/trailing widgets.
class Chip extends StatelessWidget {
  const Chip({
    super.key,
    required this.child,
    this.leading,
    this.trailing,
    this.onPressed,
    this.style,
  });

  final Widget child;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onPressed;
  final AbstractButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final componentTheme = ComponentTheme.maybeOf<ChipTheme>(context);
    final resolvedStyle =
        style ?? componentTheme?.style ?? ButtonVariance.secondary;

    return Button(
      style: resolvedStyle.copyWith(
        mouseCursor: (context, states, value) {
          return onPressed != null
              ? SystemMouseCursors.click
              : SystemMouseCursors.basic;
        },
        padding: (context, states, value) {
          return styleValue(
            themeValue: componentTheme?.padding,
            defaultValue: EdgeInsets.symmetric(
              horizontal: theme.scaling * 8,
              vertical: theme.scaling * 4,
            ),
          );
        },
      ),
      onPressed: onPressed ?? () {},
      leading: leading,
      trailing: trailing,
      child: child,
    );
  }
}

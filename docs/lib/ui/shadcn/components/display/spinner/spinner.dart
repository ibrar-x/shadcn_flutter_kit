import 'package:flutter/widgets.dart';

import '../../../shared/theme/theme.dart';
import '../../../shared/utils/style_value.dart';

part '_impl/spinner_theme.dart';

/// Shared spinner base class with color and size resolution helpers.
abstract class Spinner extends StatelessWidget {
  /// Optional color override.
  final Color? color;

  /// Optional size override.
  final double? size;

  const Spinner({super.key, this.color, this.size});

  Color? resolveColor(BuildContext context) {
    final compTheme = ComponentTheme.maybeOf<SpinnerTheme>(context);
    return styleValue(
      widgetValue: color,
      themeValue: compTheme?.color,
      defaultValue: null,
    );
  }

  double resolveSize(BuildContext context, double defaultValue) {
    final compTheme = ComponentTheme.maybeOf<SpinnerTheme>(context);
    return styleValue(
      widgetValue: size,
      themeValue: compTheme?.size,
      defaultValue: defaultValue,
    );
  }
}

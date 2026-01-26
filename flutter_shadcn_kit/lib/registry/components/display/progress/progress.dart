import 'package:flutter/material.dart' hide Theme;

import '../../../shared/theme/theme.dart';
import '../../../shared/utils/style_value.dart';

part '_impl/progress_theme.dart';

/// Normalized progress indicator that respects theme defaults.
class Progress extends StatelessWidget {
  const Progress({
    super.key,
    this.progress,
    this.min = 0.0,
    this.max = 1.0,
    this.color,
    this.backgroundColor,
  }) : assert(progress == null || (progress >= min && progress <= max),
            'Progress must be between min and max');

  final double? progress;
  final double min;
  final double max;
  final Color? color;
  final Color? backgroundColor;

  double? get normalizedValue {
    if (progress == null) return null;
    return (progress! - min) / (max - min);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final compTheme = ComponentTheme.maybeOf<ProgressTheme>(context);
    return LinearProgressIndicator(
      value: normalizedValue,
      backgroundColor: styleValue(
        widgetValue: backgroundColor,
        themeValue: compTheme?.backgroundColor,
        defaultValue: null,
      ),
      color: styleValue(
        widgetValue: color,
        themeValue: compTheme?.color,
        defaultValue: null,
      ),
      minHeight: styleValue(
        widgetValue: null,
        themeValue: compTheme?.minHeight,
        defaultValue: 8.0 * theme.scaling,
      ),
      borderRadius: styleValue(
        widgetValue: null,
        themeValue: compTheme?.borderRadius,
        defaultValue: theme.borderRadiusSm,
      ),
    );
  }
}

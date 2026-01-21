import 'package:flutter/widgets.dart';

import '../../shared/primitives/animated_value_builder.dart';
import '../../shared/theme/theme.dart';
import '../../shared/utils/style_value.dart';

part '_impl/number_ticker_theme.dart';

/// Builder signature for custom ticker content.
typedef NumberTickerBuilder = Widget Function(
    BuildContext context, double value, Widget? child);

/// Formatter signature for textual tickers.
typedef NumberTickerFormatted = String Function(double value);

/// Smooth number animation component with text or custom builder variants.
class NumberTicker extends StatelessWidget {
  const NumberTicker.builder({
    super.key,
    this.initialNumber,
    required this.number,
    required this.builder,
    this.child,
    this.duration,
    this.curve,
  })  : formatter = null,
        style = null;

  const NumberTicker({
    super.key,
    this.initialNumber,
    required this.number,
    required this.formatter,
    this.duration,
    this.curve,
    this.style,
  })  : builder = null,
        child = null;

  final num? initialNumber;
  final num number;
  final NumberTickerBuilder? builder;
  final Widget? child;
  final NumberTickerFormatted? formatter;
  final Duration? duration;
  final Curve? curve;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final compTheme = ComponentTheme.maybeOf<NumberTickerTheme>(context);
    final resolvedDuration = styleValue(
      widgetValue: duration,
      themeValue: compTheme?.duration,
      defaultValue: const Duration(milliseconds: 500),
    );
    final resolvedCurve = styleValue(
      widgetValue: curve,
      themeValue: compTheme?.curve,
      defaultValue: Curves.easeInOut,
    );
    final initial = initialNumber?.toDouble();
    if (formatter != null) {
      final resolvedStyle = styleValue(
        widgetValue: style,
        themeValue: compTheme?.style,
        defaultValue: null,
      );
      return AnimatedValueBuilder(
        value: number.toDouble(),
        duration: resolvedDuration,
        curve: resolvedCurve,
        initialValue: initial,
        builder: (context, value, child) {
          return Text(
            formatter!(value),
            style: resolvedStyle,
          );
        },
      );
    }
    return AnimatedValueBuilder(
      value: number.toDouble(),
      duration: resolvedDuration,
      curve: resolvedCurve,
      initialValue: initial,
      builder: (context, value, child) {
        return builder!(context, value, child);
      },
      child: child,
    );
  }
}

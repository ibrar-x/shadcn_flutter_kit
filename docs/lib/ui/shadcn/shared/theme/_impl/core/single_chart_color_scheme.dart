part of '../../color_scheme.dart';

class SingleChartColorScheme implements ChartColorScheme {
  /// The single color used for all chart elements.
  final Color color;

  /// Creates a single color chart scheme.
  const SingleChartColorScheme(this.color);

  @override
  List<Color> get chartColors => [color, color, color, color, color];

  @override
  Color get chart1 => color;

  @override
  Color get chart2 => color;

  @override
  Color get chart3 => color;

  @override
  Color get chart4 => color;

  @override
  Color get chart5 => color;
}

/// A color scheme for charts with 5 distinct colors.
///
/// Provides colors for up to 5 different data series in charts.

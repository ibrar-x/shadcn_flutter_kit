part of '../../number_ticker.dart';

/// Theme data for [NumberTicker].
class NumberTickerTheme extends ComponentThemeData {
  final Duration? duration;
  final Curve? curve;
  final TextStyle? style;

  const NumberTickerTheme({
    super.themeDensity,
    super.themeSpacing,
    super.themeShadows,
    this.duration,
    this.curve,
    this.style,
  });

  NumberTickerTheme copyWith({
    ValueGetter<Duration?>? duration,
    ValueGetter<Curve?>? curve,
    ValueGetter<TextStyle?>? style,
  }) {
    return NumberTickerTheme(
      duration: duration == null ? this.duration : duration(),
      curve: curve == null ? this.curve : curve(),
      style: style == null ? this.style : style(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is NumberTickerTheme &&
        other.duration == duration &&
        other.curve == curve &&
        other.style == style;
  }

  @override
  int get hashCode => Object.hash(duration, curve, style);
}

part of '../../accordion.dart';

/// Theme data used by [Accordion], [AccordionItem], and [AccordionTrigger].
class AccordionTheme extends ComponentThemeData {
  /// Creates an accordion theme.
  const AccordionTheme({
    super.themeDensity,
    super.themeSpacing,
    super.themeShadows,
    this.duration,
    this.curve,
    this.reverseCurve,
    this.padding,
    this.iconGap,
    this.dividerHeight,
    this.dividerColor,
    this.arrowIcon,
    this.arrowIconColor,
  });

  /// Animation duration when expanding/collapsing items.
  final Duration? duration;

  /// Curve applied when expanding.
  final Curve? curve;

  /// Curve applied when collapsing.
  final Curve? reverseCurve;

  /// Vertical padding around the trigger and content.
  final double? padding;

  /// Spacing between the trigger content and the arrow icon.
  final double? iconGap;

  /// Height of the dividers between items.
  final double? dividerHeight;

  /// Color of the dividers between items.
  final Color? dividerColor;

  /// Icon data used for the expand/collapse indicator.
  final IconData? arrowIcon;

  /// Color of the expand/collapse icon.
  final Color? arrowIconColor;

  /// Creates a copy of this theme with selective overrides.
  AccordionTheme copyWith({
    ValueGetter<Duration?>? duration,
    ValueGetter<Curve?>? curve,
    ValueGetter<Curve?>? reverseCurve,
    ValueGetter<double?>? padding,
    ValueGetter<double?>? iconGap,
    ValueGetter<double?>? dividerHeight,
    ValueGetter<Color?>? dividerColor,
    ValueGetter<IconData?>? arrowIcon,
    ValueGetter<Color?>? arrowIconColor,
  }) {
    return AccordionTheme(
      duration: duration == null ? this.duration : duration(),
      curve: curve == null ? this.curve : curve(),
      reverseCurve: reverseCurve == null ? this.reverseCurve : reverseCurve(),
      padding: padding == null ? this.padding : padding(),
      iconGap: iconGap == null ? this.iconGap : iconGap(),
      dividerHeight: dividerHeight == null
          ? this.dividerHeight
          : dividerHeight(),
      dividerColor: dividerColor == null ? this.dividerColor : dividerColor(),
      arrowIcon: arrowIcon == null ? this.arrowIcon : arrowIcon(),
      arrowIconColor: arrowIconColor == null
          ? this.arrowIconColor
          : arrowIconColor(),
    );
  }

  @override
  bool operator ==(Object other) =>
      other is AccordionTheme &&
      duration == other.duration &&
      curve == other.curve &&
      reverseCurve == other.reverseCurve &&
      padding == other.padding &&
      iconGap == other.iconGap &&
      dividerHeight == other.dividerHeight &&
      dividerColor == other.dividerColor &&
      arrowIcon == other.arrowIcon &&
      arrowIconColor == other.arrowIconColor;

  @override
  int get hashCode => Object.hash(
    duration,
    curve,
    reverseCurve,
    padding,
    iconGap,
    dividerHeight,
    dividerColor,
    arrowIcon,
    arrowIconColor,
  );

  @override
  String toString() {
    return 'AccordionTheme(duration: $duration, curve: $curve, reverseCurve: $reverseCurve, padding: $padding, iconGap: $iconGap, dividerHeight: $dividerHeight, dividerColor: $dividerColor, arrowIcon: $arrowIcon, arrowIconColor: $arrowIconColor)';
  }
}

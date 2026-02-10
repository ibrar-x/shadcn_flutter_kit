part of '../../collapsible.dart';

/// Theme data for collapsible widgets and triggers.
class CollapsibleTheme extends ComponentThemeData {
  /// Creates a theme for collapsible sections.
  const CollapsibleTheme({
    super.themeDensity,
    super.themeSpacing,
    super.themeShadows,
    this.padding,
    this.iconExpanded,
    this.iconCollapsed,
    this.crossAxisAlignment,
    this.mainAxisAlignment,
    this.iconGap,
  });

  /// Horizontal padding around the trigger row.
  final double? padding;

  /// Icon shown when expanded.
  final IconData? iconExpanded;

  /// Icon shown when collapsed.
  final IconData? iconCollapsed;

  /// Cross-axis alignment for the column of children.
  final CrossAxisAlignment? crossAxisAlignment;

  /// Main-axis alignment for the column of children.
  final MainAxisAlignment? mainAxisAlignment;

  /// Spacing between trigger children and the icon.
  final double? iconGap;

  /// Copies the theme with selected overrides.
  CollapsibleTheme copyWith({
    ValueGetter<double?>? padding,
    ValueGetter<IconData?>? iconExpanded,
    ValueGetter<IconData?>? iconCollapsed,
    ValueGetter<CrossAxisAlignment?>? crossAxisAlignment,
    ValueGetter<MainAxisAlignment?>? mainAxisAlignment,
    ValueGetter<double?>? iconGap,
  }) {
    return CollapsibleTheme(
      padding: padding == null ? this.padding : padding(),
      iconExpanded: iconExpanded == null ? this.iconExpanded : iconExpanded(),
      iconCollapsed: iconCollapsed == null
          ? this.iconCollapsed
          : iconCollapsed(),
      crossAxisAlignment: crossAxisAlignment == null
          ? this.crossAxisAlignment
          : crossAxisAlignment(),
      mainAxisAlignment: mainAxisAlignment == null
          ? this.mainAxisAlignment
          : mainAxisAlignment(),
      iconGap: iconGap == null ? this.iconGap : iconGap(),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CollapsibleTheme &&
        other.padding == padding &&
        other.iconExpanded == iconExpanded &&
        other.iconCollapsed == iconCollapsed &&
        other.crossAxisAlignment == crossAxisAlignment &&
        other.mainAxisAlignment == mainAxisAlignment &&
        other.iconGap == iconGap;
  }

  @override
  int get hashCode => Object.hash(
    padding,
    iconExpanded,
    iconCollapsed,
    crossAxisAlignment,
    mainAxisAlignment,
    iconGap,
  );
}

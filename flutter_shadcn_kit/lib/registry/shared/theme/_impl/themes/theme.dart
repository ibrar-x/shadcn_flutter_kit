part of '../../theme.dart';

class Theme extends InheritedTheme {
  /// The theme data to provide to descendants.
  final ThemeData data;

  /// Creates a [Theme].
  ///
  /// Parameters:
  /// - [data] (`ThemeData`, required): Theme data to provide.
  /// - [child] (`Widget`, required): Child widget.
  const Theme({
    super.key,
    required this.data,
    required super.child,
  });

  /// Gets the [ThemeData] from the closest [Theme] ancestor.
  ///
  /// Returns: `ThemeData` — the theme data.
  static ThemeData of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<Theme>();
    return theme?.data ?? const ThemeData();
  }

  @override
  bool updateShouldNotify(covariant Theme oldWidget) {
    return oldWidget.data != data;
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    final Theme? ancestorTheme = context.findAncestorWidgetOfExactType<Theme>();
    return identical(this, ancestorTheme)
        ? child
        : Theme(data: data, child: child);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ThemeData>('data', data));
  }
}

/// A tween for animating between two [ThemeData] values.

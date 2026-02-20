/// Global token override entrypoint for the scrollable component.
class ScrollableThemeTokensConfig {
  const ScrollableThemeTokensConfig._();

  /// Global component theme override for `ScrollableClientTheme`.
  static Object? global;
  static const String globalType = 'ScrollableClientTheme';
  static const Map<String, Object?> globalDefaults = <String, Object?>{
    'diagonalDragBehavior': null,
    'dragStartBehavior': null,
    'keyboardDismissBehavior': null,
    'clipBehavior': null,
    'hitTestBehavior': null,
    'overscroll': null,
  };
  static const Map<String, Object?> globalTokens = <String, Object?>{};
}

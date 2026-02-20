/// Global token override entrypoint for the scrollable component.
class ScrollableThemeTokensConfigGlobalDefaults {
  final Object? diagonalDragBehavior;
  final Object? dragStartBehavior;
  final Object? keyboardDismissBehavior;
  final Object? clipBehavior;
  final Object? hitTestBehavior;
  final Object? overscroll;

  const ScrollableThemeTokensConfigGlobalDefaults({
    this.diagonalDragBehavior,
    this.dragStartBehavior,
    this.keyboardDismissBehavior,
    this.clipBehavior,
    this.hitTestBehavior,
    this.overscroll,
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'diagonalDragBehavior': diagonalDragBehavior,
    'dragStartBehavior': dragStartBehavior,
    'keyboardDismissBehavior': keyboardDismissBehavior,
    'clipBehavior': clipBehavior,
    'hitTestBehavior': hitTestBehavior,
    'overscroll': overscroll,
  };
}

class ScrollableThemeTokensConfigGlobalTokens {
  const ScrollableThemeTokensConfigGlobalTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class ScrollableThemeTokensConfig {
  const ScrollableThemeTokensConfig._();

  /// Global component theme override for `ScrollableClientTheme`.
  static Object? global;
  static const String globalType = 'ScrollableClientTheme';
  static const ScrollableThemeTokensConfigGlobalDefaults globalDefaults =
      ScrollableThemeTokensConfigGlobalDefaults();
  static const ScrollableThemeTokensConfigGlobalTokens globalTokens =
      ScrollableThemeTokensConfigGlobalTokens();
}

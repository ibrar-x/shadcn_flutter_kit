/// Global token override entrypoint for the divider component.
class DividerThemeTokensConfigGlobalDefaults {
  final Object? color;
  final Object? height;
  final Object? thickness;
  final Object? indent;
  final Object? endIndent;
  final Object? padding;
  final Object? childAlignment;

  const DividerThemeTokensConfigGlobalDefaults({
    this.color,
    this.height,
    this.thickness,
    this.indent,
    this.endIndent,
    this.padding,
    this.childAlignment,
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'color': color,
    'height': height,
    'thickness': thickness,
    'indent': indent,
    'endIndent': endIndent,
    'padding': padding,
    'childAlignment': childAlignment,
  };
}

class DividerThemeTokensConfigGlobalTokens {
  const DividerThemeTokensConfigGlobalTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class DividerThemeTokensConfig {
  const DividerThemeTokensConfig._();

  /// Global component theme override for `DividerTheme`.
  static Object? global;
  static const String globalType = 'DividerTheme';
  static const DividerThemeTokensConfigGlobalDefaults globalDefaults =
      DividerThemeTokensConfigGlobalDefaults();
  static const DividerThemeTokensConfigGlobalTokens globalTokens =
      DividerThemeTokensConfigGlobalTokens();
}

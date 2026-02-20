// GENERATED: component theming architecture defaults file.
// Built-in defaults - do not edit manually.

class TextFieldThemeConfigGlobalDefaults {
  final Object? border;
  final Object? borderRadius;
  final Object? filled;
  final Object? padding;

  const TextFieldThemeConfigGlobalDefaults({
    this.border =
        'Border.all( color: theme.colorScheme.border, strokeAlign: BorderSide.strokeAlignCenter, )',
    this.borderRadius,
    this.filled = false,
    this.padding =
        'EdgeInsets.symmetric(horizontal: densityContentPadding * 0.75)',
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'border': border,
    'borderRadius': borderRadius,
    'filled': filled,
    'padding': padding,
  };
}

const textFieldThemeTokensConfigGlobalDefaults = TextFieldThemeConfigGlobalDefaults();

/// Global token override entrypoint for the date_picker component.
class DatePickerThemeTokensConfigGlobalDefaults {
  final Object? mode;
  final Object? initialView;
  final Object? initialViewType;
  final Object? popoverAlignment;
  final Object? popoverAnchorAlignment;
  final Object? popoverPadding;

  const DatePickerThemeTokensConfigGlobalDefaults({
    this.mode,
    this.initialView,
    this.initialViewType,
    this.popoverAlignment,
    this.popoverAnchorAlignment,
    this.popoverPadding,
  });

  Map<String, Object?> toMap() => <String, Object?>{
    'mode': mode,
    'initialView': initialView,
    'initialViewType': initialViewType,
    'popoverAlignment': popoverAlignment,
    'popoverAnchorAlignment': popoverAnchorAlignment,
    'popoverPadding': popoverPadding,
  };
}

class DatePickerThemeTokensConfigGlobalTokens {
  const DatePickerThemeTokensConfigGlobalTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class DatePickerThemeTokensConfig {
  const DatePickerThemeTokensConfig._();

  /// Global component theme override for `DatePickerTheme`.
  static Object? global;
  static const String globalType = 'DatePickerTheme';
  static const DatePickerThemeTokensConfigGlobalDefaults globalDefaults =
      DatePickerThemeTokensConfigGlobalDefaults();
  static const DatePickerThemeTokensConfigGlobalTokens globalTokens =
      DatePickerThemeTokensConfigGlobalTokens();
}

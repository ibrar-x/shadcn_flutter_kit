/// Global token override entrypoint for the input_otp component.
class InputOtpThemeTokensConfigGlobalDefaults {
  final Object? spacing;
  final Object? height;

  const InputOtpThemeTokensConfigGlobalDefaults({this.spacing, this.height});

  Map<String, Object?> toMap() => <String, Object?>{
    'spacing': spacing,
    'height': height,
  };
}

class InputOtpThemeTokensConfigGlobalTokens {
  const InputOtpThemeTokensConfigGlobalTokens();

  Map<String, Object?> toMap() => const <String, Object?>{};
}

class InputOtpThemeTokensConfig {
  const InputOtpThemeTokensConfig._();

  /// Global component theme override for `InputOTPTheme`.
  static Object? global;
  static const String globalType = 'InputOTPTheme';
  static const InputOtpThemeTokensConfigGlobalDefaults globalDefaults =
      InputOtpThemeTokensConfigGlobalDefaults();
  static const InputOtpThemeTokensConfigGlobalTokens globalTokens =
      InputOtpThemeTokensConfigGlobalTokens();
}

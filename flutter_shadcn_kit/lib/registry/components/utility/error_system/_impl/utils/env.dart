class Env {
  static bool showTechnicalDetails =
      const bool.fromEnvironment('SHADCN_SHOW_TECHNICAL_ERRORS', defaultValue: false);
}

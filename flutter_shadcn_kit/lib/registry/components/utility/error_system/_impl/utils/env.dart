// Env: compile-time flags for error system behavior.
// Controls whether technicalDetails are attached/visible (SHADCN_SHOW_TECHNICAL_ERRORS).

class Env {
  static bool showTechnicalDetails = const bool.fromEnvironment(
    'SHADCN_SHOW_TECHNICAL_ERRORS',
    defaultValue: false,
  );
}

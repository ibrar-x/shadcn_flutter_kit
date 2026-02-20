import 'dart:io';

/// Refactors preset_themes.dart to remove redundancy by extracting shadow scales
/// and using factory helpers for tokens.
void main(List<String> args) {
  final inputFile = File(
    '/Users/ibrar/Desktop/infinora.noworkspace/shadcn_copy_paste/shadcn_flutter_kit/flutter_shadcn_kit/lib/registry/shared/theme/preset_themes.dart',
  );

  if (!inputFile.existsSync()) {
    stderr.writeln('Error: Input file not found');
    exitCode = 1;
    return;
  }

  final source = inputFile.readAsStringSync();
  final refactored = _refactor(source);

  stdout.writeln(refactored);
}

String _refactor(String source) {
  final lines = source.split('\n');
  final output = <String>[];
  var i = 0;

  // Copy header and imports as-is
  while (i < lines.length && !lines[i].contains('final List<RegistryThemePreset>')) {
    final line = lines[i];

    // Skip redundant doc comments like "/// Creates a `BoxShadow` instance."
    if (line.trim() == '/// Creates a `BoxShadow` instance.' ||
        line.trim() == "/// Creates a \`RegistryThemePreset\` instance.") {
      i++;
      continue;
    }

    // Skip old comment doc for fields like "/// Stores `X` state/configuration for this implementation."
    if (line.trim().startsWith('///') &&
        (line.contains('Stores') && line.contains('state/configuration'))) {
      i++;
      continue;
    }

    output.add(line);
    i++;
  }

  // Add shadow scale constants and factories before the list
  output.add('');
  output.add('// ============================================================================');
  output.add('// Common Shadow Scales');
  output.add('// ============================================================================');
  output.add('');
  output.add('/// Standard light shadow (used by most light mode themes).');
  output.add('final _shadowLightStandard = ShadowScale(');
  output.add('  shadow2xs: const [BoxShadow(offset: Offset(0, 4), blurRadius: 8, spreadRadius: -1, color: Color(0x1A000000))],');
  output.add('  shadowXs: const [BoxShadow(offset: Offset(0, 4), blurRadius: 8, spreadRadius: -1, color: Color(0x1A000000))],');
  output.add('  shadowSm: const [BoxShadow(offset: Offset(0, 4), blurRadius: 8, spreadRadius: -1, color: Color(0x1A000000))],');
  output.add('  shadow: const [BoxShadow(offset: Offset(0, 4), blurRadius: 8, spreadRadius: -1, color: Color(0x1A000000))],');
  output.add('  shadowMd: const [BoxShadow(offset: Offset(0, 4), blurRadius: 8, spreadRadius: -1, color: Color(0x1A000000))],');
  output.add('  shadowLg: const [BoxShadow(offset: Offset(0, 4), blurRadius: 8, spreadRadius: -1, color: Color(0x1A000000))],');
  output.add('  shadowXl: const [BoxShadow(offset: Offset(0, 4), blurRadius: 8, spreadRadius: -1, color: Color(0x1A000000))],');
  output.add('  shadow2xl: const [BoxShadow(offset: Offset(0, 4), blurRadius: 8, spreadRadius: -1, color: Color(0x1A000000))],');
  output.add(');');
  output.add('');
  output.add('/// Standard dark shadow (used by most dark mode themes).');
  output.add('final _shadowDarkStandard = ShadowScale(');
  output.add('  shadow2xs: const [BoxShadow(offset: Offset(20.5, 16.5), blurRadius: 25.5, spreadRadius: -30, color: Color(0x12000000))],');
  output.add('  shadowXs: const [BoxShadow(offset: Offset(20.5, 16.5), blurRadius: 25.5, spreadRadius: -30, color: Color(0x12000000))],');
  output.add('  shadowSm: const [BoxShadow(offset: Offset(20.5, 16.5), blurRadius: 25.5, spreadRadius: -30, color: Color(0x12000000))],');
  output.add('  shadow: const [BoxShadow(offset: Offset(20.5, 16.5), blurRadius: 25.5, spreadRadius: -30, color: Color(0x12000000))],');
  output.add('  shadowMd: const [BoxShadow(offset: Offset(20.5, 16.5), blurRadius: 25.5, spreadRadius: -30, color: Color(0x12000000))],');
  output.add('  shadowLg: const [BoxShadow(offset: Offset(20.5, 16.5), blurRadius: 25.5, spreadRadius: -30, color: Color(0x12000000))],');
  output.add('  shadowXl: const [BoxShadow(offset: Offset(20.5, 16.5), blurRadius: 25.5, spreadRadius: -30, color: Color(0x12000000))],');
  output.add('  shadow2xl: const [BoxShadow(offset: Offset(20.5, 16.5), blurRadius: 25.5, spreadRadius: -30, color: Color(0x12000000))],');
  output.add(');');
  output.add('');
  output.add('/// Soft light shadow (used by amethyst, cosmic, etc).');
  output.add('final _shadowLightSoft = ShadowScale(');
  output.add('  shadow2xs: const [BoxShadow(offset: Offset(1, 2), blurRadius: 5, spreadRadius: 1, color: Color(0x0F000000))],');
  output.add('  shadowXs: const [BoxShadow(offset: Offset(1, 2), blurRadius: 5, spreadRadius: 1, color: Color(0x0F000000))],');
  output.add('  shadowSm: const [BoxShadow(offset: Offset(1, 2), blurRadius: 5, spreadRadius: 1, color: Color(0x0F000000))],');
  output.add('  shadow: const [BoxShadow(offset: Offset(1, 2), blurRadius: 5, spreadRadius: 1, color: Color(0x0F000000))],');
  output.add('  shadowMd: const [BoxShadow(offset: Offset(1, 2), blurRadius: 5, spreadRadius: 1, color: Color(0x0F000000))],');
  output.add('  shadowLg: const [BoxShadow(offset: Offset(1, 2), blurRadius: 5, spreadRadius: 1, color: Color(0x0F000000))],');
  output.add('  shadowXl: const [BoxShadow(offset: Offset(1, 2), blurRadius: 5, spreadRadius: 1, color: Color(0x0F000000))],');
  output.add('  shadow2xl: const [BoxShadow(offset: Offset(1, 2), blurRadius: 5, spreadRadius: 1, color: Color(0x0F000000))],');
  output.add(');');
  output.add('');
  output.add('// ============================================================================');
  output.add('// Factory Helpers');
  output.add('// ============================================================================');
  output.add('');
  output.add('RegistryThemePresetTokens _lightTokens({');
  output.add('  double radius = 0.5,');
  output.add('  double spacingBase = 4,');
  output.add('  ShadowScale? shadows,');
  output.add('  String? fontSans,');
  output.add('  String? fontSerif,');
  output.add('  String? fontMono,');
  output.add('}) =>');
  output.add('    RegistryThemePresetTokens(');
  output.add('      radius: radius,');
  output.add('      spacing: SpacingScale(spacingBase),');
  output.add('      tracking: TrackingScale(normal: 0),');
  output.add('      shadows: shadows ?? _shadowLightStandard,');
  output.add('      fontSans: fontSans,');
  output.add('      fontSerif: fontSerif,');
  output.add('      fontMono: fontMono,');
  output.add('    );');
  output.add('');
  output.add('RegistryThemePresetTokens _darkTokens({');
  output.add('  double radius = 0.5,');
  output.add('  double spacingBase = 3.84,');
  output.add('  ShadowScale? shadows,');
  output.add('  String? fontSans,');
  output.add('  String? fontSerif,');
  output.add('  String? fontMono,');
  output.add('}) =>');
  output.add('    RegistryThemePresetTokens(');
  output.add('      radius: radius,');
  output.add('      spacing: SpacingScale(spacingBase),');
  output.add('      tracking: TrackingScale(normal: 0),');
  output.add('      shadows: shadows ?? _shadowDarkStandard,');
  output.add('      fontSans: fontSans,');
  output.add('      fontSerif: fontSerif,');
  output.add('      fontMono: fontMono,');
  output.add('    );');
  output.add('');
  output.add('// ============================================================================');
  output.add('// Presets List');
  output.add('// ============================================================================');
  output.add('');

  // Now regenerate the list with cleaned syntax
  output.add('final List<RegistryThemePreset> registryThemePresets = [');

  // Parse presets from the original source
  final presets = _extractPresets(source);
  for (var j = 0; j < presets.length; j++) {
    final preset = presets[j];
    output.add('  RegistryThemePreset(');
    output.add('    id: ${preset['id']},');
    output.add('    name: ${preset['name']},');
    output.add('    light: const ColorScheme(');
    _addColorScheme(output, preset['light'] as Map<String, String>, '      ');
    output.add('    ),');
    output.add('    dark: const ColorScheme(');
    _addColorScheme(output, preset['dark'] as Map<String, String>, '      ');
    output.add('    ),');
    output.add('    lightTokens: _lightTokens(');
    _addLightTokens(output, preset['lightTokens'] as Map<String, dynamic>, '      ');
    output.add('    ),');
    output.add('    darkTokens: _darkTokens(');
    _addDarkTokens(output, preset['darkTokens'] as Map<String, dynamic>, '      ');
    output.add('    ),');
    output.add('  ),');
  }

  output.add('];');

  return output.join('\n');
}

List<Map<String, dynamic>> _extractPresets(String source) {
  final presets = <Map<String, dynamic>>[];

  // Simple regex-based extraction (production code would do proper parsing)
  // For now, return empty to signal that this is a template
  // The actual implementation would parse ColorScheme and RegistryThemePresetTokens blocks

  return presets;
}

void _addColorScheme(List<String> output, Map<String, String> colors, String indent) {
  colors.forEach((key, value) {
    output.add('$indent$key: Color($value),');
  });
}

void _addLightTokens(List<String> output, Map<String, dynamic> tokens, String indent) {
  output.add('${indent}radius: ${tokens['radius']},');
  if (tokens['fontSans'] != null) {
    output.add('${indent}fontSans: "${tokens['fontSans']}",');
  }
  if (tokens['fontSerif'] != null) {
    output.add('${indent}fontSerif: "${tokens['fontSerif']}",');
  }
  if (tokens['fontMono'] != null) {
    output.add('${indent}fontMono: "${tokens['fontMono']}",');
  }
}

void _addDarkTokens(List<String> output, Map<String, dynamic> tokens, String indent) {
  output.add('${indent}radius: ${tokens['radius']},');
  if (tokens['spacingBase'] != null) {
    output.add('${indent}spacingBase: ${tokens['spacingBase']},');
  }
  if (tokens['fontSans'] != null) {
    output.add('${indent}fontSans: "${tokens['fontSans']}",');
  }
  if (tokens['fontSerif'] != null) {
    output.add('${indent}fontSerif: "${tokens['fontSerif']}",');
  }
  if (tokens['fontMono'] != null) {
    output.add('${indent}fontMono: "${tokens['fontMono']}",');
  }
}

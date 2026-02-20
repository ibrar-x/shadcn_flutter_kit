#!/usr/bin/env dart
// Refactors preset_themes.dart by extracting presets and rebuilding with factory pattern
// Run: dart tool/refactor_presets_to_factories.dart

import 'dart:io';
import 'dart:convert';

const String defaultInputPath =
  'lib/registry/shared/theme/preset_themes.dart.backup';
const String fallbackInputPath =
  'lib/registry/shared/theme/preset_themes.dart';
const String defaultOutputPath =
    'lib/registry/shared/theme/preset_themes_refactored.dart';

void main(List<String> args) async {
  try {
    final inputPath = _argValue(args, '--input') ??
        (File(defaultInputPath).existsSync() ? defaultInputPath : fallbackInputPath);
    final outputPath = _argValue(args, '--output') ?? defaultOutputPath;

    print('📖 Reading source file: $inputPath');
    final oldFile = File(inputPath);
    if (!oldFile.existsSync()) {
      print('❌ Error: $inputPath not found');
      exit(1);
    }

    final sourceContent = oldFile.readAsStringSync();
    final presets = extractPresets(sourceContent);

    if (presets.isEmpty) {
      print('❌ Error: No presets extracted');
      exit(1);
    }

    print('✓ Extracted ${presets.length} presets');

    // Generate refactored content
    final refactoredContent = generateRefactoredFile(presets);
    final outputFile = File(outputPath);
    await outputFile.writeAsString(refactoredContent);

    // Report metrics
    final oldLines = sourceContent.split('\n').length;
    final newLines = refactoredContent.split('\n').length;
    final reduction = 100 * (1 - newLines / oldLines);

    print('');
    print('✅ Refactoring Complete');
    print('━' * 50);
    print('📊 Metrics:');
    print('  Old file: $oldLines lines');
    print('  New file: $newLines lines');
    print('  Reduction: ${reduction.toStringAsFixed(1)}%');
    print('  Saved: ${oldLines - newLines} lines');
    print('');
    print('📁 Output: $outputPath');
    print('');
    print('Next steps:');
    print('  1. Review the output file');
    print('  2. Run: dart analyze $outputPath');
    print('  3. Copy: cp $outputPath lib/registry/shared/theme/preset_themes.dart');
    print('  4. Test: flutter test');
  } catch (e) {
    print('❌ Error: $e');
    exit(1);
  }
}

String? _argValue(List<String> args, String key) {
  for (final arg in args) {
    if (arg.startsWith('$key=')) {
      return arg.substring(key.length + 1);
    }
  }
  return null;
}

/// Extracts all RegistryThemePreset instances from the Dart source
List<Map<String, dynamic>> extractPresets(String source) {
  final presets = <Map<String, dynamic>>[];
  final listStart = source.indexOf('final List<RegistryThemePreset> registryThemePresets = [');
  if (listStart == -1) {
    return presets;
  }

  final openBracket = source.indexOf('[', listStart);
  final closeBracket = _findMatching(source, openBracket, '[', ']');
  final listContent = source.substring(openBracket + 1, closeBracket);

  var scan = 0;
  while (true) {
    const keyword = 'RegistryThemePreset(';
    final idx = listContent.indexOf(keyword, scan);
    if (idx == -1) {
      break;
    }

    final openParen = listContent.indexOf('(', idx);
    final closeParen = _findMatching(listContent, openParen, '(', ')');
    final presetBody = listContent.substring(openParen + 1, closeParen);
    final preset = _parsePresetBlock(presetBody);
    if (preset != null) {
      presets.add(preset);
    }
    scan = closeParen + 1;
  }

  return presets;
}

/// Parses a single preset block into a structured map
Map<String, dynamic>? _parsePresetBlock(String block) {
  try {
    final idMatch = RegExp(r"id:\s*'([^']+)'").firstMatch(block);
    final nameMatch = RegExp(r"name:\s*'([^']+)'").firstMatch(block);
    if (idMatch == null || nameMatch == null) {
      return null;
    }
    final id = idMatch.group(1)!;
    final name = nameMatch.group(1)!;

    // Extract light ColorScheme
    final lightColors = _parseColorScheme(_extractConstructorBody(block, 'light', 'ColorScheme'));
    final darkColors = _parseColorScheme(_extractConstructorBody(block, 'dark', 'ColorScheme'));

    // Extract tokens
    final lightTokens = _parseTokens(_extractConstructorBody(block, 'lightTokens', 'RegistryThemePresetTokens'));
    final darkTokens = _parseTokens(_extractConstructorBody(block, 'darkTokens', 'RegistryThemePresetTokens'));

    return {
      'id': id,
      'name': name,
      'light': lightColors,
      'dark': darkColors,
      'lightTokens': lightTokens,
      'darkTokens': darkTokens,
    };
  } catch (e) {
    print('⚠ Warning: Error parsing preset block: $e');
    return null;
  }
}

/// Extracts color fields from a ColorScheme block
Map<String, String> _parseColorScheme(String block) {
  final colors = <String, String>{};
  final pattern = RegExp(r'(\w+):\s*Color\((0x[0-9A-Fa-f]{8})\)');

  for (final match in pattern.allMatches(block)) {
    colors[match.group(1)!] = match.group(2)!;
  }

  return colors;
}

/// Extracts token fields (radius, fonts, spacing)
Map<String, dynamic> _parseTokens(String block) {
  final tokens = <String, dynamic>{};

  // Extract radius
  final radiusMatch = RegExp(r'radius:\s*([\d.]+)').firstMatch(block);
  if (radiusMatch != null) {
    tokens['radius'] = double.tryParse(radiusMatch.group(1)!) ?? 0.5;
  }

  // Extract spacing base
  final spacingMatch = RegExp(r'SpacingScale\(([-\d.]+)\)').firstMatch(block);
  if (spacingMatch != null) {
    tokens['spacingBase'] =
        double.tryParse(spacingMatch.group(1)!) ?? 4.0;
  }

  final normalized = _normalizeWhitespace(block);
  const lightStandardSig =
      'offset:Offset(0,4),blurRadius:8,spreadRadius:-1,color:Color(0x1A000000)';
  const darkStandardSig =
      'offset:Offset(20.5,16.5),blurRadius:25.5,spreadRadius:-30,color:Color(0x12000000)';
  const lightSoftSig =
      'offset:Offset(1,2),blurRadius:5,spreadRadius:1,color:Color(0x0F000000)';

  if (normalized.contains(lightSoftSig)) {
    tokens['shadowPreset'] = 'lightSoft';
  } else if (normalized.contains(lightStandardSig)) {
    tokens['shadowPreset'] = 'lightStandard';
  } else if (normalized.contains(darkStandardSig)) {
    tokens['shadowPreset'] = 'darkStandard';
  } else {
    final boxShadowMatch = RegExp(
      r'offset:\s*Offset\(\s*(-?\d+(?:\.\d+)?)\s*,\s*(-?\d+(?:\.\d+)?)\s*\)\s*,\s*'
      r'blurRadius:\s*(-?\d+(?:\.\d+)?)\s*,\s*'
      r'spreadRadius:\s*(-?\d+(?:\.\d+)?)\s*,\s*'
      r'color:\s*Color\((0x[0-9A-Fa-f]{8})\)',
      dotAll: true,
    ).firstMatch(block);

    if (boxShadowMatch != null) {
      tokens['shadowPreset'] = 'uniformCustom';
      tokens['shadowX'] = num.parse(boxShadowMatch.group(1)!);
      tokens['shadowY'] = num.parse(boxShadowMatch.group(2)!);
      tokens['shadowBlur'] = num.parse(boxShadowMatch.group(3)!);
      tokens['shadowSpread'] = num.parse(boxShadowMatch.group(4)!);
      tokens['shadowColor'] = boxShadowMatch.group(5)!;
    }
  }

  // Extract fonts
  for (final fontType in ['fontSans', 'fontSerif', 'fontMono']) {
    final fontMatch =
        RegExp('$fontType:\\s*"((?:\\\\.|[^"\\\\])*)"').firstMatch(block);
    if (fontMatch != null && fontMatch.group(1)!.isNotEmpty) {
      tokens[fontType] = _unescapeDartString(fontMatch.group(1)!);
    }
  }

  return tokens;
}

/// Generates the complete refactored file
String generateRefactoredFile(List<Map<String, dynamic>> presets) {
  final lines = <String>[];

  // Header
  lines.add('// GENERATED CODE - DO NOT MODIFY BY HAND.');
  lines.add('// Run `dart run tool/generate_theme_presets.dart` to refresh.');
  lines.add('// ignore_for_file: prefer_const_constructors');
  lines.add('');
  lines.add("import 'dart:ui';");
  lines.add('');
  lines.add("import 'package:flutter/painting.dart';");
  lines.add('');
  lines.add("import 'color_scheme.dart';");
  lines.add("import 'theme.dart';");
  lines.add('');

  // Classes
  lines.addAll(_generateClasses());

  // Shadow constants
  lines.addAll(_generateShadowConstants());

  // Factory helpers
  lines.addAll(_generateFactories());

  // Presets list
  lines.addAll(_generatePresetsList(presets));

  return lines.join('\n');
}

List<String> _generateClasses() {
  return [
    '/// RegistryThemePresetTokens defines a reusable type for this registry module.',
    'class RegistryThemePresetTokens {',
    '  final double radius;',
    '  final SpacingScale spacing;',
    '  final TrackingScale tracking;',
    '  final ShadowScale shadows;',
    '  final String? fontSans;',
    '  final String? fontSerif;',
    '  final String? fontMono;',
    '',
    '  RegistryThemePresetTokens({',
    '    required this.radius,',
    '    required this.spacing,',
    '    required this.tracking,',
    '    required this.shadows,',
    '    this.fontSans,',
    '    this.fontSerif,',
    '    this.fontMono,',
    '  });',
    '',
    '  /// Derived density values based on preset spacing scale.',
    '  Density get density => Density.fromSpacingScale(spacing);',
    '}',
    '',
    '/// RegistryThemePreset defines a reusable type for this registry module.',
    'class RegistryThemePreset {',
    '  final String id;',
    '  final String name;',
    '  final ColorScheme light;',
    '  final ColorScheme dark;',
    '  final RegistryThemePresetTokens lightTokens;',
    '  final RegistryThemePresetTokens darkTokens;',
    '',
    '  RegistryThemePreset({',
    '    required this.id,',
    '    required this.name,',
    '    required this.light,',
    '    required this.dark,',
    '    required this.lightTokens,',
    '    required this.darkTokens,',
    '  });',
    '}',
    '',
  ];
}

List<String> _generateShadowConstants() {
  final shadowTypes = [
    'shadow2xs',
    'shadowXs',
    'shadowSm',
    'shadow',
    'shadowMd',
    'shadowLg',
    'shadowXl',
    'shadow2xl',
  ];

  return [
    '// ============================================================================',
    '// Common Shadow Scales',
    '// ============================================================================',
    '',
    '/// Standard light shadow (used by most light mode themes).',
    'final _shadowLightStandard = ShadowScale(',
    ...shadowTypes.map(
      (t) =>
          '  $t: const [BoxShadow(offset: Offset(0, 4), blurRadius: 8, spreadRadius: -1, color: Color(0x1A000000))],',
    ),
    ');',
    '',
    '/// Standard dark shadow (used by most dark mode themes).',
    'final _shadowDarkStandard = ShadowScale(',
    ...shadowTypes.map(
      (t) =>
          '  $t: const [BoxShadow(offset: Offset(20.5, 16.5), blurRadius: 25.5, spreadRadius: -30, color: Color(0x12000000))],',
    ),
    ');',
    '',
    '/// Soft light shadow (used by amethyst, cosmic, etc).',
    'final _shadowLightSoft = ShadowScale(',
    ...shadowTypes.map(
      (t) =>
          '  $t: const [BoxShadow(offset: Offset(1, 2), blurRadius: 5, spreadRadius: 1, color: Color(0x0F000000))],',
    ),
    ');',
    '',
  ];
}

List<String> _generateFactories() {
  return [
    '// ============================================================================',
    '// Factory Helpers',
    '// ============================================================================',
    '',
    'RegistryThemePresetTokens _lightTokens({',
    '  double radius = 0.5,',
    '  double spacingBase = 4,',
    '  ShadowScale? shadows,',
    '  String? fontSans,',
    '  String? fontSerif,',
    '  String? fontMono,',
    '}) =>',
    '    RegistryThemePresetTokens(',
    '      radius: radius,',
    '      spacing: SpacingScale(spacingBase),',
    '      tracking: TrackingScale(normal: 0),',
    '      shadows: shadows ?? _shadowLightStandard,',
    '      fontSans: fontSans,',
    '      fontSerif: fontSerif,',
    '      fontMono: fontMono,',
    '    );',
    '',
    'RegistryThemePresetTokens _darkTokens({',
    '  double radius = 0.5,',
    '  double spacingBase = 3.84,',
    '  ShadowScale? shadows,',
    '  String? fontSans,',
    '  String? fontSerif,',
    '  String? fontMono,',
    '}) =>',
    '    RegistryThemePresetTokens(',
    '      radius: radius,',
    '      spacing: SpacingScale(spacingBase),',
    '      tracking: TrackingScale(normal: 0),',
    '      shadows: shadows ?? _shadowDarkStandard,',
    '      fontSans: fontSans,',
    '      fontSerif: fontSerif,',
    '      fontMono: fontMono,',
    '    );',
    '',
    'ShadowScale _uniformShadowScale({',
    '  required num x,',
    '  required num y,',
    '  required num blur,',
    '  required num spread,',
    '  required int color,',
    '}) =>',
    '    ShadowScale(',
    '      shadow2xs: [BoxShadow(offset: Offset(x.toDouble(), y.toDouble()), blurRadius: blur.toDouble(), spreadRadius: spread.toDouble(), color: Color(color))],',
    '      shadowXs: [BoxShadow(offset: Offset(x.toDouble(), y.toDouble()), blurRadius: blur.toDouble(), spreadRadius: spread.toDouble(), color: Color(color))],',
    '      shadowSm: [BoxShadow(offset: Offset(x.toDouble(), y.toDouble()), blurRadius: blur.toDouble(), spreadRadius: spread.toDouble(), color: Color(color))],',
    '      shadow: [BoxShadow(offset: Offset(x.toDouble(), y.toDouble()), blurRadius: blur.toDouble(), spreadRadius: spread.toDouble(), color: Color(color))],',
    '      shadowMd: [BoxShadow(offset: Offset(x.toDouble(), y.toDouble()), blurRadius: blur.toDouble(), spreadRadius: spread.toDouble(), color: Color(color))],',
    '      shadowLg: [BoxShadow(offset: Offset(x.toDouble(), y.toDouble()), blurRadius: blur.toDouble(), spreadRadius: spread.toDouble(), color: Color(color))],',
    '      shadowXl: [BoxShadow(offset: Offset(x.toDouble(), y.toDouble()), blurRadius: blur.toDouble(), spreadRadius: spread.toDouble(), color: Color(color))],',
    '      shadow2xl: [BoxShadow(offset: Offset(x.toDouble(), y.toDouble()), blurRadius: blur.toDouble(), spreadRadius: spread.toDouble(), color: Color(color))],',
    '    );',
    '',
  ];
}

List<String> _generatePresetsList(List<Map<String, dynamic>> presets) {
  final lines = <String>[
    '// ============================================================================',
    '// Presets List',
    '// ============================================================================',
    '',
    'final List<RegistryThemePreset> registryThemePresets = [',
  ];

  for (final preset in presets) {
    lines.add('  RegistryThemePreset(');
    lines.add("    id: '${preset['id']}',");
    lines.add("    name: '${preset['name']}',");

    // Light ColorScheme
    lines.add('    light: const ColorScheme(');
    lines.add('      brightness: Brightness.light,');
    final lightColors = preset['light'] as Map<String, String>;
    for (final entry in lightColors.entries) {
      lines.add('      ${entry.key}: Color(${entry.value}),');
    }
    lines.add('    ),');

    // Dark ColorScheme
    lines.add('    dark: const ColorScheme(');
    lines.add('      brightness: Brightness.dark,');
    final darkColors = preset['dark'] as Map<String, String>;
    for (final entry in darkColors.entries) {
      lines.add('      ${entry.key}: Color(${entry.value}),');
    }
    lines.add('    ),');

    // Light Tokens
    lines.add('    lightTokens: _lightTokens(');
    final lightTokens = preset['lightTokens'] as Map<String, dynamic>;
    lines.add('      radius: ${lightTokens['radius'] ?? 0.5},');
    lines.add('      spacingBase: ${lightTokens['spacingBase'] ?? 4},');
    final lightShadowPreset = lightTokens['shadowPreset'];
    if (lightShadowPreset == 'lightSoft') {
      lines.add('      shadows: _shadowLightSoft,');
    } else if (lightShadowPreset == 'lightStandard' || lightShadowPreset == null) {
      lines.add('      shadows: _shadowLightStandard,');
    } else if (lightShadowPreset == 'darkStandard') {
      lines.add('      shadows: _shadowDarkStandard,');
    } else if (lightShadowPreset == 'uniformCustom') {
      lines.add(
          '      shadows: _uniformShadowScale(x: ${lightTokens['shadowX']}, y: ${lightTokens['shadowY']}, blur: ${lightTokens['shadowBlur']}, spread: ${lightTokens['shadowSpread']}, color: ${lightTokens['shadowColor']}),');
    }
    if (lightTokens.containsKey('fontSans')) {
      lines.add('      fontSans: ${_dartStringLiteral(lightTokens['fontSans'] as String)},');
    }
    if (lightTokens.containsKey('fontSerif')) {
      lines.add('      fontSerif: ${_dartStringLiteral(lightTokens['fontSerif'] as String)},');
    }
    if (lightTokens.containsKey('fontMono')) {
      lines.add('      fontMono: ${_dartStringLiteral(lightTokens['fontMono'] as String)},');
    }
    lines.add('    ),');

    // Dark Tokens
    lines.add('    darkTokens: _darkTokens(');
    final darkTokens = preset['darkTokens'] as Map<String, dynamic>;
    final darkFontSans = (darkTokens['fontSans'] ?? lightTokens['fontSans']) as String?;
    final darkFontSerif = (darkTokens['fontSerif'] ?? lightTokens['fontSerif']) as String?;
    final darkFontMono = (darkTokens['fontMono'] ?? lightTokens['fontMono']) as String?;
    lines.add('      radius: ${darkTokens['radius'] ?? 0.5},');
    lines.add('      spacingBase: ${darkTokens['spacingBase'] ?? 3.84},');
    final darkShadowPreset = darkTokens['shadowPreset'];
    if (darkShadowPreset == 'lightSoft') {
      lines.add('      shadows: _shadowLightSoft,');
    } else if (darkShadowPreset == 'darkStandard' || darkShadowPreset == null) {
      lines.add('      shadows: _shadowDarkStandard,');
    } else if (darkShadowPreset == 'lightStandard') {
      lines.add('      shadows: _shadowLightStandard,');
    } else if (darkShadowPreset == 'uniformCustom') {
      lines.add(
          '      shadows: _uniformShadowScale(x: ${darkTokens['shadowX']}, y: ${darkTokens['shadowY']}, blur: ${darkTokens['shadowBlur']}, spread: ${darkTokens['shadowSpread']}, color: ${darkTokens['shadowColor']}),');
    }
    if (darkFontSans != null) {
      lines.add('      fontSans: ${_dartStringLiteral(darkFontSans)},');
    }
    if (darkFontSerif != null) {
      lines.add('      fontSerif: ${_dartStringLiteral(darkFontSerif)},');
    }
    if (darkFontMono != null) {
      lines.add('      fontMono: ${_dartStringLiteral(darkFontMono)},');
    }
    lines.add('    ),');

    lines.add('  ),');
  }

  lines.add('];');
  lines.add('');

  return lines;
}

String _extractConstructorBody(String source, String field, String typeName) {
  final pattern = RegExp('$field\\s*:\\s*(?:const\\s+)?$typeName\\s*\\(');
  final match = pattern.firstMatch(source);
  if (match == null) {
    throw FormatException('Could not find $field constructor $typeName(...)');
  }
  final open = source.indexOf('(', match.start);
  final close = _findMatching(source, open, '(', ')');
  return source.substring(open + 1, close);
}

int _findMatching(String text, int openIndex, String openChar, String closeChar) {
  var depth = 0;
  var inSingleQuote = false;
  var inDoubleQuote = false;

  for (var i = openIndex; i < text.length; i++) {
    final ch = text[i];
    final prev = i > 0 ? text[i - 1] : '';
    final escaped = prev == r'\\';

    if (ch == "'" && !inDoubleQuote && !escaped) {
      inSingleQuote = !inSingleQuote;
    } else if (ch == '"' && !inSingleQuote && !escaped) {
      inDoubleQuote = !inDoubleQuote;
    }

    if (inSingleQuote || inDoubleQuote) {
      continue;
    }

    if (ch == openChar) {
      depth += 1;
    } else if (ch == closeChar) {
      depth -= 1;
      if (depth == 0) {
        return i;
      }
    }
  }

  throw FormatException('Unbalanced $openChar$closeChar pair');
}

String _unescapeDartString(String value) {
  return value
  .replaceAll(r'\"', '"')
  .replaceAll(r"\'", "'")
  .replaceAll(r'\\', r'\');
}

String _dartStringLiteral(String value) {
  final escaped = value
      .replaceAll(r'\', r'\\')
      .replaceAll("'", r"\'");
  return "'$escaped'";
}

String _normalizeWhitespace(String input) {
  return input.replaceAll(RegExp(r'\s+'), '');
}

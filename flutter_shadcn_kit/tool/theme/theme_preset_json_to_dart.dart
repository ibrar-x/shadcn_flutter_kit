import 'dart:convert';
import 'dart:io';

const List<String> _colorFields = <String>[
  'background',
  'foreground',
  'card',
  'cardForeground',
  'popover',
  'popoverForeground',
  'primary',
  'primaryForeground',
  'secondary',
  'secondaryForeground',
  'muted',
  'mutedForeground',
  'accent',
  'accentForeground',
  'destructive',
  'destructiveForeground',
  'border',
  'input',
  'ring',
  'chart1',
  'chart2',
  'chart3',
  'chart4',
  'chart5',
  'sidebar',
  'sidebarForeground',
  'sidebarPrimary',
  'sidebarPrimaryForeground',
  'sidebarAccent',
  'sidebarAccentForeground',
  'sidebarBorder',
  'sidebarRing',
];

const List<String> _shadowFields = <String>[
  'shadow2xs',
  'shadowXs',
  'shadowSm',
  'shadow',
  'shadowMd',
  'shadowLg',
  'shadowXl',
  'shadow2xl',
];

const String _defaultLightShadow =
    'const [BoxShadow(offset: Offset(0, 4), blurRadius: 8, spreadRadius: -1, color: Color(0x1A000000))]';
const String _defaultDarkShadow =
    'const [BoxShadow(offset: Offset(20.5, 16.5), blurRadius: 25.5, spreadRadius: -30, color: Color(0x12000000))]';

void main(List<String> args) {
  if (args.contains('--help') || args.contains('-h')) {
    _printUsage();
    return;
  }

  final registryDir = _findRegistryDir(Directory.current);
  if (registryDir == null) {
    stderr.writeln('Error: Could not locate lib/registry directory.');
    exitCode = 1;
    return;
  }

  final opts = _parseArgs(args);
  final inputDir = _resolvePath(
    (opts['input-dir'] as String?) ?? '${registryDir.path}/themes_preset',
  );
  final outputDir = _resolvePath(
    (opts['output-dir'] as String?) ??
        '${registryDir.path}/shared/theme/presets',
  );
  final modelsPath = _resolvePath(
    (opts['models-path'] as String?) ??
        '${registryDir.path}/shared/theme/theme_preset_models.dart',
  );
  final appThemePresetPath = _resolvePath(
    (opts['app-theme-preset-path'] as String?) ??
        '${registryDir.path}/shared/theme/app_theme_preset.dart',
  );
  final appThemePath = _resolvePath(
    (opts['app-theme-path'] as String?) ??
        '${registryDir.path}/shared/theme/app_theme.dart',
  );
  final legacyPresetPath = _resolvePath(
    (opts['legacy-preset-path'] as String?) ??
        '${registryDir.path}/shared/theme/preset_themes.dart',
  );

  final input = Directory(inputDir);
  if (!input.existsSync()) {
    stderr.writeln('Error: Input directory does not exist: $inputDir');
    exitCode = 1;
    return;
  }

  final presetId = opts['preset-id'] as String?;
  final presetJsonPath = opts['preset-json'] as String?;
  if (presetId == null && presetJsonPath == null) {
    stderr.writeln('Error: Provide --preset-id=<id> or --preset-json=<path>.');
    exitCode = 1;
    return;
  }

  final output = Directory(outputDir);
  output.createSync(recursive: true);

  final presetFile = _resolvePresetFile(
    inputDir: inputDir,
    presetId: presetId,
    presetJsonPath: presetJsonPath,
  );
  if (presetFile == null || !presetFile.existsSync()) {
    stderr.writeln('Error: Could not resolve preset json file.');
    if (presetId != null) {
      stderr.writeln('Tried: $inputDir/$presetId.json');
    }
    if (presetJsonPath != null) {
      stderr.writeln('Provided: ${_resolvePath(presetJsonPath)}');
    }
    exitCode = 1;
    return;
  }
  final map = jsonDecode(presetFile.readAsStringSync()) as Map<String, dynamic>;
  final selected = _PresetData.fromJson(map);

  File(modelsPath)
    ..createSync(recursive: true)
    ..writeAsStringSync(_buildModelsFile());

  final fileName = '${_snake(selected.id)}.dart';
  final outPath = '$outputDir/$fileName';
  File(outPath)
    ..createSync(recursive: true)
    ..writeAsStringSync(_buildPresetFile(selected, modelsPath, outPath));

  File(appThemePresetPath)
    ..createSync(recursive: true)
    ..writeAsStringSync(
      _buildAppThemePresetFile(
        modelsPath: modelsPath,
        selectedPresetPath: outPath,
        appThemePresetPath: appThemePresetPath,
        selectedVariable: selected.variableName,
      ),
    );

  _updateAppThemeImport(appThemePath, modelsPath);

  final deleteLegacy = (opts['delete-legacy'] as String?) != 'false';
  if (deleteLegacy) {
    final legacyFile = File(legacyPresetPath);
    if (legacyFile.existsSync()) {
      legacyFile.deleteSync();
    }
  }

  stdout.writeln('Generated preset Dart file: $outPath');
  stdout.writeln('Wrote models file: $modelsPath');
  stdout.writeln('Updated app theme preset: $appThemePresetPath');
  stdout.writeln('Updated app theme imports: $appThemePath');
  if (deleteLegacy) {
    stdout.writeln('Removed legacy file if present: $legacyPresetPath');
  }
}

void _printUsage() {
  stdout.writeln(
    'Usage: dart run tool/theme/theme_preset_json_to_dart.dart [options]',
  );
  stdout.writeln('');
  stdout.writeln(
    'Converts one preset json into one theme dart file for CLI installation.',
  );
  stdout.writeln(
    'Also regenerates theme preset models and updates app_theme_preset.dart.',
  );
  stdout.writeln('');
  stdout.writeln('Options:');
  stdout.writeln(
    '  --input-dir=<path>            Source json folder (default: lib/registry/themes_preset)',
  );
  stdout.writeln(
    '  --output-dir=<path>           Output folder for per-theme dart files',
  );
  stdout.writeln(
    '  --preset-id=<id>              Preset id (looks for <input-dir>/<id>.json)',
  );
  stdout.writeln(
    '  --preset-json=<path>          Explicit preset json path (overrides preset-id)',
  );
  stdout.writeln(
    '  --models-path=<path>          Output for theme_preset_models.dart',
  );
  stdout.writeln(
    '  --app-theme-preset-path=<p>   Output for app_theme_preset.dart',
  );
  stdout.writeln(
    '  --app-theme-path=<path>       app_theme.dart path to rewrite imports',
  );
  stdout.writeln(
    '  --legacy-preset-path=<path>   Legacy preset_themes.dart path to delete',
  );
  stdout.writeln(
    '  --delete-legacy=<true|false>  Delete legacy preset file (default: true)',
  );
}

Map<String, Object?> _parseArgs(List<String> args) {
  final result = <String, Object?>{};
  for (final arg in args) {
    if (!arg.startsWith('--')) {
      continue;
    }
    final eq = arg.indexOf('=');
    if (eq == -1) {
      result[arg.substring(2)] = true;
    } else {
      result[arg.substring(2, eq)] = arg.substring(eq + 1);
    }
  }
  return result;
}

String _resolvePath(String path) {
  if (path.startsWith('/')) {
    return path;
  }
  return File(path).absolute.path;
}

Directory? _findRegistryDir(Directory from) {
  Directory current = from.absolute;
  while (true) {
    final candidate = Directory('${current.path}/lib/registry');
    if (candidate.existsSync()) {
      return candidate;
    }
    final parent = current.parent;
    if (parent.path == current.path) {
      return null;
    }
    current = parent;
  }
}

String _buildModelsFile() {
  return '''// GENERATED CODE - DO NOT MODIFY BY HAND.
// Run `dart run tool/theme/theme_preset_json_to_dart.dart` to refresh.

import 'package:flutter/widgets.dart';

import 'color_scheme.dart';
import 'theme.dart';

class RegistryThemePresetTokens {
  final double radius;
  final SpacingScale spacing;
  final TrackingScale tracking;
  final ShadowScale shadows;
  final String? fontSans;
  final String? fontSerif;
  final String? fontMono;

  const RegistryThemePresetTokens({
    required this.radius,
    required this.spacing,
    required this.tracking,
    required this.shadows,
    this.fontSans,
    this.fontSerif,
    this.fontMono,
  });

  Density get density => Density.fromSpacingScale(spacing);
}

class RegistryThemePreset {
  final String id;
  final String name;
  final ColorScheme light;
  final ColorScheme dark;
  final RegistryThemePresetTokens lightTokens;
  final RegistryThemePresetTokens darkTokens;

  const RegistryThemePreset({
    required this.id,
    required this.name,
    required this.light,
    required this.dark,
    required this.lightTokens,
    required this.darkTokens,
  });
}
''';
}

String _buildPresetFile(_PresetData preset, String modelsPath, String outPath) {
  final modelsImport = _relativeImport(outPath, modelsPath);
  final light = _buildColorScheme('light', preset.light, 'Brightness.light');
  final dark = _buildColorScheme('dark', preset.dark, 'Brightness.dark');
  final lightTokens = _buildTokenScheme(
    'lightTokens',
    preset.lightTokens,
    true,
  );
  final darkTokens = _buildTokenScheme('darkTokens', preset.darkTokens, false);

  return '''// GENERATED CODE - DO NOT MODIFY BY HAND.
// Source: ${preset.id}.json

import 'package:flutter/widgets.dart';

import '$modelsImport';

final RegistryThemePreset ${preset.variableName} = RegistryThemePreset(
  id: '${preset.id}',
  name: '${_escape(preset.name)}',
$light
$dark
$lightTokens
$darkTokens
);
''';
}

String _buildAppThemePresetFile({
  required String modelsPath,
  required String selectedPresetPath,
  required String appThemePresetPath,
  required String selectedVariable,
}) {
  final modelsImport = _relativeImport(appThemePresetPath, modelsPath);
  final presetImport = _relativeImport(appThemePresetPath, selectedPresetPath);

  return '''// GENERATED CODE - DO NOT MODIFY BY HAND.
// Run `dart run tool/theme/theme_preset_json_to_dart.dart` to refresh.

import '$modelsImport';
import '$presetImport';

class InstalledThemePreset {
  static RegistryThemePreset current = $selectedVariable;
}
''';
}

File? _resolvePresetFile({
  required String inputDir,
  required String? presetId,
  required String? presetJsonPath,
}) {
  if (presetJsonPath != null && presetJsonPath.isNotEmpty) {
    return File(_resolvePath(presetJsonPath));
  }
  if (presetId != null && presetId.isNotEmpty) {
    return File('$inputDir/$presetId.json');
  }
  return null;
}

void _updateAppThemeImport(String appThemePath, String modelsPath) {
  final file = File(appThemePath);
  if (!file.existsSync()) {
    return;
  }

  final content = file.readAsStringSync();
  final modelsImport = "import '${_relativeImport(appThemePath, modelsPath)}';";

  var next = content.replaceAll(
    RegExp(r"^import 'preset_themes\.dart';\s*$\n?", multiLine: true),
    '',
  );

  if (!next.contains(modelsImport)) {
    next = next.replaceFirst(
      "import 'app_theme_preset.dart';\n",
      "import 'app_theme_preset.dart';\n$modelsImport\n",
    );
  }

  file.writeAsStringSync(next);
}

String _buildColorScheme(
  String fieldName,
  Map<String, String> scheme,
  String brightness,
) {
  final lines = <String>[];
  lines.add('  $fieldName: const ColorScheme(');
  lines.add('    brightness: $brightness,');
  for (final key in _colorFields) {
    final color = scheme[key] ?? '0xFF000000';
    lines.add('    $key: Color($color),');
  }
  lines.add('  ),');
  return lines.join('\n');
}

String _buildTokenScheme(String fieldName, _TokenData? token, bool isLight) {
  final t = token ?? _TokenData.defaults(isLight: isLight);
  final lines = <String>[];
  lines.add('  $fieldName: RegistryThemePresetTokens(');
  lines.add('    radius: ${_n(t.radius)},');
  lines.add('    spacing: SpacingScale(${_n(t.spacingBase)}),');
  lines.add('    tracking: TrackingScale(normal: ${_n(t.trackingNormal)}),');
  lines.add('    shadows: ShadowScale(');

  for (final field in _shadowFields) {
    final shadows = t.shadows[field];
    if (shadows == null || shadows.isEmpty) {
      lines.add(
        '      $field: ${isLight ? _defaultLightShadow : _defaultDarkShadow},',
      );
      continue;
    }

    final boxShadows = shadows
        .map(
          (_BoxShadowData s) =>
              'BoxShadow(offset: Offset(${_n(s.x)}, ${_n(s.y)}), blurRadius: ${_n(s.blur)}, spreadRadius: ${_n(s.spread)}, color: Color(${s.color}))',
        )
        .join(', ');
    lines.add('      $field: const [$boxShadows],');
  }

  lines.add('    ),');
  if (t.fontSans != null) {
    lines.add("    fontSans: '${_escape(t.fontSans!)}',");
  }
  if (t.fontSerif != null) {
    lines.add("    fontSerif: '${_escape(t.fontSerif!)}',");
  }
  if (t.fontMono != null) {
    lines.add("    fontMono: '${_escape(t.fontMono!)}',");
  }
  lines.add('  ),');

  return lines.join('\n');
}

String _escape(String value) => value.replaceAll(r"'", r"\\'");

String _n(num value) {
  if (value == value.roundToDouble()) {
    return value.toInt().toString();
  }
  return value.toString();
}

String _snake(String value) => value.replaceAll('-', '_').toLowerCase();

String _camel(String value) {
  final parts = value
      .split(RegExp(r'[-_\\s]+'))
      .where((String p) => p.isNotEmpty);
  var out = '';
  var first = true;
  for (final part in parts) {
    final head = part[0].toUpperCase();
    final tail = part.substring(1).toLowerCase();
    if (first) {
      out += part[0].toLowerCase() + tail;
      first = false;
    } else {
      out += '$head$tail';
    }
  }
  return out;
}

String _relativeImport(String fromPath, String toPath) {
  final fromSegments = _splitPath(File(fromPath).absolute.parent.path);
  final toSegments = _splitPath(File(toPath).absolute.path);

  var i = 0;
  while (i < fromSegments.length &&
      i < toSegments.length &&
      fromSegments[i] == toSegments[i]) {
    i += 1;
  }

  final up = List<String>.filled(fromSegments.length - i, '..');
  final down = toSegments.sublist(i);
  return [...up, ...down].join('/');
}

List<String> _splitPath(String path) {
  return path
      .replaceAll('\\', '/')
      .split('/')
      .where((String segment) => segment.isNotEmpty)
      .toList();
}

class _PresetData {
  _PresetData({
    required this.id,
    required this.name,
    required this.light,
    required this.dark,
    required this.lightTokens,
    required this.darkTokens,
  });

  final String id;
  final String name;
  final Map<String, String> light;
  final Map<String, String> dark;
  final _TokenData? lightTokens;
  final _TokenData? darkTokens;

  String get variableName => '${_camel(id)}ThemePreset';

  factory _PresetData.fromJson(Map<String, dynamic> map) {
    final tokens = (map['tokens'] as Map?)?.cast<String, dynamic>();

    return _PresetData(
      id: map['id'] as String,
      name: map['name'] as String? ?? map['id'] as String,
      light: _readScheme((map['light'] as Map).cast<String, dynamic>()),
      dark: _readScheme((map['dark'] as Map).cast<String, dynamic>()),
      lightTokens: tokens?['light'] == null
          ? null
          : _TokenData.fromJson(
              (tokens!['light'] as Map).cast<String, dynamic>(),
            ),
      darkTokens: tokens?['dark'] == null
          ? null
          : _TokenData.fromJson(
              (tokens!['dark'] as Map).cast<String, dynamic>(),
            ),
    );
  }

  static Map<String, String> _readScheme(Map<String, dynamic> map) {
    final out = <String, String>{};
    for (final field in _colorFields) {
      out[field] = (map[field] as String?) ?? '0xFF000000';
    }
    return out;
  }
}

class _TokenData {
  _TokenData({
    required this.radius,
    required this.spacingBase,
    required this.trackingNormal,
    required this.shadows,
    this.fontSans,
    this.fontSerif,
    this.fontMono,
  });

  final num radius;
  final num spacingBase;
  final num trackingNormal;
  final Map<String, List<_BoxShadowData>> shadows;
  final String? fontSans;
  final String? fontSerif;
  final String? fontMono;

  factory _TokenData.defaults({required bool isLight}) {
    final defaults = <String, List<_BoxShadowData>>{};
    for (final field in _shadowFields) {
      defaults[field] = <_BoxShadowData>[];
    }

    return _TokenData(
      radius: 0.5,
      spacingBase: isLight ? 4 : 3.84,
      trackingNormal: 0,
      shadows: defaults,
    );
  }

  factory _TokenData.fromJson(Map<String, dynamic> map) {
    final spacing =
        (map['spacing'] as Map?)?.cast<String, dynamic>() ??
        const <String, dynamic>{};
    final tracking =
        (map['tracking'] as Map?)?.cast<String, dynamic>() ??
        const <String, dynamic>{};
    final shadowsMap =
        (map['shadows'] as Map?)?.cast<String, dynamic>() ??
        const <String, dynamic>{};

    final shadows = <String, List<_BoxShadowData>>{};
    for (final field in _shadowFields) {
      final raw = shadowsMap[field] as List?;
      if (raw == null) {
        shadows[field] = <_BoxShadowData>[];
        continue;
      }
      shadows[field] = raw
          .cast<Map>()
          .map((Map v) => _BoxShadowData.fromJson(v.cast<String, dynamic>()))
          .toList();
    }

    return _TokenData(
      radius: (map['radius'] as num?) ?? 0.5,
      spacingBase: (spacing['base'] as num?) ?? 4,
      trackingNormal: (tracking['normal'] as num?) ?? 0,
      shadows: shadows,
      fontSans: map['fontSans'] as String?,
      fontSerif: map['fontSerif'] as String?,
      fontMono: map['fontMono'] as String?,
    );
  }
}

class _BoxShadowData {
  _BoxShadowData({
    required this.x,
    required this.y,
    required this.blur,
    required this.spread,
    required this.color,
  });

  final num x;
  final num y;
  final num blur;
  final num spread;
  final String color;

  factory _BoxShadowData.fromJson(Map<String, dynamic> map) {
    return _BoxShadowData(
      x: map['x'] as num,
      y: map['y'] as num,
      blur: map['blur'] as num,
      spread: map['spread'] as num,
      color: map['color'] as String,
    );
  }
}

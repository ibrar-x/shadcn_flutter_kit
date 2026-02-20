import 'dart:convert';
import 'dart:io';

void main(List<String> args) {
  if (args.contains('-h') || args.contains('--help')) {
    _printUsage();
    return;
  }

  final registryDir = _findRegistryDir(Directory.current);
  if (registryDir == null) {
    stderr.writeln('Error: Could not locate lib/registry directory.');
    exitCode = 1;
    return;
  }

  String? defaultThemeId;
  String outputFileName = 'theme.index.json';

  for (var i = 0; i < args.length; i++) {
    final arg = args[i];
    if (arg == '--default' && i + 1 < args.length) {
      defaultThemeId = args[i + 1].trim();
      i += 1;
      continue;
    }
    if (arg == '--output' && i + 1 < args.length) {
      outputFileName = args[i + 1].trim();
      i += 1;
      continue;
    }
  }

  final themesPresetDir = Directory('${registryDir.path}/themes_preset');
  if (!themesPresetDir.existsSync()) {
    stderr.writeln('Error: ${themesPresetDir.path} does not exist.');
    exitCode = 1;
    return;
  }

  final presetFiles = themesPresetDir
      .listSync()
      .whereType<File>()
      .where((file) => file.path.toLowerCase().endsWith('.json'))
      .toList()
    ..sort((a, b) => a.path.compareTo(b.path));

  if (presetFiles.isEmpty) {
    stderr.writeln('Error: No JSON files found in ${themesPresetDir.path}.');
    exitCode = 1;
    return;
  }

  final themes = <Map<String, dynamic>>[];
  final seenIds = <String>{};

  for (final file in presetFiles) {
    final content = file.readAsStringSync();
    final decoded = jsonDecode(content);
    if (decoded is! Map<String, dynamic>) {
      stderr.writeln('Skipping ${file.path}: top-level JSON is not an object.');
      continue;
    }

    final id = (decoded['id'] as String?)?.trim();
    final name = (decoded['name'] as String?)?.trim();
    final description = (decoded['description'] as String?)?.trim();
    final light = decoded['light'];

    if (id == null || id.isEmpty || name == null || name.isEmpty) {
      stderr.writeln('Skipping ${file.path}: missing required id/name.');
      continue;
    }
    if (seenIds.contains(id)) {
      stderr.writeln('Skipping ${file.path}: duplicate id "$id".');
      continue;
    }
    seenIds.add(id);

    String? primary;
    String? background;
    if (light is Map<String, dynamic>) {
      primary = light['primary'] as String?;
      background = light['background'] as String?;
    }

    final entry = <String, dynamic>{
      'id': id,
      'name': name,
      if (description != null && description.isNotEmpty) 'description': description,
      'file': 'themes_preset/${_basename(file.path)}',
      if (primary != null || background != null)
        'preview': {
          if (primary != null) 'primary': primary,
          if (background != null) 'background': background,
        },
    };

    themes.add(entry);
  }

  themes.sort((a, b) {
    final left = (a['id'] as String).toLowerCase();
    final right = (b['id'] as String).toLowerCase();
    return left.compareTo(right);
  });

  if (themes.isEmpty) {
    stderr.writeln('Error: No valid theme preset entries found.');
    exitCode = 1;
    return;
  }

  if (defaultThemeId != null && !seenIds.contains(defaultThemeId)) {
    stderr.writeln('Error: --default "$defaultThemeId" does not exist in themes_preset JSON files.');
    exitCode = 1;
    return;
  }

  final output = <String, dynamic>{
    r'$schema': 'https://flutter-shadcn.github.io/registry-directory/registry/themes.index.schema.v1.json',
    'schemaVersion': 1,
    'generatedAt': DateTime.now().toUtc().toIso8601String(),
    if (defaultThemeId != null) 'defaultThemeId': defaultThemeId,
    'themes': themes,
  };

  final outputFile = File('${registryDir.path}/$outputFileName');
  outputFile.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(output));
  stdout.writeln('Generated ${outputFile.path} with ${themes.length} theme(s).');
}

void _printUsage() {
  stdout.writeln('Usage: flutter pub run tool/theme_index_generate.dart [--default <id>] [--output <filename>]');
  stdout.writeln('');
  stdout.writeln('Generates lib/registry/theme.index.json from lib/registry/themes_preset/*.json');
}

Directory? _findRegistryDir(Directory from) {
  Directory current = from.absolute;
  while (true) {
    final candidate = Directory('${current.path}/lib/registry');
    if (candidate.existsSync()) {
      final marker = File('${candidate.path}/themes.index.schema.json');
      if (marker.existsSync()) {
        return candidate;
      }
    }

    final parent = current.parent;
    if (parent.path == current.path) {
      return null;
    }
    current = parent;
  }
}

String _basename(String path) {
  final normalized = path.replaceAll('\\', '/');
  final slash = normalized.lastIndexOf('/');
  if (slash == -1) {
    return normalized;
  }
  return normalized.substring(slash + 1);
}
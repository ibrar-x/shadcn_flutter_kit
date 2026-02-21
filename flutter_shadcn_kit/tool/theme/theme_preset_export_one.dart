import 'dart:convert';
import 'dart:io';

import 'theme_preset_dart_parser.dart';

void main(List<String> args) {
  if (args.contains('-h') || args.contains('--help')) {
    _printUsage();
    return;
  }

  if (args.isEmpty) {
    stderr.writeln('Error: Missing theme id.');
    _printUsage();
    exitCode = 1;
    return;
  }

  final themeId = args.first.trim();
  final registryDir = findRegistryDir(Directory.current);
  if (registryDir == null) {
    stderr.writeln('Error: Could not locate lib/registry directory.');
    exitCode = 1;
    return;
  }

  final presetSourceFile = File(
    '${registryDir.path}/shared/theme/preset_themes.dart',
  );
  if (!presetSourceFile.existsSync()) {
    stderr.writeln('Error: ${presetSourceFile.path} not found.');
    exitCode = 1;
    return;
  }

  final presets = parseThemePresetsFromDart(
    presetSourceFile.readAsStringSync(),
  );
  final preset = presets
      .where((item) => (item['id'] as String) == themeId)
      .firstOrNull;
  if (preset == null) {
    stderr.writeln('Error: Theme "$themeId" not found in preset_themes.dart.');
    exitCode = 1;
    return;
  }

  final outputDir = Directory('${registryDir.path}/themes_preset');
  if (!outputDir.existsSync()) {
    outputDir.createSync(recursive: true);
  }

  final outputFile = File('${outputDir.path}/${preset['id']}.json');
  final outputMap = withThemeSchema(
    preset: preset,
    generatedAt: DateTime.now().toUtc().toIso8601String(),
  );

  outputFile.writeAsStringSync(
    const JsonEncoder.withIndent('  ').convert(outputMap),
  );
  stdout.writeln('Generated ${outputFile.path}');
}

void _printUsage() {
  stdout.writeln(
    'Usage: dart run tool/theme/theme_preset_export_one.dart <theme-id>',
  );
  stdout.writeln('');
  stdout.writeln(
    'Exports one registry Dart theme preset to lib/registry/themes_preset/<theme-id>.json',
  );
}

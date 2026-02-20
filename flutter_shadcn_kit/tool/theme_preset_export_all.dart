import 'dart:convert';
import 'dart:io';

import 'theme_preset_dart_parser.dart';

void main(List<String> args) {
  if (args.contains('-h') || args.contains('--help')) {
    _printUsage();
    return;
  }

  final registryDir = findRegistryDir(Directory.current);
  if (registryDir == null) {
    stderr.writeln('Error: Could not locate lib/registry directory.');
    exitCode = 1;
    return;
  }

  final presetSourceFile = File('${registryDir.path}/shared/theme/preset_themes.dart');
  if (!presetSourceFile.existsSync()) {
    stderr.writeln('Error: ${presetSourceFile.path} not found.');
    exitCode = 1;
    return;
  }

  final outputDir = Directory('${registryDir.path}/themes_preset');
  if (!outputDir.existsSync()) {
    outputDir.createSync(recursive: true);
  }

  final generatedAt = DateTime.now().toUtc().toIso8601String();
  final presets = parseThemePresetsFromDart(presetSourceFile.readAsStringSync());
  var count = 0;

  for (final preset in presets) {
    final outputFile = File('${outputDir.path}/${preset['id']}.json');
    final jsonMap = withThemeSchema(preset: preset, generatedAt: generatedAt);

    outputFile.writeAsStringSync(
      const JsonEncoder.withIndent('  ').convert(jsonMap),
    );
    count += 1;
  }

  stdout.writeln('Generated $count preset file(s) in ${outputDir.path}');
}

void _printUsage() {
  stdout.writeln('Usage: flutter pub run tool/theme_preset_export_all.dart');
  stdout.writeln('');
  stdout.writeln('Exports all registry Dart theme presets to lib/registry/themes_preset/*.json');
}
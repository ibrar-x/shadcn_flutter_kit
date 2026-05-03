import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';

import 'theme_preset_json_to_dart.dart';

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

  var outputFileName = 'manifests/theme.index.json';
  for (var i = 0; i < args.length; i++) {
    if (args[i] == '--output' && i + 1 < args.length) {
      outputFileName = args[i + 1].trim();
      i += 1;
    }
  }

  final themesPresetDir = Directory('${registryDir.path}/themes_preset');
  if (!themesPresetDir.existsSync()) {
    stderr.writeln('Error: ${themesPresetDir.path} does not exist.');
    exitCode = 1;
    return;
  }

  final presetFiles =
      themesPresetDir
          .listSync()
          .whereType<File>()
          .where((file) => file.path.toLowerCase().endsWith('.json'))
          .toList()
        ..sort((left, right) => left.path.compareTo(right.path));

  if (presetFiles.isEmpty) {
    stderr.writeln('Error: No JSON files found in ${themesPresetDir.path}.');
    exitCode = 1;
    return;
  }

  final generatedRoot = Directory(
    '${registryDir.path}/$defaultThemeArtifactSourceRoot',
  );
  if (generatedRoot.existsSync()) {
    generatedRoot.deleteSync(recursive: true);
  }
  generatedRoot.createSync(recursive: true);

  final manifestThemes = <Map<String, dynamic>>[];
  final seenNames = <String>{};

  for (final file in presetFiles) {
    final decoded = jsonDecode(file.readAsStringSync());
    if (decoded is! Map<String, dynamic>) {
      stderr.writeln('Skipping ${file.path}: top-level JSON is not an object.');
      continue;
    }

    final entry = buildThemeArtifactManifestEntry(
      presetJson: decoded,
      sourcePath: 'themes_preset/${_basename(file.path)}',
    );

    if (!seenNames.add(entry.name)) {
      stderr.writeln(
        'Skipping ${file.path}: duplicate theme name "${entry.name}".',
      );
      continue;
    }

    final manifestFiles = <Map<String, dynamic>>[];
    for (final artifact in entry.files) {
      final outFile = File('${registryDir.path}/${artifact.source}');
      outFile.parent.createSync(recursive: true);
      outFile.writeAsStringSync(_ensureTrailingNewline(artifact.content));

      manifestFiles.add(<String, dynamic>{
        'source': artifact.source,
        'target': artifact.target,
        'sha256': sha256.convert(outFile.readAsBytesSync()).toString(),
      });
    }

    manifestFiles.sort((left, right) {
      final leftSource = left['source'] as String;
      final rightSource = right['source'] as String;
      return leftSource.compareTo(rightSource);
    });

    manifestThemes.add(<String, dynamic>{
      'name': entry.name,
      'label': entry.label,
      if (entry.description != null && entry.description!.trim().isNotEmpty)
        'description': entry.description,
      'source': entry.source,
      'files': manifestFiles,
    });
  }

  manifestThemes.sort((left, right) {
    final leftName = (left['name'] as String).toLowerCase();
    final rightName = (right['name'] as String).toLowerCase();
    return leftName.compareTo(rightName);
  });

  if (manifestThemes.isEmpty) {
    stderr.writeln('Error: No valid theme artifact entries found.');
    exitCode = 1;
    return;
  }

  final output = <String, dynamic>{
    r'$schema':
        'https://flutter-shadcn.github.io/registry-directory/registry/themes.index.schema.v1.json',
    'schemaVersion': 1,
    'generatedAt': DateTime.now().toUtc().toIso8601String(),
    'themes': manifestThemes,
  };

  final outputFile = File('${registryDir.path}/$outputFileName');
  outputFile.parent.createSync(recursive: true);
  outputFile.writeAsStringSync(
    '${const JsonEncoder.withIndent('  ').convert(output)}\n',
  );
  stdout.writeln(
    'Generated ${outputFile.path} with ${manifestThemes.length} theme artifact entr${manifestThemes.length == 1 ? 'y' : 'ies'}.',
  );
}

void _printUsage() {
  stdout.writeln(
    'Usage: dart run tool/theme/theme_index_generate.dart [--output <filename>]',
  );
  stdout.writeln('');
  stdout.writeln(
    'Generates lib/registry/manifests/theme.index.json and per-theme install artifacts from lib/registry/themes_preset/*.json',
  );
}

Directory? _findRegistryDir(Directory from) {
  Directory current = from.absolute;
  while (true) {
    final candidate = Directory('${current.path}/lib/registry');
    if (candidate.existsSync()) {
      final marker = File(
        '${candidate.path}/manifests/themes.index.schema.json',
      );
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

String _ensureTrailingNewline(String content) {
  if (content.endsWith('\n')) {
    return content;
  }
  return '$content\n';
}

String _basename(String path) {
  final normalized = path.replaceAll('\\', '/');
  final slash = normalized.lastIndexOf('/');
  if (slash == -1) {
    return normalized;
  }
  return normalized.substring(slash + 1);
}

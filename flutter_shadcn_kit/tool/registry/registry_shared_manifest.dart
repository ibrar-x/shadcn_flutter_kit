import 'dart:convert';
import 'dart:io';

typedef JsonMap = Map<String, dynamic>;

typedef JsonList = List<dynamic>;

Directory? _findRepoRoot(Directory start) {
  Directory current = start.absolute;
  while (true) {
    final candidate = File('${current.path}/lib/registry/components.json');
    if (candidate.existsSync()) {
      return current;
    }
    final parent = current.parent;
    if (parent.path == current.path) {
      return null;
    }
    current = parent;
  }
}

JsonMap _readJson(File file) {
  return jsonDecode(file.readAsStringSync()) as JsonMap;
}

void _writeJson(File file, Object data) {
  final encoder = const JsonEncoder.withIndent('  ');
  file.writeAsStringSync('${encoder.convert(data)}\n');
}

class _ParsedArgs {
  _ParsedArgs(this.values, this.flags);

  final Map<String, List<String>> values;
  final Set<String> flags;

  bool hasFlag(String name) => flags.contains(name);
  String? getValue(String name) => values[name]?.last;
}

_ParsedArgs _parseArgs(List<String> args) {
  final values = <String, List<String>>{};
  final flags = <String>{};
  for (var i = 0; i < args.length; i++) {
    final arg = args[i];
    if (!arg.startsWith('--')) continue;
    final trimmed = arg.substring(2);
    if (trimmed.isEmpty) continue;
    final eqIndex = trimmed.indexOf('=');
    if (eqIndex != -1) {
      final key = trimmed.substring(0, eqIndex);
      final value = trimmed.substring(eqIndex + 1);
      values.putIfAbsent(key, () => []).add(value);
      continue;
    }
    if (i + 1 < args.length && !args[i + 1].startsWith('--')) {
      final value = args[i + 1];
      i += 1;
      values.putIfAbsent(trimmed, () => []).add(value);
      continue;
    }
    flags.add(trimmed);
  }
  return _ParsedArgs(values, flags);
}

int _parseManifestVersion(dynamic value, {int fallback = 1}) {
  if (value is int) return value;
  if (value is String) {
    final parsed = int.tryParse(value);
    if (parsed != null) return parsed;
  }
  return fallback;
}

void _printUsage() {
  stdout.writeln(
    'Usage: dart run tool/registry/registry_shared_manifest.dart [options]',
  );
  stdout.writeln('');
  stdout.writeln(
    'Generates shared_manifest.json from registry/shared and components.json.',
  );
  stdout.writeln('');
  stdout.writeln('Options:');
  stdout.writeln(
    '  --bump-manifest-version       Increment manifestVersion in shared manifest.',
  );
  stdout.writeln(
    '  --set-manifest-version <int>  Set manifestVersion explicitly.',
  );
  stdout.writeln('  --force                       Skip manifestVersion guard.');
  stdout.writeln('  -h, --help                    Show this help.');
  stdout.writeln('');
  stdout.writeln(
    'Notes: If manifestVersion > 1, the script refuses to run unless',
  );
  stdout.writeln(
    '  --bump-manifest-version, --set-manifest-version, or --force is used.',
  );
}

List<String> _listFilesRelative(Directory baseDir) {
  final result = <String>[];
  for (final entity in baseDir.listSync(recursive: true)) {
    if (entity is! File) continue;
    final rel = entity.path
        .substring(baseDir.path.length + 1)
        .replaceAll('\\', '/');
    result.add(rel);
  }
  result.sort();
  return result;
}

String? _extractSource(dynamic entry) {
  if (entry is String) return entry;
  if (entry is Map && entry['source'] is String) {
    return entry['source'] as String;
  }
  return null;
}

void main(List<String> args) {
  if (args.contains('-h') || args.contains('--help')) {
    _printUsage();
    return;
  }

  final parsed = _parseArgs(args);
  final force = parsed.hasFlag('force');
  final bumpManifest = parsed.hasFlag('bump-manifest-version');
  final setManifestRaw = parsed.getValue('set-manifest-version');

  int? setManifestVersion;
  if (setManifestRaw != null && setManifestRaw.isNotEmpty) {
    setManifestVersion = int.tryParse(setManifestRaw);
    if (setManifestVersion == null || setManifestVersion < 1) {
      stderr.writeln(
        'Error: --set-manifest-version must be a positive integer.',
      );
      exitCode = 2;
      return;
    }
  }

  final root = _findRepoRoot(Directory.current);
  if (root == null) {
    stderr.writeln('Error: Could not locate lib/registry/components.json');
    exitCode = 1;
    return;
  }

  final registryDir = Directory('${root.path}/lib/registry');
  final componentsJson = File('${registryDir.path}/components.json');
  if (!componentsJson.existsSync()) {
    stderr.writeln(
      'Error: components.json not found at ${componentsJson.path}',
    );
    exitCode = 1;
    return;
  }

  final sharedRoot = Directory('${registryDir.path}/shared');
  if (!sharedRoot.existsSync()) {
    stderr.writeln('Error: shared folder not found at ${sharedRoot.path}');
    exitCode = 1;
    return;
  }

  final existingManifest = File('${sharedRoot.path}/shared_manifest.json');
  var manifestVersion = 1;
  if (existingManifest.existsSync()) {
    final existing = _readJson(existingManifest);
    manifestVersion = _parseManifestVersion(existing['manifestVersion']);
  }
  if (manifestVersion > 1 &&
      !force &&
      setManifestVersion == null &&
      !bumpManifest) {
    stderr.writeln(
      'Refusing to update shared manifest: manifestVersion is $manifestVersion. '
      'Use --bump-manifest-version, --set-manifest-version, or --force to override.',
    );
    exitCode = 2;
    return;
  }
  if (setManifestVersion != null) {
    manifestVersion = setManifestVersion;
  } else if (bumpManifest) {
    manifestVersion += 1;
  } else if (manifestVersion < 1) {
    manifestVersion = 1;
  }

  final registry = _readJson(componentsJson);
  final sharedEntries = (registry['shared'] as JsonList?) ?? <dynamic>[];

  final allFiles = _listFilesRelative(sharedRoot);
  final allFileSet = allFiles.toSet();
  final referencedFiles = <String>{};
  final missingFiles = <String>[];

  final groups = <JsonMap>[];
  for (final entry in sharedEntries) {
    if (entry is! Map) continue;
    final id = entry['id'];
    if (id is! String || id.isEmpty) continue;

    final files = <JsonMap>[];
    final rawFiles = (entry['files'] as List?) ?? <dynamic>[];
    for (final item in rawFiles) {
      final source = _extractSource(item);
      if (source == null) continue;
      if (!source.startsWith('registry/shared/')) continue;
      final rel = source.substring('registry/shared/'.length);
      if (!allFileSet.contains(rel)) {
        missingFiles.add(source);
      } else {
        referencedFiles.add(rel);
      }
      files.add({
        'path': rel,
        'source': source,
        'destination': (item is Map && item['destination'] is String)
            ? item['destination']
            : '{sharedPath}/$rel',
      });
    }

    files.sort((a, b) => (a['path'] as String).compareTo(b['path'] as String));

    groups.add({
      'id': id,
      if (entry['description'] is String) 'description': entry['description'],
      'files': files,
    });
  }

  groups.sort((a, b) => (a['id'] as String).compareTo(b['id'] as String));

  final ungroupedFiles = allFiles
      .where((file) => !referencedFiles.contains(file))
      .toList();

  final manifest = <String, dynamic>{
    r'$schema': './shared_manifest.schema.json',
    'manifestVersion': manifestVersion,
    'schemaVersion': 1,
    'generatedAt': DateTime.now().toUtc().toIso8601String(),
    'root': 'registry/shared',
    'files': allFiles,
    'groups': groups,
    'missingFiles': missingFiles..sort(),
    'ungroupedFiles': ungroupedFiles..sort(),
  };

  final outFile = File('${sharedRoot.path}/shared_manifest.json');
  _writeJson(outFile, manifest);

  stdout.writeln('Shared manifest generated at ${outFile.path}.');
  stdout.writeln('Shared files: ${allFiles.length}.');
  stdout.writeln('Groups: ${groups.length}.');
  if (missingFiles.isNotEmpty) {
    stdout.writeln('Missing shared files: ${missingFiles.length}.');
  }
  if (ungroupedFiles.isNotEmpty) {
    stdout.writeln('Ungrouped shared files: ${ungroupedFiles.length}.');
  }
}

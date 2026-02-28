import 'dart:convert';
import 'dart:io';

import '../common/registry_component_metadata.dart';

typedef JsonMap = Map<String, dynamic>;

typedef JsonList = List<dynamic>;

Directory? _findRepoRoot(Directory start) {
  Directory current = start.absolute;
  while (true) {
    final candidate = File(
      '${current.path}/lib/registry/manifests/components.json',
    );
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

String _basename(String path) {
  final normalized = path.replaceAll('\\', '/');
  final parts = normalized.split('/');
  for (var i = parts.length - 1; i >= 0; i--) {
    final part = parts[i];
    if (part.isNotEmpty) return part;
  }
  return '';
}

JsonMap _readJson(File file) {
  return jsonDecode(file.readAsStringSync()) as JsonMap;
}

bool _deepEquals(dynamic a, dynamic b) {
  if (a is Map && b is Map) {
    if (a.length != b.length) return false;
    for (final key in a.keys) {
      if (!b.containsKey(key)) return false;
      if (!_deepEquals(a[key], b[key])) return false;
    }
    return true;
  }
  if (a is List && b is List) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (!_deepEquals(a[i], b[i])) return false;
    }
    return true;
  }
  return a == b;
}

String? _extractSource(dynamic entry) {
  if (entry is String) return entry;
  if (entry is Map && entry['source'] is String) {
    return entry['source'] as String;
  }
  return null;
}

List<Map<String, String>> _buildFileMappings({
  required Directory registryDir,
  required Directory entryDir,
  required String type,
}) {
  final files = <Map<String, String>>[];
  final baseRel = entryDir.path
      .substring(registryDir.path.length + 1)
      .replaceAll('\\', '/');
  final relFiles = listComponentSourceFilesRelative(entryDir);
  for (final rel in relFiles) {
    final registryRel = '$baseRel/$rel';
    final source = type == 'components' ? 'registry/$registryRel' : registryRel;
    final destination = '{installPath}/$registryRel';
    files.add({'source': source, 'destination': destination});
  }
  return files;
}

bool _mapsEqual(List<Map<String, String>> a, List<Map<String, String>> b) {
  if (a.length != b.length) return false;
  for (var i = 0; i < a.length; i++) {
    if (a[i]['source'] != b[i]['source'] ||
        a[i]['destination'] != b[i]['destination']) {
      return false;
    }
  }
  return true;
}

void _printUsage() {
  stdout.writeln('Usage: dart run tool/registry/registry_verify.dart');
  stdout.writeln('');
  stdout.writeln('Validates registry/components.json against the filesystem:');
  stdout.writeln('  - duplicate/missing/extra component entries');
  stdout.writeln('  - file list mismatches');
  stdout.writeln('  - meta.json presence and id/category alignment');
  stdout.writeln('  - meta.json file list matches');
  stdout.writeln('  - shared deps / component deps / pubspec deps validity');
  stdout.writeln('  - shared file coverage and duplicates');
  stdout.writeln('  - docs snapshot consistency');
  stdout.writeln('');
  stdout.writeln('Options:');
  stdout.writeln('  -h, --help  Show this help.');
}

void main(List<String> args) {
  if (args.contains('-h') || args.contains('--help')) {
    _printUsage();
    return;
  }

  final root = _findRepoRoot(Directory.current);
  if (root == null) {
    stderr.writeln(
      'Error: Could not locate lib/registry/manifests/components.json',
    );
    exitCode = 1;
    return;
  }

  final registryDir = Directory('${root.path}/lib/registry');
  final componentsJson = File('${registryDir.path}/manifests/components.json');
  if (!componentsJson.existsSync()) {
    stderr.writeln(
      'Error: components.json not found at ${componentsJson.path}',
    );
    exitCode = 1;
    return;
  }

  final registry = _readJson(componentsJson);
  final entries = (registry['components'] as JsonList?) ?? <dynamic>[];
  final sharedEntries = (registry['shared'] as JsonList?) ?? <dynamic>[];

  final ids = <String>[];
  final duplicates = <String>{};
  final idSet = <String>{};

  for (final entry in entries) {
    if (entry is! Map) continue;
    final id = entry['id'];
    if (id is! String || id.isEmpty) continue;
    if (idSet.contains(id)) {
      duplicates.add(id);
    } else {
      idSet.add(id);
      ids.add(id);
    }
  }

  final missingEntries = <String>[];
  final extraEntries = <String>[];
  final fileMismatches = <String>[];
  final metaMissing = <String>[];
  final metaMismatches = <String>[];
  final metaFileMismatches = <String>[];
  final invalidSharedDeps = <String>[];
  final invalidComponentDeps = <String>[];
  final invalidPubspecDeps = <String>[];
  final docsMismatch = <String>[];
  final missingSharedFiles = <String>[];
  final duplicateSharedIds = <String>{};
  final duplicateSharedFiles = <String>{};

  final dirIndex = <String, Directory>{};

  for (final type in ['components', 'composites']) {
    final rootDir = Directory('${registryDir.path}/$type');
    if (!rootDir.existsSync()) continue;
    for (final categoryDir in rootDir.listSync().whereType<Directory>()) {
      for (final entryDir in categoryDir.listSync().whereType<Directory>()) {
        final name = _basename(entryDir.path);
        if (name.startsWith('_') || name.startsWith('.')) continue;
        dirIndex[name] = entryDir;
      }
    }
  }

  for (final id in dirIndex.keys) {
    if (!idSet.contains(id)) {
      missingEntries.add(id);
    }
  }

  for (final id in idSet) {
    if (!dirIndex.containsKey(id)) {
      extraEntries.add(id);
    }
  }

  for (final entry in entries) {
    if (entry is! Map) continue;
    final id = entry['id'];
    if (id is! String || id.isEmpty) continue;
    final dir = dirIndex[id];
    if (dir == null) continue;

    final rel = dir.path
        .substring(registryDir.path.length + 1)
        .replaceAll('\\', '/');
    final type = rel.startsWith('components/') ? 'components' : 'composites';

    final expected = _buildFileMappings(
      registryDir: registryDir,
      entryDir: dir,
      type: type,
    );
    expected.sort((a, b) => a['source']!.compareTo(b['source']!));

    final files = entry['files'] as List?;
    if (files == null) {
      fileMismatches.add(id);
      continue;
    }
    final actual = files
        .whereType<Map>()
        .map(
          (e) => {
            'source': e['source']?.toString() ?? '',
            'destination': e['destination']?.toString() ?? '',
          },
        )
        .toList();
    actual.sort((a, b) => a['source']!.compareTo(b['source']!));

    if (!_mapsEqual(expected, actual)) {
      fileMismatches.add(id);
    }
  }

  final docsSnapshots = <File>{
    File('${root.path}/docs/assets/registry/components.json'),
    File('${root.parent.path}/docs/assets/registry/components.json'),
  };
  for (final docsSnapshot in docsSnapshots) {
    if (!docsSnapshot.existsSync()) continue;
    final docsRegistry = _readJson(docsSnapshot);
    if (!_deepEquals(registry, docsRegistry)) {
      docsMismatch.add(docsSnapshot.path);
    }
  }

  final sharedIds = <String>{};
  final sharedSources = <String>{};
  for (final entry in sharedEntries) {
    if (entry is! Map) continue;
    final id = entry['id'];
    if (id is! String || id.isEmpty) continue;
    if (sharedIds.contains(id)) {
      duplicateSharedIds.add(id);
    } else {
      sharedIds.add(id);
    }
    final files = entry['files'] as List? ?? <dynamic>[];
    for (final file in files) {
      final source = _extractSource(file);
      if (source == null) continue;
      if (sharedSources.contains(source)) {
        duplicateSharedFiles.add(source);
      } else {
        sharedSources.add(source);
      }
    }
  }

  final sharedRoot = Directory('${registryDir.path}/shared');
  final sharedFiles = <String>{};
  if (sharedRoot.existsSync()) {
    for (final rel in listSharedSourceFilesRelative(sharedRoot)) {
      sharedFiles.add('registry/shared/$rel');
    }
  }
  for (final source in sharedFiles) {
    if (!sharedSources.contains(source)) {
      missingSharedFiles.add(source);
    }
  }

  for (final entry in dirIndex.entries) {
    final id = entry.key;
    final dir = entry.value;
    final category = _basename(dir.parent.path);
    final metadata = ComponentMetadataPaths(entryDir: dir, id: id);
    final metaFile = preferredFile(
      canonical: metadata.canonicalMeta,
      legacy: metadata.legacyMeta,
    );
    if (!metaFile.existsSync()) {
      metaMissing.add(id);
      continue;
    }
    final meta = _readJson(metaFile);
    final metaId = meta['id'];
    final metaCategory = meta['category'];
    if (metaId != id || metaCategory != category) {
      metaMismatches.add(id);
    }

    final deps = meta['dependencies'];
    if (deps is Map) {
      final shared = deps['shared'];
      if (shared is List) {
        for (final item in shared) {
          if (item is String && item.isNotEmpty && !sharedIds.contains(item)) {
            invalidSharedDeps.add('$id:$item');
          }
        }
      }
      final components = deps['components'];
      if (components is List) {
        for (final item in components) {
          if (item is String && item.isNotEmpty && !idSet.contains(item)) {
            invalidComponentDeps.add('$id:$item');
          }
        }
      }
      final pubspec = deps['pubspec'];
      if (pubspec is Map) {
        for (final entry in pubspec.entries) {
          if (entry.key is! String || entry.value is! String) {
            invalidPubspecDeps.add(id);
            break;
          }
        }
      } else if (pubspec != null) {
        invalidPubspecDeps.add(id);
      }
    }

    final metaFiles = meta['files'];
    if (metaFiles is List) {
      final actual = listComponentSourceFilesRelative(dir);
      final listed = metaFiles.whereType<String>().toList()..sort();
      actual.sort();
      if (actual.length != listed.length) {
        metaFileMismatches.add(id);
      } else {
        for (var i = 0; i < actual.length; i++) {
          if (actual[i] != listed[i]) {
            metaFileMismatches.add(id);
            break;
          }
        }
      }
    }
  }

  stdout.writeln('Registry verification summary:');
  stdout.writeln('  Total entries: ${idSet.length}');
  stdout.writeln('  Duplicate ids: ${duplicates.length}');
  stdout.writeln('  Missing entries: ${missingEntries.length}');
  stdout.writeln('  Extra entries: ${extraEntries.length}');
  stdout.writeln('  File list mismatches: ${fileMismatches.length}');
  stdout.writeln('  Meta missing: ${metaMissing.length}');
  stdout.writeln('  Meta mismatches: ${metaMismatches.length}');
  stdout.writeln('  Meta file list mismatches: ${metaFileMismatches.length}');
  stdout.writeln('  Invalid shared deps: ${invalidSharedDeps.length}');
  stdout.writeln('  Invalid component deps: ${invalidComponentDeps.length}');
  stdout.writeln('  Invalid pubspec deps: ${invalidPubspecDeps.length}');
  stdout.writeln('  Shared duplicate ids: ${duplicateSharedIds.length}');
  stdout.writeln('  Shared duplicate files: ${duplicateSharedFiles.length}');
  stdout.writeln('  Missing shared files: ${missingSharedFiles.length}');
  stdout.writeln(
    '  Docs snapshot mismatch: ${docsMismatch.isNotEmpty ? 1 : 0}',
  );

  if (duplicates.isNotEmpty) {
    stdout.writeln('Duplicate ids: ${duplicates.toList()..sort()}');
  }
  if (missingEntries.isNotEmpty) {
    stdout.writeln('Missing entries: ${missingEntries..sort()}');
  }
  if (extraEntries.isNotEmpty) {
    stdout.writeln('Extra entries: ${extraEntries..sort()}');
  }
  if (fileMismatches.isNotEmpty) {
    stdout.writeln('File list mismatches: ${fileMismatches..sort()}');
  }
  if (metaMissing.isNotEmpty) {
    stdout.writeln('Missing meta.json: ${metaMissing..sort()}');
  }
  if (metaMismatches.isNotEmpty) {
    stdout.writeln('Meta id/category mismatches: ${metaMismatches..sort()}');
  }
  if (metaFileMismatches.isNotEmpty) {
    stdout.writeln('Meta file list mismatches: ${metaFileMismatches..sort()}');
  }
  if (invalidSharedDeps.isNotEmpty) {
    stdout.writeln('Invalid shared deps: ${invalidSharedDeps..sort()}');
  }
  if (invalidComponentDeps.isNotEmpty) {
    stdout.writeln('Invalid component deps: ${invalidComponentDeps..sort()}');
  }
  if (invalidPubspecDeps.isNotEmpty) {
    stdout.writeln('Invalid pubspec deps: ${invalidPubspecDeps..sort()}');
  }
  if (duplicateSharedIds.isNotEmpty) {
    stdout.writeln(
      'Duplicate shared ids: ${duplicateSharedIds.toList()..sort()}',
    );
  }
  if (duplicateSharedFiles.isNotEmpty) {
    stdout.writeln(
      'Duplicate shared files: ${duplicateSharedFiles.toList()..sort()}',
    );
  }
  if (missingSharedFiles.isNotEmpty) {
    stdout.writeln('Missing shared files: ${missingSharedFiles..sort()}');
  }
  if (docsMismatch.isNotEmpty) {
    stdout.writeln('Docs snapshot mismatch: ${docsMismatch.first}');
  }

  if (duplicates.isNotEmpty ||
      missingEntries.isNotEmpty ||
      extraEntries.isNotEmpty ||
      fileMismatches.isNotEmpty ||
      metaMissing.isNotEmpty ||
      metaMismatches.isNotEmpty ||
      metaFileMismatches.isNotEmpty ||
      invalidSharedDeps.isNotEmpty ||
      invalidComponentDeps.isNotEmpty ||
      invalidPubspecDeps.isNotEmpty ||
      duplicateSharedIds.isNotEmpty ||
      duplicateSharedFiles.isNotEmpty ||
      missingSharedFiles.isNotEmpty ||
      docsMismatch.isNotEmpty) {
    exitCode = 2;
  }
}

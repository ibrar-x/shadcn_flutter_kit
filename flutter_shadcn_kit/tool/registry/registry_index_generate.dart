import 'dart:convert';
import 'dart:io';

import '../common/registry_component_metadata.dart';

const indexSchemaVersion = 1;

/// Validates that a component entry matches the required schema structure
void validateComponentEntry(Map<String, dynamic> component, int index) {
  final errors = <String>[];
  final id = component['id'] as String? ?? 'unknown';

  // Required fields
  if (!component.containsKey('id') || component['id'] is! String) {
    errors.add('Missing or invalid id');
  }
  if (!component.containsKey('name') || component['name'] is! String) {
    errors.add('Missing or invalid name');
  }
  if (!component.containsKey('category') || component['category'] is! String) {
    errors.add('Missing or invalid category');
  }
  if (!component.containsKey('description') ||
      component['description'] is! String) {
    errors.add('Missing or invalid description');
  }
  if (!component.containsKey('tags') || component['tags'] is! List) {
    errors.add('Missing or invalid tags');
  }
  if (!component.containsKey('install') || component['install'] is! String) {
    errors.add('Missing or invalid install');
  }
  if (!component.containsKey('import') || component['import'] is! String) {
    errors.add('Missing or invalid import');
  }
  if (!component.containsKey('importPath') ||
      component['importPath'] is! String) {
    errors.add('Missing or invalid importPath');
  }

  // Validate api structure
  if (!component.containsKey('api') || component['api'] is! Map) {
    errors.add('Missing or invalid api');
  } else {
    final api = component['api'] as Map;
    if (!api.containsKey('constructors') || api['constructors'] is! List) {
      errors.add('api.constructors is required and must be an array');
    }
    if (!api.containsKey('callbacks') || api['callbacks'] is! List) {
      errors.add('api.callbacks is required and must be an array');
    }
  }

  // Validate examples structure
  if (!component.containsKey('examples') || component['examples'] is! Map) {
    errors.add('Missing or invalid examples');
  } else {
    final examples = component['examples'] as Map;
    if (!examples.containsKey('minimal') || examples['minimal'] is! String) {
      errors.add('examples.minimal is required and must be a string');
    }
  }

  // Validate dependencies structure
  if (!component.containsKey('dependencies') ||
      component['dependencies'] is! Map) {
    errors.add('Missing or invalid dependencies');
  } else {
    final deps = component['dependencies'] as Map;
    if (!deps.containsKey('pubspec') || deps['pubspec'] is! Map) {
      errors.add('dependencies.pubspec is required and must be an object');
    }
    if (!deps.containsKey('shared') || deps['shared'] is! List) {
      errors.add('dependencies.shared is required and must be an array');
    }
  }

  // Validate related
  if (!component.containsKey('related') || component['related'] is! List) {
    errors.add('Missing or invalid related');
  }

  if (errors.isNotEmpty) {
    print('❌ Schema validation failed for component[$index] "$id":');
    for (final error in errors) {
      print('   - $error');
    }
    throw Exception('Schema validation failed for component "$id"');
  }
}

/// Validates the entire index structure
void validateIndex(Map<String, dynamic> index) {
  final errors = <String>[];

  if (!index.containsKey('schemaVersion') || index['schemaVersion'] is! int) {
    errors.add('Missing or invalid schemaVersion');
  }
  if (!index.containsKey('generatedAt') || index['generatedAt'] is! String) {
    errors.add('Missing or invalid generatedAt');
  }
  if (!index.containsKey('components') || index['components'] is! List) {
    errors.add('Missing or invalid components array');
  }

  if (errors.isNotEmpty) {
    print('❌ Index schema validation failed:');
    for (final error in errors) {
      print('   - $error');
    }
    throw Exception('Index schema validation failed');
  }

  // Validate each component
  final components = index['components'] as List;
  for (var i = 0; i < components.length; i++) {
    if (components[i] is Map<String, dynamic>) {
      validateComponentEntry(components[i] as Map<String, dynamic>, i);
    }
  }
}

void _printUsage() {
  stdout.writeln('Usage: dart run tool/registry/registry_index_generate.dart');
  stdout.writeln('');
  stdout.writeln(
    'Generates registry/index.json from components.json + meta.json.',
  );
  stdout.writeln('Optionally merges <id>.meta.json if present.');
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

  final registryDir = '${root.path}/lib/registry';
  final componentsJson = '$registryDir/manifests/components.json';
  final indexJson = '$registryDir/manifests/index.json';

  final registry = readJson(componentsJson);

  if (registry['components'] is! List) {
    throw Exception(
      'registry/components.json must have a top-level "components" array',
    );
  }

  final items = <Map<String, dynamic>>[];
  final components = registry['components'] as List;

  for (final entry in components) {
    final entryMap = entry as Map<String, dynamic>;
    final id = entryMap['id'] as String;
    final category = entryMap['category'] as String;

    // Try to find the component folder
    String? dir;

    // First, check if files array has a source path we can use
    final files = entryMap['files'] as List?;
    if (files != null && files.isNotEmpty) {
      final firstFile = files[0] as Map<String, dynamic>;
      final source = firstFile['source'] as String;
      dir = detectFolderFromSource(registryDir, source);
    }

    // If no files or couldn't detect, try common locations
    if (dir == null) {
      final candidates = [
        '$registryDir/components/$category/$id',
        '$registryDir/composites/$category/$id',
      ];

      for (final candidate in candidates) {
        if (Directory(candidate).existsSync()) {
          dir = candidate;
          break;
        }
      }
    }

    if (dir == null) {
      print('⚠ Skipping $id: folder not found');
      continue;
    }

    final metadata = ComponentMetadataPaths(entryDir: Directory(dir), id: id);
    final metaFile = preferredFile(
      canonical: metadata.canonicalMeta,
      legacy: metadata.legacyMeta,
    );
    final readmeMetaFile = preferredFile(
      canonical: metadata.canonicalReadmeMeta,
      legacy: metadata.legacyReadmeMeta,
    );

    if (!metaFile.existsSync()) {
      print('⚠ Skipping $id: missing component metadata at ${metaFile.path}');
      continue;
    }

    final meta = readJson(metaFile.path);
    Map<String, dynamic> doc = {};
    if (readmeMetaFile.existsSync()) {
      doc = readJson(readmeMetaFile.path);
    }

    // Prefer authoritative values from components.json/meta.json for these:
    final tags = meta['tags'] is List
        ? (meta['tags'] as List).cast<String>()
        : <String>[];

    final install = doc['install'] as String? ?? 'flutter_shadcn add $id';

    // For AI/builders, include both raw import statement and normalized relative path
    final importStatement = doc['import'] as String? ?? '';
    final importPath = normalizeImportPath(importStatement);

    // Ensure API has required structure
    final apiRaw = doc['api'] as Map?;
    final api = {
      'constructors': apiRaw?['constructors'] ?? [],
      'callbacks': apiRaw?['callbacks'] ?? [],
    };
    // Include any additional API fields
    if (apiRaw != null) {
      apiRaw.forEach((key, value) {
        if (key != 'constructors' && key != 'callbacks') {
          api[key] = value;
        }
      });
    }

    items.add({
      'id': id,
      'name': doc['name'] ?? meta['name'] ?? id,
      'category': category,
      'description': doc['description'] ?? meta['description'] ?? '',
      'tags': tags,
      if (meta['version'] is String) 'version': meta['version'],
      'install': install,
      'import': importStatement,
      'importPath': importPath,

      // API surface hints (from README-derived meta)
      'api': api,

      // minimal example for bootstrapping
      'examples': doc['examples'] ?? {'minimal': ''},

      // dependency graph (authoritative from meta.json, not README)
      'dependencies': {
        'pubspec':
            (meta['dependencies'] as Map?)?['pubspec'] ?? <String, dynamic>{},
        'shared': (meta['dependencies'] as Map?)?['shared'] ?? <String>[],
      },

      // extra discoverability
      'related': doc['related'] is List
          ? (doc['related'] as List).cast<String>()
          : <String>[],
    });
  }

  // Deterministic ordering
  items.sort((a, b) => (a['id'] as String).compareTo(b['id'] as String));

  final index = {
    r'$schema': './index.schema.json',
    'schemaVersion': indexSchemaVersion,
    'generatedAt': DateTime.now().toUtc().toIso8601String(),
    'components': items,
  };

  // Validate against schema before writing
  print('Validating index against schema...');
  validateIndex(index);
  print('✓ Schema validation passed');

  writeJson(indexJson, index);
  print('Wrote $indexJson (${items.length} components).');
}

String? detectFolderFromSource(String registryDir, String source) {
  // Extract type from path: "registry/components/..." or "composites/..."
  if (source.startsWith('registry/components/')) {
    final parts = source.split('/');
    // registry/components/<category>/<id>/...
    if (parts.length >= 4) {
      final category = parts[2];
      final id = parts[3];
      return '$registryDir/components/$category/$id';
    }
  } else if (source.startsWith('composites/')) {
    final parts = source.split('/');
    // composites/<category>/<id>/...
    if (parts.length >= 3) {
      final category = parts[1];
      final id = parts[2];
      return '$registryDir/composites/$category/$id';
    }
  } else if (source.startsWith('registry/composites/')) {
    final parts = source.split('/');
    // registry/composites/<category>/<id>/...
    if (parts.length >= 4) {
      final category = parts[2];
      final id = parts[3];
      return '$registryDir/composites/$category/$id';
    }
  }
  return null;
}

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

String normalizeImportPath(String importStmt) {
  // "import 'package:<your_app>/ui/shadcn/control/button/button.dart';"
  // Convert to relative install import if possible: "ui/shadcn/control/button/button.dart"
  final pattern = RegExp(
    r"import\s+'package:<your_app>/([^']+)';",
    multiLine: true,
  );
  final match = pattern.firstMatch(importStmt);
  if (match != null) return match.group(1)!;
  return ''; // keep empty if cannot normalize
}

Map<String, dynamic> readJson(String path) {
  final content = File(path).readAsStringSync();
  return json.decode(content) as Map<String, dynamic>;
}

void writeJson(String path, Map<String, dynamic> obj) {
  final encoder = JsonEncoder.withIndent('  ');
  final jsonString = encoder.convert(obj);
  File(path).writeAsStringSync('$jsonString\n');
}

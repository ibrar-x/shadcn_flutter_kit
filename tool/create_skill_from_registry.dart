import 'dart:convert';
import 'dart:io';

/// Creates a "skill bundle" folder from your registry directory by copying the
/// recommended artifacts for AI tools (index + schemas + shared + meta files).
///
/// Usage:
///   dart tool/create_skill_from_registry.dart <skill-name> [--out=skills] [--force]
///   dart tool/create_skill_from_registry.dart --info
///
/// Examples:
///   dart tool/create_skill_from_registry.dart screen_builder
///   dart tool/create_skill_from_registry.dart screen_builder --out=skills
///   dart tool/create_skill_from_registry.dart screen_builder --force

const defaultRegistry = 'flutter_shadcn_kit/lib/registry';
const defaultOut = 'skills';

void main(List<String> args) {
  if (args.contains('--info')) {
    printInfo();
    exit(0);
  }

  if (args.isEmpty || args[0].startsWith('-')) {
    stderr.writeln(
        '❌ Missing <skill-name>\n\nUsage: dart tool/create_skill_from_registry.dart <skill-name> [--out=skills] [--force]\n       dart tool/create_skill_from_registry.dart --info');
    exit(1);
  }

  final skillName = args[0];
  final registryDir = argValue(args, '--registry', defaultRegistry);
  final outRoot = argValue(args, '--out', defaultOut);
  final force = args.contains('--force');
  if (!Directory(registryDir).existsSync()) {
    stderr.writeln('❌ Registry directory not found: $registryDir');
    exit(1);
  }

  final outDir = '$outRoot/$skillName';
  if (Directory(outDir).existsSync() && !force) {
    stderr.writeln(
        '❌ Skill folder already exists: $outDir\nUse --force to refresh registry_snapshot + manifest (SKILL.md and skill.prompt.json are preserved).');
    exit(1);
  }

  ensureDir(outDir);

  if (force) {
    final snapshotDir = Directory('$outDir/registry_snapshot');
    if (snapshotDir.existsSync()) snapshotDir.deleteSync(recursive: true);

    final schemaDir = Directory('$outDir/schemas');
    if (schemaDir.existsSync()) schemaDir.deleteSync(recursive: true);

    final manifestFile = File('$outDir/manifest.json');
    if (manifestFile.existsSync()) manifestFile.deleteSync();
  }

  final filesToCopy = <String>[];

  // Required core
  final required = [
    '$registryDir/index.json',
    '$registryDir/components.json',
  ];

  for (final p in required) {
    if (!File(p).existsSync()) {
      stderr.writeln('❌ Missing required file: $p');
      stderr.writeln('Make sure you generated index.json first.');
      exit(1);
    }
    filesToCopy.add(p);
  }

  // Recommended root-level registry metadata
  final recommended = [
    '$registryDir/components.schema.json',
    '$registryDir/folder_structure.json',
    '$registryDir/readme_meta.schema.json',
    '$registryDir/index.schema.json',
  ];
  for (final p in recommended) {
    if (File(p).existsSync()) {
      filesToCopy.add(p);
    }
  }

  // Schemas folder (required if present)
  final schemasDir = '$registryDir/schemas';
  if (Directory(schemasDir).existsSync()) {
    filesToCopy.addAll(listFilesRecursive(schemasDir));
  }

  // registry/shared/** (required if present)
  final sharedDir = '$registryDir/shared';
  if (Directory(sharedDir).existsSync()) {
    filesToCopy.addAll(listFilesRecursive(sharedDir));
  }

  // Per-component meta
  final componentDirs = collectComponentDirs(registryDir);
  for (final dir in componentDirs) {
    final id = dir.split('/').last;

    // Always include meta.json for dependency graph context (useful for skills)
    final metaJson = '$dir/meta.json';
    if (File(metaJson).existsSync()) {
      filesToCopy.add(metaJson);
    }

    // Always include {id}.meta.json for AI-safe API usage
    final readmeMeta = '$dir/$id.meta.json';
    if (File(readmeMeta).existsSync()) filesToCopy.add(readmeMeta);
  }

  // De-dupe, deterministic order
  final uniq = filesToCopy.toSet().toList()
    ..sort((a, b) => relFromRepo(a, registryDir)
        .compareTo(relFromRepo(b, registryDir)));

  // Copy + build manifest
  final manifest = {
    'skill': {
      'name': skillName,
      'createdAt': DateTime.now().toUtc().toIso8601String(),
      'sourceRegistryDir': registryDir,
      'includes': {
        'core': true,
        'schemas': Directory(schemasDir).existsSync(),
        'shared': Directory(sharedDir).existsSync(),
        'apiMeta': true,
      },
    },
    'files': <Map<String, dynamic>>[],
  };

  for (final src in uniq) {
    final rel = src.substring(registryDir.length + 1).replaceAll('\\', '/');
    final dst = '$outDir/registry_snapshot/$rel';

    copyFile(src, dst);

    final bytes = File(src).lengthSync();
    final hash = fileHashSha256(src);

    (manifest['files'] as List).add({
      'path': 'registry_snapshot/$rel',
      'bytes': bytes,
      'sha256': hash,
    });
  }

  // Add a starter SKILL.md template
  final skillTemplatePath = '$outDir/SKILL.md';
  if (!File(skillTemplatePath).existsSync()) {
    File(skillTemplatePath).writeAsStringSync('''# Skill: $skillName

## Purpose

- 

## Inputs

- 

## Workflow

1. Search `registry_snapshot/index.json`
2. Output install commands
3. Use only documented APIs from `{id}.meta.json` (if included) / README
4. Write app code only (never modify `ui/shadcn/**`)

## Non-negotiables

- Install via CLI only: `flutter_shadcn add <id>`
- Never guess APIs or imports
- Registry snapshot is read-only
''');
  }

  // Add a starter skill.prompt.json template
  final skillPromptPath = '$outDir/skill.prompt.json';
  if (!File(skillPromptPath).existsSync()) {
    writeJson(skillPromptPath, {
      'skill': skillName,
      'purpose': '',
      'inputs': <String>[],
      'workflow': [
        'Search registry_snapshot/index.json',
        'Output install commands',
        'Use only documented APIs from {id}.meta.json',
        'Write app code only (never modify ui/shadcn/**)'
      ],
      'constraints': [
        'Install via CLI only: flutter_shadcn add <id>',
        'Never guess APIs or imports',
        'Registry snapshot is read-only'
      ]
    });
  }

  // Write manifest
  final manifestPath = '$outDir/manifest.json';
  writeJson(manifestPath, manifest);

  // Create manifest schema
  createManifestSchema(outDir);

  print('✅ Skill bundle created: $outDir');
  print('   Files copied: ${(manifest['files'] as List).length}');
  print('   Snapshot root: $outDir/registry_snapshot');
  print('   Manifest: $manifestPath');
  print('\nTip: use --info to see all flags and behavior.');
}

String argValue(List<String> args, String prefix, String defaultValue) {
  final arg = args.firstWhere(
    (x) => x.startsWith(prefix),
    orElse: () => '',
  );
  if (arg.isEmpty) return defaultValue;
  final parts = arg.split('=');
  return parts.length > 1 ? parts[1] : defaultValue;
}

void ensureDir(String path) {
  Directory(path).createSync(recursive: true);
}

String fileHashSha256(String path) {
  final result = Process.runSync('shasum', ['-a', '256', path]);
  if (result.exitCode != 0) {
    throw StateError(
      'Failed to compute sha256 for $path: ${result.stderr.toString().trim()}',
    );
  }
  final output = result.stdout.toString().trim();
  if (output.isEmpty) {
    throw StateError('Empty sha256 output for $path');
  }
  return output.split(RegExp(r'\s+')).first;
}

void copyFile(String src, String dst) {
  ensureDir(dst.substring(0, dst.lastIndexOf('/')));
  File(src).copySync(dst);
}

List<String> listFilesRecursive(String rootDir) {
  final out = <String>[];
  if (!Directory(rootDir).existsSync()) return out;

  final stack = <String>[rootDir];
  while (stack.isNotEmpty) {
    final cur = stack.removeLast();
    final entries = Directory(cur).listSync();
    for (final e in entries) {
      if (e is Directory) {
        stack.add(e.path);
      } else if (e is File) {
        out.add(e.path);
      }
    }
  }
  out.sort();
  return out;
}

String relFromRepo(String path, String registryDir) {
  if (path.startsWith(registryDir)) {
    return path.substring(registryDir.length + 1);
  }
  return path;
}

List<String> collectComponentDirs(String registryDir) {
  // registry/components/<category>/<id>/
  // registry/composites/<category>/<id>/
  final roots = [
    '$registryDir/components',
    '$registryDir/composites',
  ].where((p) => Directory(p).existsSync()).toList();

  final dirs = <String>[];
  for (final root in roots) {
    final cats =
        Directory(root).listSync().whereType<Directory>().map((d) => d.path);
    for (final catDir in cats) {
      final ids = Directory(catDir)
          .listSync()
          .whereType<Directory>()
          .map((d) => d.path);
      dirs.addAll(ids);
    }
  }
  dirs.sort();
  return dirs;
}

void writeJson(String path, Map<String, dynamic> obj) {
  final encoder = JsonEncoder.withIndent('  ');
  final jsonString = encoder.convert(obj);
  File(path).writeAsStringSync('$jsonString\n');
}

void createManifestSchema(String outDir) {
  final schemaDir = '$outDir/schemas';
  ensureDir(schemaDir);

  final schema = {
    r'$schema': 'https://json-schema.org/draft/2020-12/schema',
    r'$id': 'manifest.schema.json',
    'title': 'Skill bundle manifest',
    'type': 'object',
    'additionalProperties': false,
    'required': ['skill', 'files'],
    'properties': {
      'skill': {
        'type': 'object',
        'additionalProperties': false,
        'required': ['name', 'createdAt', 'sourceRegistryDir', 'includes'],
        'properties': {
          'name': {'type': 'string', 'minLength': 1},
          'createdAt': {'type': 'string'},
          'sourceRegistryDir': {'type': 'string'},
          'includes': {
            'type': 'object',
            'additionalProperties': false,
            'required': ['core', 'schemas', 'shared', 'apiMeta'],
            'properties': {
              'core': {'type': 'boolean'},
              'schemas': {'type': 'boolean'},
              'shared': {'type': 'boolean'},
              'apiMeta': {'type': 'boolean'},
            },
          },
        },
      },
      'files': {
        'type': 'array',
        'items': {
          'type': 'object',
          'additionalProperties': false,
          'required': ['path', 'bytes', 'sha256'],
          'properties': {
            'path': {'type': 'string'},
            'bytes': {'type': 'integer', 'minimum': 0},
            'sha256': {'type': 'string', 'pattern': r'^[a-f0-9]{64}$'},
          },
        },
      },
    },
  };

  writeJson('$schemaDir/manifest.schema.json', schema);
}

void printInfo() {
  print('''
Create a recommended (B) skill bundle for AI tools.

Usage:
  dart tool/create_skill_from_registry.dart <skill-name> [--out=skills] [--force]
  dart tool/create_skill_from_registry.dart --info

Flags:
  --out=DIR       Output root folder (default: skills)
  --registry=DIR  Registry directory (default: flutter_shadcn_kit/lib/registry)
  --force         Refresh registry_snapshot + manifest + schemas
                 (SKILL.md and skill.prompt.json are preserved)

What gets copied:
  registry_snapshot/index.json
  registry_snapshot/components.json
  registry_snapshot/**/meta.json
  registry_snapshot/**/{id}.meta.json
  registry_snapshot/shared/** (if present)
  registry_snapshot/schemas/** (if present)

Also created:
  SKILL.md (if missing)
  skill.prompt.json (if missing)
  manifest.json
  schemas/manifest.schema.json
''');
}

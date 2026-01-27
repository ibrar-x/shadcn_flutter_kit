import 'dart:convert';
import 'dart:io';

const _taxonomyFolders = [
  'core',
  'styles',
  'themes',
  'variants',
  'utils',
  'state',
  'extensions',
];

enum _EntryType { component, composite }

typedef _Json = Map<String, dynamic>;

typedef _Prompt = String? Function();

Future<void> main(List<String> args) async {
  if (args.isEmpty) {
    _printUsage();
    exitCode = 64;
    return;
  }

  final root = _findRepoRoot(Directory.current);
  if (root == null) {
    stderr.writeln('Error: Could not locate lib/registry/components.json');
    exitCode = 1;
    return;
  }

  switch (args.first) {
    case 'init':
      await _initComponent(root);
      break;
    case 'sync':
      await _syncRegistry(root);
      break;
    case 'add-impl':
      await _addImplFile(root);
      break;
    case '-h':
    case '--help':
      _printUsage();
      break;
    default:
      stderr.writeln('Unknown command: ${args.first}');
      _printUsage();
      exitCode = 64;
  }
}

void _printUsage() {
  stdout.writeln('Usage: dart run tool/registry_tool.dart <command>');
  stdout.writeln('');
  stdout.writeln('Commands:');
  stdout.writeln('  init      Create a new component/composite');
  stdout.writeln('  sync      Sync registry files and components.json');
  stdout.writeln('  add-impl  Add a stub file under _impl taxonomy');
}

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

Future<void> _initComponent(Directory root) async {
  final registryDir = Directory('${root.path}/lib/registry');
  final componentsJson = File('${registryDir.path}/components.json');
  final json = jsonDecode(await componentsJson.readAsString()) as _Json;

  final type = _promptType();
  final category = _promptCategory(registryDir, type);
  final name = _promptValue('Component name (display name):');
  final id = _promptValue(
    'Component id (snake_case):',
    defaultValue: _toSnakeCase(name),
  );
  final description = _promptValue('Description:', defaultValue: '');
  final tags = _promptList('Tags (comma separated):');
  final sharedDeps = _promptList('Shared dependencies (comma separated):');
  final dependsOn = _promptList('Component dependencies (comma separated):');
  final wantsPreview = _promptYesNo('Create preview.dart?', defaultValue: true);

  final entryDir = _entryDir(registryDir, type, category, id);
  if (entryDir.existsSync()) {
    final overwrite = _promptYesNo(
      'Directory already exists. Continue and overwrite missing files?',
      defaultValue: false,
    );
    if (!overwrite) {
      stdout.writeln('Aborted.');
      return;
    }
  }

  entryDir.createSync(recursive: true);
  _ensureTaxonomy(entryDir);

  final className = _toPascalCase(name);
  final mainFile = File('${entryDir.path}/$id.dart');
  if (!mainFile.existsSync()) {
    mainFile.writeAsStringSync(_componentStub(className));
  }

  if (wantsPreview) {
    final previewFile = File('${entryDir.path}/preview.dart');
    if (!previewFile.existsSync()) {
      previewFile.writeAsStringSync(_previewStub(id, className));
    }
  }

  final readmeFile = File('${entryDir.path}/README.md');
  if (!readmeFile.existsSync()) {
    readmeFile.writeAsStringSync(_readmeStub(name, description));
  }

  final metaFile = File('${entryDir.path}/meta.json');
  if (!metaFile.existsSync()) {
    metaFile.writeAsStringSync(
      _metaStub(
        type: type,
        id: id,
        name: name,
        description: description,
        category: category,
        tags: tags,
        sharedDeps: sharedDeps,
        dependsOn: dependsOn,
      ),
    );
  }

  _upsertComponentEntry(
    json,
    registryDir,
    type,
    id,
    name,
    description,
    category,
    tags,
    sharedDeps,
    dependsOn,
  );

  await componentsJson.writeAsString(
    const JsonEncoder.withIndent('  ').convert(json) + '\n',
  );

  final overwriteMain = _promptYesNo(
    'Replace lib/main.dart with a ShadcnApp stub?',
    defaultValue: true,
  );
  if (overwriteMain) {
    final mainPath = File('${root.path}/lib/main.dart');
    mainPath.writeAsStringSync(_appMainStub(category, id, className));
  }

  stdout.writeln('Created ${type.name} $id in $category.');
}

Future<void> _syncRegistry(Directory root) async {
  final registryDir = Directory('${root.path}/lib/registry');
  final componentsJson = File('${registryDir.path}/components.json');
  final json = jsonDecode(await componentsJson.readAsString()) as _Json;

  _syncEntries(json, registryDir, _EntryType.component);
  _syncEntries(json, registryDir, _EntryType.composite);

  await componentsJson.writeAsString(
    const JsonEncoder.withIndent('  ').convert(json) + '\n',
  );

  stdout.writeln('Sync complete.');
}

Future<void> _addImplFile(Directory root) async {
  final registryDir = Directory('${root.path}/lib/registry');
  final type = _promptType();
  final category = _promptCategory(registryDir, type);
  final id = _promptValue('Component id (folder name):');
  final bucket = _promptValue(
    'Impl bucket (${_taxonomyFolders.join(', ')}):',
    defaultValue: 'core',
  );
  if (!_taxonomyFolders.contains(bucket)) {
    stderr.writeln('Invalid bucket: $bucket');
    return;
  }

  final entryDir = _entryDir(registryDir, type, category, id);
  if (!entryDir.existsSync()) {
    stderr.writeln('Component not found at ${entryDir.path}');
    return;
  }

  final className = _promptValue('Class name (PascalCase):');
  final fileName = _promptValue(
    'File name (snake_case, without .dart):',
    defaultValue: _toSnakeCase(className),
  );
  final implDir = Directory('${entryDir.path}/_impl/$bucket');
  implDir.createSync(recursive: true);
  final file = File('${implDir.path}/$fileName.dart');
  if (!file.existsSync()) {
    final relLibrary = _libraryRelPath(file, entryDir, id);
    file.writeAsStringSync(_implStub(relLibrary, className));
  }

  final libraryFile = File('${entryDir.path}/$id.dart');
  if (libraryFile.existsSync()) {
    final relPart = file.path
        .substring(entryDir.path.length + 1)
        .replaceAll('\\', '/');
    _ensurePart(libraryFile, relPart);
  }

  stdout.writeln('Added $fileName.dart to _impl/$bucket.');
}

void _syncEntries(_Json json, Directory registryDir, _EntryType type) {
  final rootDir = type == _EntryType.component
      ? Directory('${registryDir.path}/components')
      : Directory('${registryDir.path}/composites');

  final entries = json['components'] as List<dynamic>;

  final existing = <String, _Json>{};
  for (final entry in entries) {
    final map = entry as _Json;
    existing[map['id'] as String] = map;
  }

  final componentDirs = <Directory>[];
  for (final category in rootDir.listSync().whereType<Directory>()) {
    for (final compDir in category.listSync().whereType<Directory>()) {
      componentDirs.add(compDir);
    }
  }

  for (final compDir in componentDirs) {
    _ensureTaxonomy(compDir);
    _normalizeImplFiles(compDir);

    final id = compDir.uri.pathSegments.last.replaceAll('/', '');
    final category = compDir.parent.uri.pathSegments.last.replaceAll('/', '');
    final metaFile = File('${compDir.path}/meta.json');
    final name = _titleCase(id);
    final description = 'TODO: describe $name.';

    if (!metaFile.existsSync()) {
      metaFile.writeAsStringSync(
        _metaStub(
          type: type,
          id: id,
          name: name,
          description: description,
          category: category,
          tags: [category, id],
          sharedDeps: const [],
          dependsOn: const [],
        ),
      );
    }

    final readmeFile = File('${compDir.path}/README.md');
    if (!readmeFile.existsSync()) {
      readmeFile.writeAsStringSync(_readmeStub(name, description));
    }

    final entry =
        existing[id] ??
        {
          'id': id,
          'name': name,
          'description': description,
          'category': category,
          'tags': <String>[category, id],
          'files': <dynamic>[],
          'shared': <String>[],
          'dependsOn': <String>[],
          'pubspec': {'dependencies': <String, String>{}},
          'assets': <String>[],
          'postInstall': <String>[],
        };

    entry['files'] = _buildFileList(registryDir, compDir, type);
    existing[id] = entry;
  }

  // Merge back, preserving order and adding missing.
  final updated = <_Json>[];
  final seen = <String>{};
  for (final entry in entries) {
    final id = (entry as _Json)['id'] as String;
    if (existing.containsKey(id)) {
      updated.add(existing[id]!);
      seen.add(id);
    }
  }
  for (final entry in existing.entries) {
    if (!seen.contains(entry.key)) {
      updated.add(entry.value);
    }
  }

  json['components'] = updated;
}

void _normalizeImplFiles(Directory compDir) {
  final implDir = Directory('${compDir.path}/_impl');
  if (!implDir.existsSync()) {
    return;
  }
  for (final file in implDir.listSync().whereType<File>().where(
    (f) => f.path.endsWith('.dart'),
  )) {
    final bucket = _bucketForFile(file.uri.pathSegments.last);
    final targetDir = Directory('${implDir.path}/$bucket');
    targetDir.createSync(recursive: true);
    final target = File('${targetDir.path}/${file.uri.pathSegments.last}');
    file.renameSync(target.path);

    var text = target.readAsStringSync();
    if (text.contains("part of '../")) {
      text = text.replaceAll("part of '../", "part of '../../");
      target.writeAsStringSync(text);
    }

    _rewritePartPaths(compDir, file.uri.pathSegments.last, bucket);
  }
}

void _rewritePartPaths(Directory compDir, String fileName, String bucket) {
  final dartFiles = compDir
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'));
  for (final file in dartFiles) {
    final text = file.readAsStringSync();
    final updated = text.replaceAll(
      "part '_impl/$fileName';",
      "part '_impl/$bucket/$fileName';",
    );
    if (updated != text) {
      file.writeAsStringSync(updated);
    }
  }
}

List<_Json> _buildFileList(
  Directory registryDir,
  Directory compDir,
  _EntryType type,
) {
  final files = <_Json>[];

  for (final file in compDir.listSync(recursive: true).whereType<File>()) {
    final rel = file.path
        .substring(registryDir.path.length + 1)
        .replaceAll('\\', '/');

    final source = type == _EntryType.component ? 'registry/$rel' : rel;

    final destination = type == _EntryType.component
        ? '{installPath}/$rel'
        : '{installPath}/$rel';

    files.add({'source': source, 'destination': destination});
  }

  files.sort(
    (a, b) => (a['source'] as String).compareTo(b['source'] as String),
  );
  return files;
}

void _ensureTaxonomy(Directory entryDir) {
  final implDir = Directory('${entryDir.path}/_impl');
  implDir.createSync(recursive: true);
  for (final folder in _taxonomyFolders) {
    Directory('${implDir.path}/$folder').createSync(recursive: true);
  }
}

void _ensurePart(File libraryFile, String partPath) {
  final text = libraryFile.readAsStringSync();
  if (text.contains("part '$partPath';")) {
    return;
  }
  final lines = text.split('\n');
  var insertAt = 0;
  for (var i = 0; i < lines.length; i++) {
    if (lines[i].startsWith('import ')) {
      insertAt = i + 1;
    }
  }
  lines.insert(insertAt, "part '$partPath';");
  libraryFile.writeAsStringSync(lines.join('\n'));
}

void _upsertComponentEntry(
  _Json json,
  Directory registryDir,
  _EntryType type,
  String id,
  String name,
  String description,
  String category,
  List<String> tags,
  List<String> sharedDeps,
  List<String> dependsOn,
) {
  final compDir = _entryDir(registryDir, type, category, id);
  final files = _buildFileList(registryDir, compDir, type);
  final components = json['components'] as List<dynamic>;

  _Json entry;
  final index = components.indexWhere((e) => (e as _Json)['id'] == id);
  if (index >= 0) {
    entry = components[index] as _Json;
  } else {
    entry = {
      'id': id,
      'name': name,
      'description': description,
      'category': category,
      'tags': tags,
      'files': files,
      'shared': sharedDeps,
      'dependsOn': dependsOn,
      'pubspec': {'dependencies': <String, String>{}},
      'assets': <String>[],
      'postInstall': <String>[],
    };
    components.add(entry);
  }

  entry['name'] = name;
  entry['description'] = description;
  entry['category'] = category;
  entry['tags'] = tags;
  entry['files'] = files;
  entry['shared'] = sharedDeps;
  entry['dependsOn'] = dependsOn;
}

Directory _entryDir(
  Directory registryDir,
  _EntryType type,
  String category,
  String id,
) {
  final base = type == _EntryType.component ? 'components' : 'composites';
  return Directory('${registryDir.path}/$base/$category/$id');
}

_EntryType _promptType() {
  final raw = _promptValue(
    'Type (component/composite):',
    defaultValue: 'component',
  ).toLowerCase();
  return raw.startsWith('composite')
      ? _EntryType.composite
      : _EntryType.component;
}

String _promptCategory(Directory registryDir, _EntryType type) {
  final base = type == _EntryType.component ? 'components' : 'composites';
  final categories =
      Directory('${registryDir.path}/$base')
          .listSync()
          .whereType<Directory>()
          .map((d) => d.uri.pathSegments.last.replaceAll('/', ''))
          .toList()
        ..sort();
  stdout.writeln('Existing categories: ${categories.join(', ')}');
  return _promptValue(
    'Category:',
    defaultValue: categories.isEmpty ? '' : categories.first,
  );
}

String _promptValue(String prompt, {String? defaultValue}) {
  stdout.write(
    defaultValue == null || defaultValue.isEmpty
        ? '$prompt '
        : '$prompt [$defaultValue] ',
  );
  final value = stdin.readLineSync()?.trim();
  if (value == null || value.isEmpty) {
    return defaultValue ?? '';
  }
  return value;
}

List<String> _promptList(String prompt) {
  final raw = _promptValue(prompt, defaultValue: '');
  if (raw.trim().isEmpty) {
    return [];
  }
  return raw
      .split(',')
      .map((e) => e.trim())
      .where((e) => e.isNotEmpty)
      .toList();
}

bool _promptYesNo(String prompt, {bool defaultValue = false}) {
  final suffix = defaultValue ? 'Y/n' : 'y/N';
  stdout.write('$prompt [$suffix] ');
  final value = stdin.readLineSync()?.trim().toLowerCase();
  if (value == null || value.isEmpty) {
    return defaultValue;
  }
  return value.startsWith('y');
}

String _toSnakeCase(String input) {
  final sanitized = input
      .replaceAll(RegExp(r'[^a-zA-Z0-9\s_]'), ' ')
      .trim()
      .replaceAll(RegExp(r'\s+'), '_');
  final buffer = StringBuffer();
  for (var i = 0; i < sanitized.length; i++) {
    final char = sanitized[i];
    if (char.toUpperCase() == char && char.toLowerCase() != char) {
      if (i != 0 && sanitized[i - 1] != '_' && sanitized[i - 1] != ' ') {
        buffer.write('_');
      }
      buffer.write(char.toLowerCase());
    } else {
      buffer.write(char.toLowerCase());
    }
  }
  return buffer.toString().replaceAll(RegExp(r'_+'), '_');
}

String _toPascalCase(String input) {
  final parts = _toSnakeCase(input).split('_');
  return parts
      .map((p) => p.isEmpty ? '' : '${p[0].toUpperCase()}${p.substring(1)}')
      .join();
}

String _titleCase(String input) {
  final parts = _toSnakeCase(input).split('_');
  return parts
      .map((p) => p.isEmpty ? '' : '${p[0].toUpperCase()}${p.substring(1)}')
      .join(' ');
}

String _bucketForFile(String fileName) {
  final name = fileName.toLowerCase();
  if (name.contains('theme')) return 'themes';
  if (name.contains('style')) return 'styles';
  if (name.contains('variant')) return 'variants';
  if (name.contains('state')) return 'state';
  if (name.contains('controller') ||
      name.contains('handler') ||
      name.contains('intent') ||
      name.contains('api') ||
      name.contains('typedef') ||
      name.contains('types') ||
      name.contains('tween')) {
    return 'utils';
  }
  return 'core';
}

String _componentStub(String className) {
  return '''import 'package:flutter/widgets.dart';

class $className extends StatelessWidget {
  const $className({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
''';
}

String _previewStub(String id, String className) {
  return '''import 'package:flutter/widgets.dart';
import '$id.dart';

class ${className}Preview extends StatelessWidget {
  const ${className}Preview({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: $className());
  }
}
''';
}

String _readmeStub(String name, String description) {
  final safeDesc = description.isEmpty ? 'Describe $name here.' : description;
  return '''# $name

$safeDesc

## Usage

```dart
// TODO: Add usage example.
```
''';
}

String _metaStub({
  required _EntryType type,
  required String id,
  required String name,
  required String description,
  required String category,
  required List<String> tags,
  required List<String> sharedDeps,
  required List<String> dependsOn,
}) {
  final base = <String, dynamic>{
    'id': id,
    'name': name,
    'description': description,
    'category': category,
    'tags': tags,
    'dependencies': <String, dynamic>{
      'shared': sharedDeps,
      'components': dependsOn,
    },
  };

  if (type == _EntryType.composite) {
    base['dependencies'] = {
      'shared': sharedDeps,
      'pubspec': <String, String>{},
    };
  }

  return const JsonEncoder.withIndent('  ').convert(base) + '\n';
}

String _appMainStub(String category, String id, String className) {
  return '''import 'package:flutter/widgets.dart';

import 'package:flutter_shadcn_kit/registry/composites/layout/app/app.dart';
import 'package:flutter_shadcn_kit/registry/shared/theme/theme.dart' as shadcn;
import 'package:flutter_shadcn_kit/registry/components/$category/$id/$id.dart';

void main() {
  runApp(const _RegistryApp());
}

class _RegistryApp extends StatelessWidget {
  const _RegistryApp();

  @override
  Widget build(BuildContext context) {
    return ShadcnApp(
      title: '$className',
      theme: const shadcn.ThemeData(),
      home: const Scaffold(
        appBar: AppBar(title: Text('$className')),
        body: Center(child: $className()),
      ),
    );
  }
}
''';
}

String _implStub(String relLibrary, String className) {
  return '''part of '$relLibrary';

class $className {
  const $className();
}
''';
}

String _libraryRelPath(File partFile, Directory entryDir, String id) {
  final libraryFile = File('${entryDir.path}/$id.dart');
  return _relativePath(partFile.parent.path, libraryFile.path);
}

String _relativePath(String fromDir, String toPath) {
  final from = Uri.file(fromDir).pathSegments;
  final to = Uri.file(toPath).pathSegments;
  var i = 0;
  while (i < from.length && i < to.length && from[i] == to[i]) {
    i++;
  }
  final up = List.filled(from.length - i, '..');
  final down = to.sublist(i);
  return [...up, ...down].join('/');
}

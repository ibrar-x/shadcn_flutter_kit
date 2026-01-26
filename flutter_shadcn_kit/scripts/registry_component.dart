import 'dart:convert';
import 'dart:io';

String _join(String a, String b) {
  if (a.endsWith(Platform.pathSeparator)) {
    return '$a$b';
  }
  return '$a${Platform.pathSeparator}$b';
}

String _toSnake(String input) {
  final cleaned = input
      .replaceAll(RegExp(r'[/\\]+'), ' ')
      .replaceAll('-', ' ')
      .trim();
  if (cleaned.isEmpty) return '';
  final buffer = StringBuffer();
  for (var i = 0; i < cleaned.length; i++) {
    final ch = cleaned[i];
    if (ch == ' ') {
      if (buffer.isNotEmpty && buffer.toString().endsWith('_') == false) {
        buffer.write('_');
      }
      continue;
    }
    final isUpper = ch.toUpperCase() == ch && ch.toLowerCase() != ch;
    final isPrevLower = i > 0 &&
        cleaned[i - 1].toLowerCase() == cleaned[i - 1] &&
        cleaned[i - 1].toUpperCase() != cleaned[i - 1];
    if (isUpper && isPrevLower) {
      buffer.write('_');
    }
    buffer.write(ch.toLowerCase());
  }
  return buffer.toString().replaceAll(RegExp(r'_+'), '_');
}

String _toTitle(String input) {
  final parts = input.replaceAll('_', ' ').split(RegExp(r'\s+'));
  return parts
      .where((p) => p.isNotEmpty)
      .map((p) => p[0].toUpperCase() + p.substring(1))
      .join(' ');
}

String _toPascal(String input) {
  final parts = input.replaceAll('_', ' ').split(RegExp(r'\s+'));
  return parts
      .where((p) => p.isNotEmpty)
      .map((p) => p[0].toUpperCase() + p.substring(1))
      .join('');
}

Map<String, String> _parseArgs(List<String> args) {
  final result = <String, String>{};
  for (var i = 0; i < args.length; i++) {
    final arg = args[i];
    if (arg.startsWith('--')) {
      final key = arg.substring(2);
      final value = i + 1 < args.length && !args[i + 1].startsWith('--')
          ? args[++i]
          : 'true';
      result[key] = value;
    }
  }
  return result;
}

void _writeIfMissing(File file, String content) {
  if (file.existsSync()) {
    return;
  }
  file.createSync(recursive: true);
  file.writeAsStringSync(content);
}

Map<String, dynamic> _loadJson(File file) {
  return jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
}

List<Map<String, dynamic>> _scanComponents(Directory componentsRoot) {
  final entries = <Map<String, dynamic>>[];
  for (final categoryDir in componentsRoot.listSync()) {
    if (categoryDir is! Directory) continue;
    final category = categoryDir.path.split(Platform.pathSeparator).last;
    for (final componentDir in categoryDir.listSync()) {
      if (componentDir is! Directory) continue;
      final componentId = componentDir.path.split(Platform.pathSeparator).last;
      final metaFile = File(_join(componentDir.path, 'meta.json'));
      Map<String, dynamic> meta = {};
      if (metaFile.existsSync()) {
        meta = _loadJson(metaFile);
      }
      final id = meta['id'] as String? ?? componentId;
      final name = meta['name'] as String? ?? _toTitle(id);
      final description = meta['description'] as String? ?? '';
      final metaCategory = meta['category'] as String? ?? category;
      final tags = (meta['tags'] as List?)?.cast<String>() ??
          <String>[metaCategory, id];
      final deps = (meta['dependencies'] as Map?)?.cast<String, dynamic>() ??
          const <String, dynamic>{};
      final shared = (deps['shared'] as List?)?.cast<String>() ?? <String>[];
      final components =
          (deps['components'] as List?)?.cast<String>() ?? <String>[];
      final pubspec =
          (deps['pubspec'] as Map?)?.cast<String, dynamic>() ??
              <String, dynamic>{};
      final assets = (meta['assets'] as List?)?.cast<String>() ?? <String>[];
      final postInstall =
          (meta['postInstall'] as List?)?.cast<String>() ?? <String>[];

      final files = <Map<String, String>>[];
      final fileList = <String>[];
      for (final entity in componentDir.listSync(recursive: true)) {
        if (entity is! File) continue;
        final relPath = entity.path.substring(componentDir.path.length + 1);
        fileList.add(relPath.replaceAll('\\', '/'));
      }
      fileList.sort();
      for (final rel in fileList) {
        files.add({
          'source': 'registry/components/$category/$componentId/$rel',
          'destination': '{installPath}/components/$category/$componentId/$rel',
        });
      }

      entries.add({
        'id': id,
        'name': name,
        'description': description,
        'category': metaCategory,
        'tags': tags,
        'files': files,
        'shared': shared,
        'dependsOn': components,
        'pubspec': {'dependencies': pubspec},
        'assets': assets,
        'postInstall': postInstall,
      });
    }
  }
  return entries;
}

void _updateComponentsJson(File jsonFile, List<Map<String, dynamic>> scanned) {
  if (!jsonFile.existsSync()) {
    return;
  }
  final data = _loadJson(jsonFile);
  final existing = (data['components'] as List).cast<Map<String, dynamic>>();
  final scannedIds = scanned.map((e) => e['id'] as String).toSet();
  final preserved =
      existing.where((e) => !scannedIds.contains(e['id'] as String)).toList();
  data['components'] = [...scanned, ...preserved];
  jsonFile.writeAsStringSync(
    '${const JsonEncoder.withIndent('  ').convert(data)}\n',
  );
}

void main(List<String> args) {
  final parsed = _parseArgs(args);
  final nameArg = parsed['name'];
  final categoryArg = parsed['category'];
  final descriptionArg = parsed['description'] ?? '';

  final scriptDir = File(Platform.script.toFilePath()).parent;
  final kitRoot = scriptDir.parent;
  final repoRoot = kitRoot.parent;

  final registryRoot = Directory(_join(kitRoot.path, 'lib/registry'));
  final componentsRoot =
      Directory(_join(registryRoot.path, 'components'));

  if (nameArg != null && categoryArg != null) {
    final componentId = _toSnake(nameArg);
    final category = _toSnake(categoryArg);
    final title = _toTitle(componentId);
    final description =
        descriptionArg.isNotEmpty ? descriptionArg : '$title component.';

    final componentDir = Directory(
      _join(_join(componentsRoot.path, category), componentId),
    );
    componentDir.createSync(recursive: true);
    final implDir = Directory(_join(componentDir.path, '_impl'));
    implDir.createSync(recursive: true);

    _writeIfMissing(
      File(_join(componentDir.path, 'README.md')),
      '# $title\n\n$description\n',
    );

    _writeIfMissing(
      File(_join(componentDir.path, 'meta.json')),
      '${const JsonEncoder.withIndent('  ').convert({
            'id': componentId,
            'name': title,
            'description': description,
            'category': category,
            'tags': [category, componentId],
            'dependencies': {
              'pubspec': {},
              'shared': [],
              'components': [],
            },
          })}\n',
    );

    final className = _toPascal(componentId);
    _writeIfMissing(
      File(_join(componentDir.path, '$componentId.dart')),
      "import 'package:flutter/material.dart';\n\n"
          'class $className extends StatelessWidget {\n'
          '  const $className({super.key});\n\n'
          '  @override\n'
          '  Widget build(BuildContext context) {\n'
          '    return const SizedBox.shrink();\n'
          '  }\n'
          '}\n',
    );

    _writeIfMissing(
      File(_join(componentDir.path, 'preview.dart')),
      "import 'package:flutter/material.dart' as m;\n\n"
          "import '$componentId.dart';\n\n"
          'class ${className}Preview extends m.StatelessWidget {\n'
          '  const ${className}Preview({super.key});\n\n'
          '  @override\n'
          '  m.Widget build(m.BuildContext context) {\n'
          '    return const m.SizedBox.shrink();\n'
          '  }\n'
          '}\n',
    );

    _writeIfMissing(
      File(_join(implDir.path, '${componentId}_impl.dart')),
      "/// Internal helpers for $title.\n",
    );
  }

  final scanned = _scanComponents(componentsRoot);
  _updateComponentsJson(
    File(_join(registryRoot.path, 'components.json')),
    scanned,
  );
  _updateComponentsJson(
    File(_join(repoRoot.path, 'docs/assets/registry/components.json')),
    scanned,
  );

  stdout.writeln('Registry components.json updated.');
}

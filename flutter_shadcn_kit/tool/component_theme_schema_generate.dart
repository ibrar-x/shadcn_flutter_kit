import 'dart:convert';
import 'dart:io';

typedef JsonMap = Map<String, dynamic>;

final RegExp _classPattern = RegExp(
  r'(?:abstract\s+)?class\s+(\w+)\s+extends\s+ComponentThemeData\s*\{',
);
final RegExp _fieldPattern = RegExp(r'\bfinal\s+([^;=]+?)\s+(\w+)\s*;');

Directory? _findRepoRoot(Directory start) {
  Directory current = start.absolute;
  while (true) {
    final candidate = Directory('${current.path}/lib/registry/components');
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

class _ParsedArgs {
  _ParsedArgs(this.values, this.flags);

  final Map<String, List<String>> values;
  final Set<String> flags;

  bool hasFlag(String name) => flags.contains(name);
  List<String> getValues(String name) => values[name] ?? const [];
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
      values.putIfAbsent(trimmed, () => []).add(args[++i]);
      continue;
    }

    flags.add(trimmed);
  }

  return _ParsedArgs(values, flags);
}

List<String> _parseCsvValues(List<String> values) {
  final out = <String>[];
  for (final value in values) {
    for (final part in value.split(',')) {
      final trimmed = part.trim();
      if (trimmed.isNotEmpty) out.add(trimmed);
    }
  }
  return out;
}

void _printUsage() {
  stdout.writeln(
    'Usage: dart run tool/component_theme_schema_generate.dart [options]',
  );
  stdout.writeln('');
  stdout.writeln(
    'Generates theme.schema.json for all components under lib/registry/components.',
  );
  stdout.writeln('');
  stdout.writeln('Options:');
  stdout.writeln(
    '  --components <ids>     Comma-separated component ids to generate.',
  );
  stdout.writeln(
    '  --dry-run              Print targets without writing files.',
  );
  stdout.writeln('  -h, --help             Show this help.');
}

String _prettyLabel(String name) {
  final spaced = name.replaceAllMapped(
    RegExp(r'([a-z0-9])([A-Z])'),
    (m) => '${m.group(1)} ${m.group(2)}',
  );
  final parts = spaced.split('_').join(' ').split(RegExp(r'\s+'));
  return parts
      .where((part) => part.isNotEmpty)
      .map((part) => '${part[0].toUpperCase()}${part.substring(1)}')
      .join(' ');
}

String _extractClassBody(String content, int classStart) {
  final braceStart = content.indexOf('{', classStart);
  if (braceStart == -1) return '';

  var depth = 0;
  for (var i = braceStart; i < content.length; i++) {
    final char = content[i];
    if (char == '{') depth++;
    if (char == '}') {
      depth--;
      if (depth == 0) {
        return content.substring(braceStart + 1, i);
      }
    }
  }

  return '';
}

class _ThemeField {
  _ThemeField({required this.name, required this.dartType});

  final String name;
  final String dartType;
}

bool _isThemeFile(File file) {
  final name = file.path.split(Platform.pathSeparator).last;
  return name.endsWith('.dart') && name.contains('theme');
}

String _normalizeType(String raw) {
  final compact = raw.replaceAll(RegExp(r'\s+'), ' ').trim();
  return compact;
}

List<_ThemeField> _collectThemeFields(Directory componentDir) {
  final fields = <_ThemeField>[];
  final seen = <String>{};

  for (final entity in componentDir.listSync(recursive: true)) {
    if (entity is! File || !_isThemeFile(entity)) continue;
    final content = entity.readAsStringSync();

    for (final match in _classPattern.allMatches(content)) {
      final classStart = match.start;
      final body = _extractClassBody(content, classStart);
      if (body.isEmpty) continue;

      for (final fieldMatch in _fieldPattern.allMatches(body)) {
        final dartType = _normalizeType(fieldMatch.group(1) ?? 'Object?');
        final name = fieldMatch.group(2) ?? '';
        if (name.isEmpty) continue;
        if (seen.add(name)) {
          fields.add(_ThemeField(name: name, dartType: dartType));
        }
      }
    }
  }

  fields.sort((a, b) => a.name.compareTo(b.name));
  return fields;
}

String _baseType(String dartType) {
  final withoutNullable = dartType.replaceAll('?', '').trim();
  return withoutNullable;
}

bool _isListType(String base) =>
    base.startsWith('List<') || base.startsWith('Iterable<');

String _extractGeneric(String base) {
  final start = base.indexOf('<');
  final end = base.lastIndexOf('>');
  if (start == -1 || end == -1 || end <= start) return '';
  return base.substring(start + 1, end).trim();
}

String _fieldTypeForDartType(String dartType) {
  final base = _baseType(dartType);

  if (base == 'bool') return 'boolean';
  if (base == 'int') return 'integer';
  if (base == 'double' || base == 'num') return 'number';
  if (base == 'String') return 'string';
  if (base == 'Color') return 'color';
  if (base == 'Duration') return 'duration';
  if (base == 'TextStyle') return 'textStyle';
  if (base == 'Curve') return 'curve';

  if (base == 'Gradient' ||
      base == 'LinearGradient' ||
      base == 'RadialGradient' ||
      base == 'SweepGradient') {
    return 'gradient';
  }

  if (base == 'Border' ||
      base == 'BoxBorder' ||
      base == 'BorderSide' ||
      base == 'OutlinedBorder') {
    return 'border';
  }

  if (_isListType(base)) {
    final generic = _extractGeneric(base).replaceAll('?', '');
    if (generic == 'BoxShadow') {
      return 'shadowList';
    }
    return 'list';
  }

  return 'object';
}

Object? _normalizeDefaultValue({
  required String fieldType,
  required Object? value,
  required JsonMap validation,
}) {
  if (value == null) return null;

  if (fieldType == 'number' || fieldType == 'integer') {
    if (value is! num) {
      throw ArgumentError('Default value must be numeric for $fieldType');
    }
    final min = validation['min'];
    final max = validation['max'];
    final clampMode = validation['clamp'] as String? ?? 'reject';
    var normalized = value;
    if (min is num && normalized < min) {
      if (clampMode == 'clamp') {
        normalized = min;
      } else {
        throw RangeError('Default value $value is below min $min');
      }
    }
    if (max is num && normalized > max) {
      if (clampMode == 'clamp') {
        normalized = max;
      } else {
        throw RangeError('Default value $value is above max $max');
      }
    }
    if (fieldType == 'integer') {
      return normalized.round();
    }
    return normalized;
  }

  if (fieldType == 'string') {
    if (value is! String) {
      throw ArgumentError('Default value must be string for $fieldType');
    }
    final pattern = validation['pattern'];
    if (pattern is String && pattern.isNotEmpty) {
      final regex = RegExp(pattern);
      if (!regex.hasMatch(value)) {
        throw ArgumentError(
          'Default value "$value" does not match pattern $pattern',
        );
      }
    }
    return value;
  }

  if (fieldType == 'list' || fieldType == 'shadowList') {
    if (value is! List) {
      throw ArgumentError('Default value must be a list for $fieldType');
    }
    final minItems = validation['minItems'];
    final maxItems = validation['maxItems'];
    if (minItems is int && value.length < minItems) {
      throw RangeError(
        'Default list length ${value.length} < minItems $minItems',
      );
    }
    if (maxItems is int && value.length > maxItems) {
      throw RangeError(
        'Default list length ${value.length} > maxItems $maxItems',
      );
    }
    return value;
  }

  return value;
}

JsonMap _buildValidation(String fieldType) {
  switch (fieldType) {
    case 'number':
    case 'integer':
      return {'clamp': 'reject'};
    case 'string':
      return <String, dynamic>{};
    case 'list':
    case 'shadowList':
      return {'minItems': 0};
    default:
      return <String, dynamic>{};
  }
}

JsonMap _buildUiHints(String fieldType) {
  switch (fieldType) {
    case 'number':
    case 'integer':
      return {'control': 'input'};
    case 'color':
      return {'control': 'color'};
    case 'duration':
      return {'control': 'input', 'unit': 'ms'};
    case 'enum':
      return {'control': 'select'};
    default:
      return {'control': 'input'};
  }
}

JsonMap _buildFieldSpec(_ThemeField field, String since) {
  final fieldType = _fieldTypeForDartType(field.dartType);
  final validation = _buildValidation(fieldType);
  final defaultValue = _normalizeDefaultValue(
    fieldType: fieldType,
    value: null,
    validation: validation,
  );

  final spec = <String, dynamic>{
    'type': fieldType,
    'name': field.name,
    'label': _prettyLabel(field.name),
    'description': 'Generated from Dart type `${field.dartType}`.',
    'defaultValue': defaultValue,
    'required': false,
    'isAdvanced': false,
    'visibleIf': <dynamic>[],
    'validation': validation,
    'ui': _buildUiHints(fieldType),
    'since': since,
  };

  if (fieldType == 'number') {
    spec['precision'] = 2;
  }

  return spec;
}

JsonMap _readMeta(File file) {
  return jsonDecode(file.readAsStringSync()) as JsonMap;
}

void _writeJson(File file, Object data) {
  final encoder = const JsonEncoder.withIndent('  ');
  file.writeAsStringSync('${encoder.convert(data)}\n');
}

String _joinPath(String a, String b) {
  if (a.endsWith(Platform.pathSeparator)) return '$a$b';
  return '$a${Platform.pathSeparator}$b';
}

void main(List<String> args) {
  final parsed = _parseArgs(args);
  if (parsed.hasFlag('help') || parsed.hasFlag('h')) {
    _printUsage();
    return;
  }

  final dryRun = parsed.hasFlag('dry-run');
  final targetComponents = _parseCsvValues(
    parsed.getValues('components'),
  ).toSet();

  final root = _findRepoRoot(Directory.current);
  if (root == null) {
    stderr.writeln('Error: Could not locate lib/registry/components');
    exitCode = 1;
    return;
  }

  final componentsRoot = Directory('${root.path}/lib/registry/components');
  if (!componentsRoot.existsSync()) {
    stderr.writeln(
      'Error: components root not found at ${componentsRoot.path}',
    );
    exitCode = 1;
    return;
  }

  final componentDirs = <Directory>[];
  for (final category in componentsRoot.listSync().whereType<Directory>()) {
    for (final component in category.listSync().whereType<Directory>()) {
      final name = component.path.split(Platform.pathSeparator).last;
      if (name.startsWith('.') || name.startsWith('_')) continue;
      if (targetComponents.isNotEmpty && !targetComponents.contains(name))
        continue;
      componentDirs.add(component);
    }
  }
  componentDirs.sort((a, b) => a.path.compareTo(b.path));

  if (componentDirs.isEmpty) {
    stdout.writeln('No matching components found.');
    return;
  }

  var written = 0;
  for (final componentDir in componentDirs) {
    final id = componentDir.path.split(Platform.pathSeparator).last;
    final metaFile = File(_joinPath(componentDir.path, 'meta.json'));
    final category = componentDir.parent.path
        .split(Platform.pathSeparator)
        .last;

    var title = _prettyLabel(id);
    var since = '1.0.0';
    var description = 'Theme schema for $id component.';

    if (metaFile.existsSync()) {
      final meta = _readMeta(metaFile);
      title = (meta['name'] as String?)?.trim().isNotEmpty == true
          ? meta['name'] as String
          : title;
      since = (meta['version'] as String?)?.trim().isNotEmpty == true
          ? meta['version'] as String
          : since;
      description = (meta['description'] as String?)?.trim().isNotEmpty == true
          ? '${meta['description']} Theme tokens and editor schema.'
          : description;
    }

    final fields = _collectThemeFields(
      componentDir,
    ).map((field) => _buildFieldSpec(field, since)).toList();

    final schema = <String, dynamic>{
      r'$schema': '../../../component_theme.schema.json',
      'id': id,
      'title': '$title Theme',
      'description': description,
      'schemaVersion': 1,
      'since': since,
      'migrations': <String, String>{},
      'groups': [
        {
          'title': 'Theme',
          'description':
              'Generated fields discovered from `$category/$id` theme classes.',
          'fields': fields,
        },
      ],
    };

    final outputFile = File(_joinPath(componentDir.path, 'theme.schema.json'));
    if (dryRun) {
      stdout.writeln('[dry-run] ${outputFile.path}');
      continue;
    }

    _writeJson(outputFile, schema);
    written++;
    stdout.writeln('Wrote ${outputFile.path} (${fields.length} fields)');
  }

  if (!dryRun) {
    stdout.writeln('Done. Generated $written component theme schema files.');
  }
}

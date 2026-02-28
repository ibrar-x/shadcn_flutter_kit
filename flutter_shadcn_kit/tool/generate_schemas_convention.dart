import 'dart:convert';
import 'dart:io';

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:flutter_shadcn_kit/registry/shared/theme/schema/component_schema.dart';

import 'common/registry_component_metadata.dart';

typedef JsonMap = Map<String, dynamic>;

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
    'Usage: dart run tool/generate_schemas_convention.dart [options]',
  );
  stdout.writeln('');
  stdout.writeln(
    'Generate component theme schemas from *_theme_defaults.dart using naming conventions.',
  );
  stdout.writeln('');
  stdout.writeln('Options:');
  stdout.writeln(
    '  --components <ids>     Comma-separated component ids to generate.',
  );
  stdout.writeln(
    '  --format <kind>        One of: json, dart, both (default: json).',
  );
  stdout.writeln(
    '  --dry-run              Print targets without writing files.',
  );
  stdout.writeln(
    '  --strict               Exit non-zero if fields are skipped or overrides are invalid.',
  );
  stdout.writeln('  -h, --help             Show this help.');
}

enum _OutputFormat { json, dart, both }

_OutputFormat _parseFormat(_ParsedArgs args) {
  final raw = args.getValues('format').isNotEmpty
      ? args.getValues('format').last.trim().toLowerCase()
      : 'json';
  switch (raw) {
    case 'json':
      return _OutputFormat.json;
    case 'dart':
      return _OutputFormat.dart;
    case 'both':
      return _OutputFormat.both;
    default:
      throw ArgumentError('Unknown --format "$raw". Use json|dart|both.');
  }
}

class _DefaultFieldInfo {
  _DefaultFieldInfo({
    required this.name,
    required this.type,
    required this.sourceClass,
    this.defaultExpr,
  });

  final String name;
  final String type;
  final String sourceClass;
  final Expression? defaultExpr;
}

class _ParsedThemeFile {
  _ParsedThemeFile(this.fields, this.classNames);

  final List<_DefaultFieldInfo> fields;
  final List<String> classNames;
}

class _ThemeClassVisitor extends SimpleAstVisitor<void> {
  final List<_DefaultFieldInfo> fields = <_DefaultFieldInfo>[];
  final List<String> classNames = <String>[];

  final Set<String> _seenClassFieldNames = <String>{};

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    final className = node.name.lexeme;
    if (!_isThemeClass(className)) {
      return;
    }
    classNames.add(className);

    final declaredFieldExpr = <String, Expression?>{};
    final declaredFieldTypes = <String, String>{};

    for (final member in node.members) {
      if (member is! FieldDeclaration || member.isStatic) continue;
      final typeSource = member.fields.type?.toSource().trim() ?? 'dynamic';
      for (final variable in member.fields.variables) {
        final fieldName = variable.name.lexeme;
        declaredFieldExpr[fieldName] = variable.initializer;
        declaredFieldTypes[fieldName] = typeSource;
      }
    }

    final preferredCtor = _pickPreferredConstructor(node);
    final ctorDefaults = preferredCtor == null
        ? <String, Expression?>{}
        : _collectConstructorDefaults(preferredCtor);

    final fieldNames = declaredFieldTypes.keys.toList()..sort();
    for (final fieldName in fieldNames) {
      if (!_seenClassFieldNames.add('$className::$fieldName')) {
        continue;
      }
      fields.add(
        _DefaultFieldInfo(
          name: fieldName,
          type: declaredFieldTypes[fieldName] ?? 'dynamic',
          sourceClass: className,
          defaultExpr: ctorDefaults[fieldName] ?? declaredFieldExpr[fieldName],
        ),
      );
    }
  }

  bool _isThemeClass(String className) {
    return className.endsWith('ThemeDefaults') ||
        className.endsWith('ThemeTokens');
  }

  ConstructorDeclaration? _pickPreferredConstructor(ClassDeclaration node) {
    final constructors = node.members
        .whereType<ConstructorDeclaration>()
        .toList();
    if (constructors.isEmpty) return null;

    for (final ctor in constructors) {
      if (ctor.name == null) return ctor;
    }
    return constructors.first;
  }

  Map<String, Expression?> _collectConstructorDefaults(
    ConstructorDeclaration ctor,
  ) {
    final out = <String, Expression?>{};
    for (final parameter in ctor.parameters.parameters) {
      if (parameter is DefaultFormalParameter) {
        final inner = parameter.parameter;
        if (inner is FieldFormalParameter) {
          final name = _extractFieldFormalName(inner);
          if (name != null) {
            out[name] = parameter.defaultValue;
          }
        }
        continue;
      }

      if (parameter is FieldFormalParameter) {
        final name = _extractFieldFormalName(parameter);
        if (name != null) {
          out[name] = null;
        }
      }
    }
    return out;
  }

  String? _extractFieldFormalName(FieldFormalParameter parameter) {
    final match = RegExp(r'this\.(\w+)').firstMatch(parameter.toSource());
    return match?.group(1);
  }
}

String _normalizeType(String raw) {
  final compact = raw.replaceAll(RegExp(r'\s+'), ' ').trim();
  return compact.replaceAll('?', '').trim();
}

_ParsedThemeFile _parseThemeFile(File file) {
  final content = file.readAsStringSync();
  final parseResult = parseString(content: content, path: file.path);
  final visitor = _ThemeClassVisitor();
  parseResult.unit.visitChildren(visitor);
  return _ParsedThemeFile(visitor.fields, visitor.classNames);
}

class _Range {
  const _Range(this.min, this.max, this.step);

  final num min;
  final num max;
  final num step;
}

class _InferenceOverrides {
  _InferenceOverrides({
    required this.groups,
    required this.labels,
    required this.descriptions,
    required this.tokenPaths,
    required this.ranges,
    required this.fieldTypes,
    required this.advanced,
    required this.errors,
    required this.warnings,
    required this.referencedFields,
  });

  final Map<String, String> groups;
  final Map<String, String> labels;
  final Map<String, String> descriptions;
  final Map<String, String> tokenPaths;
  final Map<String, _Range> ranges;
  final Map<String, FieldType> fieldTypes;
  final Map<String, bool> advanced;
  final List<String> errors;
  final List<String> warnings;
  final Set<String> referencedFields;
}

_InferenceOverrides _readOverrides(File defaultsFile, Set<String> knownFields) {
  final candidateA = File(
    defaultsFile.path.replaceAll(
      '_theme_defaults.dart',
      '_schema_overrides.json',
    ),
  );
  final candidateB = File(
    defaultsFile.path.replaceAll(
      '_theme_defaults.dart',
      '_theme_schema_overrides.json',
    ),
  );

  File? source;
  if (candidateA.existsSync()) {
    source = candidateA;
  } else if (candidateB.existsSync()) {
    source = candidateB;
  }

  if (source == null) {
    return _InferenceOverrides(
      groups: const <String, String>{},
      labels: const <String, String>{},
      descriptions: const <String, String>{},
      tokenPaths: const <String, String>{},
      ranges: const <String, _Range>{},
      fieldTypes: const <String, FieldType>{},
      advanced: const <String, bool>{},
      errors: <String>[],
      warnings: <String>[],
      referencedFields: <String>{},
    );
  }

  final errors = <String>[];
  final warnings = <String>[];
  final referencedFields = <String>{};
  final sourcePath = source.path;

  Map<String, dynamic> root;
  try {
    root = jsonDecode(source.readAsStringSync()) as Map<String, dynamic>;
  } catch (error) {
    errors.add('Invalid JSON in override file $sourcePath: $error');
    return _InferenceOverrides(
      groups: const <String, String>{},
      labels: const <String, String>{},
      descriptions: const <String, String>{},
      tokenPaths: const <String, String>{},
      ranges: const <String, _Range>{},
      fieldTypes: const <String, FieldType>{},
      advanced: const <String, bool>{},
      errors: errors,
      warnings: warnings,
      referencedFields: referencedFields,
    );
  }

  Map<String, String> stringMap(String key) {
    final map = <String, String>{};
    final value = root[key];
    if (value == null) return map;
    if (value is! Map) {
      errors.add('"$key" in $sourcePath must be an object.');
      return map;
    }
    value.forEach((rawK, rawV) {
      if (rawK is! String || rawV is! String) {
        errors.add('"$key" entries in $sourcePath must be string->string.');
        return;
      }
      map[rawK] = rawV;
      referencedFields.add(rawK);
    });
    return map;
  }

  final groups = stringMap('groups');
  final labels = stringMap('labels');
  final descriptions = stringMap('descriptions');
  final tokenPaths = stringMap('tokenPaths');

  final ranges = <String, _Range>{};
  final rawRanges = root['ranges'];
  if (rawRanges != null) {
    if (rawRanges is! Map) {
      errors.add('"ranges" in $sourcePath must be an object.');
    } else {
      rawRanges.forEach((rawK, rawV) {
        if (rawK is! String || rawV is! Map) {
          errors.add('"ranges" entries in $sourcePath must be object values.');
          return;
        }
        final min = rawV['min'];
        final max = rawV['max'];
        final step = rawV['step'];
        if (min is! num || max is! num || step is! num) {
          errors.add(
            '"ranges.$rawK" in $sourcePath requires numeric min/max/step.',
          );
          return;
        }
        ranges[rawK] = _Range(min, max, step);
        referencedFields.add(rawK);
      });
    }
  }

  final fieldTypes = <String, FieldType>{};
  final rawFieldTypes = root['fieldTypes'];
  if (rawFieldTypes != null) {
    if (rawFieldTypes is! Map) {
      errors.add('"fieldTypes" in $sourcePath must be an object.');
    } else {
      rawFieldTypes.forEach((rawK, rawV) {
        if (rawK is! String || rawV is! String) {
          errors.add(
            '"fieldTypes" entries in $sourcePath must be string->string.',
          );
          return;
        }
        final normalized = rawV.toLowerCase().trim();
        switch (normalized) {
          case 'boolean':
            fieldTypes[rawK] = FieldType.boolean;
            break;
          case 'number':
            fieldTypes[rawK] = FieldType.number;
            break;
          case 'integer':
            fieldTypes[rawK] = FieldType.integer;
            break;
          case 'string':
            fieldTypes[rawK] = FieldType.string;
            break;
          case 'color':
            fieldTypes[rawK] = FieldType.color;
            break;
          case 'duration':
            fieldTypes[rawK] = FieldType.duration;
            break;
          case 'enum':
            fieldTypes[rawK] = FieldType.enumType;
            break;
          case 'object':
            fieldTypes[rawK] = FieldType.object;
            break;
          default:
            errors.add(
              'Unsupported field type "$rawV" for "$rawK" in $sourcePath.',
            );
        }
        referencedFields.add(rawK);
      });
    }
  }

  final advanced = <String, bool>{};
  final rawAdvanced = root['advanced'];
  if (rawAdvanced != null) {
    if (rawAdvanced is! Map) {
      errors.add('"advanced" in $sourcePath must be an object.');
    } else {
      rawAdvanced.forEach((rawK, rawV) {
        if (rawK is! String || rawV is! bool) {
          errors.add('"advanced" entries in $sourcePath must be string->bool.');
          return;
        }
        advanced[rawK] = rawV;
        referencedFields.add(rawK);
      });
    }
  }

  for (final field in referencedFields) {
    if (!knownFields.contains(field)) {
      warnings.add(
        'Override references unknown field "$field" in $sourcePath.',
      );
    }
  }

  return _InferenceOverrides(
    groups: groups,
    labels: labels,
    descriptions: descriptions,
    tokenPaths: tokenPaths,
    ranges: ranges,
    fieldTypes: fieldTypes,
    advanced: advanced,
    errors: errors,
    warnings: warnings,
    referencedFields: referencedFields,
  );
}

bool _isLikelyBooleanName(String fieldName) {
  final lower = fieldName.toLowerCase();
  return lower.startsWith('show') ||
      lower.startsWith('enable') ||
      lower.startsWith('is') ||
      lower.startsWith('has') ||
      lower.startsWith('ignore');
}

bool _isLikelyColorName(String fieldName) {
  final lower = fieldName.toLowerCase();
  return lower.startsWith('color') ||
      lower.endsWith('color') ||
      lower.contains('background') ||
      lower.contains('foreground');
}

bool _isLikelyDurationName(String fieldName) {
  final lower = fieldName.toLowerCase();
  return lower.startsWith('duration') ||
      lower.startsWith('delay') ||
      lower.endsWith('duration') ||
      lower.endsWith('delay');
}

bool _isLikelyNumberName(String fieldName) {
  final lower = fieldName.toLowerCase();
  return lower.contains('height') ||
      lower.contains('width') ||
      lower.contains('padding') ||
      lower.contains('margin') ||
      lower.contains('gap') ||
      lower.contains('spacing') ||
      lower.contains('border') ||
      lower.contains('radius') ||
      lower.contains('corner') ||
      lower.contains('fontsize') ||
      lower.contains('fontweight') ||
      lower.contains('letterspacing') ||
      lower.contains('icon') ||
      lower.contains('opacity') ||
      lower.contains('shadow') ||
      lower.contains('elevation');
}

String _inferGroup(String fieldName) {
  final lower = fieldName.toLowerCase();

  if (lower.contains('height') ||
      lower.contains('width') ||
      lower.contains('padding') ||
      lower.contains('margin') ||
      lower.contains('gap') ||
      lower.contains('spacing')) {
    return 'Dimensions';
  }

  if (lower.contains('border') ||
      lower.contains('radius') ||
      lower.contains('corner') ||
      lower.contains('shadow') ||
      lower.contains('elevation') ||
      lower.contains('opacity')) {
    return 'Appearance';
  }

  if (lower.contains('font') ||
      lower.contains('text') ||
      lower.contains('letter') ||
      lower.contains('icon')) {
    return 'Typography';
  }

  if (lower.contains('color') ||
      lower.contains('background') ||
      lower.contains('foreground')) {
    return 'Colors';
  }

  if (lower.contains('duration') ||
      lower.contains('delay') ||
      lower.contains('animation')) {
    return 'Animation';
  }

  if (lower.startsWith('ignore') ||
      lower.startsWith('enable') ||
      lower.startsWith('disable')) {
    return 'Advanced';
  }

  if (_isLikelyBooleanName(fieldName)) {
    return 'Options';
  }

  return 'General';
}

FieldType _inferFieldType(_DefaultFieldInfo field) {
  final type = _normalizeType(field.type);
  final lower = field.name.toLowerCase();

  if (type == 'bool' || _isLikelyBooleanName(field.name)) {
    return FieldType.boolean;
  }
  if (type == 'Color' || _isLikelyColorName(field.name)) {
    return FieldType.color;
  }
  if (type == 'Duration' || _isLikelyDurationName(field.name)) {
    return FieldType.duration;
  }
  if ((type == 'int' && lower.contains('weight')) || _looksEnumLike(field)) {
    return FieldType.enumType;
  }
  if (type == 'double' || type == 'num') {
    return FieldType.number;
  }
  if (type == 'int') {
    return FieldType.integer;
  }
  if (type == 'String') {
    final options = _inferEnumOptions(field.name, field.type);
    return options != null ? FieldType.enumType : FieldType.string;
  }
  if (_isLikelyNumberName(field.name)) {
    return FieldType.number;
  }
  return FieldType.object;
}

bool _looksEnumLike(_DefaultFieldInfo field) {
  final expr = field.defaultExpr;
  if (expr is PrefixedIdentifier) return true;
  if (expr is PropertyAccess) return true;
  return false;
}

_Range _inferRange(String fieldName, String type) {
  final lower = fieldName.toLowerCase();
  final normalizedType = _normalizeType(type);
  final isInt = normalizedType == 'int';

  if (lower.contains('opacity')) {
    return const _Range(0.0, 1.0, 0.05);
  }
  if (lower.contains('fontsize') || lower.contains('textsize')) {
    return const _Range(10.0, 32.0, 1.0);
  }
  if (lower.contains('height') || lower.contains('width')) {
    return const _Range(0.0, 200.0, 4.0);
  }
  if (lower.contains('padding') || lower.contains('margin')) {
    return const _Range(0.0, 48.0, 4.0);
  }
  if (lower.contains('gap') || lower.contains('spacing')) {
    return const _Range(0.0, 32.0, 2.0);
  }
  if (lower.contains('borderwidth') || lower.contains('strokewidth')) {
    return const _Range(0.0, 8.0, 0.5);
  }
  if (lower.contains('radius') || lower.contains('corner')) {
    return const _Range(0.0, 32.0, 1.0);
  }
  if (lower.contains('icon') && lower.contains('size')) {
    return const _Range(12.0, 48.0, 2.0);
  }
  if (lower.contains('letter') || lower.contains('tracking')) {
    return const _Range(-2.0, 4.0, 0.1);
  }
  if (lower.contains('shadow') || lower.contains('elevation')) {
    return const _Range(0.0, 24.0, 1.0);
  }
  if (_isLikelyDurationName(fieldName)) {
    return const _Range(0, 5000, 50);
  }
  return _Range(0.0, 100.0, isInt ? 1 : 1.0);
}

_Range? _fitRangeToDefault(
  _Range? range,
  Object? defaultValue,
  FieldType type,
) {
  if (range == null) return null;
  if (defaultValue is! num) return range;

  num min = range.min;
  num max = range.max;
  if (defaultValue < min) {
    min = defaultValue;
  }
  if (defaultValue > max) {
    max = defaultValue;
  }

  if (type == FieldType.integer || type == FieldType.duration) {
    min = min.floor();
    max = max.ceil();
  }

  if (min == max) {
    max = min + (range.step == 0 ? 1 : range.step);
  }

  return _Range(min, max, range.step);
}

List<String>? _inferEnumOptions(String fieldName, String type) {
  final lower = fieldName.toLowerCase();

  if (lower.contains('weight')) {
    return const <String>['300', '400', '500', '600', '700', '800', '900'];
  }
  if (lower.contains('align') && lower.contains('text')) {
    return const <String>['left', 'center', 'right', 'justify'];
  }
  if (lower.contains('variant') || lower.contains('style')) {
    return const <String>[
      'default',
      'primary',
      'secondary',
      'outline',
      'ghost',
      'destructive',
    ];
  }
  if (lower.contains('size')) {
    return const <String>['sm', 'md', 'lg', 'xl'];
  }

  final normalizedType = _normalizeType(type);
  if (normalizedType == 'bool') {
    return const <String>['false', 'true'];
  }

  return null;
}

String? _suggestTokenPath(String fieldName) {
  final lower = fieldName.toLowerCase();

  if (lower.contains('padding') ||
      lower.contains('margin') ||
      lower.contains('gap')) {
    return 'spacing.md';
  }
  if (lower.contains('radius') || lower.contains('corner')) {
    return 'radius.md';
  }
  if (lower.contains('fontsize')) {
    return 'typography.body.fontSize';
  }
  if (lower.contains('color') ||
      lower.contains('background') ||
      lower.contains('foreground')) {
    return 'palette.primary';
  }
  return null;
}

String _getTokenFamily(String fieldName) {
  final lower = fieldName.toLowerCase();

  if (lower.contains('padding') ||
      lower.contains('margin') ||
      lower.contains('gap')) {
    return 'spacing';
  }
  if (lower.contains('radius') || lower.contains('corner')) {
    return 'radius';
  }
  if (lower.contains('font') || lower.contains('text')) {
    return 'typography';
  }
  if (lower.contains('color') || lower.contains('background')) {
    return 'palette';
  }
  return 'general';
}

String _toLabel(String fieldName) {
  final result = fieldName
      .replaceAllMapped(RegExp(r'([A-Z])'), (match) => ' ${match.group(1)}')
      .trim();
  if (result.isEmpty) return fieldName;
  return result.substring(0, 1).toUpperCase() + result.substring(1);
}

String _generateDescription(String fieldName, String type) {
  final label = _toLabel(fieldName);
  final lower = fieldName.toLowerCase();

  if (_isLikelyBooleanName(fieldName) || _normalizeType(type) == 'bool') {
    if (fieldName.startsWith('show')) return 'Show or hide $label.';
    if (fieldName.startsWith('enable')) return 'Enable or disable $label.';
    if (fieldName.startsWith('ignore')) return 'Override global theme setting.';
    return 'Toggle $label.';
  }

  if (lower.contains('radius')) {
    return '$label in pixels (affected by theme.radius).';
  }
  if (lower.contains('opacity')) {
    return '$label (0.0 = transparent, 1.0 = opaque).';
  }
  if (_isLikelyColorName(fieldName) || _normalizeType(type) == 'Color') {
    return '$label in hex format (#RRGGBB or #AARRGGBB).';
  }
  if (_isLikelyDurationName(fieldName) || _normalizeType(type) == 'Duration') {
    return '$label in milliseconds.';
  }

  return '$label in pixels (affected by theme.scaling).';
}

Object? _defaultValueForField(_DefaultFieldInfo field, FieldType fieldType) {
  final expr = field.defaultExpr;
  if (expr == null) return null;

  switch (fieldType) {
    case FieldType.boolean:
      if (expr is BooleanLiteral) return expr.value;
      break;
    case FieldType.integer:
      if (expr is IntegerLiteral) return expr.value;
      if (expr is DoubleLiteral) return expr.value.round();
      break;
    case FieldType.number:
      if (expr is IntegerLiteral) return expr.value;
      if (expr is DoubleLiteral) return expr.value;
      if (expr is PrefixExpression && expr.operator.lexeme == '-') {
        final operand = expr.operand;
        if (operand is IntegerLiteral) {
          final value = operand.value;
          if (value != null) return -value;
        }
        if (operand is DoubleLiteral) return -operand.value;
      }
      break;
    case FieldType.string:
      if (expr is StringLiteral) return expr.stringValue;
      break;
    case FieldType.duration:
      return _durationValue(expr);
    case FieldType.color:
      return _colorValue(expr);
    case FieldType.enumType:
      return _enumLikeValue(expr) ?? _stringLiteral(expr);
    default:
      break;
  }
  return null;
}

String? _stringLiteral(Expression expr) {
  if (expr is StringLiteral) return expr.stringValue;
  return null;
}

Object? _durationValue(Expression expr) {
  if (expr is IntegerLiteral) return expr.value;
  if (expr is DoubleLiteral) return expr.value.round();
  if (expr is InstanceCreationExpression) {
    final name = expr.constructorName.type.name2.lexeme;
    if (name == 'Duration') {
      for (final arg in expr.argumentList.arguments) {
        if (arg is NamedExpression) {
          final label = arg.name.label.name;
          final value = arg.expression;
          if (value is IntegerLiteral || value is DoubleLiteral) {
            final num? numeric = value is IntegerLiteral
                ? value.value
                : (value as DoubleLiteral).value;
            if (numeric == null) {
              continue;
            }
            switch (label) {
              case 'milliseconds':
                return numeric;
              case 'seconds':
                return (numeric * 1000).round();
              case 'minutes':
                return (numeric * 60000).round();
            }
          }
        }
      }
    }
  }
  return null;
}

Object? _colorValue(Expression expr) {
  if (expr is IntegerLiteral) {
    final value = expr.value;
    if (value != null) return _hexColor(value);
  }

  if (expr is InstanceCreationExpression) {
    final typeName = expr.constructorName.type.name2.lexeme;
    if (typeName == 'Color' && expr.argumentList.arguments.isNotEmpty) {
      final first = expr.argumentList.arguments.first;
      if (first is IntegerLiteral) {
        final value = first.value;
        if (value != null) return _hexColor(value);
      }
    }
  }

  if (expr is PrefixedIdentifier) {
    final prefix = expr.prefix.name;
    if (prefix == 'Colors') {
      return expr.identifier.name;
    }
  }
  return null;
}

String _hexColor(int value) {
  final hex = value.toRadixString(16).padLeft(8, '0').toUpperCase();
  if (hex.startsWith('FF')) {
    return '#${hex.substring(2)}';
  }
  return '#$hex';
}

String? _enumLikeValue(Expression expr) {
  if (expr is PrefixedIdentifier) {
    return expr.identifier.name;
  }
  if (expr is PropertyAccess) {
    return expr.propertyName.name;
  }
  if (expr is IntegerLiteral) {
    final value = expr.value;
    if (value != null) return value.toString();
    return null;
  }
  if (expr is StringLiteral) {
    return expr.stringValue;
  }
  return null;
}

FieldValidation _buildValidation(FieldType fieldType, {_Range? range}) {
  switch (fieldType) {
    case FieldType.number:
    case FieldType.integer:
      return FieldValidation(
        clamp: ClampBehavior.reject,
        min: range?.min,
        max: range?.max,
        step: range?.step,
      );
    default:
      return const FieldValidation();
  }
}

EditorHints _buildUiHints(FieldType fieldType, {_Range? range}) {
  switch (fieldType) {
    case FieldType.number:
    case FieldType.integer:
      if (range != null) {
        return const EditorHints(control: UiControl.slider, unit: UiUnit.px);
      }
      return const EditorHints(control: UiControl.input, unit: UiUnit.px);
    case FieldType.color:
      return const EditorHints(control: UiControl.color);
    case FieldType.duration:
      return const EditorHints(control: UiControl.input, unit: UiUnit.ms);
    case FieldType.enumType:
      return const EditorHints(control: UiControl.select);
    default:
      return const EditorHints(control: UiControl.input);
  }
}

String _prettyLabel(String text) {
  final spaced = text.replaceAllMapped(
    RegExp(r'([a-z0-9])([A-Z])'),
    (m) => '${m.group(1)} ${m.group(2)}',
  );
  final words = spaced.split('_').join(' ').split(RegExp(r'\s+'));
  return words
      .where((entry) => entry.isNotEmpty)
      .map((entry) => '${entry[0].toUpperCase()}${entry.substring(1)}')
      .join(' ');
}

class _GenerationTarget {
  _GenerationTarget({
    required this.componentId,
    required this.category,
    required this.componentDir,
    required this.defaultsFile,
    required this.tokensFile,
  });

  final String componentId;
  final String category;
  final Directory componentDir;
  final File defaultsFile;
  final File? tokensFile;
}

_GenerationTarget? _resolveTarget({
  required File defaultsFile,
  required Directory componentsRoot,
}) {
  final relative = defaultsFile.path.substring(componentsRoot.path.length + 1);
  final parts = relative.split(Platform.pathSeparator);
  if (parts.length < 3) return null;
  final category = parts[0];
  final componentId = parts[1];
  final componentDir = Directory(
    '${componentsRoot.path}/$category/$componentId',
  );
  if (!componentDir.existsSync()) return null;

  final tokensFile = File(
    defaultsFile.path.replaceAll('_theme_defaults.dart', '_theme_tokens.dart'),
  );
  return _GenerationTarget(
    componentId: componentId,
    category: category,
    componentDir: componentDir,
    defaultsFile: defaultsFile,
    tokensFile: tokensFile.existsSync() ? tokensFile : null,
  );
}

List<_GenerationTarget> _collectTargets(
  Directory componentsRoot, {
  required Set<String> filterComponents,
}) {
  final targets = <_GenerationTarget>[];

  for (final entity in componentsRoot.listSync(recursive: true)) {
    if (entity is! File) continue;
    if (!entity.path.endsWith('_theme_defaults.dart')) continue;

    final target = _resolveTarget(
      defaultsFile: entity,
      componentsRoot: componentsRoot,
    );
    if (target == null) continue;
    if (filterComponents.isNotEmpty &&
        !filterComponents.contains(target.componentId)) {
      continue;
    }
    targets.add(target);
  }

  targets.sort((a, b) => a.defaultsFile.path.compareTo(b.defaultsFile.path));
  return targets;
}

List<_DefaultFieldInfo> _mergeFields({
  required List<_DefaultFieldInfo> defaultsFields,
  required List<_DefaultFieldInfo> tokenFields,
}) {
  final out = <_DefaultFieldInfo>[];
  final byName = <String, _DefaultFieldInfo>{};

  for (final field in tokenFields) {
    byName[field.name] = field;
  }
  for (final field in defaultsFields) {
    byName[field.name] = field;
  }

  final keys = byName.keys.toList()..sort();
  for (final key in keys) {
    out.add(byName[key]!);
  }
  return out;
}

Map<String, dynamic> _buildSchemaMap(
  ComponentSchema schema, {
  required bool canonical,
}) {
  final json = schema.toJson();
  json[r'$schema'] = canonical
      ? '../../../../manifests/component_theme.schema.json'
      : '../../../manifests/component_theme.schema.json';
  return json;
}

String _jsonEncodePretty(Object? data) {
  return const JsonEncoder.withIndent('  ').convert(data);
}

String _schemaClassName(String componentId) {
  return '${_prettyLabel(componentId).replaceAll(' ', '')}ThemeSchema';
}

String _buildDartSchemaFile({
  required String componentId,
  required Map<String, dynamic> schemaJson,
}) {
  final className = _schemaClassName(componentId);
  final escaped = _jsonEncodePretty(schemaJson).replaceAll("'''", r"\'\'\'");
  return """
// GENERATED CODE - DO NOT MODIFY BY HAND
// Generator: convention-based schema generator

import 'dart:convert';

import '../../../../../../shared/theme/schema/component_schema.dart';

class $className {
  static const String id = '$componentId';

  static final ComponentSchema schema = ComponentSchema.fromJson(
    jsonDecode(_rawSchema) as Map<String, dynamic>,
  );

  static const String _rawSchema = r'''$escaped''';
}
""";
}

class _BuildResult {
  _BuildResult({
    required this.schema,
    required this.includedFields,
    required this.skippedFields,
    required this.overrideErrors,
    required this.overrideWarnings,
  });

  final ComponentSchema schema;
  final int includedFields;
  final List<String> skippedFields;
  final List<String> overrideErrors;
  final List<String> overrideWarnings;
}

_BuildResult _buildComponentSchema({
  required _GenerationTarget target,
  required String title,
  required String since,
  required String description,
}) {
  final defaultsParsed = _parseThemeFile(target.defaultsFile);
  final tokenParsed = target.tokensFile != null
      ? _parseThemeFile(target.tokensFile!)
      : _ParsedThemeFile(const <_DefaultFieldInfo>[], const <String>[]);

  final mergedFields = _mergeFields(
    defaultsFields: defaultsParsed.fields,
    tokenFields: tokenParsed.fields,
  );
  final knownFieldNames = mergedFields.map((entry) => entry.name).toSet();
  final overrides = _readOverrides(target.defaultsFile, knownFieldNames);

  final skippedFields = <String>[];
  final grouped = <String, List<FieldSpec>>{};

  for (final field in mergedFields) {
    var inferredType = _inferFieldType(field);
    if (overrides.fieldTypes.containsKey(field.name)) {
      inferredType = overrides.fieldTypes[field.name]!;
    }

    if (inferredType == FieldType.object) {
      skippedFields.add(
        '${field.name} (${field.type}) in ${field.sourceClass}: unsupported/object type',
      );
      continue;
    }

    var group = _inferGroup(field.name);
    if (overrides.groups.containsKey(field.name)) {
      group = overrides.groups[field.name]!;
    }

    _Range? range;
    if (inferredType == FieldType.number ||
        inferredType == FieldType.integer ||
        inferredType == FieldType.duration) {
      range = _inferRange(field.name, field.type);
      if (overrides.ranges.containsKey(field.name)) {
        range = overrides.ranges[field.name];
      }
    }

    final inferredDefault = _defaultValueForField(field, inferredType);
    range = _fitRangeToDefault(range, inferredDefault, inferredType);

    final tokenPathOverride = overrides.tokenPaths[field.name];
    final tokenPath = tokenPathOverride ?? _suggestTokenPath(field.name);
    final tokenBinding = tokenPath == null
        ? null
        : TokenBinding(
            path: tokenPath,
            allowedFamilies: <String>[_getTokenFamily(field.name)],
          );

    var label = _toLabel(field.name);
    if (overrides.labels.containsKey(field.name)) {
      label = overrides.labels[field.name]!;
    }

    var descriptionText = _generateDescription(field.name, field.type);
    if (overrides.descriptions.containsKey(field.name)) {
      descriptionText = overrides.descriptions[field.name]!;
    }

    final isAdvanced =
        overrides.advanced[field.name] ?? field.name.startsWith('ignore');

    final fieldSpec = FieldSpec(
      type: inferredType,
      name: field.name,
      label: label,
      description: descriptionText,
      defaultValue: inferredDefault,
      requiredField: false,
      isAdvanced: isAdvanced,
      visibleIf: const <VisibleIf>[],
      tokenBinding: tokenBinding,
      validation: _buildValidation(inferredType, range: range),
      ui: _buildUiHints(inferredType, range: range),
      since: since,
    );

    grouped.putIfAbsent(group, () => <FieldSpec>[]).add(fieldSpec);
  }

  final groupOrder = <String>[
    'Dimensions',
    'Appearance',
    'Typography',
    'Colors',
    'Animation',
    'Options',
    'Advanced',
    'General',
  ];
  final orderedGroupNames = grouped.keys.toList()
    ..sort((a, b) {
      final ai = groupOrder.indexOf(a);
      final bi = groupOrder.indexOf(b);
      final va = ai == -1 ? 999 : ai;
      final vb = bi == -1 ? 999 : bi;
      if (va != vb) return va.compareTo(vb);
      return a.compareTo(b);
    });

  final groups = <SchemaGroup>[];
  for (final groupName in orderedGroupNames) {
    final fields = grouped[groupName]!
      ..sort((a, b) => a.name.compareTo(b.name));
    groups.add(SchemaGroup(title: groupName, fields: fields));
  }

  return _BuildResult(
    schema: ComponentSchema(
      id: target.componentId,
      title: '$title Theme',
      description: description,
      schemaVersion: 1,
      since: since,
      migrations: const <String, String>{},
      groups: groups,
    ),
    includedFields: grouped.values.fold<int>(
      0,
      (sum, fields) => sum + fields.length,
    ),
    skippedFields: skippedFields,
    overrideErrors: overrides.errors,
    overrideWarnings: overrides.warnings,
  );
}

void _writeJson(File file, Object data) {
  file.parent.createSync(recursive: true);
  file.writeAsStringSync('${_jsonEncodePretty(data)}\n');
}

void _writeSchemaJson({
  required ComponentMetadataPaths metadata,
  required ComponentSchema schema,
}) {
  final canonical = _buildSchemaMap(schema, canonical: true);
  final legacy = _buildSchemaMap(schema, canonical: false);
  _writeJson(metadata.canonicalThemeSchema, canonical);
  _writeJson(metadata.legacyThemeSchema, legacy);
}

void _writeDartSchema(
  File defaultsFile,
  Map<String, dynamic> canonicalSchemaJson,
  String componentId,
) {
  final output = File(
    defaultsFile.path.replaceAll('_theme_defaults.dart', '_theme_schema.dart'),
  );
  output.parent.createSync(recursive: true);
  output.writeAsStringSync(
    _buildDartSchemaFile(
      componentId: componentId,
      schemaJson: canonicalSchemaJson,
    ),
  );
}

void main(List<String> args) {
  final parsed = _parseArgs(args);
  if (parsed.hasFlag('help') || parsed.hasFlag('h')) {
    _printUsage();
    return;
  }

  final dryRun = parsed.hasFlag('dry-run');
  final strict = parsed.hasFlag('strict');
  final filterComponents = _parseCsvValues(
    parsed.getValues('components'),
  ).toSet();

  _OutputFormat format;
  try {
    format = _parseFormat(parsed);
  } catch (error) {
    stderr.writeln(error);
    _printUsage();
    exitCode = 1;
    return;
  }

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

  final targets = _collectTargets(
    componentsRoot,
    filterComponents: filterComponents,
  );
  if (targets.isEmpty) {
    stdout.writeln('No matching *_theme_defaults.dart files found.');
    return;
  }

  var generated = 0;
  var skippedFieldCount = 0;
  var hasStrictViolation = false;

  stdout.writeln('Scanning ${targets.length} defaults files...');

  for (final target in targets) {
    final metadata = ComponentMetadataPaths(
      entryDir: target.componentDir,
      id: target.componentId,
    );
    final metaFile = preferredFile(
      canonical: metadata.canonicalMeta,
      legacy: metadata.legacyMeta,
    );

    var title = _prettyLabel(target.componentId);
    var since = '1.0.0';
    var description =
        'Convention-generated theme schema for ${_prettyLabel(target.componentId)}.';

    if (metaFile.existsSync()) {
      final meta = jsonDecode(metaFile.readAsStringSync()) as JsonMap;
      final rawName = (meta['name'] as String?)?.trim();
      final rawVersion = (meta['version'] as String?)?.trim();
      final rawDescription = (meta['description'] as String?)?.trim();
      if (rawName != null && rawName.isNotEmpty) title = rawName;
      if (rawVersion != null && rawVersion.isNotEmpty) since = rawVersion;
      if (rawDescription != null && rawDescription.isNotEmpty) {
        description = '$rawDescription Theme tokens and editor schema.';
      }
    }

    final built = _buildComponentSchema(
      target: target,
      title: title,
      since: since,
      description: description,
    );

    skippedFieldCount += built.skippedFields.length;

    if (built.overrideErrors.isNotEmpty) {
      hasStrictViolation = true;
      for (final error in built.overrideErrors) {
        stderr.writeln('ERROR: $error');
      }
    }
    if (built.overrideWarnings.isNotEmpty) {
      for (final warning in built.overrideWarnings) {
        stderr.writeln('WARN: $warning');
      }
      if (strict) {
        hasStrictViolation = true;
      }
    }
    if (strict && built.skippedFields.isNotEmpty) {
      hasStrictViolation = true;
    }

    final canonicalJson = _buildSchemaMap(built.schema, canonical: true);
    final dartOutputPath = target.defaultsFile.path.replaceAll(
      '_theme_defaults.dart',
      '_theme_schema.dart',
    );

    stdout.writeln(
      '- ${target.componentId}: ${built.includedFields} fields '
      '(skipped ${built.skippedFields.length})',
    );

    if (dryRun) {
      if (format == _OutputFormat.json || format == _OutputFormat.both) {
        stdout.writeln('  [dry-run] ${metadata.canonicalThemeSchema.path}');
        stdout.writeln('  [dry-run] ${metadata.legacyThemeSchema.path}');
      }
      if (format == _OutputFormat.dart || format == _OutputFormat.both) {
        stdout.writeln('  [dry-run] $dartOutputPath');
      }
      continue;
    }

    if (format == _OutputFormat.json || format == _OutputFormat.both) {
      _writeSchemaJson(metadata: metadata, schema: built.schema);
    }
    if (format == _OutputFormat.dart || format == _OutputFormat.both) {
      _writeDartSchema(target.defaultsFile, canonicalJson, target.componentId);
    }
    generated++;
  }

  stdout.writeln(
    'Done. Generated $generated component schema set(s). '
    'Skipped $skippedFieldCount unsupported field(s).',
  );

  if (hasStrictViolation) {
    stderr.writeln('Strict checks failed.');
    exitCode = 2;
  }
}

import 'dart:io';

class Registration {
  Registration({required this.fieldName, required this.typeName});

  final String fieldName;
  final String typeName;
}

class ThemeField {
  ThemeField({required this.name, required this.type});

  final String name;
  final String type;
}

class ThemeClassData {
  ThemeClassData({required this.name, required this.fields});

  final String name;
  final List<ThemeField> fields;
}

void main() {
  final root = Directory.current.path;
  final componentsDir = Directory('$root/lib/registry/components');
  if (!componentsDir.existsSync()) {
    stderr.writeln('Missing components dir: ${componentsDir.path}');
    exitCode = 1;
    return;
  }

  final configFiles =
      componentsDir
          .listSync(recursive: true)
          .whereType<File>()
          .where((f) => f.path.endsWith('_theme_config.dart'))
          .toList()
        ..sort((a, b) => a.path.compareTo(b.path));

  var rewritten = 0;
  for (final configFile in configFiles) {
    final configPath = configFile.path;
    final configDir = configFile.parent.path;
    final defaultsPath =
        '$configDir/${_baseName(configPath)}_theme_defaults.dart';
    final tokensPath = '$configDir/${_baseName(configPath)}_theme_tokens.dart';

    final defaultsFile = File(defaultsPath);
    final tokensFile = File(tokensPath);
    if (!defaultsFile.existsSync() || !tokensFile.existsSync()) {
      continue;
    }

    final configContent = configFile.readAsStringSync();
    final configClassName = _extractConfigClassName(configContent);
    if (configClassName == null) continue;

    final regs = _extractRegistrations(configContent, configClassName);
    if (regs.isEmpty) continue;

    final componentDir = configFile.parent.parent.parent;
    final componentDartFiles = componentDir
        .listSync(recursive: true)
        .whereType<File>()
        .where((f) => f.path.endsWith('.dart'))
        .toList();

    final themeClassMap = _collectThemeClasses(componentDartFiles);
    final fallbackMap = _collectFallbackMap(componentDartFiles);

    final defaultsOut = _buildDefaultsFile(regs, themeClassMap, fallbackMap);
    final tokensOut = _buildTokensFile(regs, themeClassMap);
    final configOut = _buildConfigFile(configClassName, regs);

    defaultsFile.writeAsStringSync(defaultsOut);
    tokensFile.writeAsStringSync(tokensOut);
    configFile.writeAsStringSync(configOut);
    rewritten++;
  }

  stdout.writeln('Rewrote $rewritten component config triplets.');
}

String _baseName(String configPath) {
  final fileName = configPath.split(Platform.pathSeparator).last;
  return fileName.replaceAll('_theme_config.dart', '');
}

String? _extractConfigClassName(String configContent) {
  final m = RegExp(r'class\s+(\w+ThemeConfig)\s*\{').firstMatch(configContent);
  return m?.group(1);
}

List<Registration> _extractRegistrations(
  String configContent,
  String configClassName,
) {
  final typeRe = RegExp(
    r"static\s+const\s+String\s+(\w+)Type\s*=\s*'([^']+)';",
  );
  final regs = <Registration>[];
  final baseTypeName = configClassName.replaceAll('Config', '');

  for (final m in typeRe.allMatches(configContent)) {
    final typeName = m.group(2)!;
    final fieldName = typeName == baseTypeName
        ? 'global'
        : _lowerCamel(typeName);
    regs.add(Registration(fieldName: fieldName, typeName: typeName));
  }

  if (regs.isEmpty) {
    regs.add(Registration(fieldName: 'global', typeName: baseTypeName));
  }

  return regs;
}

Map<String, ThemeClassData> _collectThemeClasses(List<File> files) {
  final out = <String, ThemeClassData>{};
  final classRe = RegExp(r'class\s+(\w+)\s+extends\s+ComponentThemeData\s*\{');

  for (final file in files) {
    if (file.path.contains(
      '${Platform.pathSeparator}config${Platform.pathSeparator}',
    )) {
      continue;
    }

    final content = file.readAsStringSync();
    for (final m in classRe.allMatches(content)) {
      final className = m.group(1)!;
      final body = _extractClassBody(content, m.start);
      if (body.isEmpty) continue;

      final fields = <ThemeField>[];
      final fieldRe = RegExp(r'final\s+([^;=]+?)\s+(\w+)\s*;');
      for (final fm in fieldRe.allMatches(body)) {
        final type = fm.group(1)!.replaceAll(RegExp(r'\s+'), ' ').trim();
        final name = fm.group(2)!.trim();
        fields.add(ThemeField(name: name, type: type));
      }

      out[className] = ThemeClassData(name: className, fields: fields);
    }
  }

  return out;
}

String _extractClassBody(String content, int classStart) {
  final braceStart = content.indexOf('{', classStart);
  if (braceStart == -1) return '';

  var depth = 0;
  for (var i = braceStart; i < content.length; i++) {
    final ch = content[i];
    if (ch == '{') depth++;
    if (ch == '}') {
      depth--;
      if (depth == 0) {
        return content.substring(braceStart + 1, i);
      }
    }
  }
  return '';
}

Map<String, String> _collectFallbackMap(List<File> files) {
  final out = <String, String>{};

  for (final file in files) {
    if (file.path.contains(
      '${Platform.pathSeparator}config${Platform.pathSeparator}',
    )) {
      continue;
    }

    final lines = file.readAsLinesSync();
    for (final line in lines) {
      if (!line.contains('??')) continue;

      final m = RegExp(
        r'\.?([A-Za-z_]\w*)\s*\?\?\s*([^,);]+)',
      ).firstMatch(line);
      if (m == null) continue;

      final field = m.group(1)!.trim();
      final fallback = m.group(2)!.trim();
      if (field.isEmpty || fallback.isEmpty) continue;
      if (fallback == 'null') continue;

      out.putIfAbsent(field, () => fallback);
    }
  }

  return out;
}

String _buildDefaultsFile(
  List<Registration> regs,
  Map<String, ThemeClassData> themeClassMap,
  Map<String, String> fallbackMap,
) {
  final out = StringBuffer()
    ..writeln('// ═══════════════════════════════════════════════════════════')
    ..writeln('// COMPONENT THEME DEFAULTS')
    ..writeln('// Built-in defaults (never changes)')
    ..writeln('// Hard-coded widget/variant fallbacks are documented per field')
    ..writeln('// ═══════════════════════════════════════════════════════════')
    ..writeln();

  for (final reg in regs) {
    final defaultsClass = '${reg.typeName}Defaults';
    final themeClass = themeClassMap[reg.typeName];
    final fields = themeClass?.fields ?? const <ThemeField>[];

    out.writeln('class $defaultsClass {');
    for (final f in fields) {
      final fallback = fallbackMap[f.name];
      if (fallback != null) {
        out.writeln('  /// Widget fallback: $fallback');
      }
      out.writeln('  final Object? ${f.name};');
    }
    if (fields.isNotEmpty) out.writeln();

    if (fields.isEmpty) {
      out.writeln('  const $defaultsClass();');
    } else {
      out.writeln('  const $defaultsClass({');
      for (final f in fields) {
        final fallback = fallbackMap[f.name];
        final literal = fallback == null ? null : _literalOrNull(fallback);
        if (literal != null) {
          out.writeln('    this.${f.name} = $literal,');
        } else {
          out.writeln('    this.${f.name},');
        }
      }
      out.writeln('  });');
    }
    out.writeln('}');
    out.writeln();
  }

  return '${out.toString().trimRight()}\n';
}

String _buildTokensFile(
  List<Registration> regs,
  Map<String, ThemeClassData> themeClassMap,
) {
  final out = StringBuffer()
    ..writeln('// ═══════════════════════════════════════════════════════════')
    ..writeln('// COMPONENT THEME TOKENS')
    ..writeln(
      '// User customization layer (replace this file from website output)',
    )
    ..writeln('// ═══════════════════════════════════════════════════════════')
    ..writeln();

  for (final reg in regs) {
    final tokensClass = '${reg.typeName}Tokens';
    final tokenInstance = '${_lowerCamel(reg.typeName)}Tokens';
    final themeClass = themeClassMap[reg.typeName];
    final fields = themeClass?.fields ?? const <ThemeField>[];

    out.writeln('class $tokensClass {');
    for (final f in fields) {
      out.writeln('  final Object? ${f.name};');
    }
    out.writeln('  final bool? ignoreGlobalScaling;');
    out.writeln('  final bool? ignoreGlobalRadius;');
    out.writeln();

    out.writeln('  const $tokensClass({');
    for (final f in fields) {
      out.writeln('    this.${f.name},');
    }
    out.writeln('    this.ignoreGlobalScaling,');
    out.writeln('    this.ignoreGlobalRadius,');
    out.writeln('  });');
    out.writeln('}');
    out.writeln();
    out.writeln('const $tokenInstance = $tokensClass();');
    out.writeln();
  }

  return '${out.toString().trimRight()}\n';
}

String _buildConfigFile(String configClassName, List<Registration> regs) {
  final prefixSnake = _snakeFromConfigClass(configClassName);

  final out = StringBuffer()
    ..writeln('// ═══════════════════════════════════════════════════════════')
    ..writeln('// COMPONENT THEME CONFIG')
    ..writeln('// Registration wiring (do not edit manually)')
    ..writeln('// ═══════════════════════════════════════════════════════════')
    ..writeln()
    ..writeln("import '${prefixSnake}_defaults.dart';")
    ..writeln("import '${prefixSnake}_tokens.dart';")
    ..writeln()
    ..writeln('class $configClassName {')
    ..writeln('  const $configClassName._();')
    ..writeln();

  for (final reg in regs) {
    final defaultsClass = '${reg.typeName}Defaults';
    final tokensClass = '${reg.typeName}Tokens';
    final tokenInstance = '${_lowerCamel(reg.typeName)}Tokens';

    out.writeln('  static const Object? ${reg.fieldName} = null;');
    out.writeln(
      "  static const String ${reg.fieldName}Type = '${reg.typeName}';",
    );

    if (reg.fieldName == 'global') {
      out.writeln('  static const $defaultsClass defaults = $defaultsClass();');
      out.writeln('  static const $tokensClass tokens = $tokenInstance;');
    } else {
      out.writeln(
        '  static const $defaultsClass ${reg.fieldName}Defaults = $defaultsClass();',
      );
      out.writeln(
        '  static const $tokensClass ${reg.fieldName}TokenConfig = $tokenInstance;',
      );
    }
    out.writeln();
  }

  out.writeln('  static T? resolve<T>() {');
  for (final reg in regs) {
    out.writeln('    if (T.toString() == ${reg.fieldName}Type) {');
    out.writeln('      return ${reg.fieldName} as T?;');
    out.writeln('    }');
  }
  out.writeln('    return null;');
  out.writeln('  }');
  out.writeln('}');

  return '${out.toString().trimRight()}\n';
}

String? _literalOrNull(String expr) {
  final e = expr.trim();

  if (RegExp(r'^-?\d+(\.\d+)?$').hasMatch(e)) return e;
  if (e == 'true' || e == 'false') return e;
  if (RegExp(r"^'.*'$").hasMatch(e)) return e;
  if (RegExp(r'^".*"$').hasMatch(e)) return e;

  return null;
}

String _snakeFromConfigClass(String className) {
  final raw = className.replaceAll('ThemeConfig', '');
  final withUnderscore = raw.replaceAllMapped(
    RegExp(r'([a-z0-9])([A-Z])'),
    (m) => '${m.group(1)}_${m.group(2)}',
  );
  return '${withUnderscore.toLowerCase()}_theme';
}

String _lowerCamel(String value) {
  if (value.isEmpty) return value;
  return value[0].toLowerCase() + value.substring(1);
}

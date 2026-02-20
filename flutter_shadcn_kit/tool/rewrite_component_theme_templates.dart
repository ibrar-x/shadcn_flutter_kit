import 'dart:io';

class Registration {
  Registration({required this.fieldName, required this.typeName});

  final String fieldName;
  final String typeName;
}

class DefaultsClassData {
  DefaultsClassData({required this.fields, required this.defaults});

  final List<String> fields;
  final Map<String, String> defaults;
}

class ParseState {
  final Map<String, DefaultsClassData> byClass = <String, DefaultsClassData>{};
  final List<String> classOrder = <String>[];
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
    final className = _extractConfigClassName(configContent);
    if (className == null) continue;

    final regs = _extractRegistrations(configContent, className);
    if (regs.isEmpty) continue;

    final defaultsState = _parseDefaultsFile(defaultsFile.readAsStringSync());

    final regDefaults = <String, DefaultsClassData>{};
    final assignedClassNames = <String>{};
    for (var i = 0; i < regs.length; i++) {
      final reg = regs[i];
      final classNameGuess = _findBestDefaultsClassName(
        defaultsState,
        reg.fieldName,
        assignedClassNames,
        i,
      );
      if (classNameGuess != null) {
        assignedClassNames.add(classNameGuess);
        regDefaults[reg.fieldName] = defaultsState.byClass[classNameGuess]!;
      } else {
        regDefaults[reg.fieldName] = DefaultsClassData(
          fields: const <String>[],
          defaults: const <String, String>{},
        );
      }
    }

    final defaultsOut = _buildDefaultsFile(regs, regDefaults);
    final tokensOut = _buildTokensFile(regs, regDefaults);
    final configOut = _buildConfigFile(className, regs);

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

ParseState _parseDefaultsFile(String defaultsContent) {
  final state = ParseState();
  final classRe = RegExp(r'class\s+(\w+)\s*\{([\s\S]*?)\n\}');

  for (final classMatch in classRe.allMatches(defaultsContent)) {
    final className = classMatch.group(1)!;
    final body = classMatch.group(2)!;

    final fields = <String>[];
    for (final fm in RegExp(r'final\s+[^;]+\s+(\w+)\s*;').allMatches(body)) {
      fields.add(fm.group(1)!);
    }

    final defaults = <String, String>{};
    final ctorMatch = RegExp(
      'const\\s+$className\\s*\\(\\{([\\s\\S]*?)\\}\\);',
    ).firstMatch(body);
    if (ctorMatch != null) {
      final paramsRaw = ctorMatch.group(1)!;
      for (final param in _splitTopLevelComma(paramsRaw)) {
        final p = param.trim();
        if (!p.startsWith('this.')) continue;
        final eq = p.indexOf('=');
        if (eq == -1) continue;
        final left = p.substring(5, eq).trim();
        final right = p.substring(eq + 1).trim();
        if (left.isNotEmpty && right.isNotEmpty) {
          defaults[left] = right;
        }
      }
    }

    state.classOrder.add(className);
    state.byClass[className] = DefaultsClassData(
      fields: fields,
      defaults: defaults,
    );
  }

  return state;
}

List<String> _splitTopLevelComma(String input) {
  final parts = <String>[];
  final sb = StringBuffer();
  var depthRound = 0;
  var depthSquare = 0;
  var depthCurly = 0;
  var inSingleQuote = false;
  var inDoubleQuote = false;
  var escaped = false;

  for (var i = 0; i < input.length; i++) {
    final ch = input[i];

    if (escaped) {
      sb.write(ch);
      escaped = false;
      continue;
    }

    if (ch == r'\\') {
      sb.write(ch);
      escaped = true;
      continue;
    }

    if (!inDoubleQuote && ch == "'") {
      inSingleQuote = !inSingleQuote;
      sb.write(ch);
      continue;
    }

    if (!inSingleQuote && ch == '"') {
      inDoubleQuote = !inDoubleQuote;
      sb.write(ch);
      continue;
    }

    if (!inSingleQuote && !inDoubleQuote) {
      if (ch == '(') depthRound++;
      if (ch == ')') depthRound--;
      if (ch == '[') depthSquare++;
      if (ch == ']') depthSquare--;
      if (ch == '{') depthCurly++;
      if (ch == '}') depthCurly--;

      if (ch == ',' && depthRound == 0 && depthSquare == 0 && depthCurly == 0) {
        parts.add(sb.toString());
        sb.clear();
        continue;
      }
    }

    sb.write(ch);
  }

  final tail = sb.toString();
  if (tail.trim().isNotEmpty) {
    parts.add(tail);
  }
  return parts;
}

String? _findBestDefaultsClassName(
  ParseState state,
  String fieldName,
  Set<String> assigned,
  int index,
) {
  final key = fieldName.toLowerCase();

  for (final className in state.classOrder) {
    if (assigned.contains(className)) continue;
    if (className.toLowerCase().contains(key)) return className;
  }

  final unassigned = state.classOrder
      .where((c) => !assigned.contains(c))
      .toList();
  if (index < unassigned.length) {
    return unassigned[index];
  }
  return null;
}

String _buildDefaultsFile(
  List<Registration> regs,
  Map<String, DefaultsClassData> regDefaults,
) {
  final out = StringBuffer()
    ..writeln('// ═══════════════════════════════════════════════════════════')
    ..writeln('// COMPONENT THEME DEFAULTS')
    ..writeln('// Built-in defaults (never changes)')
    ..writeln('// ═══════════════════════════════════════════════════════════')
    ..writeln();

  for (final reg in regs) {
    final className = '${reg.typeName}Defaults';
    final data =
        regDefaults[reg.fieldName] ??
        DefaultsClassData(
          fields: const <String>[],
          defaults: const <String, String>{},
        );

    out.writeln('class $className {');
    for (final field in data.fields) {
      out.writeln('  final Object? $field;');
    }
    if (data.fields.isNotEmpty) out.writeln();

    if (data.fields.isEmpty) {
      out.writeln('  const $className();');
    } else {
      out.writeln('  const $className({');
      for (final field in data.fields) {
        final def = data.defaults[field];
        if (def != null) {
          out.writeln('    this.$field = $def,');
        } else {
          out.writeln('    this.$field,');
        }
      }
      out.writeln('  });');
    }
    out.writeln('}');
    out.writeln();
  }

  return out.toString().trimRight() + '\n';
}

String _buildTokensFile(
  List<Registration> regs,
  Map<String, DefaultsClassData> regDefaults,
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
    final className = '${reg.typeName}Tokens';
    final instanceName = '${_lowerCamel(reg.typeName)}Tokens';
    final data =
        regDefaults[reg.fieldName] ??
        DefaultsClassData(
          fields: const <String>[],
          defaults: const <String, String>{},
        );

    out.writeln('class $className {');
    for (final field in data.fields) {
      out.writeln('  final Object? $field;');
    }
    out.writeln('  final bool? ignoreGlobalScaling;');
    out.writeln('  final bool? ignoreGlobalRadius;');
    out.writeln();

    out.writeln('  const $className({');
    for (final field in data.fields) {
      out.writeln('    this.$field,');
    }
    out.writeln('    this.ignoreGlobalScaling,');
    out.writeln('    this.ignoreGlobalRadius,');
    out.writeln('  });');
    out.writeln('}');
    out.writeln();
    out.writeln('const $instanceName = $className();');
    out.writeln();
  }

  return out.toString().trimRight() + '\n';
}

String _buildConfigFile(String configClassName, List<Registration> regs) {
  final out = StringBuffer()
    ..writeln('// ═══════════════════════════════════════════════════════════')
    ..writeln('// COMPONENT THEME CONFIG')
    ..writeln('// Registration wiring (do not edit manually)')
    ..writeln('// ═══════════════════════════════════════════════════════════')
    ..writeln()
    ..writeln(
      "import '${_snakeFromConfigClass(configClassName)}_defaults.dart';",
    )
    ..writeln("import '${_snakeFromConfigClass(configClassName)}_tokens.dart';")
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

  return out.toString().trimRight() + '\n';
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

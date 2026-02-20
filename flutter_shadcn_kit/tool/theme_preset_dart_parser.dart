import 'dart:io';

const _themeSchemaUrl =
    'https://flutter-shadcn.github.io/registry-directory/registry/themes.schema.v1.json';

const List<String> _colorFields = [
  'background',
  'foreground',
  'card',
  'cardForeground',
  'popover',
  'popoverForeground',
  'primary',
  'primaryForeground',
  'secondary',
  'secondaryForeground',
  'muted',
  'mutedForeground',
  'accent',
  'accentForeground',
  'destructive',
  'destructiveForeground',
  'border',
  'input',
  'ring',
  'chart1',
  'chart2',
  'chart3',
  'chart4',
  'chart5',
  'sidebar',
  'sidebarForeground',
  'sidebarPrimary',
  'sidebarPrimaryForeground',
  'sidebarAccent',
  'sidebarAccentForeground',
  'sidebarBorder',
  'sidebarRing',
];

const List<String> _shadowFields = [
  'shadow2xs',
  'shadowXs',
  'shadowSm',
  'shadow',
  'shadowMd',
  'shadowLg',
  'shadowXl',
  'shadow2xl',
];

Directory? findRegistryDir(Directory from) {
  Directory current = from.absolute;
  while (true) {
    final candidate = Directory('${current.path}/lib/registry');
    if (candidate.existsSync()) {
      final marker = File('${candidate.path}/themes.schema.json');
      if (marker.existsSync()) {
        return candidate;
      }
    }

    final parent = current.parent;
    if (parent.path == current.path) {
      return null;
    }
    current = parent;
  }
}

List<Map<String, dynamic>> parseThemePresetsFromDart(String source) {
  final listStart = source.indexOf('final List<RegistryThemePreset> registryThemePresets = [');
  if (listStart == -1) {
    throw FormatException('Could not find registryThemePresets list in preset_themes.dart');
  }

  final openBracket = source.indexOf('[', listStart);
  final closeBracket = _findMatching(source, openBracket, '[', ']');
  final listContent = source.substring(openBracket + 1, closeBracket);

  final presets = <Map<String, dynamic>>[];
  var scan = 0;
  while (true) {
    final keyword = 'RegistryThemePreset(';
    final idx = listContent.indexOf(keyword, scan);
    if (idx == -1) {
      break;
    }
    final openParen = listContent.indexOf('(', idx);
    final closeParen = _findMatching(listContent, openParen, '(', ')');
    final block = listContent.substring(openParen + 1, closeParen);
    presets.add(_parsePresetBlock(block));
    scan = closeParen + 1;
  }

  return presets;
}

Map<String, dynamic> withThemeSchema({
  required Map<String, dynamic> preset,
  required String generatedAt,
}) {
  return {
    r'$schema': _themeSchemaUrl,
    'schemaVersion': 1,
    'generatedAt': generatedAt,
    ...preset,
  };
}

Map<String, dynamic> _parsePresetBlock(String block) {
  final id = _firstMatch(block, RegExp(r"id:\s*'([^']+)'"), 'id');
  final name = _firstMatch(block, RegExp(r"name:\s*'([^']+)'"), 'name');

  final light = _parseColorScheme(_extractConstructorBody(block, 'light', 'ColorScheme'));
  final dark = _parseColorScheme(_extractConstructorBody(block, 'dark', 'ColorScheme'));

  final lightTokens = _parseTokens(_extractConstructorBody(block, 'lightTokens', 'RegistryThemePresetTokens'));
  final darkTokens = _parseTokens(_extractConstructorBody(block, 'darkTokens', 'RegistryThemePresetTokens'));

  return {
    'id': id,
    'name': name,
    'light': light,
    'dark': dark,
    'tokens': {
      'light': lightTokens,
      'dark': darkTokens,
    },
  };
}

Map<String, dynamic> _parseColorScheme(String content) {
  final map = <String, dynamic>{};
  for (final field in _colorFields) {
    final value = _firstMatch(
      content,
      RegExp('$field\\s*:\\s*Color\\((0x[0-9A-Fa-f]{8})\\)'),
      'Color field $field',
      group: 1,
    );
    map[field] = value;
  }
  return map;
}

Map<String, dynamic> _parseTokens(String content) {
  final radiusValue = _firstMatch(
    content,
    RegExp(r'radius\s*:\s*(-?\d+(?:\.\d+)?)'),
    'tokens.radius',
    group: 1,
  );
  final spacingBaseValue = _firstMatch(
    content,
    RegExp(r'spacing\s*:\s*SpacingScale\((-?\d+(?:\.\d+)?)\)'),
    'tokens.spacing.base',
    group: 1,
  );
  final trackingNormalMatch = RegExp(r'tracking\s*:\s*TrackingScale\(\s*normal\s*:\s*(-?\d+(?:\.\d+)?)\s*\)')
      .firstMatch(content);

  final shadowsContent = _extractConstructorBody(content, 'shadows', 'ShadowScale');
  final shadows = <String, dynamic>{};
  for (final field in _shadowFields) {
    shadows[field] = _parseShadowList(_extractArrayContent(shadowsContent, field));
  }

  final fontSans = _optionalString(content, 'fontSans');
  final fontSerif = _optionalString(content, 'fontSerif');
  final fontMono = _optionalString(content, 'fontMono');

  return {
    'radius': _num(radiusValue),
    'spacing': {
      'base': _num(spacingBaseValue),
    },
    'tracking': {
      'normal': _num(trackingNormalMatch?.group(1) ?? '0'),
    },
    'shadows': shadows,
    if (fontSans != null) 'fontSans': fontSans,
    if (fontSerif != null) 'fontSerif': fontSerif,
    if (fontMono != null) 'fontMono': fontMono,
  };
}

List<Map<String, dynamic>> _parseShadowList(String content) {
  final result = <Map<String, dynamic>>[];
  var scan = 0;

  while (true) {
    final idx = content.indexOf('BoxShadow(', scan);
    if (idx == -1) {
      break;
    }
    final open = content.indexOf('(', idx);
    final close = _findMatching(content, open, '(', ')');
    final box = content.substring(open + 1, close);
    result.add(_parseBoxShadow(box));
    scan = close + 1;
  }

  return result;
}

Map<String, dynamic> _parseBoxShadow(String content) {
  final offset = RegExp(r'offset\s*:\s*Offset\(\s*(-?\d+(?:\.\d+)?)\s*,\s*(-?\d+(?:\.\d+)?)\s*\)')
      .firstMatch(content);
  final blur = RegExp(r'blurRadius\s*:\s*(-?\d+(?:\.\d+)?)').firstMatch(content);
  final spread = RegExp(r'spreadRadius\s*:\s*(-?\d+(?:\.\d+)?)').firstMatch(content);
  final color = RegExp(r'color\s*:\s*Color\((0x[0-9A-Fa-f]{8})\)').firstMatch(content);

  if (offset == null || blur == null || spread == null || color == null) {
    throw FormatException('Invalid BoxShadow block: $content');
  }

  return {
    'x': _num(offset.group(1)!),
    'y': _num(offset.group(2)!),
    'blur': _num(blur.group(1)!),
    'spread': _num(spread.group(1)!),
    'color': color.group(1)!,
  };
}

String _extractConstructorBody(String source, String field, String typeName) {
  final pattern = RegExp('$field\\s*:\\s*(?:const\\s+)?$typeName\\s*\\(');
  final match = pattern.firstMatch(source);
  if (match == null) {
    throw FormatException('Could not find $field constructor $typeName(...)');
  }

  final open = source.indexOf('(', match.start);
  final close = _findMatching(source, open, '(', ')');
  return source.substring(open + 1, close);
}

String _extractArrayContent(String source, String field) {
  final pattern = RegExp('$field\\s*:\\s*\\[');
  final match = pattern.firstMatch(source);
  if (match == null) {
    throw FormatException('Could not find array field $field');
  }
  final open = source.indexOf('[', match.start);
  final close = _findMatching(source, open, '[', ']');
  return source.substring(open + 1, close);
}

String _firstMatch(String source, RegExp regex, String label, {int group = 1}) {
  final match = regex.firstMatch(source);
  if (match == null || match.group(group) == null) {
    throw FormatException('Missing $label');
  }
  return match.group(group)!;
}

String? _optionalString(String source, String field) {
  final match = RegExp('$field\\s*:\\s*"((?:\\\\.|[^"\\\\])*)"').firstMatch(source);
  if (match == null) {
    return null;
  }
  return _unescapeDartString(match.group(1)!);
}

String _unescapeDartString(String value) {
  return value
  .replaceAll(r'\"', '"')
  .replaceAll(r"\'", "'")
  .replaceAll(r'\\', r'\');
}

int _findMatching(String text, int openIndex, String openChar, String closeChar) {
  var depth = 0;
  for (var i = openIndex; i < text.length; i++) {
    final ch = text[i];
    if (ch == openChar) {
      depth += 1;
    } else if (ch == closeChar) {
      depth -= 1;
      if (depth == 0) {
        return i;
      }
    }
  }
  throw FormatException('Unbalanced $openChar$closeChar pair');
}

num _num(String input) {
  if (input.contains('.')) {
    return double.parse(input);
  }
  return int.parse(input);
}
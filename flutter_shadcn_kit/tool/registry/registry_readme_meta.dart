import 'dart:convert';
import 'dart:io';

import '../common/registry_component_metadata.dart';

const registryDir = 'flutter_shadcn_kit/lib/registry';
const outputSchemaVersion = 1;

/// Validates that the generated meta matches the required schema structure
void validateReadmeMeta(Map<String, dynamic> meta, String path) {
  final errors = <String>[];

  // Required fields
  if (!meta.containsKey('schemaVersion') || meta['schemaVersion'] is! int) {
    errors.add('Missing or invalid schemaVersion');
  }
  if (!meta.containsKey('id') ||
      meta['id'] is! String ||
      (meta['id'] as String).isEmpty) {
    errors.add('Missing or invalid id');
  }
  if (!meta.containsKey('name') ||
      meta['name'] is! String ||
      (meta['name'] as String).isEmpty) {
    errors.add('Missing or invalid name');
  }
  if (!meta.containsKey('description') || meta['description'] is! String) {
    errors.add('Missing or invalid description');
  }
  if (!meta.containsKey('install') ||
      meta['install'] is! String ||
      (meta['install'] as String).isEmpty) {
    errors.add('Missing or invalid install');
  }
  if (!meta.containsKey('import') || meta['import'] is! String) {
    errors.add('Missing or invalid import');
  }
  if (!meta.containsKey('examples') || meta['examples'] is! Map) {
    errors.add('Missing or invalid examples');
  } else {
    final examples = meta['examples'] as Map;
    if (!examples.containsKey('minimal') || examples['minimal'] is! String) {
      errors.add('examples.minimal is required and must be a string');
    }
  }
  if (!meta.containsKey('api') || meta['api'] is! Map) {
    errors.add('Missing or invalid api');
  }

  // Validate patterns structure if present
  if (meta.containsKey('patterns') && meta['patterns'] is! List) {
    errors.add('patterns must be an array');
  } else if (meta.containsKey('patterns')) {
    final patterns = meta['patterns'] as List;
    for (var i = 0; i < patterns.length; i++) {
      if (patterns[i] is! Map) {
        errors.add('patterns[$i] must be an object');
        continue;
      }
      final pattern = patterns[i] as Map;
      if (!pattern.containsKey('title') || pattern['title'] is! String) {
        errors.add('patterns[$i].title is required');
      }
      if (!pattern.containsKey('code') || pattern['code'] is! String) {
        errors.add('patterns[$i].code is required');
      }
    }
  }

  if (errors.isNotEmpty) {
    print('❌ Schema validation failed for $path:');
    for (final error in errors) {
      print('   - $error');
    }
    throw Exception('Schema validation failed for $path');
  }
}

void _printUsage() {
  stdout.writeln('Usage: dart run tool/registry/registry_readme_meta.dart');
  stdout.writeln('');
  stdout.writeln('Generates <id>.meta.json files from README.md content.');
  stdout.writeln('');
  stdout.writeln('Options:');
  stdout.writeln('  -h, --help  Show this help.');
}

void main(List<String> args) {
  if (args.contains('-h') || args.contains('--help')) {
    _printUsage();
    return;
  }

  final folders = listAllComponentFolders();
  final generated = <String>[];
  final errors = <String>[];

  for (final dir in folders) {
    final readmePath = '$dir/README.md';
    try {
      final md = File(readmePath).readAsStringSync();
      final meta = generateReadmeMetaFromMarkdown(md);

      final id = meta['id'] as String;
      final metadata = ComponentMetadataPaths(entryDir: Directory(dir), id: id);

      final canonicalMeta = Map<String, dynamic>.from(meta);
      canonicalMeta[r'$schema'] =
          '../../../../manifests/readme_meta.schema.json';
      validateReadmeMeta(canonicalMeta, metadata.canonicalReadmeMeta.path);
      writeJson(metadata.canonicalReadmeMeta.path, canonicalMeta);

      final legacyMeta = Map<String, dynamic>.from(meta);
      legacyMeta[r'$schema'] = '../../../manifests/readme_meta.schema.json';
      validateReadmeMeta(legacyMeta, metadata.legacyReadmeMeta.path);
      writeJson(metadata.legacyReadmeMeta.path, legacyMeta);

      generated.add(metadata.canonicalReadmeMeta.path);
      print('✓ Generated: ${metadata.canonicalReadmeMeta.path}');
    } catch (e) {
      errors.add('✗ Error in $readmePath: $e');
    }
  }

  print('\n${'=' * 60}');
  print('Generated ${generated.length} readme meta files.');
  if (errors.isNotEmpty) {
    print('\nErrors (${errors.length}):');
    for (final error in errors) {
      print(error);
    }
  }
}

List<String> listAllComponentFolders() {
  // Matches structure:
  // registry/components/<category>/<id>/
  // registry/composites/<category>/<id>/
  final roots = [
    '$registryDir/components',
    '$registryDir/composites',
  ].where((p) => Directory(p).existsSync()).toList();

  final out = <String>[];

  for (final root in roots) {
    final categories = Directory(
      root,
    ).listSync().whereType<Directory>().map((d) => d.path).toList();

    for (final catDir in categories) {
      final ids = Directory(
        catDir,
      ).listSync().whereType<Directory>().map((d) => d.path).toList();

      for (final idDir in ids) {
        final readme = '$idDir/README.md';
        if (File(readme).existsSync()) {
          out.add(idDir);
        }
      }
    }
  }

  out.sort();
  return out;
}

Map<String, dynamic> generateReadmeMetaFromMarkdown(String md) {
  final h = extractFirstHeading(md);
  if (h == null) {
    throw Exception('README missing required heading: # Name (`id`)');
  }

  final description = extractDescription(md);

  final whenToUseSec = sectionBody(md, 'When to use');
  final installSec = sectionBody(md, 'Install');
  final importSec = sectionBody(md, 'Import');
  final minimalSec = sectionBody(md, 'Minimal example');
  final patternsSec = sectionBody(md, 'Common patterns');
  final apiSec = sectionBody(md, 'API');
  final themingSec = sectionBody(md, 'Theming');
  final a11ySec = sectionBody(md, 'Accessibility');
  final doDontSec = sectionBody(md, "Do / Don\u2019t");
  final relatedSec = sectionBody(md, 'Related components');
  final rulesSec = sectionBody(md, 'Registry rules');

  final when = whenToUseSec.isNotEmpty
      ? extractWhenToUse(whenToUseSec)
      : {'use': <String>[], 'avoid': <String>[]};

  final install = extractCodeBlock(
    installSec,
    'bash',
  ).split('\n').firstWhere((l) => l.trim().isNotEmpty, orElse: () => '').trim();
  final importStmt = extractCodeBlock(importSec, 'dart').trim();
  final minimal = extractCodeBlock(minimalSec, 'dart').trim();

  final patterns = extractAllPatternBlocks(patternsSec);
  final api = extractApi(apiSec);

  // Ensure API always has required constructors and callbacks arrays
  final apiOutput = <String, dynamic>{
    'constructors': api['constructors'] ?? [],
    'callbacks': api['callbacks'] ?? [],
  };
  // Add any other API subsections that were extracted
  api.forEach((key, value) {
    if (key != 'constructors' && key != 'callbacks') {
      apiOutput[key] = value;
    }
  });

  final theming = extractBullets(themingSec);
  final accessibility = extractBullets(a11ySec);
  final doDont = extractDoDont(doDontSec);

  final related = extractBullets(relatedSec)
      .map((x) => x.replaceAll('`', '').trim())
      .where((x) => x.isNotEmpty)
      .toList();

  final registryRules = extractBullets(rulesSec);

  return {
    r'$schema': '../../../manifests/readme_meta.schema.json',
    'schemaVersion': outputSchemaVersion,
    'id': h['id'],
    'name': h['name'],
    'description': description,
    'install': install,
    'import': importStmt,
    'whenToUse': when,
    'examples': {'minimal': minimal},
    'patterns': patterns,
    'api': apiOutput,
    'theming': theming,
    'accessibility': accessibility,
    'do': doDont['do'],
    'dont': doDont['dont'],
    'related': related,
    'registryRules': registryRules,
  };
}

Map<String, String>? extractFirstHeading(String md) {
  // "# Button (`button`)"
  final pattern = RegExp(r'^#\s+(.+?)\s*\(`([^`]+)`\)\s*$', multiLine: true);
  final match = pattern.firstMatch(md);
  if (match == null) return null;
  return {'name': match.group(1)!.trim(), 'id': match.group(2)!.trim()};
}

String extractDescription(String md) {
  // The line right after the first heading (non-empty, non-hr)
  final lines = md.split(RegExp(r'\r?\n'));
  final headingIdx = lines.indexWhere((l) => RegExp(r'^#\s+').hasMatch(l));
  if (headingIdx == -1) return '';

  for (var i = headingIdx + 1; i < lines.length; i++) {
    final t = lines[i].trim();
    if (t.isEmpty) continue;
    if (RegExp(r'^---+$').hasMatch(t)) continue;
    if (RegExp(r'^##\s+').hasMatch(t)) break;
    return t;
  }
  return '';
}

String sectionBody(String md, String heading) {
  // Returns raw markdown between "## heading" and next "## "
  final pattern = RegExp(
    '^##\\s+${RegExp.escape(heading)}\\s*\$',
    multiLine: true,
  );
  final match = pattern.firstMatch(md);
  if (match == null) return '';

  final start = match.start + match.group(0)!.length;
  final rest = md.substring(start);
  final nextMatch = RegExp(r'^##\s+', multiLine: true).firstMatch(rest);
  final result = nextMatch == null ? rest : rest.substring(0, nextMatch.start);
  return result.trim();
}

String extractCodeBlock(String mdSection, String lang) {
  // First ```lang ... ```
  final pattern = RegExp(
    '```${RegExp.escape(lang)}\\s*\\n([\\s\\S]*?)\\n```',
    multiLine: true,
  );
  final match = pattern.firstMatch(mdSection);
  return match != null ? match.group(1)!.trim() : '';
}

List<Map<String, String>> extractAllPatternBlocks(String mdSection) {
  // "### Pattern: X" then first ```dart``` that follows until next "###"
  final out = <Map<String, String>>[];
  final pattern = RegExp(r'^###\s+Pattern:\s*(.+?)\s*$', multiLine: true);
  final matches = pattern.allMatches(mdSection);

  for (final match in matches) {
    final title = match.group(1)!.trim();
    final start = match.start + match.group(0)!.length;
    final rest = mdSection.substring(start);
    final nextMatch = RegExp(r'^###\s+', multiLine: true).firstMatch(rest);
    final chunk =
        (nextMatch == null ? rest : rest.substring(0, nextMatch.start)).trim();
    final code = extractCodeBlock(chunk, 'dart');
    if (code.isNotEmpty) {
      out.add({'title': title, 'code': code});
    }
  }
  return out;
}

List<String> extractBullets(String mdSection) {
  // Captures "- item" at top level
  return mdSection
      .split(RegExp(r'\r?\n'))
      .map((l) => l.trim())
      .where((l) => l.startsWith('- '))
      .map((l) => l.substring(2).trim())
      .where((l) => l.isNotEmpty)
      .toList();
}

Map<String, List<String>> extractWhenToUse(String mdSection) {
  // Expects:
  // - Use this when:
  //   - ...
  // - Avoid when:
  //   - ...
  final use = <String>[];
  final avoid = <String>[];
  final lines = mdSection.split(RegExp(r'\r?\n'));

  String? mode; // "use" | "avoid"
  for (final raw in lines) {
    final line = raw.trim();
    if (line.startsWith('- Use this when:')) {
      mode = 'use';
      continue;
    }
    if (line.startsWith('- Avoid when:')) {
      mode = 'avoid';
      continue;
    }

    final subMatch = RegExp(r'^-\s+(.+)$').firstMatch(line);
    if (subMatch != null && (mode == 'use' || mode == 'avoid')) {
      final item = subMatch.group(1)!.trim();
      if (item.isEmpty) continue;
      (mode == 'use' ? use : avoid).add(item);
    }

    // Also accept "  - ..." (indented bullets)
    if (subMatch == null) {
      final indMatch = RegExp(r'^\s*-\s+(.+)$').firstMatch(raw);
      if (indMatch != null && (mode == 'use' || mode == 'avoid')) {
        final item = indMatch.group(1)!.trim();
        if (item.isNotEmpty) {
          (mode == 'use' ? use : avoid).add(item);
        }
      }
    }
  }

  // De-dupe deterministically
  return {'use': use.toSet().toList(), 'avoid': avoid.toSet().toList()};
}

Map<String, dynamic> extractApi(String mdSection) {
  // Extract all subsections dynamically (e.g., ### Types and helpers, ### Constructor, ### Callbacks)
  final result = <String, dynamic>{};
  final subsectionPattern = RegExp(r'^###\s+(.+?)\s*$', multiLine: true);
  final matches = subsectionPattern.allMatches(mdSection);

  if (matches.isEmpty) {
    // No subsections, extract all bullets from API section
    final bullets = extractBullets(mdSection);
    if (bullets.isNotEmpty) {
      result['items'] = bullets;
    }
    // Always return constructors and callbacks (even if empty)
    result['constructors'] = [];
    result['callbacks'] = [];
    return result;
  }

  // Initialize required fields
  result['constructors'] = <String>[];
  result['callbacks'] = <String>[];

  for (final match in matches) {
    final subsectionTitle = match.group(1)!.trim();
    final start = match.start + match.group(0)!.length;
    final rest = mdSection.substring(start);
    final nextMatch = RegExp(r'^###\s+', multiLine: true).firstMatch(rest);
    final chunk =
        (nextMatch == null ? rest : rest.substring(0, nextMatch.start)).trim();
    final bullets = extractBullets(chunk);

    if (bullets.isNotEmpty) {
      // Create a key from the subsection title (lowercase, replace spaces with underscores)
      final key = subsectionTitle.toLowerCase().replaceAll(RegExp(r'\s+'), '_');

      // Map common subsection names to standard keys
      if (key == 'constructor' || key == 'constructors') {
        result['constructors'] = bullets;
      } else if (key == 'callback' || key == 'callbacks') {
        result['callbacks'] = bullets;
      } else {
        result[key] = bullets;
      }
    }
  }

  return result;
}

Map<String, List<String>> extractDoDont(String mdSection) {
  // Expects:
  // **Do**
  // - ✅ ...
  // **Don't** (with Unicode right single quote \u2019)
  // - ❌ ...
  final doList = <String>[];
  final dontList = <String>[];
  final lines = mdSection.split(RegExp(r'\r?\n'));

  String? mode;
  for (final raw in lines) {
    final line = raw.trim();
    if (line == '**Do**') {
      mode = 'do';
      continue;
    }
    // Handle both regular apostrophe and Unicode right single quote
    if (line == "**Don't**" || line == "**Don\u2019t**") {
      mode = 'dont';
      continue;
    }

    // Match bullets with or without emoji checkmarks, but exclude hr lines (---)
    final match = RegExp(r'^-\s*(✅|❌)?\s*(.+)$').firstMatch(line);
    if (match != null && (mode == 'do' || mode == 'dont')) {
      final item = match.group(2)!.trim();
      // Skip horizontal rules
      if (item.isEmpty || RegExp(r'^-+$').hasMatch(item)) continue;
      (mode == 'do' ? doList : dontList).add(item);
    }
  }

  return {'do': doList.toSet().toList(), 'dont': dontList.toSet().toList()};
}

void writeJson(String path, Map<String, dynamic> obj) {
  final encoder = JsonEncoder.withIndent('  ');
  final jsonString = encoder.convert(obj);
  File(path).parent.createSync(recursive: true);
  File(path).writeAsStringSync('$jsonString\n');
}

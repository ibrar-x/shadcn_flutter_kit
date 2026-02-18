import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;

void main(List<String> args) async {
  final parsed = _parseArgs(args);
  final componentId = parsed['component'];
  final registryRoot = parsed['registry-root'];
  final projectRoot = parsed['project-root'] ?? Directory.current.path;

  if (componentId == null || componentId.isEmpty) {
    _printUsageAndExit('Missing required argument: --component <id>');
  }
  if (registryRoot == null || registryRoot.isEmpty) {
    _printUsageAndExit(
      'Missing required argument: --registry-root <path-to-registry-lib-root>',
    );
  }

  final configFile = File(p.join(projectRoot, '.shadcn', 'config.json'));
  if (!configFile.existsSync()) {
    stderr.writeln(
      'Config not found at ${configFile.path}. Run flutter_shadcn init first.',
    );
    exit(1);
  }

  final config =
      jsonDecode(configFile.readAsStringSync()) as Map<String, dynamic>;
  final installPath = (config['installPath'] as String?) ?? 'lib/ui/shadcn';
  final sharedPath =
      (config['sharedPath'] as String?) ?? 'lib/ui/shadcn/shared';
  final includeReadme = (config['includeReadme'] as bool?) ?? false;
  final includeMeta = (config['includeMeta'] as bool?) ?? true;
  final includePreview = (config['includePreview'] as bool?) ?? false;

  final componentsFile = File(
    p.join(registryRoot, 'registry', 'components.json'),
  );
  if (!componentsFile.existsSync()) {
    stderr.writeln(
      'Could not find registry components.json at ${componentsFile.path}',
    );
    exit(1);
  }

  final componentsJson =
      jsonDecode(componentsFile.readAsStringSync()) as Map<String, dynamic>;
  final components =
      (componentsJson['components'] as List<dynamic>? ?? const []);

  Map<String, dynamic>? target;
  for (final item in components) {
    if (item is Map<String, dynamic> && item['id'] == componentId) {
      target = item;
      break;
    }
  }

  if (target == null) {
    stderr.writeln('Component "$componentId" not found in registry manifest.');
    exit(1);
  }

  final files = (target['files'] as List<dynamic>? ?? const []);
  final missingSources = <String>[];
  final missingDestinations = <String>[];
  final contentMismatches = <String>[];
  var checked = 0;

  for (final entry in files) {
    if (entry is! Map<String, dynamic>) {
      continue;
    }

    final sourceRel = entry['source'] as String?;
    final destinationTemplate = entry['destination'] as String?;
    if (sourceRel == null || destinationTemplate == null) {
      continue;
    }

    if (!_shouldValidate(
      destinationTemplate: destinationTemplate,
      includeReadme: includeReadme,
      includeMeta: includeMeta,
      includePreview: includePreview,
    )) {
      continue;
    }

    final destinationRel = destinationTemplate
        .replaceAll('{installPath}', installPath)
        .replaceAll('{sharedPath}', sharedPath);

    final sourceFile = File(p.join(registryRoot, sourceRel));
    final destinationFile = File(p.join(projectRoot, destinationRel));

    if (!sourceFile.existsSync()) {
      missingSources.add(sourceFile.path);
      continue;
    }
    if (!destinationFile.existsSync()) {
      missingDestinations.add(destinationFile.path);
      continue;
    }

    final sourceBytes = sourceFile.readAsBytesSync();
    final destinationBytes = destinationFile.readAsBytesSync();

    if (!_bytesEqual(sourceBytes, destinationBytes)) {
      contentMismatches.add('${sourceFile.path} != ${destinationFile.path}');
      continue;
    }

    checked++;
  }

  stdout.writeln('Validated component: $componentId');
  stdout.writeln('Compared files: $checked');

  if (missingSources.isNotEmpty) {
    stdout.writeln('\nMissing source files (${missingSources.length}):');
    for (final path in missingSources) {
      stdout.writeln(' - $path');
    }
  }

  if (missingDestinations.isNotEmpty) {
    stdout.writeln(
      '\nMissing destination files (${missingDestinations.length}):',
    );
    for (final path in missingDestinations) {
      stdout.writeln(' - $path');
    }
  }

  if (contentMismatches.isNotEmpty) {
    stdout.writeln('\nContent mismatches (${contentMismatches.length}):');
    for (final line in contentMismatches) {
      stdout.writeln(' - $line');
    }
  }

  final hasErrors =
      missingSources.isNotEmpty ||
      missingDestinations.isNotEmpty ||
      contentMismatches.isNotEmpty;

  if (hasErrors) {
    exit(1);
  }

  stdout.writeln('\nInstall parity check passed.');
}

Map<String, String> _parseArgs(List<String> args) {
  final parsed = <String, String>{};
  var i = 0;
  while (i < args.length) {
    final token = args[i];
    if (!token.startsWith('--')) {
      i++;
      continue;
    }

    final key = token.substring(2);
    final nextIndex = i + 1;
    if (nextIndex < args.length && !args[nextIndex].startsWith('--')) {
      parsed[key] = args[nextIndex];
      i += 2;
      continue;
    }

    parsed[key] = 'true';
    i++;
  }
  return parsed;
}

bool _shouldValidate({
  required String destinationTemplate,
  required bool includeReadme,
  required bool includeMeta,
  required bool includePreview,
}) {
  final lower = destinationTemplate.toLowerCase();

  final isReadme = lower.endsWith('/readme.md');
  if (isReadme && !includeReadme) {
    return false;
  }

  final isMeta = lower.endsWith('/meta.json');
  if (isMeta && !includeMeta) {
    return false;
  }

  final isPreview =
      lower.endsWith('/preview.dart') || lower.endsWith('/preview_state.dart');
  if (isPreview && !includePreview) {
    return false;
  }

  return true;
}

bool _bytesEqual(List<int> first, List<int> second) {
  if (first.length != second.length) {
    return false;
  }
  for (var i = 0; i < first.length; i++) {
    if (first[i] != second[i]) {
      return false;
    }
  }
  return true;
}

Never _printUsageAndExit(String message) {
  stderr.writeln(message);
  stderr.writeln(
    'Usage: dart run tool/verify_install.dart '
    '--component <id> --registry-root <path> [--project-root <path>]',
  );
  exit(64);
}

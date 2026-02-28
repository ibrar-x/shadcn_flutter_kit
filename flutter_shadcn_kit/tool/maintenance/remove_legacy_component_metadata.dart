import 'dart:io';

Directory? _findRepoRoot(Directory start) {
  Directory current = start.absolute;
  while (true) {
    final candidate = File(
      '${current.path}/lib/registry/manifests/components.json',
    );
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

void _printUsage() {
  stdout.writeln(
    'Usage: dart run tool/maintenance/remove_legacy_component_metadata.dart [--apply]',
  );
  stdout.writeln('');
  stdout.writeln(
    'Removes legacy component-root metadata files when canonical copies exist',
  );
  stdout.writeln('under each component `registry/` directory:');
  stdout.writeln('  - meta.json');
  stdout.writeln('  - <id>.meta.json');
  stdout.writeln('  - theme.schema.json');
  stdout.writeln('');
  stdout.writeln('By default this runs in dry-run mode.');
  stdout.writeln('Use --apply to actually delete files.');
}

String _basename(String path) {
  final normalized = path.replaceAll('\\', '/');
  final parts = normalized.split('/');
  for (var i = parts.length - 1; i >= 0; i--) {
    final part = parts[i];
    if (part.isNotEmpty) return part;
  }
  return '';
}

Iterable<Directory> _componentDirs(Directory registryDir) sync* {
  for (final type in <String>['components', 'composites']) {
    final rootDir = Directory('${registryDir.path}/$type');
    if (!rootDir.existsSync()) continue;
    for (final categoryDir in rootDir.listSync().whereType<Directory>()) {
      for (final componentDir
          in categoryDir.listSync().whereType<Directory>()) {
        final name = _basename(componentDir.path);
        if (name.startsWith('_') || name.startsWith('.')) continue;
        yield componentDir;
      }
    }
  }
}

void main(List<String> args) {
  if (args.contains('-h') || args.contains('--help')) {
    _printUsage();
    return;
  }

  final apply = args.contains('--apply');
  final root = _findRepoRoot(Directory.current);
  if (root == null) {
    stderr.writeln(
      'Error: Could not locate lib/registry/manifests/components.json',
    );
    exitCode = 1;
    return;
  }

  final registryDir = Directory('${root.path}/lib/registry');
  final candidates = <File>[];
  final skipped = <String>[];

  for (final componentDir in _componentDirs(registryDir)) {
    final id = _basename(componentDir.path);
    final canonicalDir = Directory('${componentDir.path}/registry');
    final legacyMeta = File('${componentDir.path}/meta.json');
    final legacyReadmeMeta = File('${componentDir.path}/$id.meta.json');
    final legacyThemeSchema = File('${componentDir.path}/theme.schema.json');

    final canonicalMeta = File('${canonicalDir.path}/meta.json');
    final canonicalReadmeMeta = File('${canonicalDir.path}/$id.meta.json');
    final canonicalThemeSchema = File('${canonicalDir.path}/theme.schema.json');

    if (legacyMeta.existsSync()) {
      if (canonicalMeta.existsSync()) {
        candidates.add(legacyMeta);
      } else {
        skipped.add(
          'skip ${legacyMeta.path}: missing canonical ${canonicalMeta.path}',
        );
      }
    }
    if (legacyReadmeMeta.existsSync()) {
      if (canonicalReadmeMeta.existsSync()) {
        candidates.add(legacyReadmeMeta);
      } else {
        skipped.add(
          'skip ${legacyReadmeMeta.path}: missing canonical ${canonicalReadmeMeta.path}',
        );
      }
    }
    if (legacyThemeSchema.existsSync()) {
      if (canonicalThemeSchema.existsSync()) {
        candidates.add(legacyThemeSchema);
      } else {
        skipped.add(
          'skip ${legacyThemeSchema.path}: missing canonical ${canonicalThemeSchema.path}',
        );
      }
    }
  }

  candidates.sort((a, b) => a.path.compareTo(b.path));

  stdout.writeln(
    apply
        ? 'Applying legacy metadata cleanup...'
        : 'Dry-run: legacy metadata cleanup plan',
  );
  stdout.writeln('Candidates: ${candidates.length}');
  if (skipped.isNotEmpty) {
    stdout.writeln('Skipped due to missing canonical files: ${skipped.length}');
  }

  for (final file in candidates) {
    if (apply) {
      file.deleteSync();
      stdout.writeln('deleted ${file.path}');
    } else {
      stdout.writeln('would delete ${file.path}');
    }
  }

  if (skipped.isNotEmpty) {
    stdout.writeln('');
    stdout.writeln('Skipped details:');
    for (final line in skipped) {
      stdout.writeln(line);
    }
  }

  if (!apply) {
    stdout.writeln('');
    stdout.writeln(
      'No files were deleted. Re-run with --apply to remove candidates.',
    );
  }
}

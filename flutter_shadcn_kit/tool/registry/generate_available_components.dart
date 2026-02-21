import 'dart:io';

void main(List<String> args) {
  if (args.contains('--help') || args.contains('-h')) {
    _printUsage();
    return;
  }

  final root = _findProjectRoot(Directory.current.absolute);
  if (root == null) {
    stderr.writeln(
      'Error: Could not locate project root containing lib/registry/components.',
    );
    exitCode = 1;
    return;
  }

  final outputPath = _resolveOutputPath(root, args);
  final componentsRoot = Directory(
    '${root.path}${Platform.pathSeparator}lib${Platform.pathSeparator}registry${Platform.pathSeparator}components',
  );

  if (!componentsRoot.existsSync()) {
    stderr.writeln(
      'Error: Components directory not found: ${componentsRoot.path}',
    );
    exitCode = 1;
    return;
  }

  final components = _collectComponents(componentsRoot);
  final output = _buildOutput(components);

  final outputFile = File(outputPath);
  outputFile.parent.createSync(recursive: true);
  outputFile.writeAsStringSync(output);

  stdout.writeln(
    'Generated ${components.length} components at ${outputFile.path}',
  );
}

void _printUsage() {
  stdout.writeln(
    'Usage: dart run tool/registry/generate_available_components.dart [--output <path>]',
  );
  stdout.writeln('');
  stdout.writeln(
    'Scans lib/registry/components and writes a sorted component list.',
  );
  stdout.writeln('');
  stdout.writeln('Options:');
  stdout.writeln(
    '  --output <path>   Output file path (default: lib/registry/available_components.txt)',
  );
  stdout.writeln('  -h, --help        Show this help');
}

Directory? _findProjectRoot(Directory start) {
  var current = start;
  while (true) {
    final candidate = Directory(
      '${current.path}${Platform.pathSeparator}lib${Platform.pathSeparator}registry${Platform.pathSeparator}components',
    );
    if (candidate.existsSync()) return current;
    final parent = current.parent;
    if (parent.path == current.path) return null;
    current = parent;
  }
}

String _resolveOutputPath(Directory root, List<String> args) {
  var output = 'lib/registry/available_components.txt';

  for (var i = 0; i < args.length; i++) {
    final arg = args[i];
    if (arg == '--output' && i + 1 < args.length) {
      output = args[i + 1];
      i += 1;
      continue;
    }
    if (arg.startsWith('--output=')) {
      output = arg.substring('--output='.length);
    }
  }

  final outputFile = File(output);
  if (outputFile.isAbsolute) return outputFile.path;
  return '${root.path}${Platform.pathSeparator}$output';
}

List<String> _collectComponents(Directory componentsRoot) {
  final result = <String>[];
  final categoryDirs = componentsRoot.listSync().whereType<Directory>().toList()
    ..sort((a, b) => _basename(a.path).compareTo(_basename(b.path)));

  for (final categoryDir in categoryDirs) {
    final category = _basename(categoryDir.path);
    final componentDirs = categoryDir.listSync().whereType<Directory>().toList()
      ..sort((a, b) => _basename(a.path).compareTo(_basename(b.path)));

    for (final componentDir in componentDirs) {
      final component = _basename(componentDir.path);
      result.add('$category/$component');
    }
  }
  return result;
}

String _buildOutput(List<String> components) {
  final buffer = StringBuffer()
    ..writeln('# Available Registry Components')
    ..writeln('total=${components.length}')
    ..writeln('');

  for (final component in components) {
    buffer.writeln(component);
  }

  return buffer.toString();
}

String _basename(String path) {
  final normalized = path.replaceAll('\\', '/');
  final index = normalized.lastIndexOf('/');
  if (index == -1) return normalized;
  return normalized.substring(index + 1);
}

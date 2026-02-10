import 'dart:convert';
import 'dart:io';

final RegExp _implExportPattern = RegExp(
  r'''^\s*export\s+['"].*_impl/.*['"]\s*;''',
);

void main(List<String> args) {
  var writeChanges = false;
  var filePath = 'lib/shadcn.dart';

  for (var i = 0; i < args.length; i++) {
    final arg = args[i];
    if (arg == '--write') {
      writeChanges = true;
      continue;
    }
    if (arg == '--file') {
      if (i + 1 >= args.length) {
        _printUsageAndExit('Missing value for --file.');
      }
      filePath = args[i + 1];
      i += 1;
      continue;
    }
    if (arg == '--help' || arg == '-h') {
      _printUsageAndExit();
    }
    _printUsageAndExit('Unknown argument: $arg');
  }

  final file = File(filePath);
  if (!file.existsSync()) {
    stderr.writeln('File not found: $filePath');
    exitCode = 2;
    return;
  }

  final original = file.readAsStringSync();
  final lines = const LineSplitter().convert(original);
  final filteredLines = <String>[];
  final removedLines = <int>[];

  for (var i = 0; i < lines.length; i++) {
    final line = lines[i];
    if (_implExportPattern.hasMatch(line)) {
      removedLines.add(i + 1);
      continue;
    }
    filteredLines.add(line);
  }

  if (removedLines.isEmpty) {
    stdout.writeln('No _impl exports found in $filePath.');
    return;
  }

  var updated = filteredLines.join('\n');
  if (original.endsWith('\n')) {
    updated = '$updated\n';
  }

  stdout.writeln(
    'Found ${removedLines.length} _impl export line(s) in $filePath.',
  );
  stdout.writeln(
    'Line numbers removed: ${removedLines.take(25).join(', ')}'
    '${removedLines.length > 25 ? ', ...' : ''}',
  );

  if (!writeChanges) {
    stdout.writeln('Dry run only. Re-run with --write to apply changes.');
    return;
  }

  file.writeAsStringSync(updated);
  stdout.writeln('Updated $filePath.');
}

Never _printUsageAndExit([String? error]) {
  if (error != null) {
    stderr.writeln(error);
    stderr.writeln('');
  }
  stdout.writeln(
    'Usage: dart run scripts/remove_impl_exports.dart '
    '[--file <path>] [--write]',
  );
  stdout.writeln('');
  stdout.writeln('Examples:');
  stdout.writeln('  dart run scripts/remove_impl_exports.dart');
  stdout.writeln('  dart run scripts/remove_impl_exports.dart --write');
  stdout.writeln(
    '  dart run scripts/remove_impl_exports.dart --file lib/shadcn.dart --write',
  );
  exit(error == null ? 0 : 64);
}

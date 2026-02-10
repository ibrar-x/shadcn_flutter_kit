import 'dart:convert';
import 'dart:io';

final RegExp _machineErrorPattern = RegExp(
  r'^(ERROR|WARNING)\|[^|]*\|([^|]+)\|([^|]+)\|(\d+)\|(\d+)\|(\d+)\|(.*)$',
);
final RegExp _exportPattern = RegExp(
  r'''^\s*export\s+['"]([^'"]+)['"](?:\s+(?:show|hide)\s+[^;]+)?\s*;''',
);
final RegExp _materialExportPattern = RegExp(
  r'''^\s*export\s+['"]package:flutter/material\.dart['"]''',
);
const Set<String> _fixableCodes = <String>{
  'AMBIGUOUS_EXPORT',
  'EXPORT_OF_NON_LIBRARY',
  'URI_DOES_NOT_EXIST',
};

class _AnalyzeIssue {
  _AnalyzeIssue({
    required this.code,
    required this.line,
    required this.message,
  });

  final String code;
  final int line;
  final String message;
}

void main(List<String> args) {
  var writeChanges = false;
  var keepMaterialExport = false;
  var filePath = 'lib/shadcn.dart';
  var maxIterations = 20;

  for (var i = 0; i < args.length; i++) {
    final arg = args[i];
    if (arg == '--write') {
      writeChanges = true;
      continue;
    }
    if (arg == '--keep-material-export') {
      keepMaterialExport = true;
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
    if (arg == '--max-iterations') {
      if (i + 1 >= args.length) {
        _printUsageAndExit('Missing value for --max-iterations.');
      }
      maxIterations = int.tryParse(args[i + 1]) ?? -1;
      if (maxIterations <= 0) {
        _printUsageAndExit('Invalid --max-iterations value: ${args[i + 1]}');
      }
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

  final prefilterRemoved = _prefilter(file, writeChanges: writeChanges);
  if (prefilterRemoved.isNotEmpty) {
    stdout.writeln(
      'Prefilter ${writeChanges ? 'removed' : 'would remove'} '
      '${prefilterRemoved.length} export line(s) before analysis.',
    );
  }

  var iterations = 0;
  var totalRemoved = 0;

  while (iterations < maxIterations) {
    iterations += 1;
    final issues = _runAnalyze(file.path);
    if (issues.isEmpty) {
      stdout.writeln('No fixable analyze errors found in ${file.path}.');
      if (!writeChanges && totalRemoved > 0) {
        stdout.writeln('Dry run complete. Re-run with --write to apply.');
      }
      return;
    }

    final lines = _readLines(file);
    final materialLine = _findMaterialExportLine(lines);
    final linesToRemove = <int>{};

    for (final issue in issues) {
      if (issue.code == 'AMBIGUOUS_EXPORT' &&
          !keepMaterialExport &&
          issue.message.contains('package:flutter/') &&
          materialLine != null) {
        linesToRemove.add(materialLine);
        continue;
      }

      if (issue.line <= 0 || issue.line > lines.length) {
        continue;
      }

      final line = lines[issue.line - 1];
      if (_exportPattern.hasMatch(line)) {
        linesToRemove.add(issue.line);
      }
    }

    if (linesToRemove.isEmpty) {
      stderr.writeln(
        'Fixable issues found, but no matching export lines were identified.',
      );
      stderr.writeln('Review analyzer output manually.');
      exitCode = 1;
      return;
    }

    totalRemoved += linesToRemove.length;
    final sorted = linesToRemove.toList()..sort();
    stdout.writeln(
      'Iteration $iterations: '
      '${writeChanges ? 'removing' : 'would remove'} '
      '${sorted.length} export line(s): '
      '${_lineListPreview(sorted)}',
    );

    if (!writeChanges) {
      break;
    }

    _removeLines(file, sorted);
  }

  if (!writeChanges) {
    stdout.writeln('Dry run complete. Re-run with --write to apply.');
    return;
  }

  final remaining = _runAnalyze(file.path);
  if (remaining.isEmpty) {
    stdout.writeln('Updated ${file.path}. Analyze errors were resolved.');
    return;
  }

  stderr.writeln(
    'Stopped with ${remaining.length} remaining fixable issue(s) after '
    '$iterations iteration(s).',
  );
  stderr.writeln(
    'Re-run with a larger --max-iterations value or inspect ${file.path}.',
  );
  exitCode = 1;
}

List<_AnalyzeIssue> _runAnalyze(String filePath) {
  final result = Process.runSync(
    'dart',
    <String>['analyze', filePath, '--format', 'machine'],
  );
  final output = '${result.stdout}\n${result.stderr}';
  final lines = const LineSplitter().convert(output);
  final issues = <_AnalyzeIssue>[];

  for (final line in lines) {
    final match = _machineErrorPattern.firstMatch(line);
    if (match == null) {
      continue;
    }
    final code = match.group(2) ?? '';
    if (!_fixableCodes.contains(code)) {
      continue;
    }
    issues.add(
      _AnalyzeIssue(
        code: code,
        line: int.tryParse(match.group(4) ?? '') ?? 0,
        message: match.group(7) ?? '',
      ),
    );
  }

  return issues;
}

List<int> _prefilter(File file, {required bool writeChanges}) {
  final lines = _readLines(file);
  final exportsToRemove = <int>{};
  final baseDir = file.parent;

  for (var i = 0; i < lines.length; i++) {
    final line = lines[i];
    final match = _exportPattern.firstMatch(line);
    if (match == null) {
      continue;
    }

    final uri = match.group(1) ?? '';
    if (uri.isEmpty) {
      continue;
    }

    if (uri.contains('/_impl/')) {
      exportsToRemove.add(i + 1);
      continue;
    }

    if (uri.startsWith('package:')) {
      continue;
    }

    final fileName = uri.split('/').last;
    if (fileName.startsWith('_')) {
      exportsToRemove.add(i + 1);
      continue;
    }

    final exportedFile = File('${baseDir.path}/$uri');
    if (!exportedFile.existsSync()) {
      exportsToRemove.add(i + 1);
      continue;
    }

    final source = exportedFile.readAsStringSync();
    final sourceLines = const LineSplitter().convert(source);
    final hasPartOfDirective = sourceLines.any((sourceLine) {
      final trimmed = sourceLine.trimLeft();
      return trimmed.startsWith('part of ');
    });
    if (hasPartOfDirective) {
      exportsToRemove.add(i + 1);
    }
  }

  final sorted = exportsToRemove.toList()..sort();
  if (sorted.isEmpty || !writeChanges) {
    return sorted;
  }

  _removeLines(file, sorted);
  return sorted;
}

List<String> _readLines(File file) {
  return const LineSplitter().convert(file.readAsStringSync());
}

void _removeLines(File file, List<int> linesToRemove) {
  final original = file.readAsStringSync();
  final lines = const LineSplitter().convert(original);
  final toRemove = linesToRemove.toSet();
  final updatedLines = <String>[];

  for (var i = 0; i < lines.length; i++) {
    if (toRemove.contains(i + 1)) {
      continue;
    }
    updatedLines.add(lines[i]);
  }

  var updated = updatedLines.join('\n');
  if (original.endsWith('\n')) {
    updated = '$updated\n';
  }

  file.writeAsStringSync(updated);
}

int? _findMaterialExportLine(List<String> lines) {
  for (var i = 0; i < lines.length; i++) {
    if (_materialExportPattern.hasMatch(lines[i])) {
      return i + 1;
    }
  }
  return null;
}

String _lineListPreview(List<int> lines) {
  const previewCount = 25;
  if (lines.length <= previewCount) {
    return lines.join(', ');
  }
  return '${lines.take(previewCount).join(', ')}, ...';
}

Never _printUsageAndExit([String? error]) {
  if (error != null) {
    stderr.writeln(error);
    stderr.writeln('');
  }
  stdout.writeln(
    'Usage: dart run scripts/fix_shadcn_barrel.dart '
    '[--file <path>] [--write] [--max-iterations <n>] '
    '[--keep-material-export]',
  );
  stdout.writeln('');
  stdout.writeln('Examples:');
  stdout.writeln('  dart run scripts/fix_shadcn_barrel.dart');
  stdout.writeln('  dart run scripts/fix_shadcn_barrel.dart --write');
  stdout.writeln(
    '  dart run scripts/fix_shadcn_barrel.dart --file lib/shadcn.dart --write',
  );
  exit(error == null ? 0 : 64);
}

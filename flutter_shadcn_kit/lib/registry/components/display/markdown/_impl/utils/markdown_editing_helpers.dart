part of '../../markdown.dart';

@immutable
class MarkdownEditResult {
  const MarkdownEditResult({required this.text, required this.selection});

  final String text;
  final TextSelection selection;
}

class MarkdownEditingHelpers {
  const MarkdownEditingHelpers._();

  static MarkdownEditResult toggleBold({
    required String text,
    required TextSelection selection,
  }) {
    return _toggleDelimited(text, selection, '**');
  }

  static MarkdownEditResult toggleItalic({
    required String text,
    required TextSelection selection,
  }) {
    return _toggleDelimited(text, selection, '*');
  }

  static MarkdownEditResult toggleInlineCode({
    required String text,
    required TextSelection selection,
  }) {
    return _toggleDelimited(text, selection, '`');
  }

  static MarkdownEditResult toggleStrikethrough({
    required String text,
    required TextSelection selection,
  }) {
    return _toggleDelimited(text, selection, '~~');
  }

  static MarkdownEditResult toggleHeading({
    required String text,
    required TextSelection selection,
    int level = 2,
  }) {
    final normalizedLevel = level.clamp(1, 6);
    return _transformSelectedLines(text, selection, (lines) {
      final prefix = '${'#' * normalizedLevel} ';
      final nonEmpty = lines.where((line) => line.trim().isNotEmpty).toList();
      final shouldRemove =
          nonEmpty.isNotEmpty &&
          nonEmpty.every(
            (line) =>
                RegExp('^#{${normalizedLevel.toInt()}}\\s+').hasMatch(line),
          );

      final nextLines = <String>[];
      for (final line in lines) {
        if (line.trim().isEmpty) {
          nextLines.add(line);
          continue;
        }
        if (shouldRemove) {
          nextLines.add(
            line.replaceFirst(RegExp('^#{${normalizedLevel.toInt()}}\\s+'), ''),
          );
          continue;
        }
        final stripped = line.replaceFirst(RegExp(r'^#{1,6}\s+'), '');
        nextLines.add('$prefix$stripped');
      }
      return nextLines;
    });
  }

  static MarkdownEditResult cycleHeading({
    required String text,
    required TextSelection selection,
  }) {
    final normalized = _normalizeSelection(text, selection);
    final bounds = _lineBounds(text, normalized);
    final lines = text.substring(bounds.$1, bounds.$2).split('\n');
    final currentLevel = _currentHeadingLevel(lines);
    final nextLevel = currentLevel >= 6 ? 0 : currentLevel + 1;
    return _transformSelectedLines(text, selection, (sourceLines) {
      return _setHeadingLevel(
        sourceLines,
        targetLevel: nextLevel == 0 ? null : nextLevel,
      );
    });
  }

  static MarkdownEditResult toggleQuote({
    required String text,
    required TextSelection selection,
  }) {
    return _toggleLinePrefix(text, selection, prefix: '> ');
  }

  static MarkdownEditResult toggleBulletList({
    required String text,
    required TextSelection selection,
  }) {
    return _toggleLinePrefix(text, selection, prefix: '- ');
  }

  static MarkdownEditResult toggleTaskList({
    required String text,
    required TextSelection selection,
  }) {
    return _toggleLinePrefix(text, selection, prefix: '- [ ] ');
  }

  static MarkdownEditResult toggleOrderedList({
    required String text,
    required TextSelection selection,
  }) {
    return _transformSelectedLines(text, selection, (lines) {
      final nonEmpty = lines.where((line) => line.trim().isNotEmpty).toList();
      final shouldRemove =
          nonEmpty.isNotEmpty &&
          nonEmpty.every((line) => RegExp(r'^\d+\.\s+').hasMatch(line));
      final nextLines = <String>[];
      var index = 1;
      for (final line in lines) {
        if (line.trim().isEmpty) {
          nextLines.add(line);
          continue;
        }
        if (shouldRemove) {
          nextLines.add(line.replaceFirst(RegExp(r'^\d+\.\s+'), ''));
        } else {
          final stripped = line.replaceFirst(RegExp(r'^\d+\.\s+'), '');
          nextLines.add('${index++}. $stripped');
        }
      }
      return nextLines;
    });
  }

  static MarkdownEditResult wrapCodeFence({
    required String text,
    required TextSelection selection,
    String language = '',
  }) {
    final normalized = _normalizeSelection(text, selection);
    final bounds = _lineBounds(text, normalized);
    final block = text.substring(bounds.$1, bounds.$2);
    final languageLabel = language.trim();
    final openingFence = languageLabel.isEmpty ? '```' : '```$languageLabel';
    final lines = block.split('\n');
    final isWrapped =
        lines.length >= 2 &&
        lines.first.trimLeft().startsWith('```') &&
        lines.last.trim() == '```';

    final replacement = isWrapped
        ? lines.sublist(1, lines.length - 1).join('\n')
        : '$openingFence\n$block\n```';

    final nextText = text.replaceRange(bounds.$1, bounds.$2, replacement);
    return MarkdownEditResult(
      text: nextText,
      selection: TextSelection(
        baseOffset: bounds.$1,
        extentOffset: bounds.$1 + replacement.length,
      ),
    );
  }

  static MarkdownEditResult insertLink({
    required String text,
    required TextSelection selection,
    String placeholderLabel = 'link text',
    String placeholderUrl = 'https://',
  }) {
    final normalized = _normalizeSelection(text, selection);
    final selected = text.substring(normalized.start, normalized.end);
    final label = selected.isEmpty ? placeholderLabel : selected;
    final replacement = '[$label]($placeholderUrl)';
    final nextText = text.replaceRange(
      normalized.start,
      normalized.end,
      replacement,
    );
    final urlStart = normalized.start + label.length + 3;
    return MarkdownEditResult(
      text: nextText,
      selection: TextSelection(
        baseOffset: urlStart,
        extentOffset: urlStart + placeholderUrl.length,
      ),
    );
  }

  static MarkdownEditResult insertImage({
    required String text,
    required TextSelection selection,
    String placeholderAlt = 'alt text',
    String placeholderUrl = 'https://',
  }) {
    final normalized = _normalizeSelection(text, selection);
    final selected = text.substring(normalized.start, normalized.end);
    final alt = selected.isEmpty ? placeholderAlt : selected;
    final replacement = '![$alt]($placeholderUrl)';
    final nextText = text.replaceRange(
      normalized.start,
      normalized.end,
      replacement,
    );
    final urlStart = normalized.start + alt.length + 4;
    return MarkdownEditResult(
      text: nextText,
      selection: TextSelection(
        baseOffset: urlStart,
        extentOffset: urlStart + placeholderUrl.length,
      ),
    );
  }

  static MarkdownEditResult insertTable({
    required String text,
    required TextSelection selection,
    List<String> headers = const <String>['Column 1', 'Column 2', 'Column 3'],
  }) {
    final normalized = _normalizeSelection(text, selection);
    final safeHeaders = headers.isEmpty
        ? const <String>['Column 1', 'Column 2']
        : headers;
    final headerRow = '| ${safeHeaders.join(' | ')} |';
    final separatorRow =
        '| ${List<String>.filled(safeHeaders.length, '---').join(' | ')} |';
    final placeholderRow =
        '| ${List<String>.filled(safeHeaders.length, 'Value').join(' | ')} |';
    final table = '$headerRow\n$separatorRow\n$placeholderRow';
    final prefix = normalized.start > 0 && text[normalized.start - 1] != '\n'
        ? '\n'
        : '';
    final suffix = normalized.end < text.length && text[normalized.end] != '\n'
        ? '\n'
        : '';
    final replacement = '$prefix$table$suffix';
    final nextText = text.replaceRange(
      normalized.start,
      normalized.end,
      replacement,
    );
    final selectStart = normalized.start + prefix.length;
    return MarkdownEditResult(
      text: nextText,
      selection: TextSelection(
        baseOffset: selectStart + 2,
        extentOffset: selectStart + 2 + safeHeaders.first.length,
      ),
    );
  }

  static MarkdownEditResult insertHorizontalRule({
    required String text,
    required TextSelection selection,
  }) {
    final normalized = _normalizeSelection(text, selection);
    final before = normalized.start > 0 && text[normalized.start - 1] != '\n'
        ? '\n'
        : '';
    final after = normalized.end < text.length && text[normalized.end] != '\n'
        ? '\n'
        : '';
    const rule = '---';
    final replacement = '$before$rule$after';
    final nextText = text.replaceRange(
      normalized.start,
      normalized.end,
      replacement,
    );
    final caret = normalized.start + replacement.length;
    return MarkdownEditResult(
      text: nextText,
      selection: TextSelection.collapsed(offset: caret),
    );
  }

  static MarkdownEditResult _toggleDelimited(
    String text,
    TextSelection selection,
    String delimiter,
  ) {
    final normalized = _normalizeSelection(text, selection);
    final selected = text.substring(normalized.start, normalized.end);
    if (selected.isEmpty) {
      final insertion = '$delimiter$delimiter';
      final nextText = text.replaceRange(
        normalized.start,
        normalized.end,
        insertion,
      );
      final caret = normalized.start + delimiter.length;
      return MarkdownEditResult(
        text: nextText,
        selection: TextSelection.collapsed(offset: caret),
      );
    }

    final isWrapped =
        selected.startsWith(delimiter) &&
        selected.endsWith(delimiter) &&
        selected.length >= delimiter.length * 2;
    final replacement = isWrapped
        ? selected.substring(
            delimiter.length,
            selected.length - delimiter.length,
          )
        : '$delimiter$selected$delimiter';
    final nextText = text.replaceRange(
      normalized.start,
      normalized.end,
      replacement,
    );
    return MarkdownEditResult(
      text: nextText,
      selection: TextSelection(
        baseOffset: normalized.start,
        extentOffset: normalized.start + replacement.length,
      ),
    );
  }

  static MarkdownEditResult _toggleLinePrefix(
    String text,
    TextSelection selection, {
    required String prefix,
  }) {
    return _transformSelectedLines(text, selection, (lines) {
      final nonEmpty = lines.where((line) => line.trim().isNotEmpty).toList();
      final shouldRemove =
          nonEmpty.isNotEmpty &&
          nonEmpty.every((line) => line.startsWith(prefix));
      return <String>[
        for (final line in lines)
          if (line.trim().isEmpty)
            line
          else if (shouldRemove)
            line.substring(prefix.length)
          else
            '$prefix$line',
      ];
    });
  }

  static MarkdownEditResult _transformSelectedLines(
    String text,
    TextSelection selection,
    List<String> Function(List<String> lines) transformer,
  ) {
    final normalized = _normalizeSelection(text, selection);
    final bounds = _lineBounds(text, normalized);
    final block = text.substring(bounds.$1, bounds.$2);
    final nextLines = transformer(block.split('\n'));
    final replacement = nextLines.join('\n');
    final nextText = text.replaceRange(bounds.$1, bounds.$2, replacement);
    return MarkdownEditResult(
      text: nextText,
      selection: TextSelection(
        baseOffset: bounds.$1,
        extentOffset: bounds.$1 + replacement.length,
      ),
    );
  }

  static TextSelection _normalizeSelection(
    String text,
    TextSelection selection,
  ) {
    final start = selection.start < 0
        ? 0
        : selection.start.clamp(0, text.length);
    final end = selection.end < 0 ? start : selection.end.clamp(0, text.length);
    return TextSelection(
      baseOffset: start < end ? start : end,
      extentOffset: start < end ? end : start,
    );
  }

  static (int, int) _lineBounds(String text, TextSelection selection) {
    final start = selection.start <= 0
        ? -1
        : text.lastIndexOf('\n', selection.start - 1);
    final end = text.indexOf('\n', selection.end);
    final lineStart = start == -1 ? 0 : start + 1;
    final lineEnd = end == -1 ? text.length : end;
    return (lineStart, lineEnd);
  }

  static int _currentHeadingLevel(List<String> lines) {
    for (final line in lines) {
      final trimmed = line.trimLeft();
      if (trimmed.isEmpty) {
        continue;
      }
      final match = RegExp(r'^(#{1,6})\s+').firstMatch(trimmed);
      if (match == null) {
        return 0;
      }
      return match.group(1)!.length;
    }
    return 0;
  }

  static List<String> _setHeadingLevel(
    List<String> lines, {
    required int? targetLevel,
  }) {
    final sanitizedLevel = targetLevel?.clamp(1, 6).toInt();
    final nextLines = <String>[];
    for (final line in lines) {
      if (line.trim().isEmpty) {
        nextLines.add(line);
        continue;
      }
      final stripped = line.replaceFirst(RegExp(r'^#{1,6}\s+'), '');
      if (sanitizedLevel == null) {
        nextLines.add(stripped);
      } else {
        nextLines.add('${'#' * sanitizedLevel} $stripped');
      }
    }
    return nextLines;
  }
}

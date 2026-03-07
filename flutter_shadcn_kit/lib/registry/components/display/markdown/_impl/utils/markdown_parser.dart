part of '../../markdown.dart';

List<_MarkdownBlock> _parseMarkdownBlocks(String data) {
  if (data.trim().isEmpty) {
    return const <_MarkdownBlock>[];
  }

  final blocks = <_MarkdownBlock>[];
  final lines = data.replaceAll('\r\n', '\n').split('\n');

  var i = 0;
  while (i < lines.length) {
    final line = lines[i];
    final trimmed = line.trimRight();

    if (trimmed.isEmpty) {
      blocks.add(
        const _MarkdownBlock(type: _MarkdownBlockType.blank, text: ''),
      );
      i += 1;
      continue;
    }

    final fencedStart = RegExp(r'^\s*```([\w-]+)?\s*$').firstMatch(trimmed);
    if (fencedStart != null) {
      final code = <String>[];
      final language = fencedStart.group(1)?.trim();
      i += 1;
      while (i < lines.length && !lines[i].trimRight().startsWith('```')) {
        code.add(lines[i]);
        i += 1;
      }
      if (i < lines.length) {
        i += 1;
      }
      blocks.add(
        _MarkdownBlock(
          type: _MarkdownBlockType.codeFence,
          text: code.join('\n'),
          language: language,
        ),
      );
      continue;
    }

    final hr = RegExp(r'^\s*([-_*])\s*\1\s*\1[\s\1]*$');
    if (hr.hasMatch(trimmed)) {
      blocks.add(
        const _MarkdownBlock(type: _MarkdownBlockType.horizontalRule, text: ''),
      );
      i += 1;
      continue;
    }

    final heading = RegExp(r'^(#{1,6})\s+(.+)$').firstMatch(trimmed);
    if (heading != null) {
      final level = heading.group(1)!.length;
      final text = heading.group(2)!;
      final type = switch (level) {
        1 => _MarkdownBlockType.heading1,
        2 => _MarkdownBlockType.heading2,
        3 => _MarkdownBlockType.heading3,
        4 => _MarkdownBlockType.heading4,
        5 => _MarkdownBlockType.heading5,
        _ => _MarkdownBlockType.heading6,
      };
      blocks.add(_MarkdownBlock(type: type, text: text));
      i += 1;
      continue;
    }

    final image = RegExp(r'^!\[([^\]]*)\]\(([^)]+)\)\s*$').firstMatch(trimmed);
    if (image != null) {
      blocks.add(
        _MarkdownBlock(
          type: _MarkdownBlockType.image,
          text: '',
          imageAlt: image.group(1) ?? '',
          imageUrl: image.group(2) ?? '',
        ),
      );
      i += 1;
      continue;
    }

    if (_looksLikeTableHeader(lines, i)) {
      final tableRows = <List<String>>[];
      final alignments = _tableAlignments(lines[i + 1]);
      tableRows.add(_parseTableRow(lines[i]));
      i += 2;
      while (i < lines.length &&
          lines[i].contains('|') &&
          lines[i].trim().isNotEmpty) {
        tableRows.add(_parseTableRow(lines[i]));
        i += 1;
      }
      final maxColumns = tableRows.fold<int>(
        0,
        (current, row) => row.length > current ? row.length : current,
      );
      final normalized = [
        for (final row in tableRows)
          [
            for (var idx = 0; idx < maxColumns; idx++)
              idx < row.length ? row[idx] : '',
          ],
      ];
      blocks.add(
        _MarkdownBlock(
          type: _MarkdownBlockType.table,
          text: '',
          tableRows: normalized,
          tableAlignments: [
            for (var idx = 0; idx < maxColumns; idx++)
              idx < alignments.length ? alignments[idx] : TextAlign.left,
          ],
        ),
      );
      continue;
    }

    if (_isQuoteLine(trimmed)) {
      final quote = <String>[];
      while (i < lines.length) {
        final current = lines[i].trimRight();
        if (!_isQuoteLine(current)) {
          break;
        }
        quote.add(current.replaceFirst(RegExp(r'^\s*>\s?'), ''));
        i += 1;
      }
      blocks.add(
        _MarkdownBlock(type: _MarkdownBlockType.quote, text: quote.join('\n')),
      );
      continue;
    }

    final listBlock = _parseListItem(trimmed);
    if (listBlock != null) {
      blocks.add(listBlock);
      i += 1;
      continue;
    }

    final paragraph = <String>[trimmed];
    i += 1;
    while (i < lines.length) {
      final next = lines[i].trimRight();
      if (next.isEmpty ||
          next.startsWith('```') ||
          RegExp(r'^(#{1,6})\s+').hasMatch(next) ||
          _parseListItem(next) != null ||
          _isQuoteLine(next) ||
          RegExp(r'^\s*([-_*])\s*\1\s*\1').hasMatch(next) ||
          _looksLikeTableHeader(lines, i) ||
          RegExp(r'^!\[[^\]]*\]\([^)]+\)\s*$').hasMatch(next)) {
        break;
      }
      paragraph.add(next);
      i += 1;
    }

    blocks.add(
      _MarkdownBlock(
        type: _MarkdownBlockType.paragraph,
        text: paragraph.join('\n'),
      ),
    );
  }

  return blocks;
}

bool _isQuoteLine(String line) {
  return RegExp(r'^\s*>\s?').hasMatch(line);
}

_MarkdownBlock? _parseListItem(String line) {
  final indent = _leadingSpaces(line) ~/ 2;

  final task = RegExp(r'^\s*[-*+]\s+\[( |x|X)\]\s+(.+)$').firstMatch(line);
  if (task != null) {
    return _MarkdownBlock(
      type: _MarkdownBlockType.taskList,
      text: task.group(2)!,
      checked: task.group(1)!.toLowerCase() == 'x',
      indentLevel: indent,
    );
  }

  final ul = RegExp(r'^\s*[-*+]\s+(.+)$').firstMatch(line);
  if (ul != null) {
    return _MarkdownBlock(
      type: _MarkdownBlockType.unorderedList,
      text: ul.group(1)!,
      indentLevel: indent,
    );
  }

  final ol = RegExp(r'^\s*(\d+)\.\s+(.+)$').firstMatch(line);
  if (ol != null) {
    return _MarkdownBlock(
      type: _MarkdownBlockType.orderedList,
      orderedIndex: int.tryParse(ol.group(1)!) ?? 1,
      text: ol.group(2)!,
      indentLevel: indent,
    );
  }

  return null;
}

int _leadingSpaces(String value) {
  var count = 0;
  for (final rune in value.runes) {
    if (rune == 32) {
      count += 1;
      continue;
    }
    break;
  }
  return count;
}

bool _looksLikeTableHeader(List<String> lines, int index) {
  if (index + 1 >= lines.length) {
    return false;
  }
  final first = lines[index].trimRight();
  final second = lines[index + 1].trimRight();
  if (!first.contains('|')) {
    return false;
  }
  return RegExp(
    r'^\s*\|?\s*:?-{3,}:?\s*(\|\s*:?-{3,}:?\s*)+\|?\s*$',
  ).hasMatch(second);
}

List<String> _parseTableRow(String line) {
  final trimmed = line.trim();
  var content = trimmed;
  if (content.startsWith('|')) {
    content = content.substring(1);
  }
  if (content.endsWith('|')) {
    content = content.substring(0, content.length - 1);
  }
  return content.split('|').map((cell) => cell.trim()).toList(growable: false);
}

List<TextAlign> _tableAlignments(String separatorLine) {
  final cells = _parseTableRow(separatorLine);
  return [for (final cell in cells) _tableAlignment(cell)];
}

TextAlign _tableAlignment(String cell) {
  final trimmed = cell.trim();
  final left = trimmed.startsWith(':');
  final right = trimmed.endsWith(':');
  if (left && right) {
    return TextAlign.center;
  }
  if (right) {
    return TextAlign.right;
  }
  return TextAlign.left;
}

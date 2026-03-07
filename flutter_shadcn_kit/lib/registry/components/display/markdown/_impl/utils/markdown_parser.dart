part of '../../markdown.dart';

_MarkdownDocument _parseMarkdownDocument(String data) {
  if (data.trim().isEmpty) {
    return const _MarkdownDocument(blocks: <_MarkdownBlock>[]);
  }

  final normalized = data.replaceAll('\r\n', '\n');
  final source = _normalizeMarkdownWithHtmlBridges(normalized);
  final lines = source.split('\n');
  final blocks = <_MarkdownBlock>[];
  final references = <String, _MarkdownLinkTarget>{};
  final footnotes = <String, String>{};

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

    final reference = _tryParseReferenceDefinition(trimmed);
    if (reference != null) {
      references[reference.$1] = reference.$2;
      i += 1;
      continue;
    }

    final footnote = _tryParseFootnoteDefinition(lines, i);
    if (footnote != null) {
      footnotes[footnote.$1] = footnote.$2;
      i = footnote.$3;
      continue;
    }

    final details = _tryParseDetailsBlock(lines, i);
    if (details != null) {
      blocks.add(details.$1);
      i = details.$2;
      continue;
    }

    final codeFence = _tryParseCodeFence(lines, i);
    if (codeFence != null) {
      blocks.add(codeFence.$1);
      i = codeFence.$2;
      continue;
    }

    final blockMath = _tryParseBlockMath(lines, i);
    if (blockMath != null) {
      blocks.add(blockMath.$1);
      i = blockMath.$2;
      continue;
    }

    final indentedCode = _tryParseIndentedCode(lines, i);
    if (indentedCode != null) {
      blocks.add(indentedCode.$1);
      i = indentedCode.$2;
      continue;
    }

    final htmlTable = _tryParseHtmlTable(lines, i);
    if (htmlTable != null) {
      blocks.add(htmlTable.$1);
      i = htmlTable.$2;
      continue;
    }

    final htmlList = _tryParseHtmlListBlock(lines, i);
    if (htmlList != null) {
      blocks.addAll(htmlList.$1);
      i = htmlList.$2;
      continue;
    }

    final htmlDefinitionList = _tryParseHtmlDefinitionListBlock(lines, i);
    if (htmlDefinitionList != null) {
      blocks.addAll(htmlDefinitionList.$1);
      i = htmlDefinitionList.$2;
      continue;
    }

    final htmlSemantic = _tryParseSemanticHtmlBlock(lines, i);
    if (htmlSemantic != null) {
      blocks.add(htmlSemantic.$1);
      i = htmlSemantic.$2;
      continue;
    }

    final htmlBlock = _tryParseHtmlBlock(lines, i);
    if (htmlBlock != null) {
      blocks.add(htmlBlock.$1);
      i = htmlBlock.$2;
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
      blocks.add(
        _MarkdownBlock(
          type: switch (level) {
            1 => _MarkdownBlockType.heading1,
            2 => _MarkdownBlockType.heading2,
            3 => _MarkdownBlockType.heading3,
            4 => _MarkdownBlockType.heading4,
            5 => _MarkdownBlockType.heading5,
            _ => _MarkdownBlockType.heading6,
          },
          text: heading.group(2)!,
        ),
      );
      i += 1;
      continue;
    }

    final setextHeading = _tryParseSetextHeading(lines, i);
    if (setextHeading != null) {
      blocks.add(setextHeading.$1);
      i = setextHeading.$2;
      continue;
    }

    final image = _tryParseImageSyntax(trimmed);
    if (image != null) {
      blocks.add(
        _MarkdownBlock(
          type: _MarkdownBlockType.image,
          text: '',
          imageAlt: image.$1,
          imageUrl: image.$2,
          imageTitle: image.$3,
        ),
      );
      i += 1;
      continue;
    }

    if (_looksLikeTableHeader(lines, i)) {
      final rows = <List<String>>[_parseTableRow(lines[i])];
      final alignments = _tableAlignments(lines[i + 1]);
      i += 2;
      while (i < lines.length &&
          lines[i].trim().isNotEmpty &&
          lines[i].contains('|')) {
        rows.add(_parseTableRow(lines[i]));
        i += 1;
      }
      final maxColumns = rows.fold<int>(
        0,
        (max, row) => row.length > max ? row.length : max,
      );
      blocks.add(
        _MarkdownBlock(
          type: _MarkdownBlockType.table,
          text: '',
          tableRows: [
            for (final row in rows)
              [
                for (var col = 0; col < maxColumns; col++)
                  col < row.length ? row[col] : '',
              ],
          ],
          tableAlignments: [
            for (var col = 0; col < maxColumns; col++)
              col < alignments.length ? alignments[col] : TextAlign.left,
          ],
        ),
      );
      continue;
    }

    final quote = _tryParseQuote(lines, i);
    if (quote != null) {
      blocks.add(quote.$1);
      i = quote.$2;
      continue;
    }

    final definition = _tryParseDefinitionList(lines, i);
    if (definition != null) {
      blocks.add(definition.$1);
      i = definition.$2;
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
          _tryParseReferenceDefinition(next) != null ||
          _tryParseCodeFence(lines, i) != null ||
          _tryParseBlockMath(lines, i) != null ||
          _tryParseIndentedCode(lines, i) != null ||
          _tryParseDetailsBlock(lines, i) != null ||
          _tryParseHtmlTable(lines, i) != null ||
          _tryParseHtmlListBlock(lines, i) != null ||
          _tryParseHtmlDefinitionListBlock(lines, i) != null ||
          _tryParseSemanticHtmlBlock(lines, i) != null ||
          _tryParseHtmlBlock(lines, i) != null ||
          RegExp(r'^(#{1,6})\s+').hasMatch(next) ||
          _tryParseSetextHeading(lines, i) != null ||
          _parseListItem(next) != null ||
          _isQuoteLine(next) ||
          RegExp(r'^\s*([-_*])\s*\1\s*\1').hasMatch(next) ||
          _looksLikeTableHeader(lines, i) ||
          _tryParseImageSyntax(next) != null ||
          _tryParseFootnoteDefinition(lines, i) != null ||
          _tryParseDefinitionList(lines, i) != null) {
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

  if (footnotes.isNotEmpty) {
    blocks.add(const _MarkdownBlock(type: _MarkdownBlockType.blank, text: ''));
    for (final entry in footnotes.entries) {
      blocks.add(
        _MarkdownBlock(
          type: _MarkdownBlockType.footnote,
          text: entry.value,
          label: entry.key,
        ),
      );
    }
  }

  return _MarkdownDocument(
    blocks: List<_MarkdownBlock>.unmodifiable(blocks),
    references: Map<String, _MarkdownLinkTarget>.unmodifiable(references),
    footnotes: Map<String, String>.unmodifiable(footnotes),
  );
}

int _computeStableMarkdownPrefixLength(String data) {
  if (data.isEmpty) {
    return 0;
  }

  final source = data.replaceAll('\r\n', '\n');
  final lines = source.split('\n');
  var offset = 0;
  var lastStable = 0;
  var inFence = false;
  String? openFence;
  var inMath = false;
  var inDetails = false;
  var inTable = false;
  var inHtmlTable = false;
  String? inHtmlContainerTag;

  for (var i = 0; i < lines.length; i++) {
    final line = lines[i];
    final trimmed = line.trimRight();
    final hasTrailingNewline = i < lines.length - 1;
    final lineEnd = offset + line.length + (hasTrailingNewline ? 1 : 0);

    if (inFence) {
      if (openFence != null && _isClosingFenceLine(trimmed, openFence)) {
        inFence = false;
        openFence = null;
        lastStable = lineEnd;
      }
      offset = lineEnd;
      continue;
    }

    if (inMath) {
      if (trimmed == r'$$') {
        inMath = false;
        lastStable = lineEnd;
      }
      offset = lineEnd;
      continue;
    }

    if (inDetails) {
      if (trimmed.toLowerCase().startsWith('</details')) {
        inDetails = false;
        lastStable = lineEnd;
      }
      offset = lineEnd;
      continue;
    }

    if (inTable) {
      if (trimmed.isEmpty) {
        inTable = false;
        lastStable = lineEnd;
        offset = lineEnd;
        continue;
      }
      if (trimmed.contains('|')) {
        if (hasTrailingNewline) {
          lastStable = lineEnd;
        }
        offset = lineEnd;
        continue;
      }
      inTable = false;
    }

    if (inHtmlTable) {
      final lower = trimmed.toLowerCase();
      if (lower.contains('</table>')) {
        inHtmlTable = false;
        lastStable = lineEnd;
      }
      offset = lineEnd;
      continue;
    }

    if (inHtmlContainerTag != null) {
      final lower = trimmed.toLowerCase();
      if (lower.contains('</$inHtmlContainerTag>')) {
        inHtmlContainerTag = null;
        lastStable = lineEnd;
      }
      offset = lineEnd;
      continue;
    }

    if (trimmed.isEmpty) {
      lastStable = lineEnd;
      offset = lineEnd;
      continue;
    }

    final fenceInfo = _parseFenceMarker(trimmed);
    if (fenceInfo != null) {
      inFence = true;
      openFence = fenceInfo.$1;
      offset = lineEnd;
      continue;
    }

    if (trimmed == r'$$') {
      inMath = true;
      offset = lineEnd;
      continue;
    }

    if (trimmed.toLowerCase().startsWith('<details')) {
      inDetails = true;
      offset = lineEnd;
      continue;
    }

    final lower = trimmed.toLowerCase();
    if (lower.startsWith('<table')) {
      if (lower.contains('</table>')) {
        if (hasTrailingNewline) {
          lastStable = lineEnd;
        }
      } else {
        inHtmlTable = true;
      }
      offset = lineEnd;
      continue;
    }

    final htmlContainer = _openingHtmlContainerTag(trimmed);
    if (htmlContainer != null) {
      if (trimmed.toLowerCase().contains('</$htmlContainer>')) {
        if (hasTrailingNewline) {
          lastStable = lineEnd;
        }
      } else {
        inHtmlContainerTag = htmlContainer;
      }
      offset = lineEnd;
      continue;
    }

    if (_isTableSeparatorLine(trimmed) && i > 0 && lines[i - 1].contains('|')) {
      inTable = true;
      if (hasTrailingNewline) {
        lastStable = lineEnd;
      }
      offset = lineEnd;
      continue;
    }

    if (trimmed.contains('|')) {
      final nextLine = i + 1 < lines.length ? lines[i + 1].trimRight() : null;
      final canBecomeTable =
          nextLine != null && _isTableSeparatorLine(nextLine);
      if (canBecomeTable) {
        offset = lineEnd;
        continue;
      }
    }

    if (hasTrailingNewline && _isStandaloneStableLine(trimmed)) {
      lastStable = lineEnd;
    }

    offset = lineEnd;
  }

  return lastStable.clamp(0, source.length);
}

String _normalizeMarkdownWithHtmlBridges(String source) {
  return _convertMarkdownTablesToHtml(source);
}

String _convertMarkdownTablesToHtml(String source) {
  final lines = source.split('\n');
  final output = <String>[];
  String? openFence;
  var inMath = false;
  var i = 0;

  while (i < lines.length) {
    final line = lines[i];
    final trimmed = line.trimRight();

    final fenceInfo = _parseFenceMarker(trimmed);
    if (openFence == null && fenceInfo != null) {
      openFence = fenceInfo.$1;
      output.add(line);
      i += 1;
      continue;
    }
    if (openFence != null && _isClosingFenceLine(trimmed, openFence)) {
      openFence = null;
      output.add(line);
      i += 1;
      continue;
    }

    if (openFence == null && trimmed == r'$$') {
      inMath = !inMath;
      output.add(line);
      i += 1;
      continue;
    }

    if (openFence != null || inMath) {
      output.add(line);
      i += 1;
      continue;
    }

    if (_looksLikeTableHeader(lines, i)) {
      final header = _parseTableRow(lines[i]);
      final alignments = _tableAlignments(lines[i + 1]);
      final bodyRows = <List<String>>[];
      i += 2;
      while (i < lines.length &&
          lines[i].trim().isNotEmpty &&
          lines[i].contains('|')) {
        bodyRows.add(_parseTableRow(lines[i]));
        i += 1;
      }
      output.addAll(_buildHtmlTableLines(header, bodyRows, alignments));
      continue;
    }

    output.add(line);
    i += 1;
  }

  return output.join('\n');
}

List<String> _buildHtmlTableLines(
  List<String> header,
  List<List<String>> bodyRows,
  List<TextAlign> alignments,
) {
  final rows = <List<String>>[header, ...bodyRows];
  final maxColumns = rows.fold<int>(
    0,
    (max, row) => row.length > max ? row.length : max,
  );
  final normalizedHeader = [
    for (var col = 0; col < maxColumns; col++)
      col < header.length ? header[col] : '',
  ];

  final lines = <String>['<table>', '  <thead>', '    <tr>'];
  for (var col = 0; col < normalizedHeader.length; col++) {
    final align = col < alignments.length ? alignments[col] : TextAlign.left;
    lines.add(
      '      <th style="text-align: ${_alignmentToCss(align)}">${_escapeHtmlText(normalizedHeader[col])}</th>',
    );
  }
  lines.addAll(<String>['    </tr>', '  </thead>']);

  if (bodyRows.isNotEmpty) {
    lines.add('  <tbody>');
    for (final row in bodyRows) {
      lines.add('    <tr>');
      for (var col = 0; col < maxColumns; col++) {
        final value = col < row.length ? row[col] : '';
        final align = col < alignments.length
            ? alignments[col]
            : TextAlign.left;
        lines.add(
          '      <td style="text-align: ${_alignmentToCss(align)}">${_escapeHtmlText(value)}</td>',
        );
      }
      lines.add('    </tr>');
    }
    lines.add('  </tbody>');
  }

  lines.add('</table>');
  return lines;
}

String _alignmentToCss(TextAlign align) {
  return switch (align) {
    TextAlign.center => 'center',
    TextAlign.right => 'right',
    _ => 'left',
  };
}

String _escapeHtmlText(String value) {
  return value
      .replaceAll('&', '&amp;')
      .replaceAll('<', '&lt;')
      .replaceAll('>', '&gt;');
}

String? _openingHtmlContainerTag(String line) {
  final trimmed = line.trimLeft();
  final lower = trimmed.toLowerCase();
  for (final tag in const <String>[
    'ul',
    'ol',
    'dl',
    'blockquote',
    'pre',
    'p',
    'div',
    'section',
    'article',
  ]) {
    if (lower.startsWith('<$tag')) {
      return tag;
    }
  }
  final heading = RegExp(
    r'^<h([1-6])\b',
    caseSensitive: false,
  ).firstMatch(trimmed);
  if (heading != null) {
    return 'h${heading.group(1)}';
  }
  return null;
}

(String, String?)? _parseFenceMarker(String line) {
  final match = RegExp(
    r'^\s*(`{3,}|~{3,})(?:\s*([\w-]+))?\s*$',
  ).firstMatch(line.trimRight());
  if (match == null) {
    return null;
  }
  return (match.group(1)!, match.group(2)?.trim());
}

bool _isClosingFenceLine(String line, String marker) {
  final char = marker[0];
  final length = marker.length;
  return RegExp(
    '^\\s*${RegExp.escape(char)}{$length,}\\s*\$',
  ).hasMatch(line.trimRight());
}

bool _isStandaloneStableLine(String line) {
  return RegExp(r'^(#{1,6})\s+').hasMatch(line) ||
      RegExp(r'^\s*(=+|-+)\s*$').hasMatch(line) ||
      RegExp(r'^\s*([-_*])\s*\1\s*\1').hasMatch(line) ||
      RegExp(r'^\s*[-*+]\s+').hasMatch(line) ||
      RegExp(r'^\s*\d+\.\s+').hasMatch(line) ||
      RegExp(r'^\s*>\s?').hasMatch(line) ||
      RegExp(r'^\s*!\[').hasMatch(line) ||
      RegExp(r'^\s*\[[^\]]+\]:').hasMatch(line) ||
      RegExp(r'^\s*\[\^[^\]]+\]:').hasMatch(line) ||
      _openingHtmlContainerTag(line) != null;
}

(String, _MarkdownLinkTarget)? _tryParseReferenceDefinition(String line) {
  final match = RegExp(
    r'''^\s*\[([^\]]+)\]:\s+(\S+)(?:\s+(?:"([^"]+)"|'([^']+)'))?\s*$''',
  ).firstMatch(line);
  if (match == null) {
    return null;
  }
  return (
    _normalizeReferenceKey(match.group(1)!),
    _MarkdownLinkTarget(
      url: match.group(2)!,
      title: match.group(3) ?? match.group(4),
    ),
  );
}

(String, String, int)? _tryParseFootnoteDefinition(
  List<String> lines,
  int index,
) {
  final match = RegExp(
    r'^\s*\[\^([^\]]+)\]:\s+(.+)$',
  ).firstMatch(lines[index].trimRight());
  if (match == null) {
    return null;
  }

  final id = match.group(1)!;
  final buffer = <String>[match.group(2)!];
  var i = index + 1;
  while (i < lines.length) {
    final line = lines[i];
    if (line.trim().isEmpty) {
      buffer.add('');
      i += 1;
      continue;
    }
    if (RegExp(r'^\s{2,}|\t').hasMatch(line)) {
      buffer.add(line.trim());
      i += 1;
      continue;
    }
    break;
  }
  return (id, buffer.join('\n').trimRight(), i);
}

(_MarkdownBlock, int)? _tryParseCodeFence(List<String> lines, int index) {
  final firstLine = lines[index].trimRight();
  final fenceInfo = _parseFenceMarker(firstLine);
  if (fenceInfo == null) {
    return null;
  }
  final marker = fenceInfo.$1;
  final language = fenceInfo.$2;
  final buffer = <String>[];
  var i = index + 1;
  while (i < lines.length &&
      !_isClosingFenceLine(lines[i].trimRight(), marker)) {
    buffer.add(lines[i]);
    i += 1;
  }
  if (i < lines.length) {
    i += 1;
  }
  return (
    _MarkdownBlock(
      type: _MarkdownBlockType.codeFence,
      text: buffer.join('\n'),
      language: language,
    ),
    i,
  );
}

(_MarkdownBlock, int)? _tryParseSetextHeading(List<String> lines, int index) {
  if (index + 1 >= lines.length) {
    return null;
  }
  final text = lines[index].trimRight();
  if (text.isEmpty) {
    return null;
  }
  final underline = lines[index + 1].trimRight();
  final match = RegExp(r'^\s*(=+|-+)\s*$').firstMatch(underline);
  if (match == null) {
    return null;
  }
  return (
    _MarkdownBlock(
      type: match.group(1)!.startsWith('=')
          ? _MarkdownBlockType.heading1
          : _MarkdownBlockType.heading2,
      text: text,
    ),
    index + 2,
  );
}

(_MarkdownBlock, int)? _tryParseIndentedCode(List<String> lines, int index) {
  if (!RegExp(r'^( {4}|\t)').hasMatch(lines[index])) {
    return null;
  }
  final buffer = <String>[];
  var i = index;
  while (i < lines.length) {
    final line = lines[i];
    if (line.trim().isEmpty) {
      buffer.add('');
      i += 1;
      continue;
    }
    if (!RegExp(r'^( {4}|\t)').hasMatch(line)) {
      break;
    }
    buffer.add(line.replaceFirst(RegExp(r'^( {4}|\t)'), ''));
    i += 1;
  }
  return (
    _MarkdownBlock(
      type: _MarkdownBlockType.indentedCode,
      text: buffer.join('\n'),
    ),
    i,
  );
}

(_MarkdownBlock, int)? _tryParseBlockMath(List<String> lines, int index) {
  final trimmed = lines[index].trimRight();
  if (trimmed != r'$$') {
    return null;
  }
  final buffer = <String>[];
  var i = index + 1;
  while (i < lines.length && lines[i].trimRight() != r'$$') {
    buffer.add(lines[i]);
    i += 1;
  }
  if (i < lines.length) {
    i += 1;
  }
  return (
    _MarkdownBlock(type: _MarkdownBlockType.math, text: buffer.join('\n')),
    i,
  );
}

(_MarkdownBlock, int)? _tryParseDetailsBlock(List<String> lines, int index) {
  if (!lines[index].trim().toLowerCase().startsWith('<details')) {
    return null;
  }

  String summary = 'Details';
  final body = <String>[];
  var i = index + 1;
  while (i < lines.length) {
    final trimmed = lines[i].trim();
    final summaryMatch = RegExp(
      r'^<summary\b[^>]*>([\s\S]*?)</summary>$',
      caseSensitive: false,
    ).firstMatch(trimmed);
    if (summaryMatch != null) {
      summary = _normalizeHtmlInline(summaryMatch.group(1) ?? '').trim();
      i += 1;
      continue;
    }
    if (trimmed.toLowerCase().startsWith('</details')) {
      i += 1;
      break;
    }
    body.add(lines[i]);
    i += 1;
  }

  return (
    _MarkdownBlock(
      type: _MarkdownBlockType.details,
      text: summary,
      items: <String>[body.join('\n').trim()],
    ),
    i,
  );
}

(_MarkdownBlock, int)? _tryParseHtmlBlock(List<String> lines, int index) {
  final trimmed = lines[index].trim();
  if (!trimmed.startsWith('<') || trimmed.startsWith('</')) {
    return null;
  }
  if (trimmed.toLowerCase().startsWith('<details')) {
    return null;
  }

  final buffer = <String>[lines[index]];
  final tag = RegExp(
    r'^<([a-zA-Z0-9]+)',
  ).firstMatch(trimmed)?.group(1)?.toLowerCase();
  var i = index + 1;
  while (i < lines.length && lines[i].trim().isNotEmpty) {
    buffer.add(lines[i]);
    if (tag != null && lines[i].trim().toLowerCase() == '</$tag>') {
      i += 1;
      break;
    }
    i += 1;
  }

  return (
    _MarkdownBlock(
      type: _MarkdownBlockType.rawHtml,
      text: buffer.join('\n'),
      htmlTag: tag,
      rawHtml: buffer.join('\n'),
    ),
    i,
  );
}

(_MarkdownBlock, int)? _tryParseSemanticHtmlBlock(
  List<String> lines,
  int index,
) {
  final trimmed = lines[index].trimLeft();
  if (!trimmed.startsWith('<') || trimmed.startsWith('</')) {
    return null;
  }

  final headingMatch = RegExp(
    r'^<h([1-6])\b',
    caseSensitive: false,
  ).firstMatch(trimmed);
  if (headingMatch != null) {
    final level = int.tryParse(headingMatch.group(1) ?? '') ?? 1;
    final tag = 'h$level';
    final collected = _collectHtmlElement(lines, index, tag);
    if (collected == null) {
      return null;
    }
    final content = _extractInnerHtml(collected.$1, tag);
    final text = _normalizeHtmlInline(content);
    if (text.isEmpty) {
      return null;
    }
    return (
      _MarkdownBlock(
        type: switch (level) {
          1 => _MarkdownBlockType.heading1,
          2 => _MarkdownBlockType.heading2,
          3 => _MarkdownBlockType.heading3,
          4 => _MarkdownBlockType.heading4,
          5 => _MarkdownBlockType.heading5,
          _ => _MarkdownBlockType.heading6,
        },
        text: text,
        htmlTag: tag,
        rawHtml: collected.$1,
      ),
      collected.$2,
    );
  }

  final lower = trimmed.toLowerCase();
  if (RegExp(r'^<hr\b[^>]*\/?>$').hasMatch(lower)) {
    return (
      _MarkdownBlock(
        type: _MarkdownBlockType.horizontalRule,
        text: '',
        htmlTag: 'hr',
        rawHtml: lines[index].trimRight(),
      ),
      index + 1,
    );
  }

  if (lower.startsWith('<img')) {
    final collected = _collectSelfClosingHtmlTag(lines, index);
    if (collected == null) {
      return null;
    }
    final attrs = collected.$1;
    final src = _extractHtmlAttribute(attrs, 'src');
    if (src == null || src.isEmpty) {
      return null;
    }
    return (
      _MarkdownBlock(
        type: _MarkdownBlockType.image,
        text: '',
        imageUrl: _decodeHtmlEntities(src),
        imageAlt: _decodeHtmlEntities(
          _extractHtmlAttribute(attrs, 'alt') ?? '',
        ),
        imageTitle: _decodeHtmlEntities(
          _extractHtmlAttribute(attrs, 'title') ?? '',
        ),
        htmlTag: 'img',
        rawHtml: collected.$1,
      ),
      collected.$2,
    );
  }

  if (lower.startsWith('<pre')) {
    final collected = _collectHtmlElement(lines, index, 'pre');
    if (collected == null) {
      return null;
    }
    final raw = collected.$1;
    final codeMatch = RegExp(
      r'<code\b([^>]*)>([\s\S]*?)</code>',
      caseSensitive: false,
    ).firstMatch(raw);
    final language =
        _extractLanguageFromCodeAttrs(codeMatch?.group(1) ?? '') ??
        _extractLanguageFromCodeAttrs(raw);
    final codeInner = codeMatch?.group(2) ?? _extractInnerHtml(raw, 'pre');
    final code = _decodeHtmlEntities(codeInner).trimRight();
    return (
      _MarkdownBlock(
        type: _MarkdownBlockType.codeFence,
        text: code,
        language: language,
        htmlTag: 'pre',
        rawHtml: collected.$1,
      ),
      collected.$2,
    );
  }

  if (lower.startsWith('<blockquote')) {
    final collected = _collectHtmlElement(lines, index, 'blockquote');
    if (collected == null) {
      return null;
    }
    final inner = _extractInnerHtml(collected.$1, 'blockquote');
    final text = _normalizeHtmlBlockText(inner);
    if (text.isEmpty) {
      return null;
    }
    return (
      _MarkdownBlock(
        type: _MarkdownBlockType.quote,
        text: text,
        htmlTag: 'blockquote',
        rawHtml: collected.$1,
      ),
      collected.$2,
    );
  }

  if (lower.startsWith('<p') || lower.startsWith('<div')) {
    final tag = lower.startsWith('<p') ? 'p' : 'div';
    final collected = _collectHtmlElement(lines, index, tag);
    if (collected == null) {
      return null;
    }
    final text = _normalizeHtmlBlockText(_extractInnerHtml(collected.$1, tag));
    if (text.isEmpty) {
      return null;
    }
    return (
      _MarkdownBlock(
        type: _MarkdownBlockType.paragraph,
        text: text,
        htmlTag: tag,
        rawHtml: collected.$1,
      ),
      collected.$2,
    );
  }

  return null;
}

(List<_MarkdownBlock>, int)? _tryParseHtmlListBlock(
  List<String> lines,
  int index,
) {
  final lower = lines[index].trimLeft().toLowerCase();
  if (!lower.startsWith('<ul') && !lower.startsWith('<ol')) {
    return null;
  }
  final tag = lower.startsWith('<ol') ? 'ol' : 'ul';
  final collected = _collectHtmlElement(lines, index, tag);
  if (collected == null) {
    return null;
  }
  final blocks = _parseHtmlListElement(collected.$1, indentLevel: 0);
  if (blocks.isEmpty) {
    return null;
  }
  return (blocks, collected.$2);
}

List<_MarkdownBlock> _parseHtmlListElement(
  String raw, {
  required int indentLevel,
}) {
  final trimmed = raw.trimLeft();
  final openMatch = RegExp(
    r'^<\s*(ul|ol)\b([^>]*)>',
    caseSensitive: false,
  ).firstMatch(trimmed);
  if (openMatch == null) {
    return const <_MarkdownBlock>[];
  }

  final listTag = (openMatch.group(1) ?? 'ul').toLowerCase();
  final isOrdered = listTag == 'ol';
  final attrs = openMatch.group(2) ?? '';
  var nextOrderedIndex = isOrdered
      ? int.tryParse(_extractHtmlAttribute(attrs, 'start') ?? '') ?? 1
      : 1;

  final inner = _extractInnerHtml(trimmed, listTag);
  final liItems = _extractTopLevelElements(inner, 'li');
  final blocks = <_MarkdownBlock>[];
  for (final liRaw in liItems) {
    final parsed = _parseHtmlListItem(
      liRaw,
      ordered: isOrdered,
      indentLevel: indentLevel,
      orderedIndex: nextOrderedIndex,
    );
    if (parsed.$1 != null) {
      blocks.add(parsed.$1!);
    }
    blocks.addAll(parsed.$2);
    if (isOrdered) {
      nextOrderedIndex += 1;
    }
  }
  return blocks;
}

(_MarkdownBlock?, List<_MarkdownBlock>) _parseHtmlListItem(
  String raw, {
  required bool ordered,
  required int indentLevel,
  required int orderedIndex,
}) {
  final inner = _extractInnerHtml(raw, 'li');
  final nestedSegments = _extractTopLevelListSegments(inner);
  final mainHtml = _removeRanges(inner, [
    for (final segment in nestedSegments) (segment.$2, segment.$3),
  ]);
  final checkboxState = _extractHtmlCheckboxState(mainHtml);
  final normalized = _normalizeHtmlBlockText(
    _stripHtmlCheckboxInputs(mainHtml),
  );

  _MarkdownBlock? block;
  if (normalized.isNotEmpty || checkboxState != null) {
    if (checkboxState != null) {
      block = _MarkdownBlock(
        type: _MarkdownBlockType.taskList,
        text: normalized,
        checked: checkboxState,
        indentLevel: indentLevel,
      );
    } else if (ordered) {
      block = _MarkdownBlock(
        type: _MarkdownBlockType.orderedList,
        text: normalized,
        orderedIndex: orderedIndex,
        indentLevel: indentLevel,
      );
    } else {
      block = _MarkdownBlock(
        type: _MarkdownBlockType.unorderedList,
        text: normalized,
        indentLevel: indentLevel,
      );
    }
  }

  final nestedBlocks = <_MarkdownBlock>[];
  for (final segment in nestedSegments) {
    final nestedRaw = inner.substring(segment.$2, segment.$3);
    nestedBlocks.addAll(
      _parseHtmlListElement(nestedRaw, indentLevel: indentLevel + 1),
    );
  }

  return (block, nestedBlocks);
}

List<(String, int, int)> _extractTopLevelListSegments(String html) {
  final segments = <(String, int, int)>[];
  for (final tag in const <String>['ul', 'ol']) {
    final ranges = _extractTopLevelTagRanges(html, tag);
    for (final range in ranges) {
      segments.add((tag, range.$1, range.$2));
    }
  }
  segments.sort((a, b) => a.$2.compareTo(b.$2));
  return segments;
}

List<String> _extractTopLevelElements(String html, String tag) {
  final ranges = _extractTopLevelTagRanges(html, tag);
  return <String>[
    for (final range in ranges) html.substring(range.$1, range.$2),
  ];
}

List<(int, int)> _extractTopLevelTagRanges(String html, String tag) {
  final tokenPattern = RegExp('</?$tag\\b[^>]*>', caseSensitive: false);
  final ranges = <(int, int)>[];
  var depth = 0;
  int? start;

  for (final match in tokenPattern.allMatches(html)) {
    final token = match.group(0)!.toLowerCase();
    final isClosing = token.startsWith('</');
    final isSelfClosing = token.endsWith('/>');
    if (!isClosing) {
      if (depth == 0) {
        start = match.start;
      }
      if (isSelfClosing) {
        if (depth == 0 && start != null) {
          ranges.add((start, match.end));
          start = null;
        }
      } else {
        depth += 1;
      }
      continue;
    }
    if (depth == 0) {
      continue;
    }
    depth -= 1;
    if (depth == 0 && start != null) {
      ranges.add((start, match.end));
      start = null;
    }
  }

  return ranges;
}

String _removeRanges(String source, List<(int, int)> ranges) {
  if (ranges.isEmpty) {
    return source;
  }
  final sorted = <(int, int)>[...ranges]..sort((a, b) => a.$1.compareTo(b.$1));
  final buffer = StringBuffer();
  var cursor = 0;
  for (final range in sorted) {
    if (range.$1 > cursor) {
      buffer.write(source.substring(cursor, range.$1));
    }
    cursor = range.$2 > cursor ? range.$2 : cursor;
  }
  if (cursor < source.length) {
    buffer.write(source.substring(cursor));
  }
  return buffer.toString();
}

bool? _extractHtmlCheckboxState(String value) {
  final input = RegExp(
    r'<input\b([^>]*)>',
    caseSensitive: false,
  ).firstMatch(value);
  if (input == null) {
    return null;
  }
  final attrs = input.group(1) ?? '';
  final type = _extractHtmlAttribute(attrs, 'type')?.toLowerCase().trim();
  if (type != 'checkbox') {
    return null;
  }
  return RegExp(r'\bchecked\b', caseSensitive: false).hasMatch(attrs);
}

String _stripHtmlCheckboxInputs(String value) {
  return value.replaceAllMapped(
    RegExp(r'<input\b([^>]*)>', caseSensitive: false),
    (match) {
      final attrs = match.group(1) ?? '';
      final type = _extractHtmlAttribute(attrs, 'type')?.toLowerCase().trim();
      if (type == 'checkbox') {
        return '';
      }
      return match.group(0) ?? '';
    },
  );
}

(List<_MarkdownBlock>, int)? _tryParseHtmlDefinitionListBlock(
  List<String> lines,
  int index,
) {
  final lower = lines[index].trimLeft().toLowerCase();
  if (!lower.startsWith('<dl')) {
    return null;
  }

  final collected = _collectHtmlElement(lines, index, 'dl');
  if (collected == null) {
    return null;
  }

  final inner = _extractInnerHtml(collected.$1, 'dl');
  final entries = <(String, int, int)>[
    for (final range in _extractTopLevelTagRanges(inner, 'dt'))
      ('dt', range.$1, range.$2),
    for (final range in _extractTopLevelTagRanges(inner, 'dd'))
      ('dd', range.$1, range.$2),
  ]..sort((a, b) => a.$2.compareTo(b.$2));

  final blocks = <_MarkdownBlock>[];
  String? currentTerm;
  final definitions = <String>[];

  void flushCurrent() {
    if (currentTerm == null || definitions.isEmpty) {
      return;
    }
    blocks.add(
      _MarkdownBlock(
        type: _MarkdownBlockType.definitionList,
        text: currentTerm!,
        items: List<String>.unmodifiable(definitions),
      ),
    );
    currentTerm = null;
    definitions.clear();
  }

  for (final entry in entries) {
    final tag = entry.$1;
    final raw = inner.substring(entry.$2, entry.$3);
    final text = _normalizeHtmlBlockText(_extractInnerHtml(raw, tag));
    if (text.isEmpty) {
      continue;
    }
    if (tag == 'dt') {
      flushCurrent();
      currentTerm = text;
      continue;
    }
    currentTerm ??= 'Term';
    definitions.add(text);
  }
  flushCurrent();

  if (blocks.isEmpty) {
    return null;
  }
  return (blocks, collected.$2);
}

(String, int)? _collectHtmlElement(List<String> lines, int index, String tag) {
  final open = RegExp('<$tag\\b', caseSensitive: false);
  final close = RegExp('</$tag\\s*>', caseSensitive: false);
  if (!open.hasMatch(lines[index])) {
    return null;
  }

  final buffer = <String>[];
  var depth = 0;
  var i = index;
  while (i < lines.length) {
    final line = lines[i];
    buffer.add(line);
    depth += open.allMatches(line).length;
    depth -= close.allMatches(line).length;
    i += 1;
    if (depth <= 0 && close.hasMatch(line)) {
      break;
    }
  }

  if (depth > 0) {
    return null;
  }
  return (buffer.join('\n'), i);
}

(String, int)? _collectSelfClosingHtmlTag(List<String> lines, int index) {
  final buffer = StringBuffer(lines[index].trim());
  var i = index + 1;
  while (!buffer.toString().contains('>') && i < lines.length) {
    buffer.write(lines[i].trim());
    i += 1;
  }
  if (!buffer.toString().contains('>')) {
    return null;
  }
  return (buffer.toString(), i);
}

String _extractInnerHtml(String raw, String tag) {
  final openPattern = RegExp('^\\s*<$tag\\b[^>]*>', caseSensitive: false);
  final closePattern = RegExp('</$tag>\\s*\$', caseSensitive: false);
  var value = raw.replaceFirst(openPattern, '');
  value = value.replaceFirst(closePattern, '');
  return value.trim();
}

String _extractOpeningHtmlAttributes(String raw, String tag) {
  final match = RegExp(
    '^\\s*<$tag\\b([^>]*)>',
    caseSensitive: false,
  ).firstMatch(raw);
  return match?.group(1)?.trim() ?? '';
}

Map<String, String> _extractHtmlAttributesMap(String raw) {
  if (raw.trim().isEmpty) {
    return const <String, String>{};
  }
  final attributes = <String, String>{};
  final matches = RegExp(
    r'''([^\s=/>]+)(?:\s*=\s*(?:"([^"]*)"|'([^']*)'|([^\s"'=<>`]+)))?''',
    caseSensitive: false,
  ).allMatches(raw);
  for (final match in matches) {
    final key = (match.group(1) ?? '').trim();
    if (key.isEmpty) {
      continue;
    }
    final value = match.group(2) ?? match.group(3) ?? match.group(4) ?? 'true';
    attributes[key] = _decodeHtmlEntities(value);
  }
  return Map<String, String>.unmodifiable(attributes);
}

String? _extractHtmlAttribute(String raw, String name) {
  final match = RegExp(
    '''$name\\s*=\\s*("([^"]*)"|'([^']*)')''',
    caseSensitive: false,
  ).firstMatch(raw);
  return match?.group(2) ?? match?.group(3);
}

String? _extractLanguageFromCodeAttrs(String attrs) {
  final match = RegExp(
    r'''class\s*=\s*("([^"]*)"|'([^']*)')''',
    caseSensitive: false,
  ).firstMatch(attrs);
  final classes = match?.group(2) ?? match?.group(3);
  if (classes == null || classes.isEmpty) {
    return null;
  }
  for (final token in classes.split(RegExp(r'\s+'))) {
    final normalized = token.trim();
    if (normalized.startsWith('language-') && normalized.length > 9) {
      return normalized.substring(9);
    }
    if (normalized.startsWith('lang-') && normalized.length > 5) {
      return normalized.substring(5);
    }
  }
  return null;
}

String _normalizeHtmlBlockText(String value) {
  final text = _normalizeHtmlInline(
    value
        .replaceAll(
          RegExp(r'</?(p|div|section|article)\b[^>]*>', caseSensitive: false),
          '\n',
        )
        .replaceAll(RegExp(r'</li>', caseSensitive: false), '\n')
        .replaceAll(RegExp(r'<li\b[^>]*>', caseSensitive: false), '• '),
  );
  return text.replaceAll(RegExp(r'\n{3,}'), '\n\n').trim();
}

String _normalizeHtmlInline(String html) {
  var value = html;
  value = value.replaceAll(RegExp(r'<br\s*/?>', caseSensitive: false), '\n');
  value = value.replaceAllMapped(
    RegExp(
      r'''<a\b[^>]*href\s*=\s*["']([^"']+)["'][^>]*>([\s\S]*?)</a>''',
      caseSensitive: false,
    ),
    (match) {
      final href = _decodeHtmlEntities(match.group(1) ?? '');
      final label = _stripHtmlTags(match.group(2) ?? '').trim();
      if (href.isEmpty) {
        return label;
      }
      return '[${label.isEmpty ? href : label}]($href)';
    },
  );
  value = value.replaceAllMapped(
    RegExp(r'<(strong|b)>([\s\S]*?)</\1>', caseSensitive: false),
    (match) => '**${_stripHtmlTags(match.group(2) ?? '').trim()}**',
  );
  value = value.replaceAllMapped(
    RegExp(r'<(em|i)>([\s\S]*?)</\1>', caseSensitive: false),
    (match) => '*${_stripHtmlTags(match.group(2) ?? '').trim()}*',
  );
  value = value.replaceAllMapped(
    RegExp(r'<(del|s)>([\s\S]*?)</\1>', caseSensitive: false),
    (match) => '~~${_stripHtmlTags(match.group(2) ?? '').trim()}~~',
  );
  value = value.replaceAllMapped(
    RegExp(r'<code>([\s\S]*?)</code>', caseSensitive: false),
    (match) => '`${_stripHtmlTags(match.group(1) ?? '').trim()}`',
  );
  value = value.replaceAllMapped(
    RegExp(r'<kbd>([\s\S]*?)</kbd>', caseSensitive: false),
    (match) => '<kbd>${_stripHtmlTags(match.group(1) ?? '').trim()}</kbd>',
  );
  value = _stripHtmlTags(value);
  return _decodeHtmlEntities(value).trim();
}

(_MarkdownBlock, int)? _tryParseHtmlTable(List<String> lines, int index) {
  final start = lines[index].trimLeft().toLowerCase();
  if (!start.startsWith('<table')) {
    return null;
  }

  final buffer = <String>[lines[index]];
  var i = index + 1;
  while (i < lines.length) {
    buffer.add(lines[i]);
    if (lines[i].trim().toLowerCase().contains('</table>')) {
      i += 1;
      break;
    }
    i += 1;
  }

  final raw = buffer.join('\n');
  final table = _parseHtmlTable(raw);
  if (table != null) {
    return (table, i);
  }
  return (
    _MarkdownBlock(
      type: _MarkdownBlockType.rawHtml,
      text: raw,
      htmlTag: 'table',
      rawHtml: raw,
    ),
    i,
  );
}

_MarkdownBlock? _parseHtmlTable(String raw) {
  final rowMatches = RegExp(
    r'<tr\b[^>]*>([\s\S]*?)</tr>',
    caseSensitive: false,
  ).allMatches(raw);
  if (rowMatches.isEmpty) {
    return null;
  }

  final rows = <List<String>>[];
  var alignments = <TextAlign>[];

  for (final rowMatch in rowMatches) {
    final rowHtml = rowMatch.group(1) ?? '';
    final cells = _parseHtmlTableCells(rowHtml);
    if (cells.isEmpty) {
      continue;
    }

    rows.add(<String>[
      for (final cell in cells) _normalizeHtmlTableCell(cell.$3),
    ]);
    if (alignments.isEmpty) {
      alignments = <TextAlign>[
        for (final cell in cells) _alignmentFromHtmlAttributes(cell.$2),
      ];
    }
  }

  if (rows.isEmpty) {
    return null;
  }

  final maxColumns = rows.fold<int>(
    0,
    (max, row) => row.length > max ? row.length : max,
  );
  return _MarkdownBlock(
    type: _MarkdownBlockType.table,
    text: '',
    tableRows: [
      for (final row in rows)
        [
          for (var col = 0; col < maxColumns; col++)
            col < row.length ? row[col] : '',
        ],
    ],
    tableAlignments: [
      for (var col = 0; col < maxColumns; col++)
        col < alignments.length ? alignments[col] : TextAlign.left,
    ],
    htmlTag: 'table',
    rawHtml: raw,
  );
}

List<(String, String, String)> _parseHtmlTableCells(String rowHtml) {
  final matches = RegExp(
    r'<(th|td)\b([^>]*)>([\s\S]*?)</\1>',
    caseSensitive: false,
  ).allMatches(rowHtml);
  return <(String, String, String)>[
    for (final match in matches)
      (
        (match.group(1) ?? '').toLowerCase(),
        match.group(2) ?? '',
        match.group(3) ?? '',
      ),
  ];
}

TextAlign _alignmentFromHtmlAttributes(String attrs) {
  final alignMatch = RegExp(
    r'''align\s*=\s*["']?\s*(left|center|right)\s*["']?''',
    caseSensitive: false,
  ).firstMatch(attrs);
  if (alignMatch != null) {
    return _cssAlignToTextAlign(alignMatch.group(1) ?? '');
  }

  final styleMatch = RegExp(
    r'''text-align\s*:\s*(left|center|right)''',
    caseSensitive: false,
  ).firstMatch(attrs);
  if (styleMatch != null) {
    return _cssAlignToTextAlign(styleMatch.group(1) ?? '');
  }
  return TextAlign.left;
}

TextAlign _cssAlignToTextAlign(String value) {
  return switch (value.toLowerCase().trim()) {
    'center' => TextAlign.center,
    'right' => TextAlign.right,
    _ => TextAlign.left,
  };
}

String _normalizeHtmlTableCell(String html) {
  var value = html;
  value = value.replaceAll(RegExp(r'<br\s*/?>', caseSensitive: false), '\n');
  value = value.replaceAllMapped(
    RegExp(
      r'''<a\b[^>]*href\s*=\s*["']([^"']+)["'][^>]*>([\s\S]*?)</a>''',
      caseSensitive: false,
    ),
    (match) {
      final url = match.group(1) ?? '';
      final label = _stripHtmlTags(match.group(2) ?? '').trim();
      if (url.isEmpty) {
        return label;
      }
      return '[${label.isEmpty ? url : label}]($url)';
    },
  );
  value = value.replaceAllMapped(
    RegExp(r'<(strong|b)>([\s\S]*?)</\1>', caseSensitive: false),
    (match) => '**${_stripHtmlTags(match.group(2) ?? '').trim()}**',
  );
  value = value.replaceAllMapped(
    RegExp(r'<(em|i)>([\s\S]*?)</\1>', caseSensitive: false),
    (match) => '*${_stripHtmlTags(match.group(2) ?? '').trim()}*',
  );
  value = value.replaceAllMapped(
    RegExp(r'<code>([\s\S]*?)</code>', caseSensitive: false),
    (match) => '`${_stripHtmlTags(match.group(1) ?? '').trim()}`',
  );
  value = _stripHtmlTags(value);
  return _decodeHtmlEntities(value).trim();
}

String _stripHtmlTags(String value) {
  return value.replaceAll(RegExp(r'<[^>]+>'), '');
}

(_MarkdownBlock, int)? _tryParseQuote(List<String> lines, int index) {
  if (!_isQuoteLine(lines[index].trimRight())) {
    return null;
  }
  final buffer = <String>[];
  var i = index;
  while (i < lines.length && _isQuoteLine(lines[i].trimRight())) {
    buffer.add(lines[i].trimRight().replaceFirst(RegExp(r'^\s*>\s?'), ''));
    i += 1;
  }
  return (
    _MarkdownBlock(type: _MarkdownBlockType.quote, text: buffer.join('\n')),
    i,
  );
}

(_MarkdownBlock, int)? _tryParseDefinitionList(List<String> lines, int index) {
  if (index + 1 >= lines.length || lines[index].trim().isEmpty) {
    return null;
  }
  if (!lines[index + 1].trimLeft().startsWith(':')) {
    return null;
  }

  final term = lines[index].trim();
  final definitions = <String>[];
  var i = index + 1;
  while (i < lines.length && lines[i].trimLeft().startsWith(':')) {
    definitions.add(lines[i].trimLeft().substring(1).trim());
    i += 1;
  }

  return (
    _MarkdownBlock(
      type: _MarkdownBlockType.definitionList,
      text: term,
      items: definitions,
    ),
    i,
  );
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
  if (_parseTableRow(first).length < 2) {
    return false;
  }
  return _isTableSeparatorLine(second);
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

  final cells = <String>[];
  final buffer = StringBuffer();
  var escaped = false;
  for (var i = 0; i < content.length; i++) {
    final char = content[i];
    if (escaped) {
      buffer.write(char);
      escaped = false;
      continue;
    }
    if (char == r'\') {
      escaped = true;
      continue;
    }
    if (char == '|') {
      cells.add(buffer.toString().trim());
      buffer.clear();
      continue;
    }
    buffer.write(char);
  }
  cells.add(buffer.toString().trim());
  return cells;
}

List<TextAlign> _tableAlignments(String separatorLine) {
  final cells = _parseTableRow(separatorLine);
  return <TextAlign>[for (final cell in cells) _tableAlignment(cell)];
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

bool _isTableSeparatorLine(String line) {
  final cells = _parseTableRow(line);
  if (cells.length < 2) {
    return false;
  }
  for (final cell in cells) {
    final normalized = cell.replaceAll(' ', '');
    if (!RegExp(r'^:?-{2,}:?$').hasMatch(normalized)) {
      return false;
    }
  }
  return true;
}

(String, String, String?)? _tryParseImageSyntax(String input) {
  final match = RegExp(
    r'''^!\[([^\]]*)\]\((\S+?)(?:\s+(?:"([^"]+)"|'([^']+)'))?\)\s*$''',
  ).firstMatch(input);
  if (match == null) {
    return null;
  }
  return (
    match.group(1) ?? '',
    match.group(2)!,
    match.group(3) ?? match.group(4),
  );
}

String _normalizeReferenceKey(String value) {
  return value.trim().toLowerCase();
}

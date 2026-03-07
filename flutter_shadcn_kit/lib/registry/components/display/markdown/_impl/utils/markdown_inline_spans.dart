part of '../../markdown.dart';

List<InlineSpan> _buildInlineSpans(
  BuildContext context,
  String text,
  TextStyle baseStyle, {
  MarkdownTapLinkCallback? onTapLink,
}) {
  final spans = <InlineSpan>[];
  final pattern = RegExp(
    r'\[([^\]]+)\]\(([^)]+)\)|`([^`]+)`|\*\*\*([^*]+)\*\*\*|\*\*([^*]+)\*\*|__([^_]+)__|~~([^~]+)~~|\*([^*]+)\*|_([^_]+)_|(https?:\/\/[^\s]+)',
  );

  var cursor = 0;
  for (final match in pattern.allMatches(text)) {
    if (match.start > cursor) {
      spans.add(TextSpan(text: text.substring(cursor, match.start)));
    }

    if (match.group(1) != null && match.group(2) != null) {
      final label = match.group(1)!;
      final url = match.group(2)!;
      spans.add(_buildLinkSpan(baseStyle, label, url, onTapLink));
    } else if (match.group(3) != null) {
      spans.add(
        TextSpan(
          text: match.group(3),
          style: baseStyle.copyWith(fontFamily: 'GeistMono'),
        ),
      );
    } else if (match.group(4) != null) {
      spans.add(
        TextSpan(
          text: match.group(4),
          style: baseStyle.copyWith(
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.italic,
          ),
        ),
      );
    } else if (match.group(5) != null || match.group(6) != null) {
      spans.add(
        TextSpan(
          text: match.group(5) ?? match.group(6),
          style: baseStyle.copyWith(fontWeight: FontWeight.w700),
        ),
      );
    } else if (match.group(7) != null) {
      spans.add(
        TextSpan(
          text: match.group(7),
          style: baseStyle.copyWith(decoration: TextDecoration.lineThrough),
        ),
      );
    } else if (match.group(8) != null || match.group(9) != null) {
      spans.add(
        TextSpan(
          text: match.group(8) ?? match.group(9),
          style: baseStyle.copyWith(fontStyle: FontStyle.italic),
        ),
      );
    } else if (match.group(10) != null) {
      final url = match.group(10)!;
      spans.add(_buildLinkSpan(baseStyle, url, url, onTapLink));
    }

    cursor = match.end;
  }

  if (cursor < text.length) {
    spans.add(TextSpan(text: text.substring(cursor)));
  }

  return spans;
}

InlineSpan _buildLinkSpan(
  TextStyle baseStyle,
  String label,
  String url,
  MarkdownTapLinkCallback? onTapLink,
) {
  final linkStyle = baseStyle.copyWith(
    color: const Color(0xFF2F6FEB),
    decoration: TextDecoration.underline,
  );

  if (onTapLink == null) {
    return TextSpan(text: label, style: linkStyle);
  }

  return WidgetSpan(
    alignment: PlaceholderAlignment.baseline,
    baseline: TextBaseline.alphabetic,
    child: GestureDetector(
      onTap: () => onTapLink(label, url),
      child: Text(label, style: linkStyle),
    ),
  );
}

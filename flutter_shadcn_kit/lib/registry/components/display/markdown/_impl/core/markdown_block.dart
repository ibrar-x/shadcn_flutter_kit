part of '../../markdown.dart';

@immutable
class _MarkdownBlock {
  const _MarkdownBlock({
    required this.type,
    required this.text,
    this.orderedIndex = 1,
    this.indentLevel = 0,
    this.checked,
    this.language,
    this.tableRows = const <List<String>>[],
    this.tableAlignments = const <TextAlign>[],
    this.imageAlt,
    this.imageUrl,
  });

  final _MarkdownBlockType type;
  final String text;
  final int orderedIndex;
  final int indentLevel;
  final bool? checked;
  final String? language;
  final List<List<String>> tableRows;
  final List<TextAlign> tableAlignments;
  final String? imageAlt;
  final String? imageUrl;
}

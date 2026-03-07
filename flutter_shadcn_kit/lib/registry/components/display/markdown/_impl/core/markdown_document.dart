part of '../../markdown.dart';

@immutable
class _MarkdownDocument {
  const _MarkdownDocument({
    required this.blocks,
    this.references = const <String, _MarkdownLinkTarget>{},
    this.footnotes = const <String, String>{},
  });

  final List<_MarkdownBlock> blocks;
  final Map<String, _MarkdownLinkTarget> references;
  final Map<String, String> footnotes;
}

@immutable
class _MarkdownLinkTarget {
  const _MarkdownLinkTarget({required this.url, this.title});

  final String url;
  final String? title;
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../shared/theme/theme.dart';
import '../../../shared/utils/style_value.dart';
import '_impl/utils/markdown_file_loader.dart';
import '_impl/utils/markdown_link_opener.dart';

part '_impl/core/markdown_block_type.dart';
part '_impl/core/markdown_block.dart';
part '_impl/core/markdown_document.dart';
part '_impl/core/markdown_disclosure.dart';
part '_impl/themes/base/markdown_theme.dart';
part '_impl/utils/markdown_inline_spans.dart';
part '_impl/utils/markdown_parser.dart';

/// Link callback for markdown links: [label](url)
typedef MarkdownTapLinkCallback = void Function(String text, String url);

enum MarkdownSourceType { text, asset, file }

int computeStableMarkdownPrefixLength(String data) {
  return _computeStableMarkdownPrefixLength(data);
}

/// Lightweight markdown renderer with no external markdown package dependency.
class Markdown extends StatefulWidget {
  const Markdown({
    super.key,
    required this.data,
    this.selectable = true,
    this.style,
    this.onTapLink,
    this.shrinkWrap = true,
    this.followLinks = true,
    this.imageBuilder,
    this.loading,
    this.errorBuilder,
  }) : sourceType = MarkdownSourceType.text,
       sourcePath = null;

  const Markdown.asset({
    super.key,
    required String asset,
    this.selectable = true,
    this.style,
    this.onTapLink,
    this.shrinkWrap = true,
    this.followLinks = true,
    this.imageBuilder,
    this.loading,
    this.errorBuilder,
  }) : data = '',
       sourceType = MarkdownSourceType.asset,
       sourcePath = asset;

  const Markdown.file({
    super.key,
    required String path,
    this.selectable = true,
    this.style,
    this.onTapLink,
    this.shrinkWrap = true,
    this.followLinks = true,
    this.imageBuilder,
    this.loading,
    this.errorBuilder,
  }) : data = '',
       sourceType = MarkdownSourceType.file,
       sourcePath = path;

  final String data;
  final bool selectable;
  final TextStyle? style;
  final MarkdownTapLinkCallback? onTapLink;
  final bool shrinkWrap;
  final bool followLinks;
  final MarkdownSourceType sourceType;
  final String? sourcePath;
  final Widget Function(BuildContext context, String url, String alt)?
  imageBuilder;
  final Widget? loading;
  final Widget Function(BuildContext context, Object error)? errorBuilder;

  Markdown copyWith({
    String? data,
    bool? selectable,
    TextStyle? style,
    MarkdownTapLinkCallback? onTapLink,
    bool? shrinkWrap,
    bool? followLinks,
    Widget Function(BuildContext context, String url, String alt)? imageBuilder,
    Widget? loading,
    Widget Function(BuildContext context, Object error)? errorBuilder,
  }) {
    return switch (sourceType) {
      MarkdownSourceType.text => Markdown(
        key: key,
        data: data ?? this.data,
        selectable: selectable ?? this.selectable,
        style: style ?? this.style,
        onTapLink: onTapLink ?? this.onTapLink,
        shrinkWrap: shrinkWrap ?? this.shrinkWrap,
        followLinks: followLinks ?? this.followLinks,
        imageBuilder: imageBuilder ?? this.imageBuilder,
        loading: loading ?? this.loading,
        errorBuilder: errorBuilder ?? this.errorBuilder,
      ),
      MarkdownSourceType.asset => Markdown.asset(
        key: key,
        asset: sourcePath ?? '',
        selectable: selectable ?? this.selectable,
        style: style ?? this.style,
        onTapLink: onTapLink ?? this.onTapLink,
        shrinkWrap: shrinkWrap ?? this.shrinkWrap,
        followLinks: followLinks ?? this.followLinks,
        imageBuilder: imageBuilder ?? this.imageBuilder,
        loading: loading ?? this.loading,
        errorBuilder: errorBuilder ?? this.errorBuilder,
      )._copyToTextIfRequested(data),
      MarkdownSourceType.file => Markdown.file(
        key: key,
        path: sourcePath ?? '',
        selectable: selectable ?? this.selectable,
        style: style ?? this.style,
        onTapLink: onTapLink ?? this.onTapLink,
        shrinkWrap: shrinkWrap ?? this.shrinkWrap,
        followLinks: followLinks ?? this.followLinks,
        imageBuilder: imageBuilder ?? this.imageBuilder,
        loading: loading ?? this.loading,
        errorBuilder: errorBuilder ?? this.errorBuilder,
      )._copyToTextIfRequested(data),
    };
  }

  @override
  State<Markdown> createState() => _MarkdownState();
}

extension on Markdown {
  Markdown _copyToTextIfRequested(String? nextData) {
    if (nextData == null) {
      return this;
    }
    return Markdown(
      key: key,
      data: nextData,
      selectable: selectable,
      style: style,
      onTapLink: onTapLink,
      shrinkWrap: shrinkWrap,
      followLinks: followLinks,
      imageBuilder: imageBuilder,
      loading: loading,
      errorBuilder: errorBuilder,
    );
  }
}

class _MarkdownState extends State<Markdown> {
  static final Set<String> _failedNetworkImageUrls = <String>{};

  String _resolvedData = '';
  Object? _error;
  bool _loading = false;
  String? _cachedDocumentSource;
  _MarkdownDocument? _cachedDocument;

  @override
  void initState() {
    super.initState();
    _loadSource();
  }

  @override
  void didUpdateWidget(covariant Markdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.data != widget.data ||
        oldWidget.sourcePath != widget.sourcePath ||
        oldWidget.sourceType != widget.sourceType) {
      _loadSource();
    }
  }

  Future<void> _loadSource() async {
    final sourceType = widget.sourceType;
    if (sourceType == MarkdownSourceType.text) {
      setState(() {
        _loading = false;
        _error = null;
        _resolvedData = widget.data;
        _cachedDocumentSource = null;
        _cachedDocument = null;
      });
      return;
    }

    final path = widget.sourcePath;
    if (path == null || path.isEmpty) {
      setState(() {
        _loading = false;
        _error = StateError('Markdown source path cannot be empty.');
        _resolvedData = '';
        _cachedDocumentSource = null;
        _cachedDocument = null;
      });
      return;
    }

    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final loaded = switch (sourceType) {
        MarkdownSourceType.asset => await rootBundle.loadString(path),
        MarkdownSourceType.file => await loadMarkdownFile(path),
        MarkdownSourceType.text => widget.data,
      };
      if (!mounted) {
        return;
      }
      setState(() {
        _loading = false;
        _error = null;
        _resolvedData = loaded;
        _cachedDocumentSource = null;
        _cachedDocument = null;
      });
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _loading = false;
        _error = error;
        _resolvedData = '';
        _cachedDocumentSource = null;
        _cachedDocument = null;
      });
    }
  }

  _MarkdownDocument _resolveDocument() {
    if (_cachedDocumentSource == _resolvedData && _cachedDocument != null) {
      return _cachedDocument!;
    }
    final parsed = _parseMarkdownDocument(_resolvedData);
    _cachedDocumentSource = _resolvedData;
    _cachedDocument = parsed;
    return parsed;
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return widget.loading ??
          const Center(child: CircularProgressIndicator(strokeWidth: 2));
    }

    final error = _error;
    if (error != null) {
      if (widget.errorBuilder != null) {
        return widget.errorBuilder!(context, error);
      }
      return Text(
        'Failed to load markdown: $error',
        style: DefaultTextStyle.of(
          context,
        ).style.copyWith(color: Colors.red.shade400),
      );
    }

    final markdownTheme = ComponentTheme.maybeOf<MarkdownTheme>(context);
    final baseStyle = styleValue<TextStyle>(
      widgetValue: widget.style,
      themeValue: markdownTheme?.style,
      defaultValue: DefaultTextStyle.of(context).style,
    );
    final document = _resolveDocument();
    final blocks = document.blocks;

    if (blocks.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      mainAxisSize: widget.shrinkWrap ? MainAxisSize.min : MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final block in blocks)
          _buildBlock(context, block, baseStyle, document, markdownTheme),
      ],
    );
  }

  Widget _buildBlock(
    BuildContext context,
    _MarkdownBlock block,
    TextStyle baseStyle,
    _MarkdownDocument document,
    MarkdownTheme? markdownTheme,
  ) {
    final linkStyle = markdownTheme?.linkStyle;
    final rich = TextSpan(
      style: baseStyle,
      children: _buildInlineSpans(
        context,
        block.text,
        baseStyle,
        document,
        onTapLink: widget.onTapLink,
        followLinks: widget.followLinks,
        linkStyle: linkStyle,
      ),
    );

    final mono = styleValue<TextStyle>(
      widgetValue: null,
      themeValue: markdownTheme?.codeStyle,
      defaultValue: baseStyle.copyWith(fontFamily: 'GeistMono', height: 1.45),
    );

    final headingScale = switch (block.type) {
      _MarkdownBlockType.heading1 => 1.75,
      _MarkdownBlockType.heading2 => 1.45,
      _MarkdownBlockType.heading3 => 1.25,
      _MarkdownBlockType.heading4 => 1.15,
      _MarkdownBlockType.heading5 => 1.05,
      _MarkdownBlockType.heading6 => 1.0,
      _ => 1.0,
    };

    final headingStyle = switch (block.type) {
      _MarkdownBlockType.heading1 => markdownTheme?.heading1Style,
      _MarkdownBlockType.heading2 => markdownTheme?.heading2Style,
      _MarkdownBlockType.heading3 => markdownTheme?.heading3Style,
      _MarkdownBlockType.heading4 => markdownTheme?.heading4Style,
      _MarkdownBlockType.heading5 => markdownTheme?.heading5Style,
      _MarkdownBlockType.heading6 => markdownTheme?.heading6Style,
      _ => null,
    };

    Widget child;
    switch (block.type) {
      case _MarkdownBlockType.codeFence:
      case _MarkdownBlockType.indentedCode:
        child = Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 6),
          padding: markdownTheme?.codePadding ?? const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color:
                markdownTheme?.codeBackgroundColor ?? const Color(0x11000000),
            borderRadius:
                markdownTheme?.codeRadius ?? BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if ((block.language ?? '').isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    block.language!,
                    style: styleValue<TextStyle>(
                      widgetValue: null,
                      themeValue: markdownTheme?.codeLanguageStyle,
                      defaultValue: mono.copyWith(
                        fontSize: (mono.fontSize ?? 14) * 0.85,
                        color: baseStyle.color?.withValues(alpha: 0.65),
                      ),
                    ),
                  ),
                ),
              widget.selectable
                  ? SelectableText(block.text, style: mono)
                  : Text(block.text, style: mono),
            ],
          ),
        );
      case _MarkdownBlockType.unorderedList:
      case _MarkdownBlockType.orderedList:
      case _MarkdownBlockType.taskList:
        child = Padding(
          padding: EdgeInsets.only(
            left: 8 + (block.indentLevel * (markdownTheme?.listIndent ?? 18)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text(switch (block.type) {
                  _MarkdownBlockType.unorderedList => '• ',
                  _MarkdownBlockType.orderedList => '${block.orderedIndex}. ',
                  _MarkdownBlockType.taskList =>
                    block.checked == true ? '☑ ' : '☐ ',
                  _ => '',
                }, style: baseStyle),
              ),
              Expanded(
                child: widget.selectable
                    ? SelectableText.rich(rich)
                    : RichText(text: rich),
              ),
            ],
          ),
        );
      case _MarkdownBlockType.quote:
        child = Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding:
              markdownTheme?.quotePadding ??
              const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: markdownTheme?.quoteBackgroundColor,
            border: Border(
              left: BorderSide(
                color:
                    markdownTheme?.quoteBorderColor ??
                    baseStyle.color?.withValues(alpha: 0.45) ??
                    const Color(0x66000000),
                width: markdownTheme?.quoteBorderWidth ?? 3,
              ),
            ),
          ),
          child: Markdown(
            data: block.text,
            selectable: widget.selectable,
            style: markdownTheme?.quoteStyle ?? baseStyle,
            onTapLink: widget.onTapLink,
            shrinkWrap: true,
            followLinks: widget.followLinks,
            imageBuilder: widget.imageBuilder,
          ),
        );
      case _MarkdownBlockType.horizontalRule:
        child = Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Divider(height: 1, color: markdownTheme?.horizontalRuleColor),
        );
      case _MarkdownBlockType.table:
        child = _buildTable(context, block, baseStyle, document, markdownTheme);
      case _MarkdownBlockType.image:
        child = _buildImage(context, block, baseStyle, markdownTheme);
      case _MarkdownBlockType.definitionList:
        child = _buildDefinitionList(
          context,
          block,
          baseStyle,
          document,
          markdownTheme,
        );
      case _MarkdownBlockType.details:
        child = _MarkdownDisclosure(
          summary: block.text,
          summaryStyle:
              markdownTheme?.detailsSummaryStyle ??
              baseStyle.copyWith(fontWeight: FontWeight.w600),
          decoration: BoxDecoration(
            border: Border.all(
              color:
                  markdownTheme?.detailsBorderColor ?? const Color(0x22000000),
            ),
            color: markdownTheme?.detailsBackgroundColor,
            borderRadius:
                markdownTheme?.detailsRadius ?? BorderRadius.circular(10),
          ),
          headerPadding:
              markdownTheme?.detailsHeaderPadding ??
              const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          bodyPadding:
              markdownTheme?.detailsBodyPadding ??
              const EdgeInsets.fromLTRB(12, 0, 12, 12),
          child: Markdown(
            data: block.items.isEmpty ? '' : block.items.first,
            selectable: widget.selectable,
            style: baseStyle,
            onTapLink: widget.onTapLink,
            shrinkWrap: true,
            followLinks: widget.followLinks,
            imageBuilder: widget.imageBuilder,
          ),
        );
      case _MarkdownBlockType.math:
        child = _buildMathBlock(block, mono, markdownTheme);
      case _MarkdownBlockType.footnote:
        child = _buildFootnote(
          context,
          block,
          baseStyle,
          document,
          markdownTheme,
        );
      case _MarkdownBlockType.rawHtml:
        child = widget.selectable
            ? SelectableText.rich(
                TextSpan(
                  style: baseStyle,
                  children: _buildInlineSpans(
                    context,
                    _htmlToInlineText(block.text),
                    baseStyle,
                    document,
                    onTapLink: widget.onTapLink,
                    followLinks: widget.followLinks,
                    linkStyle: linkStyle,
                  ),
                ),
              )
            : RichText(
                text: TextSpan(
                  style: baseStyle,
                  children: _buildInlineSpans(
                    context,
                    _htmlToInlineText(block.text),
                    baseStyle,
                    document,
                    onTapLink: widget.onTapLink,
                    followLinks: widget.followLinks,
                    linkStyle: linkStyle,
                  ),
                ),
              );
      default:
        final resolvedHeadingStyle = styleValue<TextStyle>(
          widgetValue: null,
          themeValue: headingStyle,
          defaultValue: baseStyle.copyWith(
            fontWeight: block.type.index <= _MarkdownBlockType.heading6.index
                ? FontWeight.w700
                : FontWeight.w400,
            fontSize: (baseStyle.fontSize ?? 14) * headingScale,
            height: 1.35,
          ),
        );
        child = widget.selectable
            ? SelectableText.rich(rich, style: resolvedHeadingStyle)
            : RichText(
                text: TextSpan(
                  style: resolvedHeadingStyle,
                  children: rich.children,
                ),
              );
    }

    return Padding(
      padding: EdgeInsets.only(
        bottom: block.type == _MarkdownBlockType.blank
            ? 8
            : (markdownTheme?.blockSpacing ?? 6),
      ),
      child: child,
    );
  }

  Widget _buildTable(
    BuildContext context,
    _MarkdownBlock block,
    TextStyle baseStyle,
    _MarkdownDocument document,
    MarkdownTheme? markdownTheme,
  ) {
    final rows = block.tableRows;
    if (rows.isEmpty) {
      return const SizedBox.shrink();
    }

    final headerStyle = styleValue<TextStyle>(
      widgetValue: null,
      themeValue: markdownTheme?.tableHeaderStyle,
      defaultValue: baseStyle.copyWith(fontWeight: FontWeight.w700),
    );
    final cellStyle = styleValue<TextStyle>(
      widgetValue: null,
      themeValue: markdownTheme?.tableCellStyle,
      defaultValue: baseStyle,
    );
    final borderColor =
        markdownTheme?.tableBorderColor ?? const Color(0x22000000);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: markdownTheme?.tableRadius ?? BorderRadius.circular(10),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          border: TableBorder(
            horizontalInside: BorderSide(color: borderColor),
            verticalInside: BorderSide(color: borderColor),
          ),
          children: [
            for (var rowIndex = 0; rowIndex < rows.length; rowIndex++)
              TableRow(
                decoration: BoxDecoration(
                  color: rowIndex == 0
                      ? (markdownTheme?.tableHeaderBackgroundColor ??
                            const Color(0x11000000))
                      : Colors.transparent,
                ),
                children: [
                  for (
                    var colIndex = 0;
                    colIndex < rows[rowIndex].length;
                    colIndex++
                  )
                    Padding(
                      padding:
                          markdownTheme?.tableCellPadding ??
                          const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                      child: RichText(
                        textAlign: colIndex < block.tableAlignments.length
                            ? block.tableAlignments[colIndex]
                            : TextAlign.left,
                        text: TextSpan(
                          style: rowIndex == 0 ? headerStyle : cellStyle,
                          children: _buildInlineSpans(
                            context,
                            rows[rowIndex][colIndex],
                            rowIndex == 0 ? headerStyle : cellStyle,
                            document,
                            onTapLink: widget.onTapLink,
                            followLinks: widget.followLinks,
                            linkStyle: markdownTheme?.linkStyle,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(
    BuildContext context,
    _MarkdownBlock block,
    TextStyle baseStyle,
    MarkdownTheme? markdownTheme,
  ) {
    final imageUrl = block.imageUrl ?? '';
    if (imageUrl.isEmpty) {
      return const SizedBox.shrink();
    }

    final alt = block.imageAlt ?? '';
    if (widget.imageBuilder != null) {
      return widget.imageBuilder!(context, imageUrl, alt);
    }

    final normalized = imageUrl.trim();
    Widget image;
    if (normalized.startsWith('http://') || normalized.startsWith('https://')) {
      if (_failedNetworkImageUrls.contains(normalized)) {
        image = _buildImageFallback(
          baseStyle,
          alt.isNotEmpty ? alt : 'Image failed to load: $normalized',
        );
      } else {
        image = Image.network(
          normalized,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            _failedNetworkImageUrls.add(normalized);
            return _buildImageFallback(
              baseStyle,
              alt.isNotEmpty ? alt : 'Image failed to load',
            );
          },
        );
      }
    } else {
      final assetPath = normalized.startsWith('asset:')
          ? normalized.substring(6)
          : normalized;
      image = Image.asset(
        assetPath,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) =>
            _buildImageFallback(baseStyle, alt.isNotEmpty ? alt : assetPath),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      constraints: BoxConstraints(
        maxHeight: markdownTheme?.imageMaxHeight ?? 280,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(borderRadius: BorderRadius.circular(10), child: image),
          if (alt.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                block.imageTitle?.isNotEmpty == true
                    ? '$alt • ${block.imageTitle}'
                    : alt,
                style: styleValue<TextStyle>(
                  widgetValue: null,
                  themeValue: markdownTheme?.imageCaptionStyle,
                  defaultValue: baseStyle.copyWith(
                    fontSize: (baseStyle.fontSize ?? 14) * 0.9,
                    color: baseStyle.color?.withValues(alpha: 0.75),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildImageFallback(TextStyle baseStyle, String message) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0x22000000)),
        color: const Color(0x08000000),
      ),
      child: Text(
        message,
        style: baseStyle.copyWith(
          fontSize: (baseStyle.fontSize ?? 14) * 0.9,
          color: baseStyle.color?.withValues(alpha: 0.72),
        ),
      ),
    );
  }

  Widget _buildDefinitionList(
    BuildContext context,
    _MarkdownBlock block,
    TextStyle baseStyle,
    _MarkdownDocument document,
    MarkdownTheme? markdownTheme,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            block.text,
            style: baseStyle.copyWith(fontWeight: FontWeight.w700),
          ),
          for (final item in block.items)
            Padding(
              padding: const EdgeInsets.only(left: 14, top: 4),
              child: widget.selectable
                  ? SelectableText.rich(
                      TextSpan(
                        style: baseStyle,
                        children: _buildInlineSpans(
                          context,
                          item,
                          baseStyle,
                          document,
                          onTapLink: widget.onTapLink,
                          followLinks: widget.followLinks,
                          linkStyle: markdownTheme?.linkStyle,
                        ),
                      ),
                    )
                  : RichText(
                      text: TextSpan(
                        style: baseStyle,
                        children: _buildInlineSpans(
                          context,
                          item,
                          baseStyle,
                          document,
                          onTapLink: widget.onTapLink,
                          followLinks: widget.followLinks,
                          linkStyle: markdownTheme?.linkStyle,
                        ),
                      ),
                    ),
            ),
        ],
      ),
    );
  }

  Widget _buildMathBlock(
    _MarkdownBlock block,
    TextStyle mono,
    MarkdownTheme? markdownTheme,
  ) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: markdownTheme?.codePadding ?? const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: markdownTheme?.codeBackgroundColor ?? const Color(0x11000000),
        borderRadius: markdownTheme?.codeRadius ?? BorderRadius.circular(10),
      ),
      child: Text(
        block.text,
        style: styleValue<TextStyle>(
          widgetValue: null,
          themeValue: markdownTheme?.mathStyle,
          defaultValue: mono.copyWith(fontStyle: FontStyle.italic),
        ),
      ),
    );
  }

  Widget _buildFootnote(
    BuildContext context,
    _MarkdownBlock block,
    TextStyle baseStyle,
    _MarkdownDocument document,
    MarkdownTheme? markdownTheme,
  ) {
    final labelStyle = styleValue<TextStyle>(
      widgetValue: null,
      themeValue: markdownTheme?.footnoteLabelStyle,
      defaultValue: baseStyle.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: (baseStyle.fontSize ?? 14) * 0.9,
      ),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('[${block.label}] ', style: labelStyle),
          Expanded(
            child: widget.selectable
                ? SelectableText.rich(
                    TextSpan(
                      style: baseStyle,
                      children: _buildInlineSpans(
                        context,
                        block.text,
                        baseStyle,
                        document,
                        onTapLink: widget.onTapLink,
                        followLinks: widget.followLinks,
                        linkStyle: markdownTheme?.linkStyle,
                      ),
                    ),
                  )
                : RichText(
                    text: TextSpan(
                      style: baseStyle,
                      children: _buildInlineSpans(
                        context,
                        block.text,
                        baseStyle,
                        document,
                        onTapLink: widget.onTapLink,
                        followLinks: widget.followLinks,
                        linkStyle: markdownTheme?.linkStyle,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  String _htmlToInlineText(String value) {
    return value
        .replaceAll(
          RegExp(r'</?(div|p|details|summary)>', caseSensitive: false),
          '',
        )
        .replaceAll(RegExp(r'<br\s*/?>', caseSensitive: false), '\n')
        .trim();
  }
}

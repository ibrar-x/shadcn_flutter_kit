import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../shared/theme/theme.dart';
import '../../../shared/utils/style_value.dart';
import '_impl/utils/markdown_file_loader.dart';
import '_impl/utils/markdown_link_opener.dart';

part '_impl/core/markdown_block_type.dart';
part '_impl/core/markdown_block.dart';
part '_impl/core/markdown_chunk.dart';
part '_impl/core/markdown_document.dart';
part '_impl/core/markdown_disclosure.dart';
part '_impl/themes/base/markdown_theme.dart';
part '_impl/utils/markdown_inline_spans.dart';
part '_impl/utils/markdown_parser.dart';

/// Link callback for markdown links: [label](url)
typedef MarkdownTapLinkCallback = void Function(String text, String url);
typedef MarkdownTapLinkDetailsCallback =
    void Function(MarkdownLinkTapDetails details);
typedef MarkdownTapImageCallback =
    void Function(MarkdownImageTapDetails details);
typedef MarkdownTapHeadingCallback =
    void Function(MarkdownHeadingTapDetails details);
typedef MarkdownTapElementCallback =
    void Function(MarkdownTapElementDetails details);
typedef MarkdownBlockBuilder =
    Widget? Function(BuildContext context, MarkdownBlockBuildDetails details);
typedef MarkdownDocumentReadyCallback =
    void Function(MarkdownDocumentMetrics metrics);

enum MarkdownLinkKind { anchor, email, external, relative }

enum MarkdownBlockKind {
  blank,
  paragraph,
  heading,
  unorderedList,
  orderedList,
  taskList,
  quote,
  codeBlock,
  table,
  image,
  definitionList,
  details,
  math,
  footnote,
  rawHtml,
  horizontalRule,
}

enum MarkdownTapElementKind {
  paragraph,
  heading,
  listItem,
  quote,
  codeBlock,
  tableHeaderCell,
  tableCell,
  image,
  definitionTerm,
  definitionDescription,
  detailsSummary,
  math,
  footnote,
  rawHtml,
  horizontalRule,
  link,
}

@immutable
class MarkdownLinkTapDetails {
  const MarkdownLinkTapDetails({
    required this.text,
    required this.url,
    required this.kind,
  });

  final String text;
  final String url;
  final MarkdownLinkKind kind;

  bool get isAnchor => kind == MarkdownLinkKind.anchor;
  bool get isEmail => kind == MarkdownLinkKind.email;
  bool get isExternal => kind == MarkdownLinkKind.external;
  bool get isRelative => kind == MarkdownLinkKind.relative;
}

@immutable
class MarkdownImageTapDetails {
  const MarkdownImageTapDetails({
    required this.url,
    required this.alt,
    this.title,
  });

  final String url;
  final String alt;
  final String? title;
}

@immutable
class MarkdownHeadingTapDetails {
  const MarkdownHeadingTapDetails({
    required this.text,
    required this.anchor,
    required this.level,
  });

  final String text;
  final String anchor;
  final int level;
}

@immutable
class MarkdownTapElementDetails {
  const MarkdownTapElementDetails({
    required this.kind,
    required this.text,
    this.url,
    this.title,
    this.anchor,
    this.headingLevel,
    this.blockIndex,
    this.tableRow,
    this.tableColumn,
    this.orderedIndex,
    this.checked,
  });

  final MarkdownTapElementKind kind;
  final String text;
  final String? url;
  final String? title;
  final String? anchor;
  final int? headingLevel;
  final int? blockIndex;
  final int? tableRow;
  final int? tableColumn;
  final int? orderedIndex;
  final bool? checked;

  bool get isTableCell =>
      kind == MarkdownTapElementKind.tableCell ||
      kind == MarkdownTapElementKind.tableHeaderCell;
}

@immutable
class MarkdownBlockBuildDetails {
  const MarkdownBlockBuildDetails({
    required this.kind,
    required this.text,
    required this.blockIndex,
    required this.buildDefault,
    this.headingLevel,
    this.headingAnchor,
    this.language,
    this.orderedIndex,
    this.checked,
    this.tableRows = const <List<String>>[],
    this.tableAlignments = const <TextAlign>[],
    this.imageUrl,
    this.imageAlt,
    this.imageTitle,
    this.label,
    this.items = const <String>[],
    this.htmlTag,
    this.htmlAttributes = const <String, String>{},
    this.rawHtml,
  });

  final MarkdownBlockKind kind;
  final String text;
  final int blockIndex;
  final Widget Function() buildDefault;
  final int? headingLevel;
  final String? headingAnchor;
  final String? language;
  final int? orderedIndex;
  final bool? checked;
  final List<List<String>> tableRows;
  final List<TextAlign> tableAlignments;
  final String? imageUrl;
  final String? imageAlt;
  final String? imageTitle;
  final String? label;
  final List<String> items;
  final String? htmlTag;
  final Map<String, String> htmlAttributes;
  final String? rawHtml;

  bool get isHtmlBlock => htmlTag != null;
}

@immutable
class MarkdownDocumentMetrics {
  const MarkdownDocumentMetrics({
    required this.blockCount,
    required this.chunkCount,
    required this.headingCount,
    required this.imageCount,
    required this.tableCount,
  });

  final int blockCount;
  final int chunkCount;
  final int headingCount;
  final int imageCount;
  final int tableCount;
}

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
    this.onTapLinkDetails,
    this.onTapImage,
    this.onTapHeading,
    this.onTapElement,
    this.blockBuilder,
    this.onDocumentReady,
    this.viewportStorageId,
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
    this.onTapLinkDetails,
    this.onTapImage,
    this.onTapHeading,
    this.onTapElement,
    this.blockBuilder,
    this.onDocumentReady,
    this.viewportStorageId,
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
    this.onTapLinkDetails,
    this.onTapImage,
    this.onTapHeading,
    this.onTapElement,
    this.blockBuilder,
    this.onDocumentReady,
    this.viewportStorageId,
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
  final MarkdownTapLinkDetailsCallback? onTapLinkDetails;
  final MarkdownTapImageCallback? onTapImage;
  final MarkdownTapHeadingCallback? onTapHeading;
  final MarkdownTapElementCallback? onTapElement;
  final MarkdownBlockBuilder? blockBuilder;
  final MarkdownDocumentReadyCallback? onDocumentReady;
  final Object? viewportStorageId;
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
    MarkdownTapLinkDetailsCallback? onTapLinkDetails,
    MarkdownTapImageCallback? onTapImage,
    MarkdownTapHeadingCallback? onTapHeading,
    MarkdownTapElementCallback? onTapElement,
    MarkdownBlockBuilder? blockBuilder,
    MarkdownDocumentReadyCallback? onDocumentReady,
    Object? viewportStorageId,
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
        onTapLinkDetails: onTapLinkDetails ?? this.onTapLinkDetails,
        onTapImage: onTapImage ?? this.onTapImage,
        onTapHeading: onTapHeading ?? this.onTapHeading,
        onTapElement: onTapElement ?? this.onTapElement,
        blockBuilder: blockBuilder ?? this.blockBuilder,
        onDocumentReady: onDocumentReady ?? this.onDocumentReady,
        viewportStorageId: viewportStorageId ?? this.viewportStorageId,
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
        onTapLinkDetails: onTapLinkDetails ?? this.onTapLinkDetails,
        onTapImage: onTapImage ?? this.onTapImage,
        onTapHeading: onTapHeading ?? this.onTapHeading,
        onTapElement: onTapElement ?? this.onTapElement,
        blockBuilder: blockBuilder ?? this.blockBuilder,
        onDocumentReady: onDocumentReady ?? this.onDocumentReady,
        viewportStorageId: viewportStorageId ?? this.viewportStorageId,
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
        onTapLinkDetails: onTapLinkDetails ?? this.onTapLinkDetails,
        onTapImage: onTapImage ?? this.onTapImage,
        onTapHeading: onTapHeading ?? this.onTapHeading,
        onTapElement: onTapElement ?? this.onTapElement,
        blockBuilder: blockBuilder ?? this.blockBuilder,
        onDocumentReady: onDocumentReady ?? this.onDocumentReady,
        viewportStorageId: viewportStorageId ?? this.viewportStorageId,
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
      onTapLinkDetails: onTapLinkDetails,
      onTapImage: onTapImage,
      onTapHeading: onTapHeading,
      onTapElement: onTapElement,
      blockBuilder: blockBuilder,
      onDocumentReady: onDocumentReady,
      viewportStorageId: viewportStorageId,
      shrinkWrap: shrinkWrap,
      followLinks: followLinks,
      imageBuilder: imageBuilder,
      loading: loading,
      errorBuilder: errorBuilder,
    );
  }
}

class _MarkdownTapReporter extends StatefulWidget {
  const _MarkdownTapReporter({required this.child, required this.onTap});

  final Widget child;
  final VoidCallback onTap;

  @override
  State<_MarkdownTapReporter> createState() => _MarkdownTapReporterState();
}

class _MarkdownTapReporterState extends State<_MarkdownTapReporter> {
  static const double _maxTapMovement = 10;
  static const Duration _maxTapDuration = Duration(milliseconds: 260);

  Offset? _pointerDownPosition;
  Duration? _pointerDownTime;

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (event) {
        _pointerDownPosition = event.position;
        _pointerDownTime = event.timeStamp;
      },
      onPointerCancel: (_) {
        _pointerDownPosition = null;
        _pointerDownTime = null;
      },
      onPointerUp: (event) {
        final pointerDownPosition = _pointerDownPosition;
        final pointerDownTime = _pointerDownTime;
        _pointerDownPosition = null;
        _pointerDownTime = null;
        if (pointerDownPosition == null || pointerDownTime == null) {
          return;
        }
        if ((event.position - pointerDownPosition).distance > _maxTapMovement) {
          return;
        }
        if (event.timeStamp - pointerDownTime > _maxTapDuration) {
          return;
        }
        widget.onTap();
      },
      child: widget.child,
    );
  }
}

class _MarkdownState extends State<Markdown> {
  static final Set<String> _failedNetworkImageUrls = <String>{};
  static const int _largeDocumentBlockThreshold = 48;
  static const int _initialProgressiveChunkCount = 4;
  static const int _progressiveChunkBatchSize = 2;
  static const Duration _progressiveChunkInterval = Duration(milliseconds: 24);

  Object? _error;
  bool _loading = false;
  bool _preparingDocument = false;
  int _parseGeneration = 0;
  _MarkdownDocument? _cachedDocument;
  List<_MarkdownChunk> _chunks = const <_MarkdownChunk>[];
  int _visibleChunkCount = 0;
  List<GlobalKey?> _cachedBlockHeadingKeys = const <GlobalKey?>[];
  List<String?> _cachedBlockHeadingAnchors = const <String?>[];
  Map<String, GlobalKey> _cachedHeadingAnchorMap = const <String, GlobalKey>{};
  Map<String, int> _cachedHeadingChunkIndices = const <String, int>{};
  final ScrollController _chunkScrollController = ScrollController();
  Timer? _progressiveChunkTimer;

  @override
  void initState() {
    super.initState();
    _loadSource();
  }

  @override
  void dispose() {
    _progressiveChunkTimer?.cancel();
    _chunkScrollController.dispose();
    super.dispose();
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
      _loading = false;
      _error = null;
      await _prepareDocument(widget.data);
      return;
    }

    final path = widget.sourcePath;
    if (path == null || path.isEmpty) {
      setState(() {
        _loading = false;
        _error = StateError('Markdown source path cannot be empty.');
        _clearMarkdownCaches();
        _preparingDocument = false;
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
      _loading = false;
      _error = null;
      await _prepareDocument(loaded);
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _loading = false;
        _error = error;
        _clearMarkdownCaches();
        _preparingDocument = false;
      });
    }
  }

  Future<void> _prepareDocument(String data) async {
    final generation = ++_parseGeneration;
    _progressiveChunkTimer?.cancel();
    setState(() {
      _error = null;
      _preparingDocument = true;
      _clearMarkdownCaches();
    });

    try {
      final parsed = await _parseMarkdownDocumentAsync(data);
      if (!mounted || generation != _parseGeneration) {
        return;
      }
      final chunks = _chunkMarkdownBlocks(parsed.blocks);
      final initialChunkCount = _initialChunkCountForDocument(parsed, chunks);
      final metrics = _collectDocumentMetrics(parsed, chunks);
      setState(() {
        _cachedDocument = parsed;
        _chunks = chunks;
        _visibleChunkCount = initialChunkCount;
        _primeHeadingAnchors(parsed.blocks, chunks);
        _preparingDocument = false;
      });
      _notifyDocumentReady(generation, metrics);
      _scheduleProgressiveChunkWarmup();
    } catch (error) {
      if (!mounted || generation != _parseGeneration) {
        return;
      }
      setState(() {
        _error = error;
        _preparingDocument = false;
        _clearMarkdownCaches();
      });
    }
  }

  Future<_MarkdownDocument> _parseMarkdownDocumentAsync(String data) async {
    if (data.trim().isEmpty) {
      return const _MarkdownDocument(blocks: <_MarkdownBlock>[]);
    }
    if (kIsWeb) {
      await Future<void>.delayed(Duration.zero);
      return _parseMarkdownDocument(data);
    }
    if (data.length < 8000) {
      await Future<void>.delayed(Duration.zero);
      return _parseMarkdownDocument(data);
    }
    return compute(_parseMarkdownDocument, data);
  }

  int _initialChunkCountForDocument(
    _MarkdownDocument document,
    List<_MarkdownChunk> chunks,
  ) {
    if (document.blocks.length < _largeDocumentBlockThreshold) {
      return chunks.length;
    }
    return chunks.length < _initialProgressiveChunkCount
        ? chunks.length
        : _initialProgressiveChunkCount;
  }

  void _scheduleProgressiveChunkWarmup() {
    _progressiveChunkTimer?.cancel();
    if (!widget.shrinkWrap ||
        _visibleChunkCount >= _chunks.length ||
        _chunks.length <= _initialProgressiveChunkCount) {
      return;
    }
    _progressiveChunkTimer = Timer.periodic(_progressiveChunkInterval, (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_visibleChunkCount >= _chunks.length) {
        timer.cancel();
        return;
      }
      setState(() {
        _visibleChunkCount = (_visibleChunkCount + _progressiveChunkBatchSize)
            .clamp(0, _chunks.length);
      });
    });
  }

  void _clearMarkdownCaches() {
    _progressiveChunkTimer?.cancel();
    _cachedDocument = null;
    _chunks = const <_MarkdownChunk>[];
    _visibleChunkCount = 0;
    _cachedBlockHeadingKeys = const <GlobalKey?>[];
    _cachedBlockHeadingAnchors = const <String?>[];
    _cachedHeadingAnchorMap = const <String, GlobalKey>{};
    _cachedHeadingChunkIndices = const <String, int>{};
  }

  void _primeHeadingAnchors(
    List<_MarkdownBlock> blocks,
    List<_MarkdownChunk> chunks,
  ) {
    final keys = List<GlobalKey?>.filled(blocks.length, null);
    final slugs = List<String?>.filled(blocks.length, null);
    final anchors = <String, GlobalKey>{};
    final counts = <String, int>{};
    final blockIndices = <String, int>{};
    for (var index = 0; index < blocks.length; index++) {
      final block = blocks[index];
      if (!_isHeadingBlockType(block.type)) {
        continue;
      }
      final base = _normalizeAnchorSlug(block.text);
      if (base.isEmpty) {
        continue;
      }
      final seen = counts[base] ?? 0;
      final slug = seen == 0 ? base : '$base-$seen';
      counts[base] = seen + 1;
      final key = GlobalKey(debugLabel: 'md-anchor-$slug');
      keys[index] = key;
      slugs[index] = slug;
      anchors[slug] = key;
      blockIndices[slug] = index;
    }

    final chunkIndices = <String, int>{};
    for (final entry in blockIndices.entries) {
      chunkIndices[entry.key] = _chunkIndexForBlock(entry.value, chunks);
    }

    _cachedBlockHeadingKeys = List<GlobalKey?>.unmodifiable(keys);
    _cachedBlockHeadingAnchors = List<String?>.unmodifiable(slugs);
    _cachedHeadingAnchorMap = Map<String, GlobalKey>.unmodifiable(anchors);
    _cachedHeadingChunkIndices = Map<String, int>.unmodifiable(chunkIndices);
  }

  MarkdownDocumentMetrics _collectDocumentMetrics(
    _MarkdownDocument document,
    List<_MarkdownChunk> chunks,
  ) {
    var headingCount = 0;
    var imageCount = 0;
    var tableCount = 0;
    for (final block in document.blocks) {
      if (_isHeadingBlockType(block.type)) {
        headingCount += 1;
      }
      if (block.type == _MarkdownBlockType.image) {
        imageCount += 1;
      }
      if (block.type == _MarkdownBlockType.table) {
        tableCount += 1;
      }
    }
    return MarkdownDocumentMetrics(
      blockCount: document.blocks.length,
      chunkCount: chunks.length,
      headingCount: headingCount,
      imageCount: imageCount,
      tableCount: tableCount,
    );
  }

  void _notifyDocumentReady(int generation, MarkdownDocumentMetrics metrics) {
    final callback = widget.onDocumentReady;
    if (callback == null) {
      return;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || generation != _parseGeneration) {
        return;
      }
      callback(metrics);
    });
  }

  int _chunkIndexForBlock(int blockIndex, List<_MarkdownChunk> chunks) {
    for (var index = 0; index < chunks.length; index++) {
      final chunk = chunks[index];
      if (blockIndex >= chunk.startBlockIndex &&
          blockIndex < chunk.endBlockIndex) {
        return index;
      }
    }
    return 0;
  }

  bool _isHeadingBlockType(_MarkdownBlockType type) {
    return type == _MarkdownBlockType.heading1 ||
        type == _MarkdownBlockType.heading2 ||
        type == _MarkdownBlockType.heading3 ||
        type == _MarkdownBlockType.heading4 ||
        type == _MarkdownBlockType.heading5 ||
        type == _MarkdownBlockType.heading6;
  }

  String _normalizeAnchorSlug(String value) {
    final decoded = Uri.decodeComponent(value).trim().toLowerCase();
    if (decoded.isEmpty) {
      return '';
    }
    var slug = decoded.replaceAll(RegExp(r'<[^>]+>'), '');
    slug = slug.replaceAll(RegExp(r'[`\*_\~\[\]\(\)\{\}]'), '');
    slug = slug.replaceAll(RegExp(r'[^\w\s-]'), '');
    slug = slug.replaceAll(RegExp(r'\s+'), '-');
    slug = slug.replaceAll(RegExp(r'-+'), '-');
    slug = slug.replaceAll(RegExp(r'^-+|-+$'), '');
    return slug;
  }

  bool _scrollToAnchor(String rawAnchor) {
    final anchor = _normalizeAnchorSlug(rawAnchor);
    if (anchor.isEmpty) {
      return false;
    }
    final key = _cachedHeadingAnchorMap[anchor];
    final targetContext = key?.currentContext;
    if (targetContext == null) {
      final targetChunkIndex = _cachedHeadingChunkIndices[anchor];
      if (targetChunkIndex == null) {
        return false;
      }
      if (widget.shrinkWrap) {
        if (_visibleChunkCount <= targetChunkIndex) {
          setState(() {
            _visibleChunkCount = targetChunkIndex + 1;
          });
        }
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final contextAfterBuild =
              _cachedHeadingAnchorMap[anchor]?.currentContext;
          if (contextAfterBuild != null) {
            Scrollable.ensureVisible(
              contextAfterBuild,
              alignment: 0.08,
              curve: Curves.easeOutCubic,
              duration: const Duration(milliseconds: 180),
            );
          }
        });
        return true;
      }
      if (_chunkScrollController.hasClients) {
        final targetOffset = _estimatedScrollOffsetForChunk(targetChunkIndex);
        unawaited(
          _chunkScrollController
              .animateTo(
                targetOffset.clamp(
                  0.0,
                  _chunkScrollController.position.maxScrollExtent,
                ),
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOutCubic,
              )
              .whenComplete(() {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  final contextAfterScroll =
                      _cachedHeadingAnchorMap[anchor]?.currentContext;
                  if (contextAfterScroll != null) {
                    Scrollable.ensureVisible(
                      contextAfterScroll,
                      alignment: 0.08,
                      curve: Curves.easeOutCubic,
                      duration: const Duration(milliseconds: 140),
                    );
                  }
                });
              }),
        );
        return true;
      }
      return false;
    }
    Scrollable.ensureVisible(
      targetContext,
      alignment: 0.08,
      curve: Curves.easeOutCubic,
      duration: const Duration(milliseconds: 180),
    );
    return true;
  }

  double _estimatedScrollOffsetForChunk(int chunkIndex) {
    var offset = 0.0;
    for (var index = 0; index < chunkIndex && index < _chunks.length; index++) {
      offset += _chunks[index].estimatedExtent;
    }
    return offset;
  }

  MarkdownLinkKind _classifyLinkKind(String url) {
    final trimmed = url.trim();
    if (trimmed.startsWith('#')) {
      return MarkdownLinkKind.anchor;
    }
    if (trimmed.toLowerCase().startsWith('mailto:')) {
      return MarkdownLinkKind.email;
    }
    final uri = Uri.tryParse(trimmed);
    if (uri != null && uri.hasScheme) {
      return MarkdownLinkKind.external;
    }
    return MarkdownLinkKind.relative;
  }

  PageStorageKey<String> _viewportPageStorageKey() {
    final explicitId = widget.viewportStorageId;
    if (explicitId != null) {
      return PageStorageKey<String>('markdown:$explicitId');
    }
    final source = switch (widget.sourceType) {
      MarkdownSourceType.text =>
        'text:${widget.data.hashCode}:${widget.data.length}',
      MarkdownSourceType.asset => 'asset:${widget.sourcePath ?? ''}',
      MarkdownSourceType.file => 'file:${widget.sourcePath ?? ''}',
    };
    final widgetKey = widget.key?.toString() ?? 'no-key';
    return PageStorageKey<String>('markdown:$widgetKey:$source');
  }

  void _emitElementTap(MarkdownTapElementDetails details) {
    widget.onTapElement?.call(details);
  }

  Widget _wrapElementTap({
    required Widget child,
    required MarkdownTapElementDetails details,
    bool enabled = true,
  }) {
    if (!enabled || widget.onTapElement == null) {
      return child;
    }
    return _MarkdownTapReporter(
      onTap: () => _emitElementTap(details),
      child: child,
    );
  }

  MarkdownBlockKind _blockKind(_MarkdownBlock block) {
    return switch (block.type) {
      _MarkdownBlockType.blank => MarkdownBlockKind.blank,
      _MarkdownBlockType.paragraph => MarkdownBlockKind.paragraph,
      _MarkdownBlockType.heading1 ||
      _MarkdownBlockType.heading2 ||
      _MarkdownBlockType.heading3 ||
      _MarkdownBlockType.heading4 ||
      _MarkdownBlockType.heading5 ||
      _MarkdownBlockType.heading6 => MarkdownBlockKind.heading,
      _MarkdownBlockType.unorderedList => MarkdownBlockKind.unorderedList,
      _MarkdownBlockType.orderedList => MarkdownBlockKind.orderedList,
      _MarkdownBlockType.taskList => MarkdownBlockKind.taskList,
      _MarkdownBlockType.quote => MarkdownBlockKind.quote,
      _MarkdownBlockType.codeFence ||
      _MarkdownBlockType.indentedCode => MarkdownBlockKind.codeBlock,
      _MarkdownBlockType.table => MarkdownBlockKind.table,
      _MarkdownBlockType.image => MarkdownBlockKind.image,
      _MarkdownBlockType.definitionList => MarkdownBlockKind.definitionList,
      _MarkdownBlockType.details => MarkdownBlockKind.details,
      _MarkdownBlockType.math => MarkdownBlockKind.math,
      _MarkdownBlockType.footnote => MarkdownBlockKind.footnote,
      _MarkdownBlockType.rawHtml => MarkdownBlockKind.rawHtml,
      _MarkdownBlockType.horizontalRule => MarkdownBlockKind.horizontalRule,
    };
  }

  int? _headingLevelForBlock(_MarkdownBlock block) {
    return switch (block.type) {
      _MarkdownBlockType.heading1 => 1,
      _MarkdownBlockType.heading2 => 2,
      _MarkdownBlockType.heading3 => 3,
      _MarkdownBlockType.heading4 => 4,
      _MarkdownBlockType.heading5 => 5,
      _MarkdownBlockType.heading6 => 6,
      _ => null,
    };
  }

  MarkdownTapElementKind? _blockTapKind(_MarkdownBlock block) {
    return switch (block.type) {
      _MarkdownBlockType.paragraph => MarkdownTapElementKind.paragraph,
      _MarkdownBlockType.heading1 ||
      _MarkdownBlockType.heading2 ||
      _MarkdownBlockType.heading3 ||
      _MarkdownBlockType.heading4 ||
      _MarkdownBlockType.heading5 ||
      _MarkdownBlockType.heading6 => MarkdownTapElementKind.heading,
      _MarkdownBlockType.unorderedList ||
      _MarkdownBlockType.orderedList ||
      _MarkdownBlockType.taskList => MarkdownTapElementKind.listItem,
      _MarkdownBlockType.codeFence ||
      _MarkdownBlockType.indentedCode => MarkdownTapElementKind.codeBlock,
      _MarkdownBlockType.math => MarkdownTapElementKind.math,
      _MarkdownBlockType.footnote => MarkdownTapElementKind.footnote,
      _MarkdownBlockType.rawHtml => MarkdownTapElementKind.rawHtml,
      _MarkdownBlockType.horizontalRule =>
        MarkdownTapElementKind.horizontalRule,
      _ => null,
    };
  }

  MarkdownTapElementDetails? _buildBlockTapDetails(
    _MarkdownBlock block, {
    required int blockIndex,
    String? headingAnchorSlug,
  }) {
    final kind = _blockTapKind(block);
    if (kind == null) {
      return null;
    }
    final headingLevel = switch (block.type) {
      _MarkdownBlockType.heading1 => 1,
      _MarkdownBlockType.heading2 => 2,
      _MarkdownBlockType.heading3 => 3,
      _MarkdownBlockType.heading4 => 4,
      _MarkdownBlockType.heading5 => 5,
      _MarkdownBlockType.heading6 => 6,
      _ => null,
    };
    return MarkdownTapElementDetails(
      kind: kind,
      text: block.text,
      anchor: headingAnchorSlug,
      headingLevel: headingLevel,
      blockIndex: blockIndex,
      orderedIndex: block.type == _MarkdownBlockType.orderedList
          ? block.orderedIndex
          : null,
      checked: block.type == _MarkdownBlockType.taskList ? block.checked : null,
    );
  }

  MarkdownBlockBuildDetails _buildBlockRenderDetails(
    _MarkdownBlock block, {
    required int blockIndex,
    required Widget Function() buildDefault,
    String? headingAnchorSlug,
  }) {
    return MarkdownBlockBuildDetails(
      kind: _blockKind(block),
      text: block.text,
      blockIndex: blockIndex,
      buildDefault: buildDefault,
      headingLevel: _headingLevelForBlock(block),
      headingAnchor: headingAnchorSlug,
      language: block.language,
      orderedIndex: block.type == _MarkdownBlockType.orderedList
          ? block.orderedIndex
          : null,
      checked: block.type == _MarkdownBlockType.taskList ? block.checked : null,
      tableRows: List<List<String>>.unmodifiable(
        block.tableRows
            .map((row) => List<String>.unmodifiable(row))
            .toList(growable: false),
      ),
      tableAlignments: List<TextAlign>.unmodifiable(block.tableAlignments),
      imageUrl: block.imageUrl,
      imageAlt: block.imageAlt,
      imageTitle: block.imageTitle,
      label: block.label,
      items: List<String>.unmodifiable(block.items),
      htmlTag: block.htmlTag,
      htmlAttributes: Map<String, String>.unmodifiable(
        _extractHtmlAttributesMapFromBlock(block),
      ),
      rawHtml: block.rawHtml,
    );
  }

  Map<String, String> _extractHtmlAttributesMapFromBlock(_MarkdownBlock block) {
    final tag = block.htmlTag;
    if (tag == null || tag.isEmpty) {
      return const <String, String>{};
    }
    if (block.rawHtml == null || block.rawHtml!.isEmpty) {
      return const <String, String>{};
    }
    return _extractHtmlAttributesMap(
      _extractOpeningHtmlAttributes(block.rawHtml!, tag),
    );
  }

  void _handleTapLink(String text, String url) {
    final normalizedUrl = url.trim();
    final details = MarkdownLinkTapDetails(
      text: text,
      url: normalizedUrl,
      kind: _classifyLinkKind(normalizedUrl),
    );
    _emitElementTap(
      MarkdownTapElementDetails(
        kind: MarkdownTapElementKind.link,
        text: text,
        url: normalizedUrl,
        anchor: details.isAnchor ? normalizedUrl.substring(1) : null,
      ),
    );
    if (details.isAnchor && _scrollToAnchor(normalizedUrl.substring(1))) {
      widget.onTapLinkDetails?.call(details);
      widget.onTapLink?.call(text, normalizedUrl);
      return;
    }
    widget.onTapLinkDetails?.call(details);
    widget.onTapLink?.call(text, normalizedUrl);
    if (widget.followLinks) {
      unawaited(openMarkdownLink(normalizedUrl));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading || (_preparingDocument && _cachedDocument == null)) {
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

    final markdownThemeOverride = ComponentTheme.maybeOf<MarkdownTheme>(
      context,
    );
    final baseStyle = styleValue<TextStyle>(
      widgetValue: widget.style,
      themeValue: markdownThemeOverride?.style,
      defaultValue: DefaultTextStyle.of(context).style,
    );
    final markdownTheme = (markdownThemeOverride ?? const MarkdownTheme())
        .withFallback(MarkdownTheme.htmlDefaults(baseStyle));
    final document = _cachedDocument;
    if (document == null) {
      return const SizedBox.shrink();
    }
    final blocks = document.blocks;
    final blockAnchors = _cachedBlockHeadingKeys;
    final blockHeadingSlugs = _cachedBlockHeadingAnchors;

    if (blocks.isEmpty) {
      return const SizedBox.shrink();
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final useViewportList =
            !widget.shrinkWrap && constraints.hasBoundedHeight;
        final visibleChunkCount = useViewportList
            ? _chunks.length
            : _visibleChunkCount.clamp(0, _chunks.length);

        if (_chunks.isEmpty) {
          return const SizedBox.shrink();
        }

        return ListView.builder(
          key: _viewportPageStorageKey(),
          controller: useViewportList ? _chunkScrollController : null,
          padding: EdgeInsets.zero,
          shrinkWrap: !useViewportList,
          physics: useViewportList
              ? const AlwaysScrollableScrollPhysics()
              : const NeverScrollableScrollPhysics(),
          cacheExtent: useViewportList ? 960 : null,
          addAutomaticKeepAlives: false,
          itemCount: visibleChunkCount,
          itemBuilder: (context, chunkIndex) {
            final chunk = _chunks[chunkIndex];
            return RepaintBoundary(
              child: _buildChunk(
                context,
                chunk,
                baseStyle,
                document,
                markdownTheme,
                blockAnchors,
                blockHeadingSlugs,
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildChunk(
    BuildContext context,
    _MarkdownChunk chunk,
    TextStyle baseStyle,
    _MarkdownDocument document,
    MarkdownTheme markdownTheme,
    List<GlobalKey?> blockAnchors,
    List<String?> blockHeadingSlugs,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (
          var blockIndex = chunk.startBlockIndex;
          blockIndex < chunk.endBlockIndex;
          blockIndex++
        )
          _buildBlock(
            context,
            chunk.blocks[blockIndex - chunk.startBlockIndex],
            blockIndex,
            baseStyle,
            document,
            markdownTheme,
            headingAnchorKey: blockIndex < blockAnchors.length
                ? blockAnchors[blockIndex]
                : null,
            headingAnchorSlug: blockIndex < blockHeadingSlugs.length
                ? blockHeadingSlugs[blockIndex]
                : null,
          ),
      ],
    );
  }

  Widget _buildBlock(
    BuildContext context,
    _MarkdownBlock block,
    int blockIndex,
    TextStyle baseStyle,
    _MarkdownDocument document,
    MarkdownTheme? markdownTheme, {
    GlobalKey? headingAnchorKey,
    String? headingAnchorSlug,
  }) {
    final linkStyle = markdownTheme?.linkStyle;
    final rich = TextSpan(
      style: baseStyle,
      children: _buildInlineSpans(
        context,
        block.text,
        baseStyle,
        document,
        onTapLink: _handleTapLink,
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

    Widget buildDefaultChild() {
      switch (block.type) {
        case _MarkdownBlockType.codeFence:
        case _MarkdownBlockType.indentedCode:
          return Container(
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
          return Padding(
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
          return Container(
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
              onTapLink: _handleTapLink,
              onTapLinkDetails: widget.onTapLinkDetails,
              onTapImage: widget.onTapImage,
              onTapHeading: widget.onTapHeading,
              onTapElement: widget.onTapElement,
              blockBuilder: widget.blockBuilder,
              shrinkWrap: true,
              followLinks: widget.followLinks,
              imageBuilder: widget.imageBuilder,
            ),
          );
        case _MarkdownBlockType.horizontalRule:
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Divider(
              height: 1,
              color: markdownTheme?.horizontalRuleColor,
            ),
          );
        case _MarkdownBlockType.table:
          return _buildTable(
            context,
            block,
            blockIndex,
            baseStyle,
            document,
            markdownTheme,
          );
        case _MarkdownBlockType.image:
          return _buildImage(
            context,
            block,
            blockIndex,
            baseStyle,
            markdownTheme,
          );
        case _MarkdownBlockType.definitionList:
          return _buildDefinitionList(
            context,
            block,
            blockIndex,
            baseStyle,
            document,
            markdownTheme,
          );
        case _MarkdownBlockType.details:
          return _MarkdownDisclosure(
            summary: block.text,
            onSummaryTap: (widget.onTapElement == null)
                ? null
                : () {
                    _emitElementTap(
                      MarkdownTapElementDetails(
                        kind: MarkdownTapElementKind.detailsSummary,
                        text: block.text,
                        blockIndex: blockIndex,
                      ),
                    );
                  },
            summaryStyle:
                markdownTheme?.detailsSummaryStyle ??
                baseStyle.copyWith(fontWeight: FontWeight.w600),
            decoration: BoxDecoration(
              border: Border.all(
                color:
                    markdownTheme?.detailsBorderColor ??
                    const Color(0x22000000),
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
              onTapLink: _handleTapLink,
              onTapLinkDetails: widget.onTapLinkDetails,
              onTapImage: widget.onTapImage,
              onTapHeading: widget.onTapHeading,
              onTapElement: widget.onTapElement,
              blockBuilder: widget.blockBuilder,
              shrinkWrap: true,
              followLinks: widget.followLinks,
              imageBuilder: widget.imageBuilder,
            ),
          );
        case _MarkdownBlockType.math:
          return _buildMathBlock(block, mono, markdownTheme);
        case _MarkdownBlockType.footnote:
          return _buildFootnote(
            context,
            block,
            baseStyle,
            document,
            markdownTheme,
          );
        case _MarkdownBlockType.rawHtml:
          return widget.selectable
              ? SelectableText.rich(
                  TextSpan(
                    style: baseStyle,
                    children: _buildInlineSpans(
                      context,
                      _htmlToInlineText(block.text),
                      baseStyle,
                      document,
                      onTapLink: _handleTapLink,
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
                      onTapLink: _handleTapLink,
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
          return widget.selectable
              ? SelectableText.rich(rich, style: resolvedHeadingStyle)
              : RichText(
                  text: TextSpan(
                    style: resolvedHeadingStyle,
                    children: rich.children,
                  ),
                );
      }
    }

    Widget child =
        widget.blockBuilder?.call(
          context,
          _buildBlockRenderDetails(
            block,
            blockIndex: blockIndex,
            buildDefault: buildDefaultChild,
            headingAnchorSlug: headingAnchorSlug,
          ),
        ) ??
        buildDefaultChild();

    if (headingAnchorKey != null) {
      child = KeyedSubtree(key: headingAnchorKey, child: child);
    }

    final headingLevel = switch (block.type) {
      _MarkdownBlockType.heading1 => 1,
      _MarkdownBlockType.heading2 => 2,
      _MarkdownBlockType.heading3 => 3,
      _MarkdownBlockType.heading4 => 4,
      _MarkdownBlockType.heading5 => 5,
      _MarkdownBlockType.heading6 => 6,
      _ => null,
    };
    if (headingAnchorSlug != null &&
        headingLevel != null &&
        (widget.onTapHeading != null || widget.onTapElement != null)) {
      child = _MarkdownTapReporter(
        onTap: () {
          widget.onTapHeading?.call(
            MarkdownHeadingTapDetails(
              text: block.text,
              anchor: headingAnchorSlug,
              level: headingLevel,
            ),
          );
          _emitElementTap(
            MarkdownTapElementDetails(
              kind: MarkdownTapElementKind.heading,
              text: block.text,
              anchor: headingAnchorSlug,
              headingLevel: headingLevel,
              blockIndex: blockIndex,
            ),
          );
        },
        child: child,
      );
    } else {
      final blockTapDetails = _buildBlockTapDetails(
        block,
        blockIndex: blockIndex,
        headingAnchorSlug: headingAnchorSlug,
      );
      if (blockTapDetails != null) {
        child = _wrapElementTap(child: child, details: blockTapDetails);
      }
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
    int blockIndex,
    TextStyle baseStyle,
    _MarkdownDocument document,
    MarkdownTheme? markdownTheme,
  ) {
    final rows = block.tableRows;
    if (rows.isEmpty) {
      return const SizedBox.shrink();
    }
    final maxColumns = rows.fold<int>(
      0,
      (max, row) => row.length > max ? row.length : max,
    );
    final minCellWidth = markdownTheme?.tableCellMinWidth ?? 112.0;

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
          defaultColumnWidth: const IntrinsicColumnWidth(),
          columnWidths: <int, TableColumnWidth>{
            for (var col = 0; col < maxColumns; col++)
              col: const IntrinsicColumnWidth(),
          },
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
                      child: ConstrainedBox(
                        constraints: BoxConstraints(minWidth: minCellWidth),
                        child: _wrapElementTap(
                          details: MarkdownTapElementDetails(
                            kind: rowIndex == 0
                                ? MarkdownTapElementKind.tableHeaderCell
                                : MarkdownTapElementKind.tableCell,
                            text: rows[rowIndex][colIndex],
                            blockIndex: blockIndex,
                            tableRow: rowIndex,
                            tableColumn: colIndex,
                          ),
                          child: widget.selectable
                              ? SelectableText.rich(
                                  TextSpan(
                                    style: rowIndex == 0
                                        ? headerStyle
                                        : cellStyle,
                                    children: _buildInlineSpans(
                                      context,
                                      rows[rowIndex][colIndex],
                                      rowIndex == 0 ? headerStyle : cellStyle,
                                      document,
                                      onTapLink: _handleTapLink,
                                      followLinks: widget.followLinks,
                                      linkStyle: markdownTheme?.linkStyle,
                                    ),
                                  ),
                                  textAlign:
                                      colIndex < block.tableAlignments.length
                                      ? block.tableAlignments[colIndex]
                                      : TextAlign.left,
                                )
                              : RichText(
                                  softWrap: false,
                                  textAlign:
                                      colIndex < block.tableAlignments.length
                                      ? block.tableAlignments[colIndex]
                                      : TextAlign.left,
                                  text: TextSpan(
                                    style: rowIndex == 0
                                        ? headerStyle
                                        : cellStyle,
                                    children: _buildInlineSpans(
                                      context,
                                      rows[rowIndex][colIndex],
                                      rowIndex == 0 ? headerStyle : cellStyle,
                                      document,
                                      onTapLink: _handleTapLink,
                                      followLinks: widget.followLinks,
                                      linkStyle: markdownTheme?.linkStyle,
                                    ),
                                  ),
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
    int blockIndex,
    TextStyle baseStyle,
    MarkdownTheme? markdownTheme,
  ) {
    final imageUrl = block.imageUrl ?? '';
    if (imageUrl.isEmpty) {
      return const SizedBox.shrink();
    }

    final alt = block.imageAlt ?? '';
    Widget image;
    if (widget.imageBuilder != null) {
      image = widget.imageBuilder!(context, imageUrl, alt);
    } else {
      final normalized = imageUrl.trim();
      if (normalized.startsWith('http://') ||
          normalized.startsWith('https://')) {
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
    }

    Widget child = Container(
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

    if (widget.onTapImage != null || widget.onTapElement != null) {
      child = _MarkdownTapReporter(
        onTap: () {
          widget.onTapImage?.call(
            MarkdownImageTapDetails(
              url: imageUrl.trim(),
              alt: alt,
              title: block.imageTitle,
            ),
          );
          _emitElementTap(
            MarkdownTapElementDetails(
              kind: MarkdownTapElementKind.image,
              text: alt,
              url: imageUrl.trim(),
              title: block.imageTitle,
              blockIndex: blockIndex,
            ),
          );
        },
        child: child,
      );
    }

    return child;
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
    int blockIndex,
    TextStyle baseStyle,
    _MarkdownDocument document,
    MarkdownTheme? markdownTheme,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _wrapElementTap(
            details: MarkdownTapElementDetails(
              kind: MarkdownTapElementKind.definitionTerm,
              text: block.text,
              blockIndex: blockIndex,
            ),
            child: Text(
              block.text,
              style: baseStyle.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          for (var itemIndex = 0; itemIndex < block.items.length; itemIndex++)
            Padding(
              padding: const EdgeInsets.only(left: 14, top: 4),
              child: _wrapElementTap(
                details: MarkdownTapElementDetails(
                  kind: MarkdownTapElementKind.definitionDescription,
                  text: block.items[itemIndex],
                  blockIndex: blockIndex,
                ),
                child: widget.selectable
                    ? SelectableText.rich(
                        TextSpan(
                          style: baseStyle,
                          children: _buildInlineSpans(
                            context,
                            block.items[itemIndex],
                            baseStyle,
                            document,
                            onTapLink: _handleTapLink,
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
                            block.items[itemIndex],
                            baseStyle,
                            document,
                            onTapLink: _handleTapLink,
                            followLinks: widget.followLinks,
                            linkStyle: markdownTheme?.linkStyle,
                          ),
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
                        onTapLink: _handleTapLink,
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
                        onTapLink: _handleTapLink,
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

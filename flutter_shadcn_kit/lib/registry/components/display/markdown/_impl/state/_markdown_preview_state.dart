part of '../../preview.dart';

enum _StreamMode { character, word, chunk, part }

enum _AnimationKind { blur, fade, slide, scramble }

class _MarkdownPreviewState extends m.State<MarkdownPreview> {
  static const String _showcaseFilePath =
      '/Users/ibrar/Desktop/infinora.noworkspace/shadcn_copy_paste/Markdown Feature Showcase - ChatGPT.md';
  static const String _showcaseAssetPath =
      'assets/markdown/markdown_feature_showcase.md';
  static const String _inlineMarkdown = '''# Advanced Markdown Renderer

This is **bold**, *italic*, ***bold italic***, `inline code`, and ~~strikethrough~~.

## Checklist
- [x] Parser supports task list
- [ ] Add your own `onTapLink` callback
  - Nested bullets work
  - Ordered lists also work

## Table
| Feature | Status | Notes |
| :-- | :--: | --: |
| Headings | done | 6 levels |
| Tables | done | aligned cells |
| Streaming | done | extension based |

## Code
```dart
final widget = Markdown(data: '# Hello');
print(widget.runtimeType);
```

> Block quotes are grouped and rendered with a left border.

![Network Image](https://picsum.photos/640/220)

Link example: [Flutter](https://flutter.dev)
''';

  static const String _interactionMarkdown = '''# Interaction Hooks

## Table of Contents
- [Jump to tables](#tables)
- [Jump to code](#code)
- [Open Flutter](https://flutter.dev)
- [Email support](mailto:hello@example.com)

![Preview card](https://example.com/preview.png "Preview")

## Tables
| Hook | Payload |
| :-- | :-- |
| Link | `MarkdownLinkTapDetails` |
| Image | `MarkdownImageTapDetails` |
| Heading | `MarkdownHeadingTapDetails` |

## Code
```dart
Markdown(
  data: markdown,
  onTapLinkDetails: (details) {},
  onTapImage: (details) {},
  onTapHeading: (details) {},
)
```
''';

  static const String _themeMarkdown = '''# Theme Override

## Editorial Styling
This preview uses a warmer palette and heavier heading hierarchy while keeping the same parser output.

> Quotes, tables, code fences, and details all inherit from the same theme object.

| Surface | Color |
| :-- | :-- |
| Quote | Warm amber |
| Code | Sand background |
| Table | Muted border |

```dart
const markdownTheme = MarkdownTheme(
  quoteBorderColor: Color(0xFFD97706),
);
```
''';

  static const List<String> _partStream = [
    '# Streaming Markdown\n\n',
    'The assistant is thinking...\n\n',
    'Streaming tokens into the UI in real time.\n\n',
    '## Why it feels smooth\n- Stable committed prefix\n- Animated incoming tail only\n- Layout animation reduces jumps\n',
  ];

  late final m.TextEditingController _filePathController;

  Timer? _timer;
  _StreamMode _streamMode = _StreamMode.character;
  _AnimationKind _animation = _AnimationKind.blur;
  double _speed = 1.0;
  String _streamed = '';
  int _cursor = 0;
  String _filePath = _showcaseFilePath;
  String? _showcaseMarkdown;
  Object? _showcaseError;
  MarkdownDocumentMetrics? _showcaseMetrics;
  MarkdownDocumentMetrics? _interactionMetrics;
  MarkdownDocumentMetrics? _fileMetrics;
  List<String> _interactionLog = const <String>[];

  @override
  void initState() {
    super.initState();
    _filePathController = m.TextEditingController(text: _filePath);
    _loadShowcaseAsset();
    _restartStreaming();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _filePathController.dispose();
    super.dispose();
  }

  void _restartStreaming() {
    _timer?.cancel();
    setState(() {
      _streamed = '';
      _cursor = 0;
    });

    final units = _streamUnits(_streamMode, _inlineMarkdown);
    final ms = (220 / _speed).clamp(50, 600).round();
    _timer = Timer.periodic(Duration(milliseconds: ms), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_cursor >= units.length) {
        timer.cancel();
        return;
      }
      setState(() {
        _streamed = '$_streamed${units[_cursor]}';
        _cursor += 1;
      });
    });
  }

  Future<void> _loadShowcaseAsset() async {
    const candidates = <String>[
      _showcaseAssetPath,
      'packages/flutter_shadcn_kit/assets/markdown/markdown_feature_showcase.md',
    ];
    Object? lastError;
    for (final key in candidates) {
      try {
        final data = await rootBundle.loadString(key);
        if (!mounted) {
          return;
        }
        setState(() {
          _showcaseMarkdown = data;
          _showcaseError = null;
        });
        return;
      } catch (error) {
        lastError = error;
      }
    }
    if (!mounted) {
      return;
    }
    setState(() {
      _showcaseMarkdown = null;
      _showcaseError = lastError;
    });
  }

  List<String> _streamUnits(_StreamMode mode, String input) {
    switch (mode) {
      case _StreamMode.character:
        return input.split('');
      case _StreamMode.word:
        return RegExp(r'\S+\s*|\n')
            .allMatches(input)
            .map((match) => match.group(0)!)
            .toList(growable: false);
      case _StreamMode.chunk:
        const size = 18;
        final chunks = <String>[];
        for (var i = 0; i < input.length; i += size) {
          chunks.add(input.substring(i, (i + size).clamp(0, input.length)));
        }
        return chunks;
      case _StreamMode.part:
        return _partStream;
    }
  }

  ta.StreamingTextEffectAdapter _effectForSelection() {
    final durationMs = (300 / _speed).clamp(120, 480).round();
    return switch (_animation) {
      _AnimationKind.blur => ta.BlurInEffect(
        duration: Duration(milliseconds: durationMs),
        maxBlurSigma: 12,
        fadeIn: true,
        slideUpPx: 2,
      ),
      _AnimationKind.fade => ta.FadeInEffect(
        duration: Duration(milliseconds: durationMs),
      ),
      _AnimationKind.slide => ta.SlideInEffect(
        duration: Duration(milliseconds: durationMs),
        offsetY: 8,
      ),
      _AnimationKind.scramble => ta.ScrambleInEffect(
        duration: Duration(milliseconds: durationMs),
      ),
    };
  }

  double _viewportHeight(
    m.BuildContext context, {
    double factor = 0.56,
    double min = 300,
    double max = 620,
  }) {
    final height = m.MediaQuery.sizeOf(context).height * factor;
    return height.clamp(min, max).toDouble();
  }

  void _recordInteraction(String message) {
    final now = DateTime.now();
    final stamp =
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';
    setState(() {
      _interactionLog = <String>[
        '[$stamp] $message',
        ..._interactionLog,
      ].take(10).toList(growable: false);
    });
  }

  bool _sameMetrics(
    MarkdownDocumentMetrics? current,
    MarkdownDocumentMetrics next,
  ) {
    return current?.blockCount == next.blockCount &&
        current?.chunkCount == next.chunkCount &&
        current?.headingCount == next.headingCount &&
        current?.imageCount == next.imageCount &&
        current?.tableCount == next.tableCount;
  }

  void _setShowcaseMetrics(MarkdownDocumentMetrics metrics) {
    if (_sameMetrics(_showcaseMetrics, metrics)) {
      return;
    }
    setState(() => _showcaseMetrics = metrics);
  }

  void _setInteractionMetrics(MarkdownDocumentMetrics metrics) {
    if (_sameMetrics(_interactionMetrics, metrics)) {
      return;
    }
    setState(() => _interactionMetrics = metrics);
  }

  void _setFileMetrics(MarkdownDocumentMetrics metrics) {
    if (_sameMetrics(_fileMetrics, metrics)) {
      return;
    }
    setState(() => _fileMetrics = metrics);
  }

  void _handleLinkTap(MarkdownLinkTapDetails details) {
    final kind = switch (details.kind) {
      MarkdownLinkKind.anchor => 'anchor',
      MarkdownLinkKind.email => 'email',
      MarkdownLinkKind.external => 'external',
      MarkdownLinkKind.relative => 'relative',
    };
    _recordInteraction('link[$kind] ${details.url}');
  }

  void _handleImageTap(MarkdownImageTapDetails details) {
    final label = details.alt.isNotEmpty ? details.alt : details.url;
    _recordInteraction('image $label');
  }

  void _handleHeadingTap(MarkdownHeadingTapDetails details) {
    _recordInteraction('heading h${details.level} #${details.anchor}');
  }

  m.Widget _previewImageBuilder(
    m.BuildContext context,
    String url,
    String alt,
  ) {
    return m.Container(
      width: double.infinity,
      constraints: const m.BoxConstraints(minHeight: 160),
      decoration: m.BoxDecoration(
        borderRadius: m.BorderRadius.circular(12),
        gradient: const m.LinearGradient(
          colors: <m.Color>[m.Color(0xFFF6F4EF), m.Color(0xFFE9E0D0)],
          begin: m.Alignment.topLeft,
          end: m.Alignment.bottomRight,
        ),
        border: m.Border.all(color: const m.Color(0x22000000)),
      ),
      padding: const m.EdgeInsets.all(16),
      child: m.Column(
        mainAxisAlignment: m.MainAxisAlignment.center,
        crossAxisAlignment: m.CrossAxisAlignment.center,
        children: [
          const m.Icon(m.Icons.image_outlined, size: 28),
          const m.SizedBox(height: 8),
          m.Text(
            alt.isNotEmpty ? alt : 'Preview image',
            textAlign: m.TextAlign.center,
            style: const m.TextStyle(fontWeight: m.FontWeight.w700),
          ),
          const m.SizedBox(height: 4),
          m.Text(
            url,
            maxLines: 2,
            overflow: m.TextOverflow.ellipsis,
            textAlign: m.TextAlign.center,
            style: const m.TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  m.Widget _metricChip(String label, String value) {
    return m.Container(
      padding: const m.EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: m.BoxDecoration(
        color: const m.Color(0x11000000),
        borderRadius: m.BorderRadius.circular(999),
        border: m.Border.all(color: const m.Color(0x22000000)),
      ),
      child: m.Text(
        '$label: $value',
        style: const m.TextStyle(fontSize: 12, fontWeight: m.FontWeight.w600),
      ),
    );
  }

  m.Widget _metricsBar(MarkdownDocumentMetrics? metrics) {
    if (metrics == null) {
      return const m.Text(
        'Waiting for document metrics...',
        style: m.TextStyle(fontSize: 12),
      );
    }
    return m.Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _metricChip('Blocks', '${metrics.blockCount}'),
        _metricChip('Chunks', '${metrics.chunkCount}'),
        _metricChip('Headings', '${metrics.headingCount}'),
        _metricChip('Tables', '${metrics.tableCount}'),
        _metricChip('Images', '${metrics.imageCount}'),
      ],
    );
  }

  m.Widget _interactionLogCard() {
    return m.Container(
      width: double.infinity,
      padding: const m.EdgeInsets.all(14),
      decoration: m.BoxDecoration(
        border: m.Border.all(color: const m.Color(0x22000000)),
        borderRadius: m.BorderRadius.circular(12),
        color: const m.Color(0x08000000),
      ),
      child: m.Column(
        crossAxisAlignment: m.CrossAxisAlignment.start,
        children: [
          const m.Text(
            'Interaction log',
            style: m.TextStyle(fontWeight: m.FontWeight.w700),
          ),
          const m.SizedBox(height: 8),
          if (_interactionLog.isEmpty)
            const m.Text(
              'Tap a link, image, or heading in the demos below to inspect callback payloads.',
              style: m.TextStyle(fontSize: 12),
            )
          else
            for (final entry in _interactionLog)
              m.Padding(
                padding: const m.EdgeInsets.only(bottom: 6),
                child: m.Text(
                  entry,
                  style: const m.TextStyle(
                    fontSize: 12,
                    fontFamily: 'GeistMono',
                  ),
                ),
              ),
        ],
      ),
    );
  }

  m.Widget _markdownViewport({
    required m.BuildContext context,
    required m.Widget child,
    double factor = 0.56,
    double min = 300,
    double max = 620,
  }) {
    return m.Container(
      decoration: m.BoxDecoration(
        borderRadius: m.BorderRadius.circular(12),
        color: const m.Color(0x05000000),
      ),
      clipBehavior: m.Clip.antiAlias,
      child: m.SizedBox(
        height: _viewportHeight(context, factor: factor, min: min, max: max),
        child: child,
      ),
    );
  }

  @override
  m.Widget build(m.BuildContext context) {
    return m.Scaffold(
      body: m.Align(
        alignment: m.Alignment.topCenter,
        child: m.ConstrainedBox(
          constraints: const m.BoxConstraints(maxWidth: 980),
          child: m.ListView(
            padding: const m.EdgeInsets.all(20),
            children: [
              const m.Text(
                'Markdown (Advanced + Streaming)',
                style: m.TextStyle(fontSize: 20, fontWeight: m.FontWeight.w700),
              ),
              const m.SizedBox(height: 10),
              const m.Text(
                'Large previews now run in bounded viewports so the markdown widget can virtualize chunks instead of mounting the whole document. Interaction hooks are also wired in: links, headings, images, and document metrics are captured below.',
              ),
              const m.SizedBox(height: 20),
              _sectionCard(
                title: 'Streaming Example (Comprehensive)',
                child: m.Column(
                  crossAxisAlignment: m.CrossAxisAlignment.start,
                  children: [
                    _choiceRow<_StreamMode>(
                      label: 'Stream mode',
                      values: _StreamMode.values,
                      current: _streamMode,
                      text: (value) => switch (value) {
                        _StreamMode.character => 'Character by Character',
                        _StreamMode.word => 'Word by Word',
                        _StreamMode.chunk => 'Chunk-by-Chunk',
                        _StreamMode.part => 'Part stream',
                      },
                      onSelect: (value) {
                        setState(() => _streamMode = value);
                        _restartStreaming();
                      },
                    ),
                    const m.SizedBox(height: 10),
                    _choiceRow<_AnimationKind>(
                      label: 'Animation',
                      values: _AnimationKind.values,
                      current: _animation,
                      text: (value) => switch (value) {
                        _AnimationKind.blur => 'Blur',
                        _AnimationKind.fade => 'Fade',
                        _AnimationKind.slide => 'Slide',
                        _AnimationKind.scramble => 'Scramble',
                      },
                      onSelect: (value) => setState(() => _animation = value),
                    ),
                    const m.SizedBox(height: 10),
                    const m.Text('Universal speed'),
                    m.Slider(
                      min: 0.4,
                      max: 2.0,
                      divisions: 16,
                      value: _speed,
                      label: _speed.toStringAsFixed(2),
                      onChanged: (value) => setState(() => _speed = value),
                      onChangeEnd: (_) => _restartStreaming(),
                    ),
                    const m.SizedBox(height: 10),
                    m.Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        m.FilledButton(
                          onPressed: _restartStreaming,
                          child: const m.Text('Restart stream'),
                        ),
                        m.OutlinedButton(
                          onPressed: () =>
                              setState(() => _streamed = _inlineMarkdown),
                          child: const m.Text('Show final markdown'),
                        ),
                      ],
                    ),
                    const m.SizedBox(height: 12),
                    _surface(
                      Markdown(
                        data: _streamed,
                        selectable: false,
                        followLinks: false,
                        imageBuilder: _previewImageBuilder,
                      ).withTextStreaming(
                        typewriter: const ta.TypewriterEffect(enabled: false),
                        effect: _effectForSelection(),
                        animateByWord: _streamMode == _StreamMode.word,
                      ),
                    ),
                  ],
                ),
              ),
              const m.SizedBox(height: 14),
              _sectionCard(
                title: 'Comprehensive Feature Showcase (Bundled Asset)',
                child: m.Column(
                  crossAxisAlignment: m.CrossAxisAlignment.start,
                  children: [
                    const m.Text(
                      'This is the heavy document. The preview keeps it non-selectable and bounded so scrolling stays on the lazy chunk path.',
                    ),
                    const m.SizedBox(height: 10),
                    _metricsBar(_showcaseMetrics),
                    const m.SizedBox(height: 10),
                    _surface(
                      _markdownViewport(
                        context: context,
                        child: _buildShowcaseContent(),
                      ),
                    ),
                  ],
                ),
              ),
              const m.SizedBox(height: 14),
              _sectionCard(
                title: 'Theme Override Example',
                child: _surface(
                  _markdownViewport(
                    context: context,
                    factor: 0.4,
                    min: 220,
                    max: 360,
                    child: shadcn.ComponentTheme(
                      data: const MarkdownTheme(
                        style: m.TextStyle(
                          fontFamily: 'GeistSans',
                          height: 1.55,
                          color: m.Color(0xFF2B1B10),
                        ),
                        linkStyle: m.TextStyle(
                          color: m.Color(0xFF0E7490),
                          decoration: m.TextDecoration.underline,
                          fontWeight: m.FontWeight.w600,
                        ),
                        codeBackgroundColor: m.Color(0xFFF5EEE2),
                        quoteBorderColor: m.Color(0xFFD97706),
                        quoteBackgroundColor: m.Color(0xFFFFFBEB),
                        tableBorderColor: m.Color(0xFFD6C5AB),
                        tableHeaderBackgroundColor: m.Color(0xFFF5EEE2),
                        detailsBorderColor: m.Color(0xFFD6C5AB),
                        detailsBackgroundColor: m.Color(0xFFFFFBEB),
                        horizontalRuleColor: m.Color(0xFFD6C5AB),
                        codeRadius: m.BorderRadius.all(m.Radius.circular(14)),
                        tableRadius: m.BorderRadius.all(m.Radius.circular(14)),
                        detailsRadius: m.BorderRadius.all(
                          m.Radius.circular(14),
                        ),
                        imageMaxHeight: 220,
                        listIndent: 20,
                        heading1Style: m.TextStyle(
                          fontSize: 31,
                          fontWeight: m.FontWeight.w800,
                          color: m.Color(0xFF7C2D12),
                        ),
                        heading2Style: m.TextStyle(
                          fontSize: 26,
                          fontWeight: m.FontWeight.w800,
                          color: m.Color(0xFF9A3412),
                        ),
                      ),
                      child: Markdown(
                        data: _themeMarkdown,
                        selectable: false,
                        shrinkWrap: false,
                        followLinks: false,
                        imageBuilder: _previewImageBuilder,
                      ),
                    ),
                  ),
                ),
              ),
              const m.SizedBox(height: 14),
              _sectionCard(
                title: 'Interaction Hooks',
                child: m.Column(
                  crossAxisAlignment: m.CrossAxisAlignment.start,
                  children: [
                    const m.Text(
                      'External links are intercepted in this preview, anchors still jump inside the same markdown view, and headings/images emit structured callbacks.',
                    ),
                    const m.SizedBox(height: 10),
                    _metricsBar(_interactionMetrics),
                    const m.SizedBox(height: 10),
                    _surface(
                      _markdownViewport(
                        context: context,
                        factor: 0.44,
                        min: 260,
                        max: 420,
                        child: Markdown(
                          data: _interactionMarkdown,
                          selectable: false,
                          shrinkWrap: false,
                          followLinks: false,
                          imageBuilder: _previewImageBuilder,
                          onTapLinkDetails: _handleLinkTap,
                          onTapImage: _handleImageTap,
                          onTapHeading: _handleHeadingTap,
                          onDocumentReady: _setInteractionMetrics,
                        ),
                      ),
                    ),
                    const m.SizedBox(height: 10),
                    _interactionLogCard(),
                  ],
                ),
              ),
              const m.SizedBox(height: 14),
              _sectionCard(
                title: 'Filesystem Markdown Source',
                child: m.Column(
                  crossAxisAlignment: m.CrossAxisAlignment.start,
                  children: [
                    if (f.kIsWeb)
                      const m.Padding(
                        padding: m.EdgeInsets.only(bottom: 8),
                        child: m.Text(
                          'Filesystem source is unsupported on web builds, so this panel stays disabled there.',
                        ),
                      ),
                    m.TextField(
                      controller: _filePathController,
                      decoration: const m.InputDecoration(
                        labelText: 'Absolute markdown file path',
                        border: m.OutlineInputBorder(),
                      ),
                    ),
                    const m.SizedBox(height: 10),
                    m.OutlinedButton(
                      onPressed: () {
                        setState(() {
                          _filePath = _filePathController.text.trim();
                          _fileMetrics = null;
                        });
                      },
                      child: const m.Text('Load file markdown'),
                    ),
                    const m.SizedBox(height: 10),
                    _metricsBar(_fileMetrics),
                    const m.SizedBox(height: 10),
                    if (!f.kIsWeb)
                      _surface(
                        _markdownViewport(
                          context: context,
                          factor: 0.5,
                          min: 260,
                          max: 460,
                          child: Markdown.file(
                            key: m.ValueKey(_filePath),
                            path: _filePath,
                            selectable: false,
                            shrinkWrap: false,
                            followLinks: false,
                            imageBuilder: _previewImageBuilder,
                            onTapLinkDetails: _handleLinkTap,
                            onTapImage: _handleImageTap,
                            onTapHeading: _handleHeadingTap,
                            onDocumentReady: _setFileMetrics,
                            errorBuilder: (context, error) =>
                                m.Text('File load error: $error'),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  m.Widget _surface(m.Widget child) {
    return m.Container(
      width: double.infinity,
      padding: const m.EdgeInsets.all(14),
      decoration: m.BoxDecoration(
        border: m.Border.all(color: const m.Color(0x22000000)),
        borderRadius: m.BorderRadius.circular(12),
      ),
      child: child,
    );
  }

  m.Widget _sectionCard({required String title, required m.Widget child}) {
    return m.Container(
      width: double.infinity,
      padding: const m.EdgeInsets.all(14),
      decoration: m.BoxDecoration(
        border: m.Border.all(color: const m.Color(0x22000000)),
        borderRadius: m.BorderRadius.circular(12),
      ),
      child: m.Column(
        crossAxisAlignment: m.CrossAxisAlignment.start,
        children: [
          m.Text(
            title,
            style: const m.TextStyle(fontWeight: m.FontWeight.w700),
          ),
          const m.SizedBox(height: 10),
          child,
        ],
      ),
    );
  }

  m.Widget _buildShowcaseContent() {
    final data = _showcaseMarkdown;
    if (data != null) {
      return Markdown(
        data: data,
        selectable: false,
        shrinkWrap: false,
        followLinks: false,
        imageBuilder: _previewImageBuilder,
        onTapLinkDetails: _handleLinkTap,
        onTapImage: _handleImageTap,
        onTapHeading: _handleHeadingTap,
        onDocumentReady: _setShowcaseMetrics,
      );
    }
    final error = _showcaseError;
    if (error != null) {
      return m.Column(
        crossAxisAlignment: m.CrossAxisAlignment.start,
        children: [
          m.Text('Showcase asset load error: $error'),
          const m.SizedBox(height: 8),
          m.OutlinedButton(
            onPressed: _loadShowcaseAsset,
            child: const m.Text('Retry loading showcase'),
          ),
        ],
      );
    }
    return const m.Padding(
      padding: m.EdgeInsets.symmetric(vertical: 16),
      child: m.Center(child: m.CircularProgressIndicator()),
    );
  }

  m.Widget _choiceRow<T>({
    required String label,
    required List<T> values,
    required T current,
    required String Function(T value) text,
    required void Function(T value) onSelect,
  }) {
    return m.Column(
      crossAxisAlignment: m.CrossAxisAlignment.start,
      children: [
        m.Text(label),
        const m.SizedBox(height: 6),
        m.Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final value in values)
              m.ChoiceChip(
                label: m.Text(text(value)),
                selected: value == current,
                onSelected: (_) => onSelect(value),
              ),
          ],
        ),
      ],
    );
  }
}

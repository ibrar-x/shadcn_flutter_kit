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

  @override
  void initState() {
    super.initState();
    _filePathController = m.TextEditingController(text: _filePath);
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

  List<String> _streamUnits(_StreamMode mode, String input) {
    switch (mode) {
      case _StreamMode.character:
        return input.split('');
      case _StreamMode.word:
        return RegExp(
          r'\S+\s*|\n',
        ).allMatches(input).map((m) => m.group(0)!).toList(growable: false);
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

  @override
  m.Widget build(m.BuildContext context) {
    return m.Scaffold(
      body: m.Center(
        child: m.Padding(
          padding: const m.EdgeInsets.all(20),
          child: m.ConstrainedBox(
            constraints: const m.BoxConstraints(maxWidth: 980),
            child: m.SingleChildScrollView(
              child: m.Column(
                crossAxisAlignment: m.CrossAxisAlignment.start,
                children: [
                  const m.Text(
                    'Markdown (Advanced + Streaming)',
                    style: m.TextStyle(
                      fontSize: 20,
                      fontWeight: m.FontWeight.w700,
                    ),
                  ),
                  const m.SizedBox(height: 10),
                  const m.Text(
                    'Standalone markdown renderer with optional streaming extension via dot-operator. Links open by default, and the bundled showcase below exercises the full parser.',
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
                          onSelect: (value) =>
                              setState(() => _animation = value),
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
                            selectable: true,
                          ).withTextStreaming(
                            typewriter: const ta.TypewriterEffect(
                              enabled: false,
                            ),
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
                    child: _surface(
                      Markdown.asset(
                        asset: _showcaseAssetPath,
                        selectable: true,
                        errorBuilder: (context, error) =>
                            m.Text('Asset load error: $error'),
                      ),
                    ),
                  ),
                  const m.SizedBox(height: 14),
                  _sectionCard(
                    title: 'Inline API Sample',
                    child: _surface(
                      Markdown(data: _inlineMarkdown, selectable: true),
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
                              'Filesystem source is unsupported on web builds.',
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
                            });
                          },
                          child: const m.Text('Load file markdown'),
                        ),
                        const m.SizedBox(height: 10),
                        _surface(
                          Markdown.file(
                            key: m.ValueKey(_filePath),
                            path: _filePath,
                            selectable: true,
                            errorBuilder: (context, error) =>
                                m.Text('File load error: $error'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
              m.GestureDetector(
                onTap: () => onSelect(value),
                child: m.AnimatedContainer(
                  duration: const Duration(milliseconds: 160),
                  curve: m.Curves.easeOutCubic,
                  padding: const m.EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 7,
                  ),
                  decoration: m.BoxDecoration(
                    borderRadius: m.BorderRadius.circular(999),
                    color: value == current
                        ? const m.Color(0x22000000)
                        : const m.Color(0x11000000),
                    border: m.Border.all(
                      color: value == current
                          ? const m.Color(0x66000000)
                          : const m.Color(0x33000000),
                    ),
                  ),
                  child: m.Text(
                    text(value),
                    style: const m.TextStyle(fontSize: 12),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

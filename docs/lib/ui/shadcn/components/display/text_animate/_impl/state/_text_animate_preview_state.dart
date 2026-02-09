part of '../../preview.dart';

class _TextAnimatePreviewState extends m.State<TextAnimatePreview> {
  static const String _part1 = 'The assistant is thinking...';
  static const String _part2 =
      'The assistant is thinking...\nStreaming tokens into the UI in real time.';

  late final List<String> _charChunks;
  late final List<String> _wordChunks;
  late final List<String> _fixedChunks;
  late final List<String> _partChunks;

  Timer? _timer;

  String _charStreamed = '';
  String _wordStreamed = '';
  String _chunkStreamed = '';
  String _partStreamed = '';

  int _charIndex = 0;
  int _wordIndex = 0;
  int _chunkIndex = 0;
  int _partIndex = 0;
  int _tickCount = 0;

  double _streamIntervalMs = 80;

  @override
  void initState() {
    super.initState();
    _charChunks = _part2.runes.map((r) => String.fromCharCode(r)).toList();
    _wordChunks = _buildWordChunks(_part2);
    _fixedChunks = _buildFixedChunks(_part2, 16);
    _partChunks = [_part1, _part2];
    _startStream();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startStream() {
    _timer?.cancel();
    setState(() {
      _charStreamed = '';
      _wordStreamed = '';
      _chunkStreamed = '';
      _partStreamed = '';
      _charIndex = 0;
      _wordIndex = 0;
      _chunkIndex = 0;
      _partIndex = 0;
      _tickCount = 0;
    });
    _timer = Timer.periodic(Duration(milliseconds: _streamIntervalMs.round()), (
      timer,
    ) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      setState(() {
        _tickCount += 1;
        _advanceCharacterStream();
        if (_tickCount % 2 == 0) {
          _advanceWordStream();
        }
        if (_tickCount % 3 == 0) {
          _advanceChunkStream();
        }
        if (_tickCount % 6 == 0) {
          _advancePartStream();
        }
      });

      if (_isAllStreamsComplete) {
        timer.cancel();
      }
    });
  }

  bool get _isAllStreamsComplete {
    return _charIndex >= _charChunks.length &&
        _wordIndex >= _wordChunks.length &&
        _chunkIndex >= _fixedChunks.length &&
        _partIndex >= _partChunks.length;
  }

  void _advanceCharacterStream() {
    if (_charIndex >= _charChunks.length) return;
    _charStreamed = '$_charStreamed${_charChunks[_charIndex]}';
    _charIndex += 1;
  }

  void _advanceWordStream() {
    if (_wordIndex >= _wordChunks.length) return;
    _wordStreamed = '$_wordStreamed${_wordChunks[_wordIndex]}';
    _wordIndex += 1;
  }

  void _advanceChunkStream() {
    if (_chunkIndex >= _fixedChunks.length) return;
    _chunkStreamed = '$_chunkStreamed${_fixedChunks[_chunkIndex]}';
    _chunkIndex += 1;
  }

  void _advancePartStream() {
    if (_partIndex >= _partChunks.length) return;
    _partStreamed = _partChunks[_partIndex];
    _partIndex += 1;
  }

  @override
  m.Widget build(m.BuildContext context) {
    return m.Scaffold(
      body: m.Center(
        child: m.Padding(
          padding: const m.EdgeInsets.all(24),
          child: m.ConstrainedBox(
            constraints: const m.BoxConstraints(maxWidth: 980),
            child: m.SingleChildScrollView(
              child: m.Column(
                crossAxisAlignment: m.CrossAxisAlignment.start,
                children: [
                  const m.Text(
                    'Blur Streaming Options',
                    style: m.TextStyle(
                      fontSize: 18,
                      fontWeight: m.FontWeight.w700,
                    ),
                  ),
                  const m.SizedBox(height: 10),
                  const m.Text(
                    'Four examples with different stream update granularities.',
                  ),
                  const m.SizedBox(height: 16),
                  m.Wrap(
                    spacing: 14,
                    runSpacing: 14,
                    children: [
                      _exampleCard(
                        title: 'Character by Character',
                        subtitle: 'updates every tick',
                        child: StreamingText(
                          text: _charStreamed,
                          style: const m.TextStyle(fontSize: 17, height: 1.5),
                          typewriter: const TypewriterEffect(enabled: false),
                          effect: const BlurInEffect(
                            duration: Duration(milliseconds: 720),
                            maxBlurSigma: 14,
                            fadeIn: true,
                            slideUpPx: 6,
                          ),
                          cursor: const StreamingCursor.none(),
                        ),
                      ),
                      _exampleCard(
                        title: 'Word by Word',
                        subtitle: 'updates every 2 ticks',
                        child: StreamingText(
                          text: _wordStreamed,
                          style: const m.TextStyle(fontSize: 17, height: 1.5),
                          typewriter: const TypewriterEffect(enabled: false),
                          effect: const BlurInEffect(
                            duration: Duration(milliseconds: 780),
                            maxBlurSigma: 16,
                            fadeIn: true,
                            slideUpPx: 7,
                          ),
                          cursor: const StreamingCursor.none(),
                        ),
                      ),
                      _exampleCard(
                        title: 'Chunk-by-Chunk',
                        subtitle: '16-char chunks, every 3 ticks',
                        child: StreamingText(
                          text: _chunkStreamed,
                          style: const m.TextStyle(fontSize: 17, height: 1.5),
                          typewriter: const TypewriterEffect(enabled: false),
                          effect: const BlurInEffect(
                            duration: Duration(milliseconds: 840),
                            maxBlurSigma: 18,
                            fadeIn: true,
                            slideUpPx: 10,
                            curve: m.Curves.easeOutQuart,
                          ),
                          cursor: const StreamingCursor.none(),
                        ),
                      ),
                      _exampleCard(
                        title: 'Part Stream (part-1 -> part-2)',
                        subtitle: 'part-1 then full part-2, every 6 ticks',
                        child: StreamingText(
                          text: _partStreamed,
                          style: const m.TextStyle(fontSize: 17, height: 1.5),
                          typewriter: const TypewriterEffect(enabled: false),
                          effect: const BlurInEffect(
                            duration: Duration(milliseconds: 960),
                            maxBlurSigma: 20,
                            fadeIn: true,
                            slideUpPx: 10,
                          ),
                          cursor: const StreamingCursor.none(),
                        ),
                      ),
                    ],
                  ),
                  const m.SizedBox(height: 18),
                  m.Text(
                    'Base stream tick: ${_streamIntervalMs.toStringAsFixed(0)} ms',
                  ),
                  m.Slider(
                    value: _streamIntervalMs,
                    min: 30,
                    max: 260,
                    divisions: 20,
                    onChanged: (value) {
                      setState(() => _streamIntervalMs = value);
                    },
                  ),
                  const m.SizedBox(height: 6),
                  m.Row(
                    children: [
                      m.FilledButton(
                        onPressed: _startStream,
                        child: const m.Text('Restart stream'),
                      ),
                      const m.SizedBox(width: 12),
                      m.OutlinedButton(
                        onPressed: () {
                          _timer?.cancel();
                          setState(() {
                            _charStreamed = _part2;
                            _wordStreamed = _part2;
                            _chunkStreamed = _part2;
                            _partStreamed = _part2;
                          });
                        },
                        child: const m.Text('Show full text'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<String> _buildWordChunks(String text) {
    final matches = RegExp(r'\S+\s*').allMatches(text);
    final chunks = <String>[];
    for (final match in matches) {
      final value = match.group(0);
      if (value != null && value.isNotEmpty) {
        chunks.add(value);
      }
    }
    return chunks;
  }

  List<String> _buildFixedChunks(String text, int chunkSize) {
    if (chunkSize <= 0) {
      return [text];
    }
    final runes = text.runes.toList();
    final chunks = <String>[];
    for (var i = 0; i < runes.length; i += chunkSize) {
      final end = (i + chunkSize).clamp(0, runes.length);
      chunks.add(String.fromCharCodes(runes.sublist(i, end)));
    }
    return chunks;
  }

  m.Widget _exampleCard({
    required String title,
    required String subtitle,
    required m.Widget child,
  }) {
    return m.Container(
      width: 460,
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
            style: const m.TextStyle(
              fontSize: 14,
              fontWeight: m.FontWeight.w700,
            ),
          ),
          const m.SizedBox(height: 2),
          m.Text(subtitle, style: const m.TextStyle(fontSize: 12)),
          const m.SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}

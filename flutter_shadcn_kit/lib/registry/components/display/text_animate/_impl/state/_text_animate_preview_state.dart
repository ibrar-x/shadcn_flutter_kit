part of '../../preview.dart';

class _TextAnimatePreviewState extends m.State<TextAnimatePreview> {
  static const String _sample =
      'Streaming text makes responses feel alive in chat UIs.';

  late final List<String> _chars;
  Timer? _timer;

  String _streamed = '';
  bool _enableTypewriter = true;
  bool _enableBlur = true;
  bool _enableCursor = true;
  double _charsPerSecond = 50;

  @override
  void initState() {
    super.initState();
    _chars = _sample.runes.map((r) => String.fromCharCode(r)).toList();
    _startStream();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startStream() {
    _timer?.cancel();
    var index = 0;
    _streamed = '';
    _timer = Timer.periodic(const Duration(milliseconds: 42), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (index >= _chars.length) {
        timer.cancel();
        return;
      }
      setState(() {
        _streamed = '$_streamed${_chars[index]}';
        index += 1;
      });
    });
  }

  @override
  m.Widget build(m.BuildContext context) {
    return m.Scaffold(
      body: m.Center(
        child: m.Padding(
          padding: const m.EdgeInsets.all(24),
          child: m.ConstrainedBox(
            constraints: const m.BoxConstraints(maxWidth: 640),
            child: m.Column(
              mainAxisSize: m.MainAxisSize.min,
              crossAxisAlignment: m.CrossAxisAlignment.start,
              children: [
                m.Container(
                  width: double.infinity,
                  padding: const m.EdgeInsets.all(16),
                  decoration: m.BoxDecoration(
                    border: m.Border.all(color: const m.Color(0x22000000)),
                    borderRadius: m.BorderRadius.circular(12),
                  ),
                  child: StreamingText(
                    text: _streamed,
                    style: const m.TextStyle(fontSize: 16, height: 1.5),
                    typewriter: _enableTypewriter
                        ? TypewriterEffect(charsPerSecond: _charsPerSecond)
                        : const TypewriterEffect(enabled: false),
                    effect: _enableBlur
                        ? const BlurInEffect(
                            duration: Duration(milliseconds: 260),
                            maxBlurSigma: 6,
                            fadeIn: true,
                            slideUpPx: 2,
                          )
                        : const NoEffect(),
                    cursor: _enableCursor
                        ? const StreamingCursor.blink(showWhenSettled: false)
                        : const StreamingCursor.none(),
                  ),
                ),
                const m.SizedBox(height: 18),
                m.Row(
                  children: [
                    m.Expanded(
                      child: m.SwitchListTile.adaptive(
                        value: _enableTypewriter,
                        onChanged: (value) {
                          setState(() => _enableTypewriter = value);
                        },
                        title: const m.Text('Typewriter'),
                        contentPadding: m.EdgeInsets.zero,
                      ),
                    ),
                    const m.SizedBox(width: 12),
                    m.Expanded(
                      child: m.SwitchListTile.adaptive(
                        value: _enableBlur,
                        onChanged: (value) {
                          setState(() => _enableBlur = value);
                        },
                        title: const m.Text('Blur-in'),
                        contentPadding: m.EdgeInsets.zero,
                      ),
                    ),
                    const m.SizedBox(width: 12),
                    m.Expanded(
                      child: m.SwitchListTile.adaptive(
                        value: _enableCursor,
                        onChanged: (value) {
                          setState(() => _enableCursor = value);
                        },
                        title: const m.Text('Cursor'),
                        contentPadding: m.EdgeInsets.zero,
                      ),
                    ),
                  ],
                ),
                const m.SizedBox(height: 12),
                m.Text(
                  'Characters/second: ${_charsPerSecond.toStringAsFixed(0)}',
                ),
                m.Slider(
                  value: _charsPerSecond,
                  min: 10,
                  max: 120,
                  divisions: 22,
                  onChanged: (value) => setState(() => _charsPerSecond = value),
                ),
                const m.SizedBox(height: 8),
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
                        setState(() => _streamed = _sample);
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
    );
  }
}

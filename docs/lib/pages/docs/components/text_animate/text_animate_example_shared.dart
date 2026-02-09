import 'dart:async';

import 'package:flutter/widgets.dart';

import '../../../../ui/shadcn/components/display/text_animate/text_animate.dart'
    as shadcn_text_animate;

const String kTextAnimatePart1 = 'The assistant is thinking...';
const String kTextAnimatePart2 =
    'The assistant is thinking...\nStreaming tokens into the UI in real time.';

List<String> textAnimateCharacterChunks(String text) {
  return text.runes.map((rune) => String.fromCharCode(rune)).toList();
}

List<String> textAnimateWordChunks(String text) {
  final matches = RegExp(r'\S+\s*').allMatches(text);
  return [
    for (final match in matches)
      if ((match.group(0) ?? '').isNotEmpty) match.group(0)!,
  ];
}

List<String> textAnimateFixedChunks(String text, int chunkSize) {
  final runes = text.runes.toList();
  final chunks = <String>[];
  for (var i = 0; i < runes.length; i += chunkSize) {
    final end = (i + chunkSize).clamp(0, runes.length);
    chunks.add(String.fromCharCodes(runes.sublist(i, end)));
  }
  return chunks;
}

class TextAnimateStreamingDemo extends StatefulWidget {
  const TextAnimateStreamingDemo({
    super.key,
    required this.chunks,
    required this.backgroundDescription,
    required this.tick,
    this.replaceValue = false,
    this.blurDuration = const Duration(milliseconds: 780),
    this.blurSigma = 16,
    this.slideUpPx = 8,
  });

  final List<String> chunks;
  final String backgroundDescription;
  final Duration tick;
  final bool replaceValue;
  final Duration blurDuration;
  final double blurSigma;
  final double slideUpPx;

  @override
  State<TextAnimateStreamingDemo> createState() =>
      _TextAnimateStreamingDemoState();
}

class _TextAnimateStreamingDemoState extends State<TextAnimateStreamingDemo> {
  Timer? _timer;
  String _streamed = '';
  int _index = 0;
  int _idleTicks = 0;

  @override
  void initState() {
    super.initState();
    _start();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _start() {
    _timer?.cancel();
    _timer = Timer.periodic(widget.tick, (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      if (_index < widget.chunks.length) {
        setState(() {
          if (widget.replaceValue) {
            _streamed = widget.chunks[_index];
          } else {
            _streamed = '$_streamed${widget.chunks[_index]}';
          }
          _index += 1;
          _idleTicks = 0;
        });
        return;
      }

      _idleTicks += 1;
      if (_idleTicks >= 12) {
        setState(() {
          _streamed = '';
          _index = 0;
          _idleTicks = 0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 620),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.backgroundDescription,
            style: const TextStyle(fontSize: 12, height: 1.4),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0x22000000)),
              borderRadius: BorderRadius.circular(10),
            ),
            child: shadcn_text_animate.StreamingText(
              text: _streamed,
              style: const TextStyle(fontSize: 16, height: 1.5),
              typewriter:
                  const shadcn_text_animate.TypewriterEffect(enabled: false),
              effect: shadcn_text_animate.BlurInEffect(
                duration: widget.blurDuration,
                maxBlurSigma: widget.blurSigma,
                fadeIn: true,
                slideUpPx: widget.slideUpPx,
              ),
              cursor: const shadcn_text_animate.StreamingCursor.none(),
            ),
          ),
        ],
      ),
    );
  }
}

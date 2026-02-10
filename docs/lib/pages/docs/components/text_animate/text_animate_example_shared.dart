import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../ui/shadcn/components/display/text_animate/text_animate.dart'
    as shadcn_text_animate;

const String kTextAnimatePart1 = 'The assistant is thinking...';
const String kTextAnimatePart2 =
    'The assistant is thinking...\nStreaming tokens into the UI in real time.';

final ValueNotifier<double> textAnimateGlobalSlowFactor = ValueNotifier(1.0);

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

enum TextAnimateStreamMode { character, word, chunk, part }

String textAnimateModeLabel(TextAnimateStreamMode mode) {
  switch (mode) {
    case TextAnimateStreamMode.character:
      return 'Character by Character';
    case TextAnimateStreamMode.word:
      return 'Word by Word';
    case TextAnimateStreamMode.chunk:
      return 'Chunk-by-Chunk';
    case TextAnimateStreamMode.part:
      return 'Part Stream';
  }
}

String textAnimateModeBackground(TextAnimateStreamMode mode) {
  switch (mode) {
    case TextAnimateStreamMode.character:
      return 'Background: appends one rune per tick.';
    case TextAnimateStreamMode.word:
      return 'Background: appends one word unit (with spacing) every 2 ticks.';
    case TextAnimateStreamMode.chunk:
      return 'Background: appends fixed-size 16-character chunks every 3 ticks.';
    case TextAnimateStreamMode.part:
      return 'Background: replaces full value part-1 -> part-2, diff animates only new tail.';
  }
}

typedef TextAnimateEffectBuilder
    = shadcn_text_animate.StreamingTextEffectAdapter Function(
        double slowFactor);
typedef TextAnimateTypewriterBuilder = shadcn_text_animate.TypewriterEffect
    Function(double slowFactor);

class TextAnimateUniversalSpeedControl extends StatelessWidget {
  const TextAnimateUniversalSpeedControl({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: textAnimateGlobalSlowFactor,
      builder: (context, factor, _) {
        return ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 620),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Universal slower: ${factor.toStringAsFixed(2)}x',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 6),
              const Text(
                'This controls stream update pace and animation speed across all text_animate examples on this page.',
                style: TextStyle(fontSize: 12, height: 1.35),
              ),
              const SizedBox(height: 8),
              Slider(
                value: factor,
                min: 0.5,
                max: 2.5,
                divisions: 20,
                onChanged: (value) {
                  textAnimateGlobalSlowFactor.value = value;
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class TextAnimateAnimationModesDemo extends StatefulWidget {
  const TextAnimateAnimationModesDemo({
    super.key,
    required this.animationDescription,
    required this.effectBuilder,
    required this.typewriterBuilder,
    this.animateByWord = false,
  });

  final String animationDescription;
  final TextAnimateEffectBuilder effectBuilder;
  final TextAnimateTypewriterBuilder typewriterBuilder;
  final bool animateByWord;

  @override
  State<TextAnimateAnimationModesDemo> createState() =>
      _TextAnimateAnimationModesDemoState();
}

class _TextAnimateAnimationModesDemoState
    extends State<TextAnimateAnimationModesDemo> {
  late final Map<TextAnimateStreamMode, List<String>> _chunksByMode;
  TextAnimateStreamMode _selectedMode = TextAnimateStreamMode.character;
  Timer? _timer;

  String _streamed = '';
  int _index = 0;
  int _idleTicks = 0;

  @override
  void initState() {
    super.initState();
    _chunksByMode = {
      TextAnimateStreamMode.character:
          textAnimateCharacterChunks(kTextAnimatePart2),
      TextAnimateStreamMode.word: textAnimateWordChunks(kTextAnimatePart2),
      TextAnimateStreamMode.chunk:
          textAnimateFixedChunks(kTextAnimatePart2, 16),
      TextAnimateStreamMode.part: const [kTextAnimatePart1, kTextAnimatePart2],
    };
    textAnimateGlobalSlowFactor.addListener(_onGlobalSlowFactorChanged);
    _start();
  }

  @override
  void dispose() {
    textAnimateGlobalSlowFactor.removeListener(_onGlobalSlowFactorChanged);
    _timer?.cancel();
    super.dispose();
  }

  void _onGlobalSlowFactorChanged() {
    _start();
  }

  void _setMode(TextAnimateStreamMode mode) {
    if (_selectedMode == mode) {
      return;
    }
    setState(() {
      _selectedMode = mode;
    });
    _start();
  }

  void _start() {
    _timer?.cancel();
    if (!mounted) {
      return;
    }

    setState(() {
      _streamed = '';
      _index = 0;
      _idleTicks = 0;
    });

    final tick = _tickDuration(_selectedMode);
    _timer = Timer.periodic(tick, (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      final chunks = _chunksByMode[_selectedMode] ?? const <String>[];
      if (_index < chunks.length) {
        setState(() {
          if (_selectedMode == TextAnimateStreamMode.part) {
            _streamed = chunks[_index];
          } else {
            _streamed = '$_streamed${chunks[_index]}';
          }
          _index += 1;
          _idleTicks = 0;
        });
        return;
      }

      _idleTicks += 1;
      if (_idleTicks >= 10) {
        setState(() {
          _streamed = '';
          _index = 0;
          _idleTicks = 0;
        });
      }
    });
  }

  Duration _tickDuration(TextAnimateStreamMode mode) {
    final baseMs = switch (mode) {
      TextAnimateStreamMode.character => 58,
      TextAnimateStreamMode.word => 190,
      TextAnimateStreamMode.chunk => 260,
      TextAnimateStreamMode.part => 920,
    };

    final scaled = (baseMs * textAnimateGlobalSlowFactor.value).round();
    return Duration(milliseconds: scaled.clamp(24, 5000));
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: textAnimateGlobalSlowFactor,
      builder: (context, slowFactor, _) {
        return ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.animationDescription,
                style: const TextStyle(fontSize: 12, height: 1.35),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _modeButton(TextAnimateStreamMode.character),
                  _modeButton(TextAnimateStreamMode.word),
                  _modeButton(TextAnimateStreamMode.chunk),
                  _modeButton(TextAnimateStreamMode.part),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                textAnimateModeBackground(_selectedMode),
                style: const TextStyle(fontSize: 12, height: 1.35),
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
                  typewriter: widget.typewriterBuilder(slowFactor),
                  animateByWord: widget.animateByWord,
                  effect: widget.effectBuilder(slowFactor),
                  cursor: const shadcn_text_animate.StreamingCursor.none(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _modeButton(TextAnimateStreamMode mode) {
    final selected = _selectedMode == mode;
    final child = Text(textAnimateModeLabel(mode));

    if (selected) {
      return FilledButton(
        onPressed: () => _setMode(mode),
        child: child,
      );
    }

    return OutlinedButton(
      onPressed: () => _setMode(mode),
      child: child,
    );
  }
}

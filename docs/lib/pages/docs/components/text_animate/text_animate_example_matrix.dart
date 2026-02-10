import 'dart:async';

import 'package:flutter/material.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/display/text_animate/text_animate.dart'
    as shadcn_text_animate;

const ComponentExample textAnimateMatrixExample = ComponentExample(
  title: 'Streaming Matrix: All Modes x All Animations',
  builder: _buildTextAnimateMatrixExample,
  code: '''// 4 streaming modes x 4 animation variants (responsive grid)
// Modes: Character, Word, Chunk, Part-stream (full snapshot replacement)
// Animations: BlurIn, FadeIn, SlideIn, ScrambleIn
//
// Background behavior per mode:
// - Character: append one rune each tick.
// - Word: append one word unit (with spacing) every 2 ticks.
// - Chunk: append fixed-size chunks every 3 ticks.
// - Part stream: emit full snapshots in two parts; diff animates only new tail.
//
// Each cell renders:
// StreamingText(
//   text: streamedForMode,
//   typewriter: const TypewriterEffect(enabled: false),
//   effect: selectedAnimationEffect,
//   cursor: const StreamingCursor.none(),
// )''',
);

Widget _buildTextAnimateMatrixExample(BuildContext context) {
  return const _TextAnimateMatrixDemo();
}

enum _StreamingMode { character, word, chunk, part }

enum _AnimationVariant { blur, fade, slide, scramble }

class _TextAnimateMatrixDemo extends StatefulWidget {
  const _TextAnimateMatrixDemo();

  @override
  State<_TextAnimateMatrixDemo> createState() => _TextAnimateMatrixDemoState();
}

class _TextAnimateMatrixDemoState extends State<_TextAnimateMatrixDemo> {
  static const String _part1 = 'The assistant is thinking...';
  static const String _part2 =
      'The assistant is thinking...\nStreaming tokens into the UI in real time.';

  static const List<_StreamingMode> _modes = [
    _StreamingMode.character,
    _StreamingMode.word,
    _StreamingMode.chunk,
    _StreamingMode.part,
  ];

  static const List<_AnimationVariant> _animations = [
    _AnimationVariant.blur,
    _AnimationVariant.fade,
    _AnimationVariant.slide,
    _AnimationVariant.scramble,
  ];

  late final Map<_StreamingMode, List<String>> _chunksByMode;
  late final Map<_StreamingMode, String> _streamByMode;
  late final Map<_StreamingMode, int> _indexByMode;

  Timer? _timer;
  int _tickCount = 0;
  double _streamIntervalMs = 70;

  @override
  void initState() {
    super.initState();
    _chunksByMode = {
      _StreamingMode.character:
          _part2.runes.map((rune) => String.fromCharCode(rune)).toList(),
      _StreamingMode.word: _buildWordChunks(_part2),
      _StreamingMode.chunk: _buildFixedChunks(_part2, 16),
      _StreamingMode.part: [_part1, _part2],
    };
    _streamByMode = {for (final mode in _modes) mode: ''};
    _indexByMode = {for (final mode in _modes) mode: 0};
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
      _tickCount = 0;
      for (final mode in _modes) {
        _streamByMode[mode] = '';
        _indexByMode[mode] = 0;
      }
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
        for (final mode in _modes) {
          final factor = _modeTickFactor(mode);
          if (_tickCount % factor == 0) {
            _advanceStream(mode);
          }
        }
      });

      if (_isAllStreamsComplete) {
        timer.cancel();
      }
    });
  }

  bool get _isAllStreamsComplete {
    for (final mode in _modes) {
      final index = _indexByMode[mode] ?? 0;
      final chunks = _chunksByMode[mode] ?? const <String>[];
      if (index < chunks.length) {
        return false;
      }
    }
    return true;
  }

  void _advanceStream(_StreamingMode mode) {
    final chunks = _chunksByMode[mode] ?? const <String>[];
    final index = _indexByMode[mode] ?? 0;
    if (index >= chunks.length) {
      return;
    }

    if (mode == _StreamingMode.part) {
      _streamByMode[mode] = chunks[index];
    } else {
      _streamByMode[mode] = '${_streamByMode[mode]}${chunks[index]}';
    }
    _indexByMode[mode] = index + 1;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildGrid(),
        const SizedBox(height: 12),
        Text('Base stream tick: ${_streamIntervalMs.toStringAsFixed(0)} ms'),
        Slider(
          value: _streamIntervalMs,
          min: 30,
          max: 260,
          divisions: 23,
          onChanged: (value) {
            setState(() => _streamIntervalMs = value);
          },
        ),
        const SizedBox(height: 4),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            FilledButton(
              onPressed: _startStream,
              child: const Text('Restart stream'),
            ),
            OutlinedButton(
              onPressed: () {
                _timer?.cancel();
                setState(() {
                  for (final mode in _modes) {
                    _streamByMode[mode] = _part2;
                    _indexByMode[mode] =
                        (_chunksByMode[mode] ?? const <String>[]).length;
                  }
                });
              },
              child: const Text('Show full text'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGrid() {
    final cells = <Widget>[];
    for (final animation in _animations) {
      for (final mode in _modes) {
        cells.add(_buildCell(animation: animation, mode: mode));
      }
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final columns = width >= 1440
            ? 4
            : width >= 1040
                ? 3
                : width >= 700
                    ? 2
                    : 1;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: cells.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            mainAxisExtent: 250,
          ),
          itemBuilder: (context, index) => cells[index],
        );
      },
    );
  }

  Widget _buildCell({
    required _AnimationVariant animation,
    required _StreamingMode mode,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0x22000000)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${_animationLabel(animation)} - ${_modeLabel(mode)}',
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 2),
          Text(
            _modeDescription(mode),
            style: const TextStyle(fontSize: 11, height: 1.3),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            _animationDescription(animation),
            style: const TextStyle(fontSize: 11, height: 1.3),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            constraints: const BoxConstraints(minHeight: 92),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0x05000000),
              borderRadius: BorderRadius.circular(10),
            ),
            child: shadcn_text_animate.StreamingText(
              text: _streamByMode[mode] ?? '',
              style: const TextStyle(fontSize: 16, height: 1.45),
              typewriter:
                  const shadcn_text_animate.TypewriterEffect(enabled: false),
              effect: _effectFor(animation),
              cursor: const shadcn_text_animate.StreamingCursor.none(),
            ),
          ),
        ],
      ),
    );
  }

  shadcn_text_animate.StreamingTextEffectAdapter _effectFor(
    _AnimationVariant animation,
  ) {
    switch (animation) {
      case _AnimationVariant.blur:
        return const shadcn_text_animate.BlurInEffect(
          duration: Duration(milliseconds: 840),
          maxBlurSigma: 20,
          fadeIn: true,
          slideUpPx: 8,
          curve: Curves.easeOutQuart,
        );
      case _AnimationVariant.fade:
        return const shadcn_text_animate.FadeInEffect(
          duration: Duration(milliseconds: 560),
          curve: Curves.easeOut,
        );
      case _AnimationVariant.slide:
        return const shadcn_text_animate.SlideInEffect(
          duration: Duration(milliseconds: 640),
          offsetY: 13,
          fadeIn: true,
          curve: Curves.easeOutCubic,
        );
      case _AnimationVariant.scramble:
        return const shadcn_text_animate.ScrambleInEffect(
          duration: Duration(milliseconds: 760),
          scrambleUntil: 0.78,
          fadeIn: true,
        );
    }
  }

  int _modeTickFactor(_StreamingMode mode) {
    switch (mode) {
      case _StreamingMode.character:
        return 1;
      case _StreamingMode.word:
        return 2;
      case _StreamingMode.chunk:
        return 3;
      case _StreamingMode.part:
        return 6;
    }
  }

  String _modeLabel(_StreamingMode mode) {
    switch (mode) {
      case _StreamingMode.character:
        return 'Character by Character';
      case _StreamingMode.word:
        return 'Word by Word';
      case _StreamingMode.chunk:
        return 'Chunk-by-Chunk';
      case _StreamingMode.part:
        return 'Part Stream';
    }
  }

  String _modeDescription(_StreamingMode mode) {
    switch (mode) {
      case _StreamingMode.character:
        return 'Background: one rune is appended every tick.';
      case _StreamingMode.word:
        return 'Background: one word unit (with spacing) appends every 2 ticks.';
      case _StreamingMode.chunk:
        return 'Background: fixed 16-character chunks append every 3 ticks.';
      case _StreamingMode.part:
        return 'Background: full snapshots part-1 then part-2; diff animates only the new tail.';
    }
  }

  String _animationLabel(_AnimationVariant animation) {
    switch (animation) {
      case _AnimationVariant.blur:
        return 'Blur In';
      case _AnimationVariant.fade:
        return 'Fade In';
      case _AnimationVariant.slide:
        return 'Slide In';
      case _AnimationVariant.scramble:
        return 'Scramble In';
    }
  }

  String _animationDescription(_AnimationVariant animation) {
    switch (animation) {
      case _AnimationVariant.blur:
        return 'Animation: starts blurred and settles to sharp text.';
      case _AnimationVariant.fade:
        return 'Animation: new text fades from transparent to visible.';
      case _AnimationVariant.slide:
        return 'Animation: new text rises while fading into place.';
      case _AnimationVariant.scramble:
        return 'Animation: glyphs scramble briefly, then resolve to final text.';
    }
  }

  List<String> _buildWordChunks(String text) {
    final matches = RegExp(r'\S+\s*').allMatches(text);
    return [
      for (final match in matches)
        if ((match.group(0) ?? '').isNotEmpty) match.group(0)!,
    ];
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
}

import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import 'text_animate_example_shared.dart';

const ComponentExample textAnimateChunkExample = ComponentExample(
  title: 'Blur Stream: Chunk-by-Chunk',
  builder: _buildTextAnimateChunkExample,
  code: '''final chunks = splitIntoFixedChunks(text, 16);

StreamingText(
  text: streamed,
  typewriter: const TypewriterEffect(enabled: false),
  effect: const BlurInEffect(
    duration: Duration(milliseconds: 860),
    maxBlurSigma: 18,
    fadeIn: true,
    slideUpPx: 10,
  ),
)

// Background behavior:
// - The source text is split into fixed-size chunks.
// - Each tick appends one chunk, often containing partial words.
// - StreamingText animates each incoming chunk as one streamed update.''',
);

Widget _buildTextAnimateChunkExample(BuildContext context) {
  return TextAnimateStreamingDemo(
    chunks: textAnimateFixedChunks(kTextAnimatePart2, 16),
    tick: const Duration(milliseconds: 260),
    blurDuration: const Duration(milliseconds: 860),
    blurSigma: 18,
    slideUpPx: 10,
    backgroundDescription:
        'Background: fixed-size (16-char) chunks are appended per tick, similar to transport-level chunked streaming.',
  );
}

import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import 'text_animate_example_shared.dart';

const ComponentExample textAnimateWordExample = ComponentExample(
  title: 'Blur Stream: Word by Word',
  builder: _buildTextAnimateWordExample,
  code: '''final chunks = text.splitWordsPreservingSpace();

StreamingText(
  text: streamed,
  typewriter: const TypewriterEffect(enabled: false),
  effect: const BlurInEffect(
    duration: Duration(milliseconds: 820),
    maxBlurSigma: 16,
    fadeIn: true,
    slideUpPx: 8,
  ),
)

// Background behavior:
// - Each tick appends one full word chunk (including trailing space/newline).
// - StreamingText sees a larger appended segment and animates that incoming chunk.
// - Prior words remain fixed and do not re-animate.''',
);

Widget _buildTextAnimateWordExample(BuildContext context) {
  return TextAnimateStreamingDemo(
    chunks: textAnimateWordChunks(kTextAnimatePart2),
    tick: const Duration(milliseconds: 190),
    blurDuration: const Duration(milliseconds: 820),
    blurSigma: 16,
    slideUpPx: 8,
    backgroundDescription:
        'Background: one word chunk (with spacing) is appended per tick, so blur animates at word granularity instead of per-character.',
  );
}

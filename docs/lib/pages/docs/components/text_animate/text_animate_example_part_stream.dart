import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import 'text_animate_example_shared.dart';

const ComponentExample textAnimatePartStreamExample = ComponentExample(
  title: 'Blur Stream: Part Stream (part-1 -> part-2)',
  builder: _buildTextAnimatePartStreamExample,
  code: '''const part1 = 'The assistant is thinking...';
const part2 =
    'The assistant is thinking...\\nStreaming tokens into the UI in real time.';

StreamingText(
  text: currentPart,
  typewriter: const TypewriterEffect(enabled: false),
  effect: const BlurInEffect(
    duration: Duration(milliseconds: 960),
    maxBlurSigma: 20,
    fadeIn: true,
    slideUpPx: 10,
  ),
)

// Background behavior:
// - Tick 1 sets full text to part-1.
// - Tick 2 replaces value with part-2 (full latest text so far).
// - StreamingText computes longest common prefix and animates only the newly appended tail.''',
);

Widget _buildTextAnimatePartStreamExample(BuildContext context) {
  return const TextAnimateStreamingDemo(
    chunks: [kTextAnimatePart1, kTextAnimatePart2],
    replaceValue: true,
    tick: Duration(milliseconds: 900),
    blurDuration: Duration(milliseconds: 960),
    blurSigma: 20,
    slideUpPx: 10,
    backgroundDescription:
        'Background: stream emits full text snapshots in two parts. The second update replaces the first with a longer full value; diffing animates only the new tail.',
  );
}

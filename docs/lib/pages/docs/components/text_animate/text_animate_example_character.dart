import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import 'text_animate_example_shared.dart';

const ComponentExample textAnimateCharacterExample = ComponentExample(
  title: 'Blur Stream: Character by Character',
  builder: _buildTextAnimateCharacterExample,
  code: '''StreamingText(
  text: streamed,
  typewriter: const TypewriterEffect(enabled: false),
  effect: const BlurInEffect(
    duration: Duration(milliseconds: 720),
    maxBlurSigma: 14,
    fadeIn: true,
    slideUpPx: 6,
  ),
)

// Background behavior:
// - Every tick appends one character to the full text value.
// - StreamingText diffs old/new text, then animates the newly appended char.
// - Existing text stays stable while only the incoming char blurs -> sharp.''',
);

Widget _buildTextAnimateCharacterExample(BuildContext context) {
  return TextAnimateStreamingDemo(
    chunks: textAnimateCharacterChunks(kTextAnimatePart2),
    tick: const Duration(milliseconds: 60),
    blurDuration: const Duration(milliseconds: 720),
    blurSigma: 14,
    slideUpPx: 6,
    backgroundDescription:
        'Background: one character is appended per tick. Only the newly appended character runs blur->sharp animation.',
  );
}

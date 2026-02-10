import 'package:flutter/widgets.dart';

import '../../../../ui/shadcn/components/display/text_animate/text_animate.dart'
    as shadcn_text_animate;
import '../../component_example_models.dart';
import 'text_animate_example_shared.dart';

const ComponentExample textAnimateScrambleModesExample = ComponentExample(
  title: 'Scramble Animation (4 Streaming Types)',
  builder: _buildTextAnimateScrambleModesExample,
  code: '''TextAnimateAnimationModesDemo(
  animationDescription: 'Scramble-in effect with mode toggle buttons.',
  typewriterBuilder: (_) => const TypewriterEffect(enabled: false),
  effectBuilder: (slow) => ScrambleInEffect(
    duration: Duration(milliseconds: (760 * slow).round()),
    scrambleUntil: 0.78,
  ),
)

// 4 mode buttons inside preview:
// Character by Character | Word by Word | Chunk-by-Chunk | Part Stream''',
);

Widget _buildTextAnimateScrambleModesExample(BuildContext context) {
  return TextAnimateAnimationModesDemo(
    animationDescription:
        'Animation: glyphs scramble through random symbols before settling into final text.',
    typewriterBuilder: (_) => const shadcn_text_animate.TypewriterEffect(
      enabled: false,
    ),
    effectBuilder: (slow) => shadcn_text_animate.ScrambleInEffect(
      duration: Duration(milliseconds: (760 * slow).round()),
      scrambleUntil: 0.78,
    ),
  );
}

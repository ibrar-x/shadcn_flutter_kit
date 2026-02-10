import 'package:flutter/widgets.dart';

import '../../../../ui/shadcn/components/display/text_animate/text_animate.dart'
    as shadcn_text_animate;
import '../../component_example_models.dart';
import 'text_animate_example_shared.dart';

const ComponentExample textAnimateTypewriterModesExample = ComponentExample(
  title: 'Typewriter Animation (4 Streaming Types)',
  builder: _buildTextAnimateTypewriterModesExample,
  code: '''TextAnimateAnimationModesDemo(
  animationDescription: 'Typewriter reveal with mode toggle buttons.',
  typewriterBuilder: (slow) => TypewriterEffect(
    enabled: true,
    charsPerSecond: (34 / slow).clamp(8, 80),
  ),
  effectBuilder: (_) => const NoEffect(),
)

// 4 mode buttons inside preview:
// Character by Character | Word by Word | Chunk-by-Chunk | Part Stream''',
);

Widget _buildTextAnimateTypewriterModesExample(BuildContext context) {
  return TextAnimateAnimationModesDemo(
    animationDescription:
        'Animation: newly appended tail reveals with a typewriter progression.',
    typewriterBuilder: (slow) => shadcn_text_animate.TypewriterEffect(
      enabled: true,
      charsPerSecond: (34 / slow).clamp(8, 80),
    ),
    effectBuilder: (_) => const shadcn_text_animate.NoEffect(),
  );
}

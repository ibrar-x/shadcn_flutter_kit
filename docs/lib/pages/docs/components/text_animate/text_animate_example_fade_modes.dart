import 'package:flutter/widgets.dart';

import '../../../../ui/shadcn/components/display/text_animate/text_animate.dart'
    as shadcn_text_animate;
import '../../component_example_models.dart';
import 'text_animate_example_shared.dart';

const ComponentExample textAnimateFadeModesExample = ComponentExample(
  title: 'Fade Animation (4 Streaming Types)',
  builder: _buildTextAnimateFadeModesExample,
  code: '''TextAnimateAnimationModesDemo(
  animationDescription: 'Fade-in effect with mode toggle buttons.',
  typewriterBuilder: (_) => const TypewriterEffect(enabled: false),
  effectBuilder: (slow) => FadeInEffect(
    duration: Duration(milliseconds: (560 * slow).round()),
  ),
)

// 4 mode buttons inside preview:
// Character by Character | Word by Word | Chunk-by-Chunk | Part Stream''',
);

Widget _buildTextAnimateFadeModesExample(BuildContext context) {
  return TextAnimateAnimationModesDemo(
    animationDescription:
        'Animation: newly arrived text fades from transparent to fully visible.',
    typewriterBuilder: (_) => const shadcn_text_animate.TypewriterEffect(
      enabled: false,
    ),
    effectBuilder: (slow) => shadcn_text_animate.FadeInEffect(
      duration: Duration(milliseconds: (560 * slow).round()),
    ),
  );
}

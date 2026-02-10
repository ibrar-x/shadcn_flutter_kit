import 'package:flutter/widgets.dart';

import '../../../../ui/shadcn/components/display/text_animate/text_animate.dart'
    as shadcn_text_animate;
import '../../component_example_models.dart';
import 'text_animate_example_shared.dart';

const ComponentExample textAnimateBlurModesExample = ComponentExample(
  title: 'Blur Animation (4 Streaming Types)',
  builder: _buildTextAnimateBlurModesExample,
  code: '''TextAnimateAnimationModesDemo(
  animationDescription: 'Blur-in effect with mode toggle buttons.',
  typewriterBuilder: (_) => const TypewriterEffect(enabled: false),
  effectBuilder: (slow) => BlurInEffect(
    duration: Duration(milliseconds: (840 * slow).round()),
    maxBlurSigma: 20,
    fadeIn: true,
    slideUpPx: 8,
  ),
)

// 4 mode buttons inside preview:
// Character by Character | Word by Word | Chunk-by-Chunk | Part Stream''',
);

Widget _buildTextAnimateBlurModesExample(BuildContext context) {
  return TextAnimateAnimationModesDemo(
    animationDescription:
        'Animation: incoming text starts blurred and settles to sharp text.',
    typewriterBuilder: (_) => const shadcn_text_animate.TypewriterEffect(
      enabled: false,
    ),
    effectBuilder: (slow) => shadcn_text_animate.BlurInEffect(
      duration: Duration(milliseconds: (840 * slow).round()),
      maxBlurSigma: 20,
      fadeIn: true,
      slideUpPx: 8,
    ),
  );
}

import 'package:flutter/widgets.dart';

import '../../../../ui/shadcn/components/display/text_animate/text_animate.dart'
    as shadcn_text_animate;
import '../../component_example_models.dart';
import 'text_animate_example_shared.dart';

const ComponentExample textAnimateSlideModesExample = ComponentExample(
  title: 'Slide Animation (4 Streaming Types)',
  builder: _buildTextAnimateSlideModesExample,
  code: '''TextAnimateAnimationModesDemo(
  animationDescription: 'Slide-in effect with mode toggle buttons.',
  typewriterBuilder: (_) => const TypewriterEffect(enabled: false),
  effectBuilder: (slow) => SlideInEffect(
    duration: Duration(milliseconds: (640 * slow).round()),
    offsetY: 13,
    fadeIn: true,
  ),
)

// 4 mode buttons inside preview:
// Character by Character | Word by Word | Chunk-by-Chunk | Part Stream''',
);

Widget _buildTextAnimateSlideModesExample(BuildContext context) {
  return TextAnimateAnimationModesDemo(
    animationDescription:
        'Animation: new text slides upward and fades into final position.',
    typewriterBuilder: (_) => const shadcn_text_animate.TypewriterEffect(
      enabled: false,
    ),
    effectBuilder: (slow) => shadcn_text_animate.SlideInEffect(
      duration: Duration(milliseconds: (640 * slow).round()),
      offsetY: 13,
      fadeIn: true,
    ),
  );
}

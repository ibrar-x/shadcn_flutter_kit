import 'package:flutter/widgets.dart';

import '../../../../ui/shadcn/components/display/feature_carousel/feature_carousel.dart';
import '../../../../ui/shadcn/shared/icons/lucide_icons.dart';

class FeatureCarouselExample1 extends StatefulWidget {
  const FeatureCarouselExample1({super.key});

  @override
  State<FeatureCarouselExample1> createState() =>
      _FeatureCarouselExample1State();
}

class _FeatureCarouselExample1State extends State<FeatureCarouselExample1> {
  late final FeatureCarouselController _controller = FeatureCarouselController(
    showCta: false,
    showNavArrows: true,
    autoPlay: true,
    autoPlayInterval: const Duration(seconds: 4),
    animationStyle: FeatureCarouselAnimationStyle.zoomFade,
    cycleAnimationStyles: false,
    enableSwipe: true,
    enableKeyboardNavigation: true,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 840,
      child: FeatureCardCarousel(
        controller: _controller,
        items: const [
          FeatureCarouselItem(
            title: 'Add a Color Palette Selector',
            description:
                'Allow users to pick specific palettes or dominant colors to refine their results.',
            icon: LucideIcons.palette,
            accentColor: Color(0xFF7EA3FF),
          ),
          FeatureCarouselItem(
            title: 'Add a Style Preset Picker',
            description:
                'Offer curated styles like minimal, neon, or vintage to guide output.',
            icon: LucideIcons.sparkles,
            accentColor: Color(0xFF9B87FF),
          ),
          FeatureCarouselItem(
            title: 'Add a Detail Slider',
            description:
                'Let users control complexity and sharpness without overwhelming options.',
            icon: LucideIcons.slidersHorizontal,
            accentColor: Color(0xFF67D4FF),
          ),
        ],
      ),
    );
  }
}

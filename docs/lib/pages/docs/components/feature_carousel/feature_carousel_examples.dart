import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import 'feature_carousel_example_1.dart';

const ComponentExample featureCarouselExample1 = ComponentExample(
  title: 'Feature carousel',
  builder: _buildFeatureCarouselExample1,
  code: "import 'package:docs/ui/shadcn/shadcn_ui.dart';\n\n/// Feature carousel with autoplay and stacked card transitions.\nclass FeatureCarouselExample1 extends StatelessWidget {\n  const FeatureCarouselExample1({super.key});\n\n  @override\n  Widget build(BuildContext context) {\n    return SizedBox(\n      width: 840,\n      child: FeatureCardCarousel(\n        controller: FeatureCarouselController(\n          showCta: true,\n          showNavArrows: true,\n          autoPlay: true,\n          autoPlayInterval: const Duration(seconds: 4),\n          animationStyle: FeatureCarouselAnimationStyle.zoomFade,\n          cycleAnimationStyles: false,\n          enableSwipe: true,\n          enableKeyboardNavigation: true,\n        ),\n        items: const [\n          FeatureCarouselItem(\n            title: 'Add a Color Palette Selector',\n            description: 'Allow users to pick specific palettes or dominant colors to refine their results.',\n            icon: LucideIcons.palette,\n            accentColor: Color(0xFF7EA3FF),\n          ),\n          FeatureCarouselItem(\n            title: 'Add a Style Preset Picker',\n            description: 'Offer curated styles like minimal, neon, or vintage to guide output.',\n            icon: LucideIcons.sparkles,\n            accentColor: Color(0xFF9B87FF),\n          ),\n          FeatureCarouselItem(\n            title: 'Add a Detail Slider',\n            description: 'Let users control complexity and sharpness without overwhelming options.',\n            icon: LucideIcons.slidersHorizontal,\n            accentColor: Color(0xFF67D4FF),\n          ),\n        ],\n      ),\n    );\n  }\n}\n",
);

Widget _buildFeatureCarouselExample1(BuildContext context) {
  return const FeatureCarouselExample1();
}

const List<ComponentExample> featureCarouselExamples = [
  featureCarouselExample1,
];

import 'package:flutter/widgets.dart';
import '../../component_example_models.dart';
import 'carousel_example_1.dart';
import 'carousel_example_2.dart';
import 'carousel_example_3.dart';
import 'carousel_example_4.dart';

const ComponentExample carouselExample1 = ComponentExample(
  title: "Horizontal Carousel Example",
  builder: _buildCarouselExample1,
  code: "import 'package:docs/ui/shadcn/shadcn_ui.dart';\n\nimport '../carousel_example.dart';\n\n/// Horizontal carousel with manual next/previous controls.\n///\n/// Uses a [CarouselController] to programmatically navigate slides and\n/// a sliding transition with a fixed item size and autoplay.\nclass CarouselExample1 extends StatefulWidget {\n  const CarouselExample1({super.key});\n\n  @override\n  State<CarouselExample1> createState() => _CarouselExample1State();\n}\n\nclass _CarouselExample1State extends State<CarouselExample1> {\n  final CarouselController controller = CarouselController();\n  @override\n  Widget build(BuildContext context) {\n    return SizedBox(\n      width: 800,\n      child: Row(\n        children: [\n          OutlineButton(\n              shape: ButtonShape.circle,\n              onPressed: () {\n                // Animate to previous slide.\n                controller.animatePrevious(const Duration(milliseconds: 500));\n              },\n              child: const Icon(Icons.arrow_back)),\n          const Gap(24),\n          Expanded(\n            child: SizedBox(\n              height: 200,\n              child: Carousel(\n                // frameTransform: Carousel.fadingTransform,\n                // Slide items with a 24px gap.\n                transition: const CarouselTransition.sliding(gap: 24),\n                controller: controller,\n                // Each item has a fixed dimension of 200.\n                sizeConstraint: const CarouselFixedConstraint(200),\n                // Automatically advance every 2 seconds.\n                autoplaySpeed: const Duration(seconds: 2),\n                itemCount: 5,\n                itemBuilder: (context, index) {\n                  return NumberedContainer(index: index);\n                },\n                // Duration of the slide transition animation.\n                duration: const Duration(seconds: 1),\n              ),\n            ),\n          ),\n          const Gap(24),\n          OutlineButton(\n              shape: ButtonShape.circle,\n              onPressed: () {\n                // Animate to next slide.\n                controller.animateNext(const Duration(milliseconds: 500));\n              },\n              child: const Icon(Icons.arrow_forward)),\n        ],\n      ),\n    );\n  }\n}\n",
);

Widget _buildCarouselExample1(BuildContext context) {
  return const CarouselExample1();
}

const ComponentExample carouselExample2 = ComponentExample(
  title: "Vertical Carousel Example",
  builder: _buildCarouselExample2,
  code: "import 'package:docs/ui/shadcn/shadcn_ui.dart';\n\nimport '../carousel_example.dart';\n\n/// Vertical carousel centered in a column with manual controls.\n///\n/// Demonstrates changing [direction] to [Axis.vertical] and centering items\n/// using [CarouselAlignment.center].\nclass CarouselExample2 extends StatefulWidget {\n  const CarouselExample2({super.key});\n\n  @override\n  State<CarouselExample2> createState() => _CarouselExample2State();\n}\n\nclass _CarouselExample2State extends State<CarouselExample2> {\n  final CarouselController controller = CarouselController();\n  @override\n  Widget build(BuildContext context) {\n    return SizedBox(\n      height: 500,\n      child: Column(\n        mainAxisSize: MainAxisSize.min,\n        children: [\n          OutlineButton(\n              shape: ButtonShape.circle,\n              onPressed: () {\n                // Move to previous item (upwards).\n                controller.animatePrevious(const Duration(milliseconds: 500));\n              },\n              child: const Icon(Icons.arrow_upward)),\n          const Gap(24),\n          Expanded(\n            child: SizedBox(\n              width: 200,\n              child: Carousel(\n                transition: const CarouselTransition.sliding(gap: 24),\n                // Center the visible item.\n                alignment: CarouselAlignment.center,\n                controller: controller,\n                // Rotate layout to vertical flow.\n                direction: Axis.vertical,\n                // Fix item extent to 200.\n                sizeConstraint: const CarouselFixedConstraint(200),\n                itemBuilder: (context, index) {\n                  return NumberedContainer(index: index);\n                },\n              ),\n            ),\n          ),\n          const Gap(24),\n          OutlineButton(\n              shape: ButtonShape.circle,\n              onPressed: () {\n                // Move to next item (downwards).\n                controller.animateNext(const Duration(milliseconds: 500));\n              },\n              child: const Icon(Icons.arrow_downward)),\n        ],\n      ),\n    );\n  }\n}\n",
);

Widget _buildCarouselExample2(BuildContext context) {
  return const CarouselExample2();
}

const ComponentExample carouselExample3 = ComponentExample(
  title: "Fading Carousel Example",
  builder: _buildCarouselExample3,
  code: "import 'package:docs/ui/shadcn/shadcn_ui.dart';\n\nimport '../carousel_example.dart';\n\n/// Carousel with fading transition and dot indicators.\n///\n/// Items fade in/out instead of sliding. Draggable is disabled and the\n/// [CarouselDotIndicator] syncs with the same [CarouselController].\nclass CarouselExample3 extends StatefulWidget {\n  const CarouselExample3({super.key});\n\n  @override\n  State<CarouselExample3> createState() => _CarouselExample3State();\n}\n\nclass _CarouselExample3State extends State<CarouselExample3> {\n  final CarouselController controller = CarouselController();\n  @override\n  Widget build(BuildContext context) {\n    return SizedBox(\n      width: 800,\n      child: Column(\n        mainAxisSize: MainAxisSize.min,\n        children: [\n          SizedBox(\n            height: 200,\n            child: Carousel(\n              // Use a fading transition instead of sliding.\n              transition: const CarouselTransition.fading(),\n              controller: controller,\n              // Disable gesture dragging; navigation is via controls below.\n              draggable: false,\n              // Automatically switch items.\n              autoplaySpeed: const Duration(seconds: 1),\n              itemCount: 5,\n              itemBuilder: (context, index) {\n                return NumberedContainer(index: index);\n              },\n              // Fade duration.\n              duration: const Duration(seconds: 1),\n            ),\n          ),\n          const Gap(8),\n          Row(\n            mainAxisSize: MainAxisSize.min,\n            children: [\n              // Dots reflect and control the current index via controller.\n              CarouselDotIndicator(itemCount: 5, controller: controller),\n              const Spacer(),\n              OutlineButton(\n                  shape: ButtonShape.circle,\n                  onPressed: () {\n                    controller\n                        .animatePrevious(const Duration(milliseconds: 500));\n                  },\n                  child: const Icon(Icons.arrow_back)),\n              const Gap(8),\n              OutlineButton(\n                  shape: ButtonShape.circle,\n                  onPressed: () {\n                    controller.animateNext(const Duration(milliseconds: 500));\n                  },\n                  child: const Icon(Icons.arrow_forward)),\n            ],\n          ),\n        ],\n      ),\n    );\n  }\n}\n",
);

Widget _buildCarouselExample3(BuildContext context) {
  return const CarouselExample3();
}

const ComponentExample carouselExample4 = ComponentExample(
  title: "Continuous Sliding Carousel Example",
  builder: _buildCarouselExample4,
  code: "import 'package:docs/ui/shadcn/shadcn_ui.dart';\n\nimport '../carousel_example.dart';\n\n/// Continuous sliding carousel.\n///\n/// Uses a sliding transition with a linear curve and `duration: Duration.zero`\n/// to produce a smooth, continuous marquee-like movement when combined with\n/// `autoplaySpeed`.\nclass CarouselExample4 extends StatefulWidget {\n  const CarouselExample4({super.key});\n\n  @override\n  State<CarouselExample4> createState() => _CarouselExample4State();\n}\n\nclass _CarouselExample4State extends State<CarouselExample4> {\n  final CarouselController controller = CarouselController();\n  @override\n  Widget build(BuildContext context) {\n    return SizedBox(\n      width: 800,\n      height: 200,\n      child: Carousel(\n        // Slide items horizontally with a gap.\n        transition: const CarouselTransition.sliding(gap: 24),\n        controller: controller,\n        // Disable user drag to keep the motion continuous.\n        draggable: false,\n        // Tick forward every 2 seconds.\n        autoplaySpeed: const Duration(seconds: 2),\n        // Linear curve keeps velocity constant between ticks.\n        curve: Curves.linear,\n        itemCount: 5,\n        sizeConstraint: const CarouselSizeConstraint.fixed(200),\n        itemBuilder: (context, index) {\n          return NumberedContainer(index: index);\n        },\n        // Instant transition per tick for a marquee-like feel.\n        duration: Duration.zero,\n      ),\n    );\n  }\n}\n",
);

Widget _buildCarouselExample4(BuildContext context) {
  return const CarouselExample4();
}

const List<ComponentExample> carouselExamples = [
  carouselExample1,
  carouselExample2,
  carouselExample3,
  carouselExample4,
];

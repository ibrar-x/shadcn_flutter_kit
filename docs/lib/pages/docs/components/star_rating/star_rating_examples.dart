import 'package:flutter/widgets.dart';
import '../../component_example_models.dart';
import 'star_rating_example_1.dart';

const ComponentExample starRatingExample1 = ComponentExample(
  title: "Example",
  builder: _buildStarRatingExample1,
  code: "import 'package:docs/shadcn_ui.dart';\n\nclass StarRatingExample1 extends StatefulWidget {\n  const StarRatingExample1({super.key});\n\n  @override\n  State<StarRatingExample1> createState() => _StarRatingExample1State();\n}\n\nclass _StarRatingExample1State extends State<StarRatingExample1> {\n  // The current rating value (supports fractional values like 1.5 for half-stars).\n  double value = 1.5;\n  @override\n  Widget build(BuildContext context) {\n    return StarRating(\n      // Control the icon size used for each star.\n      starSize: 32,\n      value: value,\n      onChanged: (value) {\n        setState(() {\n          // Update the rating when the user taps/drags on the stars.\n          this.value = value;\n        });\n      },\n    );\n  }\n}\n",
);

Widget _buildStarRatingExample1(BuildContext context) {
  return const StarRatingExample1();
}

const List<ComponentExample> starRatingExamples = [
  starRatingExample1,
];

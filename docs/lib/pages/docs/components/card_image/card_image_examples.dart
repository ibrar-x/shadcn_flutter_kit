import 'package:flutter/widgets.dart';
import '../../component_example_models.dart';
import 'card_image_example_1.dart';

const ComponentExample cardImageExample1 = ComponentExample(
  title: "Example",
  builder: _buildCardImageExample1,
  code: "import 'dart:ui';\n\nimport 'package:docs/shadcn_ui.dart';\n\n/// Horizontally scrollable list of CardImage items.\n///\n/// Demonstrates enabling both touch and mouse drag for horizontal scroll,\n/// and using [CardImage] to show an image with title/subtitle. Tapping a\n/// card opens a simple dialog.\nclass CardImageExample1 extends StatelessWidget {\n  const CardImageExample1({super.key});\n\n  @override\n  Widget build(BuildContext context) {\n    return ScrollConfiguration(\n      behavior: ScrollConfiguration.of(context).copyWith(\n        dragDevices: {\n          PointerDeviceKind.touch,\n          PointerDeviceKind.mouse,\n        },\n      ),\n      child: SingleChildScrollView(\n        scrollDirection: Axis.horizontal,\n        child: IntrinsicHeight(\n          child: Row(\n            crossAxisAlignment: CrossAxisAlignment.stretch,\n            mainAxisSize: MainAxisSize.min,\n            children: [\n              for (int i = 0; i < 10; i++)\n                CardImage(\n                  // Simple interaction: open a dialog on tap.\n                  onPressed: () {\n                    showDialog(\n                      context: context,\n                      builder: (context) {\n                        return AlertDialog(\n                          title: const Text('Card Image'),\n                          content: const Text('You clicked on a card image.'),\n                          actions: [\n                            PrimaryButton(\n                              onPressed: () {\n                                Navigator.of(context).pop();\n                              },\n                              child: const Text('Close'),\n                            ),\n                          ],\n                        );\n                      },\n                    );\n                  },\n                  // Network image; replace with your own provider as needed.\n                  image: Image.network(\n                    'https://picsum.photos/200/300',\n                  ),\n                  // Title and subtitle appear over the image.\n                  title: Text('Card Number \${i + 1}'),\n                  subtitle: const Text('Lorem ipsum dolor sit amet'),\n                ),\n            ],\n          ).gap(8),\n        ),\n      ),\n    );\n  }\n}\n",
);

Widget _buildCardImageExample1(BuildContext context) {
  return const CardImageExample1();
}

const List<ComponentExample> cardImageExamples = [
  cardImageExample1,
];
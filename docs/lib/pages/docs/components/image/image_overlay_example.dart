import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';

const ComponentExample imageOverlayExample = ComponentExample(
  title: 'Overlay gradient',
  builder: _buildImageOverlayExample,
  code: '''ClipRRect(
  borderRadius: BorderRadius.circular(14),
  child: SizedBox(
    width: 180,
    height: 110,
    child: Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/docs_images/carousel.png',
          fit: BoxFit.cover,
        ),
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0x00000000),
                Color(0xCC000000),
              ],
            ),
          ),
        ),
      ],
    ),
  ),
)''',
);

Widget _buildImageOverlayExample(BuildContext context) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(14),
    child: SizedBox(
      width: 180,
      height: 110,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/docs_images/carousel.png',
            fit: BoxFit.cover,
          ),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0x00000000),
                  Color(0xCC000000),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';

const ComponentExample imageFitExample = ComponentExample(
  title: 'Cover fit',
  builder: _buildImageFitExample,
  code: '''ClipRRect(
  borderRadius: BorderRadius.circular(12),
  child: SizedBox(
    width: 180,
    height: 100,
    child: Image.asset(
      'assets/docs_images/card.png',
      fit: BoxFit.cover,
    ),
  ),
)''',
);

Widget _buildImageFitExample(BuildContext context) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: SizedBox(
      width: 180,
      height: 100,
      child: Image.asset(
        'assets/docs_images/card.png',
        fit: BoxFit.cover,
      ),
    ),
  );
}

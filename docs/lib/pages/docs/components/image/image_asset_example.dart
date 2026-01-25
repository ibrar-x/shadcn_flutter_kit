import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';

const ComponentExample imageAssetExample = ComponentExample(
  title: 'Asset image',
  builder: _buildImageAssetExample,
  code: '''Image.asset(
  'assets/docs_images/button.png',
  width: 120,
  height: 90,
  fit: BoxFit.cover,
)''',
);

Widget _buildImageAssetExample(BuildContext context) {
  return Image.asset(
    'assets/docs_images/button.png',
    width: 120,
    height: 90,
    fit: BoxFit.cover,
  );
}

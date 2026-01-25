import 'package:flutter/material.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/layout/basic/basic.dart'
    as shadcn_basic;

const ComponentExample basicExample = ComponentExample(
  title: 'Basic',
  builder: _buildBasicExample,
  code: '''Basic(
  title: Text('Title'),
  leading: Icon(Icons.star),
  trailing: Icon(Icons.arrow_forward),
  subtitle: Text('Subtitle'),
  content: Text('Lorem ipsum dolor sit amet'),
)''',
);

Widget _buildBasicExample(BuildContext context) {
  return const shadcn_basic.Basic(
    title: Text('Title'),
    leading: Icon(Icons.star),
    trailing: Icon(Icons.arrow_forward),
    subtitle: Text('Subtitle'),
    content: Text('Lorem ipsum dolor sit amet'),
  );
}

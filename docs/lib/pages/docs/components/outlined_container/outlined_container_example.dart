import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/layout/outlined_container/outlined_container.dart'
    as shadcn_outlined;

const ComponentExample outlinedContainerExample = ComponentExample(
  title: 'Outlined',
  builder: _buildOutlinedContainerExample,
  code: '''OutlinedContainer(
  padding: EdgeInsets.all(16),
  child: Text('Outlined container'),
)''',
);

Widget _buildOutlinedContainerExample(BuildContext context) {
  return const shadcn_outlined.OutlinedContainer(
    padding: EdgeInsets.all(16),
    child: Text('Outlined container'),
  );
}

import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/layout/outlined_container/outlined_container.dart'
    as shadcn_outlined;

const ComponentExample outlinedContainerSizesExample = ComponentExample(
  title: 'Sizing',
  builder: _buildOutlinedContainerSizesExample,
  code: '''OutlinedContainer(
  width: 240,
  height: 120,
  child: Text('Fixed size'),
)''',
);

Widget _buildOutlinedContainerSizesExample(BuildContext context) {
  return const shadcn_outlined.OutlinedContainer(
    width: 240,
    height: 120,
    padding: EdgeInsets.all(16),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Text('Fixed size container'),
    ),
  );
}

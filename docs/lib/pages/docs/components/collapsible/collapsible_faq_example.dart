import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/layout/collapsible/collapsible.dart'
    as shadcn_collapsible;
import '../../../../ui/shadcn/components/layout/outlined_container/outlined_container.dart'
    as shadcn_outlined;
const ComponentExample collapsibleFaqExample = ComponentExample(
  title: 'FAQ',
  builder: _buildCollapsibleFaqExample,
  code: '''Collapsible(
  children: [
    CollapsibleTrigger(child: Text('What is shadcn_flutter?')),
    CollapsibleContent(child: Text('A registry-first Flutter UI kit.')),
  ],
)''',
);

Widget _buildCollapsibleFaqExample(BuildContext context) {
  return const shadcn_collapsible.Collapsible(
    children: [
      shadcn_collapsible.CollapsibleTrigger(
        child: Text('What is shadcn_flutter?'),
      ),
      shadcn_collapsible.CollapsibleContent(
        child: Padding(
          padding: EdgeInsets.only(top: 8),
          child: shadcn_outlined.OutlinedContainer(
            padding: EdgeInsets.all(12),
            child: Text('A registry-first Flutter UI kit.'),
          ),
        ),
      ),
    ],
  );
}

import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/layout/collapsible/collapsible.dart'
    as shadcn_collapsible;
import '../../../../ui/shadcn/shared/icons/lucide_icons.dart';
const ComponentExample collapsibleIconExample = ComponentExample(
  title: 'With icon',
  builder: _buildCollapsibleIconExample,
  code: '''Collapsible(
  children: [
    CollapsibleTrigger(child: Row(children: [Icon(...), Text('Details')])),
    CollapsibleContent(child: Text('Extra information')),
  ],
)''',
);

Widget _buildCollapsibleIconExample(BuildContext context) {
  return const shadcn_collapsible.Collapsible(
    children: [
      shadcn_collapsible.CollapsibleTrigger(
        child: Row(
          children: [
            Icon(LucideIcons.info),
            SizedBox(width: 8),
            Text('Details'),
          ],
        ),
      ),
      shadcn_collapsible.CollapsibleContent(
        child: Padding(
          padding: EdgeInsets.only(top: 8),
          child: Text('Extra information about this item.'),
        ),
      ),
    ],
  );
}

import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/layout/media_query/media_query.dart'
    as shadcn_media_query;
import '../../../../ui/shadcn/components/layout/outlined_container/outlined_container.dart'
    as shadcn_outlined;

const ComponentExample mediaQueryMinWidthExample = ComponentExample(
  title: 'Min width',
  builder: _buildMediaQueryMinWidthExample,
  code: '''MediaQueryVisibility(
  minWidth: 720,
  child: OutlinedContainer(child: Text('Visible on wide screens')),
  alternateChild: Text('Resize wider to see the panel'),
)''',
);

Widget _buildMediaQueryMinWidthExample(BuildContext context) {
  return const shadcn_media_query.MediaQueryVisibility(
    minWidth: 720,
    alternateChild: Text('Resize wider to see the panel'),
    child: shadcn_outlined.OutlinedContainer(
      padding: EdgeInsets.all(16),
      child: Text('Visible on wide screens'),
    ),
  );
}

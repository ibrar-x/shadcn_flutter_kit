import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/layout/media_query/media_query.dart'
    as shadcn_media_query;
import '../../../../ui/shadcn/components/layout/outlined_container/outlined_container.dart'
    as shadcn_outlined;

const ComponentExample mediaQueryMaxWidthExample = ComponentExample(
  title: 'Max width',
  builder: _buildMediaQueryMaxWidthExample,
  code: '''MediaQueryVisibility(
  maxWidth: 640,
  child: OutlinedContainer(child: Text('Compact layout')), 
  alternateChild: Text('This layout is hidden on wide screens'),
)''',
);

Widget _buildMediaQueryMaxWidthExample(BuildContext context) {
  return const shadcn_media_query.MediaQueryVisibility(
    maxWidth: 640,
    alternateChild: Text('Hidden on wide screens'),
    child: shadcn_outlined.OutlinedContainer(
      padding: EdgeInsets.all(16),
      child: Text('Compact layout'),
    ),
  );
}

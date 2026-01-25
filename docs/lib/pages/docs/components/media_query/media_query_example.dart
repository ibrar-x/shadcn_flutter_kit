import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/layout/media_query/media_query.dart'
    as shadcn_media_query;

const ComponentExample mediaQueryExample = ComponentExample(
  title: 'Visibility',
  builder: _buildMediaQueryExample,
  code: '''MediaQueryVisibility(
  minWidth: 700,
  child: Text('Visible on wide screens'),
  alternateChild: Text('Resize the window'),
)''',
);

Widget _buildMediaQueryExample(BuildContext context) {
  return const shadcn_media_query.MediaQueryVisibility(
    minWidth: 700,
    alternateChild: Text('Resize the window'),
    child: Text('Visible on wide screens'),
  );
}

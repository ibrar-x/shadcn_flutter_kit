import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/display/selectable/selectable.dart'
    as shadcn_selectable;
import '../../../../ui/shadcn/shared/primitives/text.dart';

const ComponentExample selectableBasicExample = ComponentExample(
  title: 'Basic selectable text',
  builder: _buildSelectableBasicExample,
  code: '''SelectableText('Select this text')''',
);

Widget _buildSelectableBasicExample(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Try selecting the copy below.').small().muted(),
      const SizedBox(height: 12),
      const shadcn_selectable.SelectableText(
        'SelectableText supports copy/paste and rich selection behavior.',
      ),
    ],
  );
}

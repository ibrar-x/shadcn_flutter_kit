import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/display/selectable/selectable.dart'
    as shadcn_selectable;
import '../../../../ui/shadcn/shared/theme/theme.dart' as shadcn_theme;

const ComponentExample selectableCustomCursorExample = ComponentExample(
  title: 'Custom cursor',
  builder: _buildSelectableCustomCursorExample,
  code: '''ComponentTheme<SelectableTextTheme>(
  data: SelectableTextTheme(
    cursorColor: Color(0xff7EA3FF),
    cursorRadius: Radius.circular(2),
  ),
  child: SelectableText('Custom cursor styling'),
)''',
);

Widget _buildSelectableCustomCursorExample(BuildContext context) {
  return const shadcn_theme
      .ComponentTheme<shadcn_selectable.SelectableTextTheme>(
    data: shadcn_selectable.SelectableTextTheme(
      cursorColor: Color(0xff7EA3FF),
      cursorRadius: Radius.circular(2),
      cursorWidth: 3,
      selectionHeightStyle: ui.BoxHeightStyle.max,
    ),
    child: shadcn_selectable.SelectableText(
      'Custom cursor styling with a thicker caret.',
      showCursor: true,
    ),
  );
}

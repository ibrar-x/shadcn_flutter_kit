import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/layout/outlined_container/outlined_container.dart'
    as shadcn_outlined;
import '../../../../ui/shadcn/components/layout/resizable/resizable.dart'
    as shadcn_resizable;
import '../carousel/carousel_shared.dart';

const ComponentExample resizableExample2 = ComponentExample(
  title: 'Vertical Example',
  builder: _buildResizableExample2,
  code: '''ResizablePanel.vertical(
  children: [
    ResizablePane(initialSize: 80, child: NumberedContainer(index: 0)),
    ResizablePane(initialSize: 120, child: NumberedContainer(index: 1)),
  ],
)''',
);

Widget _buildResizableExample2(BuildContext context) {
  return const shadcn_outlined.OutlinedContainer(
    clipBehavior: Clip.antiAlias,
    child: shadcn_resizable.ResizablePanel.vertical(
      children: [
        shadcn_resizable.ResizablePane(
          initialSize: 80,
          child: NumberedContainer(
            index: 0,
            width: 200,
            fill: false,
          ),
        ),
        shadcn_resizable.ResizablePane(
          initialSize: 120,
          child: NumberedContainer(
            index: 1,
            width: 200,
            fill: false,
          ),
        ),
        shadcn_resizable.ResizablePane(
          initialSize: 80,
          child: NumberedContainer(
            index: 2,
            width: 200,
            fill: false,
          ),
        ),
      ],
    ),
  );
}

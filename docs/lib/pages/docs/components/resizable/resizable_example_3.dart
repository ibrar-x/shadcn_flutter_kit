import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/layout/outlined_container/outlined_container.dart'
    as shadcn_outlined;
import '../../../../ui/shadcn/components/layout/resizable/resizable.dart'
    as shadcn_resizable;
import '../carousel/carousel_shared.dart';

const ComponentExample resizableExample3 = ComponentExample(
  title: 'Horizontal Example with Dragger',
  builder: _buildResizableExample3,
  code: '''ResizablePanel.horizontal(
  draggerBuilder: (context) => HorizontalResizableDragger(),
  children: [...],
)''',
);

Widget _buildResizableExample3(BuildContext context) {
  return shadcn_outlined.OutlinedContainer(
    clipBehavior: Clip.antiAlias,
    child: shadcn_resizable.ResizablePanel.horizontal(
      draggerBuilder: (context) {
        return const shadcn_resizable.HorizontalResizableDragger();
      },
      children: const [
        shadcn_resizable.ResizablePane(
          initialSize: 80,
          child: NumberedContainer(
            index: 0,
            height: 200,
            fill: false,
          ),
        ),
        shadcn_resizable.ResizablePane(
          initialSize: 80,
          child: NumberedContainer(
            index: 1,
            height: 200,
            fill: false,
          ),
        ),
        shadcn_resizable.ResizablePane(
          initialSize: 120,
          child: NumberedContainer(
            index: 2,
            height: 200,
            fill: false,
          ),
        ),
        shadcn_resizable.ResizablePane(
          initialSize: 80,
          child: NumberedContainer(
            index: 3,
            height: 200,
            fill: false,
          ),
        ),
        shadcn_resizable.ResizablePane(
          initialSize: 80,
          child: NumberedContainer(
            index: 4,
            height: 200,
            fill: false,
          ),
        ),
      ],
    ),
  );
}

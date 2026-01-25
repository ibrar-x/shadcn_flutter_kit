import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/layout/outlined_container/outlined_container.dart'
    as shadcn_outlined;
import '../../../../ui/shadcn/components/layout/resizable/resizable.dart'
    as shadcn_resizable;
import '../carousel/carousel_shared.dart';

const ComponentExample resizableExample6 = ComponentExample(
  title: 'Nested Example',
  builder: _buildResizableExample6,
  code: '''ResizablePanel.horizontal(
  children: [
    ResizablePane(...),
    ResizablePane(
      child: ResizablePanel.vertical(
        children: [...],
      ),
    ),
  ],
)''',
);

Widget _buildResizableExample6(BuildContext context) {
  return const shadcn_outlined.OutlinedContainer(
    clipBehavior: Clip.antiAlias,
    child: shadcn_resizable.ResizablePanel.horizontal(
      children: [
        shadcn_resizable.ResizablePane(
          initialSize: 100,
          minSize: 40,
          child: NumberedContainer(
            index: 0,
            height: 200,
            fill: false,
          ),
        ),
        shadcn_resizable.ResizablePane(
          minSize: 100,
          initialSize: 300,
          child: shadcn_resizable.ResizablePanel.vertical(
            children: [
              shadcn_resizable.ResizablePane(
                initialSize: 80,
                minSize: 40,
                child: NumberedContainer(
                  index: 1,
                  fill: false,
                ),
              ),
              shadcn_resizable.ResizablePane(
                minSize: 40,
                initialSize: 120,
                child: shadcn_resizable.ResizablePanel.horizontal(
                  children: [
                    shadcn_resizable.ResizablePane.flex(
                      child: NumberedContainer(
                        index: 2,
                        fill: false,
                      ),
                    ),
                    shadcn_resizable.ResizablePane.flex(
                      child: NumberedContainer(
                        index: 3,
                        fill: false,
                      ),
                    ),
                    shadcn_resizable.ResizablePane.flex(
                      child: NumberedContainer(
                        index: 4,
                        fill: false,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        shadcn_resizable.ResizablePane(
          initialSize: 100,
          minSize: 40,
          child: NumberedContainer(
            index: 5,
            height: 200,
            fill: false,
          ),
        ),
      ],
    ),
  );
}

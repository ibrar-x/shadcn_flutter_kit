import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/control/button/button.dart'
    as shadcn_buttons;
import '../../../../ui/shadcn/components/layout/outlined_container/outlined_container.dart'
    as shadcn_outlined;
import '../../../../ui/shadcn/components/layout/resizable/resizable.dart'
    as shadcn_resizable;
import '../carousel/carousel_shared.dart';

const ComponentExample resizableExample4 = ComponentExample(
  title: 'Controller Example',
  builder: _buildResizableExample4,
  code: '''// Controlled panes with AbsoluteResizablePaneController
''',
);

Widget _buildResizableExample4(BuildContext context) {
  return const _ResizableExample4();
}

class _ResizableExample4 extends StatefulWidget {
  const _ResizableExample4();

  @override
  State<_ResizableExample4> createState() => _ResizableExample4State();
}

class _ResizableExample4State extends State<_ResizableExample4> {
  final shadcn_resizable.AbsoluteResizablePaneController controller1 =
      shadcn_resizable.AbsoluteResizablePaneController(80);
  final shadcn_resizable.AbsoluteResizablePaneController controller2 =
      shadcn_resizable.AbsoluteResizablePaneController(80);
  final shadcn_resizable.AbsoluteResizablePaneController controller3 =
      shadcn_resizable.AbsoluteResizablePaneController(120);
  final shadcn_resizable.AbsoluteResizablePaneController controller4 =
      shadcn_resizable.AbsoluteResizablePaneController(80);
  final shadcn_resizable.AbsoluteResizablePaneController controller5 =
      shadcn_resizable.AbsoluteResizablePaneController(80);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        shadcn_outlined.OutlinedContainer(
          clipBehavior: Clip.antiAlias,
          child: shadcn_resizable.ResizablePanel.horizontal(
            children: [
              shadcn_resizable.ResizablePane.controlled(
                controller: controller1,
                child: const NumberedContainer(
                  index: 0,
                  height: 200,
                  fill: false,
                ),
              ),
              shadcn_resizable.ResizablePane.controlled(
                controller: controller2,
                child: const NumberedContainer(
                  index: 1,
                  height: 200,
                  fill: false,
                ),
              ),
              shadcn_resizable.ResizablePane.controlled(
                controller: controller3,
                maxSize: 200,
                child: const NumberedContainer(
                  index: 2,
                  height: 200,
                  fill: false,
                ),
              ),
              shadcn_resizable.ResizablePane.controlled(
                controller: controller4,
                child: const NumberedContainer(
                  index: 3,
                  height: 200,
                  fill: false,
                ),
              ),
              shadcn_resizable.ResizablePane.controlled(
                controller: controller5,
                minSize: 80,
                collapsedSize: 20,
                child: const NumberedContainer(
                  index: 4,
                  height: 200,
                  fill: false,
                ),
              ),
            ],
          ),
        ),
        const Gap(48),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            shadcn_buttons.PrimaryButton(
              onPressed: () {
                controller1.size = 80;
                controller2.size = 80;
                controller3.size = 120;
                controller4.size = 80;
                controller5.size = 80;
              },
              child: const Text('Reset'),
            ),
            shadcn_buttons.PrimaryButton(
              onPressed: () {
                controller3.tryExpandSize(20);
              },
              child: const Text('Expand Panel 2'),
            ),
            shadcn_buttons.PrimaryButton(
              onPressed: () {
                controller3.tryExpandSize(-20);
              },
              child: const Text('Shrink Panel 2'),
            ),
            shadcn_buttons.PrimaryButton(
              onPressed: () {
                controller2.tryExpandSize(20);
              },
              child: const Text('Expand Panel 1'),
            ),
            shadcn_buttons.PrimaryButton(
              onPressed: () {
                controller2.tryExpandSize(-20);
              },
              child: const Text('Shrink Panel 1'),
            ),
            shadcn_buttons.PrimaryButton(
              onPressed: () {
                controller5.tryExpandSize(20);
              },
              child: const Text('Expand Panel 4'),
            ),
            shadcn_buttons.PrimaryButton(
              onPressed: () {
                controller5.tryExpandSize(-20);
              },
              child: const Text('Shrink Panel 4'),
            ),
            shadcn_buttons.PrimaryButton(
              onPressed: () {
                controller5.tryCollapse();
              },
              child: const Text('Collapse Panel 4'),
            ),
            shadcn_buttons.PrimaryButton(
              onPressed: () {
                controller5.tryExpand();
              },
              child: const Text('Expand Panel 4'),
            ),
          ],
        ),
      ],
    );
  }
}

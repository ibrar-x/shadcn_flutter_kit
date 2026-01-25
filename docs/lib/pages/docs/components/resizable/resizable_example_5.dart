import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/layout/outlined_container/outlined_container.dart'
    as shadcn_outlined;
import '../../../../ui/shadcn/components/layout/resizable/resizable.dart'
    as shadcn_resizable;

const ComponentExample resizableExample5 = ComponentExample(
  title: 'Collapsible Example',
  builder: _buildResizableExample5,
  code: '''ResizablePanel.horizontal(
  children: [
    ResizablePane.controlled(...),
    ResizablePane(initialSize: 300, child: ...),
  ],
)''',
);

Widget _buildResizableExample5(BuildContext context) {
  return const _ResizableExample5();
}

class _ResizableExample5 extends StatefulWidget {
  const _ResizableExample5();

  @override
  State<_ResizableExample5> createState() => _ResizableExample5State();
}

class _ResizableExample5State extends State<_ResizableExample5> {
  final shadcn_resizable.ResizablePaneController controller =
      shadcn_resizable.AbsoluteResizablePaneController(120);
  final shadcn_resizable.ResizablePaneController controller2 =
      shadcn_resizable.AbsoluteResizablePaneController(120);

  @override
  Widget build(BuildContext context) {
    return shadcn_outlined.OutlinedContainer(
      clipBehavior: Clip.antiAlias,
      child: shadcn_resizable.ResizablePanel.horizontal(
        children: [
          shadcn_resizable.ResizablePane.controlled(
            minSize: 100,
            collapsedSize: 40,
            controller: controller,
            child: AnimatedBuilder(
              animation: controller,
              builder: (context, child) {
                if (controller.collapsed) {
                  return Container(
                    alignment: Alignment.center,
                    height: 200,
                    child: const RotatedBox(
                      quarterTurns: -1,
                      child: Text('Collapsed'),
                    ),
                  );
                }
                return Container(
                  alignment: Alignment.center,
                  height: 200,
                  child: const Text('Expanded'),
                );
              },
            ),
          ),
          shadcn_resizable.ResizablePane(
            initialSize: 300,
            child: Container(
              alignment: Alignment.center,
              height: 200,
              child: const Text('Resizable'),
            ),
          ),
          shadcn_resizable.ResizablePane.controlled(
            minSize: 100,
            collapsedSize: 40,
            controller: controller2,
            child: AnimatedBuilder(
              animation: controller2,
              builder: (context, child) {
                if (controller2.collapsed) {
                  return Container(
                    alignment: Alignment.center,
                    height: 200,
                    child: const RotatedBox(
                      quarterTurns: -1,
                      child: Text('Collapsed'),
                    ),
                  );
                }
                return Container(
                  alignment: Alignment.center,
                  height: 200,
                  child: const Text('Expanded'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

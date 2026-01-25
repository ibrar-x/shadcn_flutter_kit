import 'package:flutter/material.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/control/button/button.dart'
    as shadcn_buttons;
import '../../../../ui/shadcn/components/layout/outlined_container/outlined_container.dart'
    as shadcn_outlined;
import '../../../../ui/shadcn/components/layout/window/window.dart'
    as shadcn_window;

const ComponentExample windowExample1 = ComponentExample(
  title: 'Basic',
  builder: _buildWindowExample1,
  code: '''WindowNavigator(
  initialWindows: [
    Window(bounds: Rect.fromLTWH(0, 0, 200, 200), title: Text('Window 1')),
    Window(bounds: Rect.fromLTWH(200, 0, 200, 200), title: Text('Window 2')),
  ],
)''',
);

Widget _buildWindowExample1(BuildContext context) {
  return const _WindowExample1();
}

class _WindowExample1 extends StatefulWidget {
  const _WindowExample1();

  @override
  State<_WindowExample1> createState() => _WindowExample1State();
}

class _WindowExample1State extends State<_WindowExample1> {
  final GlobalKey<shadcn_window.WindowNavigatorHandle> navigatorKey =
      GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        shadcn_outlined.OutlinedContainer(
          height: 600,
          child: shadcn_window.WindowNavigator(
            key: navigatorKey,
            initialWindows: [
              shadcn_window.Window(
                bounds: const Rect.fromLTWH(0, 0, 200, 200),
                title: const Text('Window 1'),
                content: const _RebuildCounter(),
              ),
              shadcn_window.Window(
                bounds: const Rect.fromLTWH(200, 0, 200, 200),
                title: const Text('Window 2'),
                content: const _RebuildCounter(),
              ),
            ],
            child: const Center(child: Text('Desktop')),
          ),
        ),
        shadcn_buttons.PrimaryButton(
          child: const Text('Add Window'),
          onPressed: () {
            navigatorKey.currentState?.pushWindow(
              shadcn_window.Window(
                bounds: const Rect.fromLTWH(0, 0, 200, 200),
                title: Text(
                  'Window ${navigatorKey.currentState!.windows.length + 1}',
                ),
                content: const _RebuildCounter(),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _RebuildCounter extends StatefulWidget {
  const _RebuildCounter();

  @override
  State<_RebuildCounter> createState() => _RebuildCounterState();
}

class _RebuildCounterState extends State<_RebuildCounter> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.primaries[hashCode % Colors.primaries.length],
      child: Center(
        child: Text('Rebuild count: ${counter++}'),
      ),
    );
  }
}

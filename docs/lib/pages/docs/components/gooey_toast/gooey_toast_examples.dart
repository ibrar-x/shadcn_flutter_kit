import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import 'gooey_toast_example_1.dart';

const ComponentExample gooeyToastExample1 = ComponentExample(
  title: 'Playground',
  builder: _buildGooeyToastExample1,
  code: r'''import 'package:docs/shadcn_ui.dart';

class GooeyToastExample1 extends StatefulWidget {
  const GooeyToastExample1({super.key});

  @override
  State<GooeyToastExample1> createState() => _GooeyToastExample1State();
}

class _GooeyToastExample1State extends State<GooeyToastExample1> {
  final GooeyToastController controller = GooeyToastController();

  // Exposes most options in docs controls:
  // - state
  // - top/bottom + left/center/right presets
  // - animation style and shape style
  // - width, roundness, duration
  // - autopilot delays
  // - pauseOnHover, swipeToDismiss, persistUntilDismissed
  // - compact morph (duration + slide + scale)
  // - newToastBehavior (stack / dismissPrevious)
  // Blur toggle is intentionally not exposed in this docs demo.

  @override
  Widget build(BuildContext context) {
    // See source in gooey_toast_example_1.dart for full implementation.
    return const SizedBox.shrink();
  }
}
''',
);

Widget _buildGooeyToastExample1(BuildContext context) {
  return const GooeyToastExample1();
}

const ComponentExample gooeyToastExample2 = ComponentExample(
  title: 'Interactive Reply',
  builder: _buildGooeyToastExample2,
  code: r'''PrimaryButton(
  onPressed: () {
    controller.show(
      context: context,
      id: 'reply-demo',
      title: 'Thread Reply',
      state: GooeyToastState.action,
      expandedChild: /* inline reply form */,
    );
  },
  child: const Text('Interactive Reply Demo'),
)
''',
);

Widget _buildGooeyToastExample2(BuildContext context) {
  return const GooeyToastExample2();
}

const ComponentExample gooeyToastExample3 = ComponentExample(
  title: 'Booking Multi-State',
  builder: _buildGooeyToastExample3,
  code: r'''// Same toast id transitions through three states:
// loading -> success -> info
// in the same position slot.
''',
);

Widget _buildGooeyToastExample3(BuildContext context) {
  return const GooeyToastExample3();
}

const ComponentExample gooeyToastExample4 = ComponentExample(
  title: 'Tabs + ListView',
  builder: _buildGooeyToastExample4,
  code: r'''PrimaryButton(
  onPressed: () {
    controller.show(
      context: context,
      title: 'Interactive Workspace',
      expandedChild: /* tabs + list view */,
      state: GooeyToastState.info,
    );
  },
  child: const Text('Tabs + ListView Demo'),
)
''',
);

Widget _buildGooeyToastExample4(BuildContext context) {
  return const GooeyToastExample4();
}

const List<ComponentExample> gooeyToastExamples = [
  gooeyToastExample1,
  gooeyToastExample2,
  gooeyToastExample3,
  gooeyToastExample4,
];

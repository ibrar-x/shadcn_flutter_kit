import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../carousel/carousel_shared.dart';
import '../../../../ui/shadcn/components/control/button/button.dart'
    as shadcn_buttons;
import '../../../../ui/shadcn/components/navigation/switcher/switcher.dart'
    as shadcn_switcher;
import '../../../../ui/shadcn/shared/utils/util.dart';

const ComponentExample switcherExample1 = ComponentExample(
  title: 'Directional switch',
  builder: _buildSwitcherExample1,
  code: '''Switcher(
  index: index,
  direction: direction,
  children: [...],
)''',
);

Widget _buildSwitcherExample1(BuildContext context) {
  return const _SwitcherExample1();
}

class _SwitcherExample1 extends StatefulWidget {
  const _SwitcherExample1();

  @override
  State<_SwitcherExample1> createState() => _SwitcherExample1State();
}

class _SwitcherExample1State extends State<_SwitcherExample1> {
  List<AxisDirection> directions = const [
    AxisDirection.up,
    AxisDirection.down,
    AxisDirection.left,
    AxisDirection.right,
  ];
  List<Size> sizes = const [
    Size(200, 300),
    Size(300, 200),
  ];
  int directionIndex = 0;
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        shadcn_buttons.PrimaryButton(
          child: Text(
            'Switch Direction (${directions[directionIndex % directions.length]})',
          ),
          onPressed: () {
            setState(() {
              directionIndex++;
            });
          },
        ),
        gap(8),
        shadcn_buttons.PrimaryButton(
          child: const Text('Next Item'),
          onPressed: () {
            setState(() {
              index++;
            });
          },
        ),
        gap(24),
        ClipRect(
          child: shadcn_switcher.Switcher(
            index: index,
            direction: directions[directionIndex % directions.length],
            onIndexChanged: (value) {
              setState(() {
                index = value;
              });
            },
            children: [
              for (int i = 0; i < 100; i++)
                NumberedContainer(
                  index: i,
                  width: sizes[i % sizes.length].width,
                  height: sizes[i % sizes.length].height,
                ),
            ],
          ),
        ),
      ],
    );
  }
}

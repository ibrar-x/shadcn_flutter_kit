import 'dart:math';

import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/control/button/button.dart'
    as shadcn_buttons;
import '../../../../ui/shadcn/components/layout/outlined_container/outlined_container.dart'
    as shadcn_outlined;
import '../../../../ui/shadcn/components/layout/resizable/resizable.dart'
    as shadcn_resizable;

const ComponentExample resizableExample7 = ComponentExample(
  title: 'Dynamic Children Example',
  builder: _buildResizableExample7,
  code: '''ResizablePanel.vertical(
  children: [ResizablePane(initialSize: 200, child: ...)],
)
''',
);

Widget _buildResizableExample7(BuildContext context) {
  return const _ResizableExample7();
}

class _ResizableExample7 extends StatefulWidget {
  const _ResizableExample7();

  @override
  State<_ResizableExample7> createState() => _ResizableExample7State();
}

class _ResizableExample7State extends State<_ResizableExample7> {
  final List<Color> _items = List.generate(2, (index) => _generateColor());

  static Color _generateColor() {
    final random = Random();
    return HSVColor.fromAHSV(
      1.0,
      random.nextInt(360).toDouble(),
      0.8,
      0.8,
    ).toColor();
  }

  @override
  Widget build(BuildContext context) {
    return shadcn_outlined.OutlinedContainer(
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          shadcn_resizable.ResizablePanel.vertical(
            children: [
              for (int i = 0; i < _items.length; i++)
                shadcn_resizable.ResizablePane(
                  key: ValueKey(_items[i].toARGB32()),
                  initialSize: 200,
                  minSize: 100,
                  child: Container(
                    color: _items[i],
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          shadcn_buttons.TextButton(
                            child: const Text('Insert Before'),
                            onPressed: () {
                              setState(() {
                                _items.insert(i, _generateColor());
                              });
                            },
                          ),
                          shadcn_buttons.TextButton(
                            child: const Text('Remove'),
                            onPressed: () {
                              setState(() {
                                _items.removeAt(i);
                              });
                            },
                          ),
                          shadcn_buttons.TextButton(
                            child: const Text('Insert After'),
                            onPressed: () {
                              setState(() {
                                _items.insert(i + 1, _generateColor());
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          shadcn_buttons.PrimaryButton(
            child: const Text('Add'),
            onPressed: () {
              setState(() {
                _items.add(_generateColor());
              });
            },
          ),
        ],
      ),
    );
  }
}

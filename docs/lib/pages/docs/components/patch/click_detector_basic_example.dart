import 'package:flutter/material.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/control/patch/patch.dart'
    as shadcn_patch;
import '../../../../ui/shadcn/components/layout/card/card.dart' as shadcn_card;
import '../../../../ui/shadcn/shared/primitives/text.dart';

const ComponentExample clickDetectorBasicExample = ComponentExample(
  title: 'Single / double click count',
  builder: _buildClickDetectorBasicExample,
  code: '''
ClickDetector(
  onClick: (details) {},
  child: SurfaceCard(child: Text('Click me')),
)
''',
);

Widget _buildClickDetectorBasicExample(BuildContext context) {
  return const _ClickDetectorBasicExample();
}

class _ClickDetectorBasicExample extends StatefulWidget {
  const _ClickDetectorBasicExample();

  @override
  State<_ClickDetectorBasicExample> createState() =>
      _ClickDetectorBasicExampleState();
}

class _ClickDetectorBasicExampleState
    extends State<_ClickDetectorBasicExample> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return shadcn_patch.ClickDetector(
      onClick: (details) => setState(() => _count = details.clickCount),
      child: shadcn_card.SurfaceCard(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Click me').semiBold(),
              const SizedBox(height: 6),
              Text('Clicks: $_count').muted(),
            ],
          ),
        ),
      ),
    );
  }
}

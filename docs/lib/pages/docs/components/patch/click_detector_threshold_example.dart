import 'package:flutter/material.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/control/patch/patch.dart'
    as shadcn_patch;
import '../../../../ui/shadcn/components/layout/card/card.dart' as shadcn_card;
import '../../../../ui/shadcn/shared/primitives/text.dart';

const ComponentExample clickDetectorThresholdExample = ComponentExample(
  title: 'Custom threshold',
  builder: _buildClickDetectorThresholdExample,
  code: '''
ClickDetector(
  threshold: Duration(milliseconds: 700),
  onClick: (details) {},
  child: SurfaceCard(child: Text('Try triple click')),
)
''',
);

Widget _buildClickDetectorThresholdExample(BuildContext context) {
  return const _ClickDetectorThresholdExample();
}

class _ClickDetectorThresholdExample extends StatefulWidget {
  const _ClickDetectorThresholdExample();

  @override
  State<_ClickDetectorThresholdExample> createState() =>
      _ClickDetectorThresholdExampleState();
}

class _ClickDetectorThresholdExampleState
    extends State<_ClickDetectorThresholdExample> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return shadcn_patch.ClickDetector(
      threshold: const Duration(milliseconds: 700),
      onClick: (details) => setState(() => _count = details.clickCount),
      child: shadcn_card.SurfaceCard(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Try a triple click').semiBold(),
              const SizedBox(height: 6),
              Text('Current count: $_count').muted(),
            ],
          ),
        ),
      ),
    );
  }
}

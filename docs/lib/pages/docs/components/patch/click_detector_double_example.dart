import 'package:flutter/material.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/control/patch/patch.dart'
    as shadcn_patch;
import '../../../../ui/shadcn/components/layout/card/card.dart' as shadcn_card;
import '../../../../ui/shadcn/shared/primitives/text.dart';

const ComponentExample clickDetectorDoubleExample = ComponentExample(
  title: 'Double click to toggle',
  builder: _buildClickDetectorDoubleExample,
  code: '''
ClickDetector(
  onClick: (details) {
    if (details.clickCount == 2) {
      // toggle
    }
  },
  child: SurfaceCard(child: Text('Double click me')),
)
''',
);

Widget _buildClickDetectorDoubleExample(BuildContext context) {
  return const _ClickDetectorDoubleExample();
}

class _ClickDetectorDoubleExample extends StatefulWidget {
  const _ClickDetectorDoubleExample();

  @override
  State<_ClickDetectorDoubleExample> createState() =>
      _ClickDetectorDoubleExampleState();
}

class _ClickDetectorDoubleExampleState
    extends State<_ClickDetectorDoubleExample> {
  bool _favorite = false;

  @override
  Widget build(BuildContext context) {
    return shadcn_patch.ClickDetector(
      onClick: (details) {
        if (details.clickCount == 2) {
          setState(() => _favorite = !_favorite);
        }
      },
      child: shadcn_card.SurfaceCard(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                _favorite ? Icons.star_rounded : Icons.star_border_rounded,
              ),
              const SizedBox(width: 12),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Double click').semiBold(),
                  Text(
                    _favorite ? 'Saved' : 'Not saved',
                  ).muted(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

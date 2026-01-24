import 'package:flutter/material.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/control/hover/hover.dart'
    as shadcn_hover;
import '../../../../ui/shadcn/components/layout/card/card.dart' as shadcn_card;
import '../../../../ui/shadcn/shared/primitives/text.dart';

const ComponentExample hoverActivityExample = ComponentExample(
  title: 'Hover activity counter',
  builder: _buildHoverActivityExample,
  code: '''
HoverActivity(
  debounceDuration: Duration(milliseconds: 300),
  onHover: () {},
  child: SurfaceCard(child: Text('Hover me')),
)
''',
);

Widget _buildHoverActivityExample(BuildContext context) {
  return const _HoverActivityExample();
}

class _HoverActivityExample extends StatefulWidget {
  const _HoverActivityExample();

  @override
  State<_HoverActivityExample> createState() => _HoverActivityExampleState();
}

class _HoverActivityExampleState extends State<_HoverActivityExample> {
  int _pings = 0;

  @override
  Widget build(BuildContext context) {
    return shadcn_hover.HoverActivity(
      debounceDuration: const Duration(milliseconds: 300),
      onHover: () => setState(() => _pings += 1),
      child: shadcn_card.SurfaceCard(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Hover ping').semiBold(),
              const SizedBox(height: 6),
              Text('Pings: $_pings').muted(),
            ],
          ),
        ),
      ),
    );
  }
}

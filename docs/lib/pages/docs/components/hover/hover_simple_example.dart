import 'package:flutter/material.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/control/hover/hover.dart'
    as shadcn_hover;
import '../../../../ui/shadcn/components/layout/card/card.dart' as shadcn_card;
import '../../../../ui/shadcn/shared/primitives/text.dart';
import '../../../../ui/shadcn/shared/theme/theme.dart' as shadcn_theme;

const ComponentExample hoverSimpleExample = ComponentExample(
  title: 'Hover highlight',
  builder: _buildHoverSimpleExample,
  code: '''
Hover(
  onHover: (hovered) {},
  child: SurfaceCard(
    child: Padding(
      padding: EdgeInsets.all(20),
      child: Text('Hover me'),
    ),
  ),
)
''',
);

Widget _buildHoverSimpleExample(BuildContext context) {
  return const _HoverSimpleExample();
}

class _HoverSimpleExample extends StatefulWidget {
  const _HoverSimpleExample();

  @override
  State<_HoverSimpleExample> createState() => _HoverSimpleExampleState();
}

class _HoverSimpleExampleState extends State<_HoverSimpleExample> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = shadcn_theme.Theme.of(context);
    return shadcn_hover.Hover(
      onHover: (hovered) => setState(() => _hovered = hovered),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: theme.borderRadiusLg,
          border: Border.all(
            color:
                _hovered ? theme.colorScheme.accent : theme.colorScheme.border,
          ),
        ),
        child: shadcn_card.SurfaceCard(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(_hovered ? 'Hover active' : 'Hover me').semiBold(),
                const SizedBox(height: 6),
                const Text('Moves on mouse hover').muted().small(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

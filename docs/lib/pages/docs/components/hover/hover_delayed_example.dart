import 'package:flutter/material.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/control/hover/hover.dart'
    as shadcn_hover;
import '../../../../ui/shadcn/components/layout/card/card.dart' as shadcn_card;
import '../../../../ui/shadcn/shared/primitives/text.dart';
import '../../../../ui/shadcn/shared/theme/theme.dart' as shadcn_theme;

const ComponentExample hoverDelayedExample = ComponentExample(
  title: 'Delayed hover reveal',
  builder: _buildHoverDelayedExample,
  code: '''
Hover(
  waitDuration: Duration(milliseconds: 400),
  minDuration: Duration(milliseconds: 200),
  onHover: (hovered) {},
  child: SurfaceCard(child: Text('Pause to reveal')),
)
''',
);

Widget _buildHoverDelayedExample(BuildContext context) {
  return const _HoverDelayedExample();
}

class _HoverDelayedExample extends StatefulWidget {
  const _HoverDelayedExample();

  @override
  State<_HoverDelayedExample> createState() => _HoverDelayedExampleState();
}

class _HoverDelayedExampleState extends State<_HoverDelayedExample> {
  bool _active = false;

  @override
  Widget build(BuildContext context) {
    final theme = shadcn_theme.Theme.of(context);
    return shadcn_hover.Hover(
      waitDuration: const Duration(milliseconds: 400),
      minDuration: const Duration(milliseconds: 200),
      onHover: (hovered) => setState(() => _active = hovered),
      child: shadcn_card.SurfaceCard(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Pause to reveal').semiBold(),
              const SizedBox(height: 10),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 160),
                opacity: _active ? 1 : 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.muted,
                    borderRadius: theme.borderRadiusSm,
                  ),
                  child: const Text('Hover details').small(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

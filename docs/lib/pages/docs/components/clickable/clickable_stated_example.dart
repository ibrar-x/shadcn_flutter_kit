import 'package:flutter/material.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/control/clickable/clickable.dart'
    as shadcn_control_clickable;
import '../../../../ui/shadcn/shared/primitives/clickable.dart'
    as shadcn_clickable;
import '../../../../ui/shadcn/shared/primitives/text.dart';
import '../../../../ui/shadcn/shared/theme/theme.dart' as shadcn_theme;

const ComponentExample clickableStatedExample = ComponentExample(
  title: 'Clickable state-driven content',
  builder: _buildClickableStatedExample,
  code: '''
Clickable(
  onPressed: () {},
  child: StatedWidget(
    hovered: Text('Hovered'),
    pressed: Text('Pressed'),
    focused: Text('Focused'),
    child: Text('Ready'),
  ),
)
''',
);

Widget _buildClickableStatedExample(BuildContext context) {
  final theme = shadcn_theme.Theme.of(context);
  return shadcn_control_clickable.Clickable(
    onPressed: () {},
    padding: WidgetStateProperty.all(
      EdgeInsets.symmetric(
        horizontal: 24 * theme.scaling,
        vertical: 18 * theme.scaling,
      ),
    ),
    decoration: WidgetStateProperty.resolveWith((states) {
      final accent = theme.colorScheme.accent;
      final borderColor = states.contains(WidgetState.focused)
          ? accent
          : theme.colorScheme.border;
      return BoxDecoration(
        color: theme.colorScheme.card,
        borderRadius: theme.borderRadiusMd,
        border: Border.all(color: borderColor),
      );
    }),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const shadcn_clickable.StatedWidget(
          hovered: Icon(Icons.flash_on_rounded),
          pressed: Icon(Icons.flash_on_rounded),
          focused: Icon(Icons.flash_on_outlined),
          child: Icon(Icons.flash_on_outlined),
        ),
        const SizedBox(height: 8),
        shadcn_clickable.StatedWidget(
          hovered: const Text('Hovered').semiBold(),
          pressed: const Text('Pressed').semiBold(),
          focused: const Text('Focused').semiBold(),
          child: const Text('Ready').semiBold(),
        ),
        const SizedBox(height: 4),
        const Text('Use keyboard or hover').muted().small(),
      ],
    ),
  );
}

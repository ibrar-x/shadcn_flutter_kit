import 'package:flutter/material.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/control/clickable/clickable.dart'
    as shadcn_clickable;
import '../../../../ui/shadcn/components/layout/basic/basic.dart'
    as shadcn_basic;
import '../../../../ui/shadcn/shared/primitives/text.dart';
import '../../../../ui/shadcn/shared/theme/theme.dart' as shadcn_theme;

const ComponentExample clickableCardExample = ComponentExample(
  title: 'Clickable card',
  builder: _buildClickableCardExample,
  code: '''
Clickable(
  onPressed: () {},
  padding: WidgetStateProperty.all(EdgeInsets.all(16)),
  decoration: WidgetStateProperty.resolveWith((states) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Theme.of(context).colorScheme.border),
    );
  }),
  child: SizedBox(
    width: 260,
    child: Basic(
      leading: Icon(Icons.folder_outlined),
      title: Text('Product roadmap'),
      subtitle: Text('Updated 2 hours ago'),
      trailing: Icon(Icons.chevron_right),
    ),
  ),
)
''',
);

Widget _buildClickableCardExample(BuildContext context) {
  final theme = shadcn_theme.Theme.of(context);
  return shadcn_clickable.Clickable(
    onPressed: () {},
    padding: WidgetStateProperty.all(const EdgeInsets.all(16)),
    decoration: WidgetStateProperty.resolveWith((states) {
      final baseColor = theme.colorScheme.card;
      final hoverColor = theme.colorScheme.muted;
      final pressedColor = theme.colorScheme.muted.withValues(alpha: 0.7);
      return BoxDecoration(
        color: states.contains(WidgetState.pressed)
            ? pressedColor
            : states.contains(WidgetState.hovered)
                ? hoverColor
                : baseColor,
        borderRadius: theme.borderRadiusLg,
        border: Border.all(color: theme.colorScheme.border),
      );
    }),
    child: SizedBox(
      width: 260,
      child: shadcn_basic.Basic(
        leading: const Icon(Icons.folder_outlined),
        title: const Text('Product roadmap').semiBold(),
        subtitle: const Text('Updated 2 hours ago').muted(),
        trailing: const Icon(Icons.chevron_right),
        trailingAlignment: Alignment.centerRight,
      ),
    ),
  );
}

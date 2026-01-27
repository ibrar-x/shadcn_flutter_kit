import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../../../../shared/theme/theme.dart';
import '../../../../../shared/primitives/text.dart';

class CommandKeyboardDisplay extends StatelessWidget {
  const CommandKeyboardDisplay({super.key, required this.keys});

  factory CommandKeyboardDisplay.fromActivator(
      {required SingleActivator activator}) {
    final keys = <LogicalKeyboardKey>[];
    if (activator.control) keys.add(LogicalKeyboardKey.control);
    if (activator.shift) keys.add(LogicalKeyboardKey.shift);
    if (activator.alt) keys.add(LogicalKeyboardKey.alt);
    if (activator.meta) keys.add(LogicalKeyboardKey.meta);
    keys.add(activator.trigger);
    return CommandKeyboardDisplay(
      key: ValueKey(keys.map((key) => key.keyId).join('-')),
      keys: keys,
    );
  }

  final List<LogicalKeyboardKey> keys;

  @override
  Widget build(BuildContext context) {
    if (keys.isEmpty) {
      return const SizedBox.shrink();
    }
    final theme = Theme.of(context);
    return Wrap(
      spacing: theme.scaling * 4,
      children: keys.map((key) {
        final label = key.keyLabel.isNotEmpty
            ? key.keyLabel
            : key.debugName ?? key.toString();
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: theme.scaling * 6,
            vertical: theme.scaling * 2,
          ),
          decoration: BoxDecoration(
            color: theme.colorScheme.card,
            borderRadius: BorderRadius.circular(theme.radiusSm),
            border: Border.all(color: theme.colorScheme.border, width: 1),
          ),
          child: Text(label).small(),
        );
      }).toList(),
    );
  }
}

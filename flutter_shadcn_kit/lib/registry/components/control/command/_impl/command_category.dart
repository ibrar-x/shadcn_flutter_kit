import 'package:flutter/widgets.dart';

import '../../../../shared/theme/theme.dart';
import '../../../../shared/primitives/text.dart';
import '../../../../shared/utils/util.dart';

/// Groups command items under an optional heading.
class CommandCategory extends StatelessWidget {
  /// Creates a command category.
  const CommandCategory({
    super.key,
    required this.children,
    this.title,
  });

  /// Items belonging to this category.
  final List<Widget> children;

  /// Optional header.
  final Widget? title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (title != null)
          title!
              .withPadding(
                horizontal: theme.scaling * 8,
                vertical: theme.scaling * 6,
              )
              .medium()
              .xSmall()
              .muted(),
        ...children,
      ],
    ).withPadding(all: theme.scaling * 4);
  }
}

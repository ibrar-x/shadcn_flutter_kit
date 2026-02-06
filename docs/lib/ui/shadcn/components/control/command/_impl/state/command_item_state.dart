import 'package:flutter/material.dart' hide Theme, TextField;
import 'package:gap/gap.dart';

import '../../../../../shared/primitives/clickable.dart';
import '../../../../../shared/primitives/subfocus.dart';
import '../../../../../shared/theme/theme.dart';
import '../../../../../shared/utils/constants.dart';
import '../../../../../shared/utils/color_extensions.dart';
import '../../../../../shared/primitives/text.dart';
import '../core/command_item_widget.dart';

class CommandItemState extends State<CommandItem> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Actions(
      actions: {
        ActivateIntent: CallbackAction<Intent>(
          onInvoke: (intent) {
            widget.onTap?.call();
            return null;
          },
        ),
      },
      child: SubFocus(
        builder: (context, state) {
          return Clickable(
            onPressed: widget.onTap,
            onHover: (hovered) {
              if (hovered) {
                state.requestFocus();
              }
            },
            child: AnimatedContainer(
              duration: kDefaultDuration,
              decoration: BoxDecoration(
                color: state.isFocused
                    ? themeData.colorScheme.accent
                    : themeData.colorScheme.accent.withValues(alpha: 0),
                borderRadius: BorderRadius.circular(themeData.radiusSm),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: themeData.scaling * 8,
                vertical: themeData.scaling * 6,
              ),
              child: IconTheme(
                data: themeData.iconTheme.small.copyWith(
                  color: widget.onTap != null
                      ? themeData.colorScheme.accentForeground
                      : themeData.colorScheme.accentForeground.scaleAlpha(0.5),
                ),
                child: DefaultTextStyle(
                  style: TextStyle(
                    color: widget.onTap != null
                        ? themeData.colorScheme.accentForeground
                        : themeData.colorScheme.accentForeground
                            .scaleAlpha(0.5),
                  ),
                  child: Row(
                    children: [
                      if (widget.leading != null) widget.leading!,
                      if (widget.leading != null) Gap(themeData.scaling * 8),
                      Expanded(child: widget.title),
                      if (widget.trailing != null) Gap(themeData.scaling * 8),
                      if (widget.trailing != null)
                        widget.trailing!.muted().xSmall(),
                    ],
                  ).small(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

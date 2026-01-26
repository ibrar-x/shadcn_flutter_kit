part of '../command.dart';

class _CommandItemState extends State<CommandItem> {
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

class _CommandKeyboardDisplay extends StatelessWidget {
  const _CommandKeyboardDisplay({super.key, required this.keys});

  factory _CommandKeyboardDisplay.fromActivator(
      {required SingleActivator activator}) {
    final keys = <LogicalKeyboardKey>[];
    if (activator.control) keys.add(LogicalKeyboardKey.control);
    if (activator.shift) keys.add(LogicalKeyboardKey.shift);
    if (activator.alt) keys.add(LogicalKeyboardKey.alt);
    if (activator.meta) keys.add(LogicalKeyboardKey.meta);
    keys.add(activator.trigger);
    return _CommandKeyboardDisplay(
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

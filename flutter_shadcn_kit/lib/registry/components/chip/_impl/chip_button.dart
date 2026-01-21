part of '../chip.dart';

/// Specialized button for inside chips.
class ChipButton extends StatelessWidget {
  const ChipButton({
    super.key,
    required this.child,
    this.onPressed,
  });

  final Widget child;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final componentTheme = ComponentTheme.maybeOf<ChipTheme>(context);
    final padding = styleValue(
      themeValue: componentTheme?.padding,
      defaultValue: EdgeInsets.zero,
    );
    final style = componentTheme?.style ??
        ButtonVariance(
          decoration: (context, states) => const BoxDecoration(),
          mouseCursor: (context, states) {
            if (states.contains(WidgetState.disabled)) {
              return SystemMouseCursors.basic;
            }
            return SystemMouseCursors.click;
          },
          padding: (context, states) => padding,
          textStyle: (context, states) => const TextStyle(),
          iconTheme: (context, states) => theme.iconTheme.xSmall,
          margin: (context, states) => EdgeInsets.zero,
        );
    return Button(
      style: style,
      onPressed: onPressed,
      child: child,
    );
  }
}

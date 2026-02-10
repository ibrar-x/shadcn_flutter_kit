part of '../../code_snippet.dart';

class _CodeSnippetState extends State<CodeSnippet> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final compTheme = ComponentTheme.maybeOf<CodeSnippetTheme>(context);
    final backgroundColor = styleValue(
      themeValue: compTheme?.backgroundColor,
      defaultValue: theme.colorScheme.card,
    );
    final borderColor = styleValue(
      themeValue: compTheme?.borderColor,
      defaultValue: theme.colorScheme.border,
    );
    final borderWidth = styleValue(
      themeValue: compTheme?.borderWidth,
      defaultValue: theme.scaling,
    );
    final borderRadius = styleValue(
      themeValue: compTheme?.borderRadius,
      defaultValue: BorderRadius.circular(theme.radiusLg),
    );
    final padding = styleValue(
      themeValue: compTheme?.padding,
      defaultValue: EdgeInsets.only(
        left: theme.density.baseContainerPadding * theme.scaling * padSm,
        right: theme.density.baseContainerPadding * theme.scaling * pad3xl,
        top: theme.density.baseContainerPadding * theme.scaling * padSm,
        bottom: theme.density.baseContainerPadding * theme.scaling * padSm,
      ),
    );

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: borderColor, width: borderWidth),
        borderRadius: borderRadius,
      ),
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          Container(
            constraints: widget.constraints,
            child: SingleChildScrollView(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: padding,
                child: widget.code.mono.small.muted,
              ),
            ),
          ),
          if (widget.actions.isNotEmpty)
            Positioned(
              right: theme.density.baseGap * theme.scaling * gapSm,
              top: theme.density.baseGap * theme.scaling * gapSm,
              child: Row(children: _spacedActions),
            ),
        ],
      ),
    );
  }

  List<Widget> get _spacedActions {
    final actions = widget.actions;
    if (actions.isEmpty) {
      return const [];
    }
    final spaced = <Widget>[];
    for (var i = 0; i < actions.length; i++) {
      spaced.add(actions[i]);
      if (i < actions.length - 1) {
        spaced.add(const DensityGap(gapXs));
      }
    }
    return spaced;
  }
}

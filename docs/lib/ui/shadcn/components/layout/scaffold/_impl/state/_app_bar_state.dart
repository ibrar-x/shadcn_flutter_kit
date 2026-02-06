part of '../../scaffold.dart';

class _AppBarState extends State<AppBar> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final barData = Data.maybeOf<ScaffoldBarData>(context);
    var surfaceBlur = widget.surfaceBlur ?? theme.surfaceBlur;
    var surfaceOpacity = widget.surfaceOpacity ?? theme.surfaceOpacity;
    return FocusTraversalGroup(
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: surfaceBlur ?? 0,
            sigmaY: surfaceBlur ?? 0,
          ),
          child: Container(
            color: widget.backgroundColor ??
                theme.colorScheme.card.scaleAlpha(surfaceOpacity ?? 1),
            alignment: widget.alignment,
            padding: widget.padding ??
                (const EdgeInsets.symmetric(horizontal: 18, vertical: 12) *
                    scaling),
            child: SafeArea(
              top: widget.useSafeArea &&
                  barData?.isHeader == true &&
                  barData?.childIndex == 0,
              right: widget.useSafeArea,
              left: widget.useSafeArea,
              bottom: widget.useSafeArea &&
                  barData?.isHeader == false &&
                  barData?.childIndex == (barData?.childrenCount ?? 0) - 1,
              child: SizedBox(
                height: widget.height,
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (widget.leading.isNotEmpty)
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: widget.leading,
                        ).gap(widget.leadingGap ?? (4 * scaling)),
                      Flexible(
                        fit: widget.trailingExpanded
                            ? FlexFit.loose
                            : FlexFit.tight,
                        child: widget.child ??
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (widget.header != null)
                                  KeyedSubtree(
                                    key: const ValueKey('header'),
                                    child: widget.header!.muted().small(),
                                  ),
                                if (widget.title != null)
                                  KeyedSubtree(
                                    key: const ValueKey('title'),
                                    child: widget.title!.large().medium(),
                                  ),
                                if (widget.subtitle != null)
                                  KeyedSubtree(
                                    key: const ValueKey('subtitle'),
                                    child: widget.subtitle!.muted().small(),
                                  ),
                              ],
                            ),
                      ),
                      if (widget.trailing.isNotEmpty)
                        if (!widget.trailingExpanded)
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: widget.trailing,
                          ).gap(widget.trailingGap ?? (4 * scaling))
                        else
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: widget.trailing,
                            ).gap(widget.trailingGap ?? (4 * scaling)),
                          ),
                    ],
                  ).gap(18 * scaling),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

part of '../../refresh_trigger.dart';

class _DefaultRefreshIndicatorState extends State<DefaultRefreshIndicator> {
  Widget buildRefreshingContent(BuildContext context) {
    final localizations = ShadcnLocalizations.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(child: Text(localizations.refreshTriggerRefreshing)),
        const CircularProgressIndicator(),
      ],
    ).gap(8);
  }

  Widget buildCompletedContent(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = ShadcnLocalizations.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(child: Text(localizations.refreshTriggerComplete)),
        SizedBox(
          width: 12.0 * theme.scaling,
          height: 8.0 * theme.scaling,
          child: AnimatedValueBuilder(
            initialValue: 0.0,
            value: 1.0,
            duration: const Duration(milliseconds: 300),
            curve: const Interval(0.5, 1.0),
            builder: (context, value, _) {
              return CustomPaint(
                painter: AnimatedCheckPainter(
                  progress: value,
                  color: theme.colorScheme.foreground,
                  strokeWidth: 1.5 * theme.scaling,
                ),
              );
            },
          ),
        ),
      ],
    ).gap(8);
  }

  Widget buildPullingContent(BuildContext context) {
    final localizations = ShadcnLocalizations.of(context);
    return AnimatedBuilder(
      animation: widget.stage.extent,
      builder: (context, child) {
        double angle;
        if (widget.stage.direction == Axis.vertical) {
          // 0 -> 1 (0 -> 180)
          angle = -pi * widget.stage.extentValue.clamp(0, 1);
        } else {
          // 0 -> 1 (90 -> 270)
          angle = -pi / 2 + -pi * widget.stage.extentValue.clamp(0, 1);
        }
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Transform.rotate(
              angle: angle,
              child: const Icon(Icons.arrow_downward),
            ),
            Flexible(
              child: Text(
                widget.stage.extentValue < 1
                    ? localizations.refreshTriggerPull
                    : localizations.refreshTriggerRelease,
              ),
            ),
            Transform.rotate(
              angle: angle,
              child: const Icon(Icons.arrow_downward),
            ),
          ],
        ).gap(8);
      },
    );
  }

  Widget buildIdleContent(BuildContext context) {
    final localizations = ShadcnLocalizations.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [Flexible(child: Text(localizations.refreshTriggerPull))],
    ).gap(8);
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    switch (widget.stage.stage) {
      case TriggerStage.refreshing:
        child = buildRefreshingContent(context);
        break;
      case TriggerStage.completed:
        child = buildCompletedContent(context);
        break;
      case TriggerStage.pulling:
        child = buildPullingContent(context);
        break;
      case TriggerStage.idle:
        child = buildIdleContent(context);
        break;
    }
    final theme = Theme.of(context);
    return Center(
      child: SurfaceCard(
        padding: widget.stage.stage == TriggerStage.pulling
            ? EdgeInsets.all(theme.density.baseGap * theme.scaling * 0.5)
            : EdgeInsets.symmetric(
                    horizontal: theme.density.baseContentPadding * 0.75,
                    vertical: theme.density.baseGap * 0.5,
                  ) *
                  theme.scaling,
        borderRadius: theme.borderRadiusXl,
        child: AnimatedSwitcher(
          duration: kDefaultDuration,
          child: KeyedSubtree(key: ValueKey(widget.stage.stage), child: child),
        ),
      ),
    );
  }
}

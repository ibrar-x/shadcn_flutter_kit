part of '../../tracker.dart';

/// Visual tracker display.
class Tracker extends StatelessWidget {
  final List<TrackerData> data;

  const Tracker({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final trackerTheme = ComponentTheme.maybeOf<TrackerTheme>(context);
    return ClipRRect(
      borderRadius:
          BorderRadius.circular(trackerTheme?.radius ?? theme.radiusMd),
      child: Row(
        children: [
          for (final entry in data)
            Expanded(
              child: InstantTooltip(
                tooltipBuilder: (context) {
                  return TooltipContainer(
                    child: entry.tooltip,
                  );
                },
                child: Container(
                  height: trackerTheme?.itemHeight ?? 32,
                  color: entry.level.color,
                ),
              ),
            )
        ],
      ).gap(trackerTheme?.gap ?? theme.scaling * 2),
    );
  }
}

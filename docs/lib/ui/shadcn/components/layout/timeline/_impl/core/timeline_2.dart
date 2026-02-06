part of '../../timeline.dart';

class Timeline extends StatelessWidget {
  /// List of timeline entries to display.
  ///
  /// Each [TimelineData] object represents one row in the timeline with
  /// time information, title, optional content, and optional custom color.
  /// The timeline renders entries in the order provided in this list.
  final List<TimelineData> data;

  /// Override constraints for the time column width.
  ///
  /// When provided, overrides the theme's [TimelineTheme.timeConstraints]
  /// for this specific timeline instance. Controls how much space is allocated
  /// for displaying time information. If null, uses theme or default constraints.
  final BoxConstraints? timeConstraints;

  /// Creates a [Timeline] widget with the specified data entries.
  ///
  /// Parameters:
  /// - [data] (`List<TimelineData>`, required): Timeline entries to display in order.
  /// - [timeConstraints] (BoxConstraints?, optional): Override width constraints for time column.
  ///
  /// The timeline automatically handles layout, styling, and visual indicators
  /// based on the current theme and provided data. Each entry's time, title,
  /// content, and color are used to construct the appropriate visual representation.
  ///
  /// Example:
  /// ```dart
  /// Timeline(
  ///   timeConstraints: BoxConstraints(minWidth: 80, maxWidth: 120),
  ///   data: [
  ///     TimelineData(
  ///       time: Text('Yesterday'),
  ///       title: Text('Initial Setup'),
  ///       content: Text('Project repository created and initial structure added.'),
  ///     ),
  ///     TimelineData(
  ///       time: Text('Today'),
  ///       title: Text('Feature Development'),
  ///       content: Text('Implementing core functionality and UI components.'),
  ///       color: Colors.orange,
  ///     ),
  ///   ],
  /// );
  /// ```
  const Timeline({
    super.key,
    required this.data,
    // this.timeConstraints = const BoxConstraints(
    //   minWidth: 120,
    //   maxWidth: 120,
    // ),
    this.timeConstraints,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final compTheme = ComponentTheme.maybeOf<TimelineTheme>(context);
    final timeConstraints = this.timeConstraints ??
        compTheme?.timeConstraints ??
        BoxConstraints(minWidth: 120 * scaling, maxWidth: 120 * scaling);
    final spacing = compTheme?.spacing ?? 16 * scaling;
    final dotSize = compTheme?.dotSize ?? 12 * scaling;
    final connectorThickness = compTheme?.connectorThickness ?? 2 * scaling;
    final defaultColor = compTheme?.color ?? theme.colorScheme.primary;
    final rowGap = compTheme?.rowGap ?? 16 * scaling;
    List<Widget> rows = [];
    for (int i = 0; i < data.length; i++) {
      final data = this.data[i];
      rows.add(IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ConstrainedBox(
              constraints: timeConstraints,
              child: Align(
                alignment: Alignment.topRight,
                child: data.time.medium().small(),
              ),
            ),
            Gap(spacing),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 4 * scaling),
                  width: dotSize,
                  height: dotSize,
                  decoration: BoxDecoration(
                    shape: theme.radius == 0
                        ? BoxShape.rectangle
                        : BoxShape.circle,
                    color: data.color ?? defaultColor,
                  ),
                ),
                if (i != this.data.length - 1)
                  Expanded(
                    child: VerticalDivider(
                      thickness: connectorThickness,
                      color: data.color ?? defaultColor,
                      endIndent: (-4 - spacing) * scaling,
                    ),
                  ),
              ],
            ),
            Gap(spacing),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  data.title
                      .semiBold()
                      .secondaryForeground()
                      .base()
                      .withPadding(left: 4 * scaling),
                  if (data.content != null) Gap(8 * scaling),
                  if (data.content != null)
                    Expanded(child: data.content!.muted().small()),
                ],
              ),
            )
          ],
        ),
      ));
    }
    return Column(
      children: rows,
    ).gap(rowGap);
  }
}

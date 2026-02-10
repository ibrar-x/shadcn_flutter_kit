part of '../../steps.dart';

class Steps extends StatelessWidget {
  /// List of widgets representing each step in the sequence.
  ///
  /// Each widget will be displayed with an automatically numbered
  /// circular indicator showing its position in the sequence.
  final List<Widget> children;

  /// Creates a [Steps] widget.
  ///
  /// Each child widget represents one step in the sequence and will be
  /// displayed with an automatically numbered circular indicator.
  ///
  /// Parameters:
  /// - [children] (`List<Widget>`, required): list of widgets representing each step
  ///
  /// Example:
  /// ```dart
  /// Steps(
  ///   children: [
  ///     Text('First step content'),
  ///     Text('Second step content'),
  ///     Text('Third step content'),
  ///   ],
  /// )
  /// ```
  const Steps({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final compTheme = ComponentTheme.maybeOf<StepsTheme>(context);
    final indicatorSize = compTheme?.indicatorSize ?? 28 * scaling;
    final spacing =
        compTheme?.spacing ??
        theme.density.baseContentPadding * scaling * 1.125;
    final indicatorColor = compTheme?.indicatorColor ?? theme.colorScheme.muted;
    final connectorThickness = compTheme?.connectorThickness ?? 1 * scaling;
    List<Widget> mapped = [];
    for (var i = 0; i < children.length; i++) {
      mapped.add(
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: indicatorColor,
                      shape: BoxShape.circle,
                    ),
                    width: indicatorSize,
                    height: indicatorSize,
                    child: Center(
                      child: Text((i + 1).toString()).mono().bold(),
                    ),
                  ),
                  DensityGap(gapXs),
                  Expanded(
                    child: VerticalDivider(
                      thickness: connectorThickness,
                      color: indicatorColor,
                    ),
                  ),
                  DensityGap(gapXs),
                ],
              ),
              Gap(spacing),
              Expanded(child: children[i].withPadding(bottom: 32 * scaling)),
            ],
          ),
        ),
      );
    }
    return IntrinsicWidth(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: mapped,
      ),
    );
  }
}

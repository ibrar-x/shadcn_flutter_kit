part of '../collapsible.dart';

/// Holder for the collapsible child content.
class CollapsibleContent extends StatelessWidget {
  /// Creates a content pane for [Collapsible].
  const CollapsibleContent({
    super.key,
    this.collapsible = true,
    required this.child,
  });

  /// Whether this pane should respect the expansion state.
  final bool collapsible;

  /// Inner widget that is shown or hidden.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final state = Data.of<CollapsibleStateData>(context);
    return Offstage(
      offstage: collapsible && !state.isExpanded,
      child: child,
    );
  }
}

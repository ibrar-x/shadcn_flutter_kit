part of '../../scrollable_client.dart';

/// ScrollableClientViewport defines a reusable type for this registry module.
class ScrollableClientViewport extends TwoDimensionalViewport {
  /// Whether overscroll effects are enabled.
  final bool overscroll;

  /// Creates a [ScrollableClientViewport].
  const ScrollableClientViewport({
    super.key,
    required super.verticalOffset,
    required super.verticalAxisDirection,
    required super.horizontalOffset,
    required super.horizontalAxisDirection,
    required super.delegate,
    required super.mainAxis,
    super.cacheExtent,
    super.clipBehavior = Clip.hardEdge,
    required this.overscroll,
  });

  @override
/// Executes `createRenderObject` behavior for this component/composite.
  RenderTwoDimensionalViewport createRenderObject(BuildContext context) {
    return RenderScrollableClientViewport(
      horizontalOffset: horizontalOffset,
      horizontalAxisDirection: horizontalAxisDirection,
      verticalOffset: verticalOffset,
      verticalAxisDirection: verticalAxisDirection,
      delegate: delegate,
      mainAxis: mainAxis,
      childManager: context as TwoDimensionalChildManager,
      cacheExtent: cacheExtent,
      clipBehavior: clipBehavior,
      overscroll: overscroll,
    );
  }
}

part of '../../scrollable_client.dart';

class RenderScrollableClientViewport extends RenderTwoDimensionalViewport {
  /// Whether overscroll effects are enabled.
  final bool overscroll;

  /// Creates a [RenderScrollableClientViewport].
  RenderScrollableClientViewport({
    required super.horizontalOffset,
    required super.horizontalAxisDirection,
    required super.verticalOffset,
    required super.verticalAxisDirection,
    required super.delegate,
    required super.mainAxis,
    required super.childManager,
    super.cacheExtent,
    super.clipBehavior = Clip.hardEdge,
    required this.overscroll,
  });

  @override
  void layoutChildSequence() {
    double horizontalPixels = horizontalOffset.pixels;
    double verticalPixels = verticalOffset.pixels;
    final Size viewportDimension = this.viewportDimension;
    final ChildVicinity vicinity = _ScrollableClientChildVicinity(
      viewportSize: viewportDimension,
      xIndex: 0,
      yIndex: 0,
    );
    final RenderBox child = buildOrObtainChildFor(vicinity)!;
    child.layout(
        BoxConstraints(
          minWidth: constraints.maxWidth,
          minHeight: constraints.maxHeight,
        ),
        parentUsesSize: true);
    if (!overscroll) {
      horizontalPixels = max(0.0, horizontalPixels);
      verticalPixels = max(0.0, verticalPixels);
      double maxHorizontalPixels = child.size.width - viewportDimension.width;
      double maxVerticalPixels = child.size.height - viewportDimension.height;
      horizontalPixels = min(horizontalPixels, maxHorizontalPixels);
      verticalPixels = min(verticalPixels, maxVerticalPixels);
    }
    parentDataOf(child).layoutOffset =
        Offset(-horizontalPixels, -verticalPixels);
    horizontalOffset.applyContentDimensions(
        0,
        (child.size.width - viewportDimension.width)
            .clamp(0.0, double.infinity));
    verticalOffset.applyContentDimensions(
        0,
        (child.size.height - viewportDimension.height)
            .clamp(0.0, double.infinity));
    horizontalOffset.applyViewportDimension(viewportDimension.width);
    verticalOffset.applyViewportDimension(viewportDimension.height);
  }
}

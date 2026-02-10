part of '../../scrollable.dart';

class _ScrollableClientChildVicinity extends ChildVicinity {
  final Size viewportSize;

  const _ScrollableClientChildVicinity({
    required this.viewportSize,
    required super.xIndex,
    required super.yIndex,
  });
}

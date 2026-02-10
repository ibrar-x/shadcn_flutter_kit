part of '../../flex.dart';

/// Parent data used by patched [RenderStack].
class StackParentData extends rendering.StackParentData
    with PaintOrderParentDataMixin {
  @override
  String toString() => '${super.toString()}; paintOrder=$paintOrder';
}

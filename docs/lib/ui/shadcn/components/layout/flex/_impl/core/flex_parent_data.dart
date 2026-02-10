part of '../../flex.dart';

/// Parent data used by patched [RenderFlex].
class FlexParentData extends rendering.FlexParentData
    with PaintOrderParentDataMixin {
  @override
  String toString() => '${super.toString()}; paintOrder=$paintOrder';
}

part of '../../flex.dart';

/// Parent data used by patched [RenderFlex].
class FlexParentData extends rendering.FlexParentData
    with PaintOrderParentDataMixin {
  @override
/// Executes `toString` behavior for this component/composite.
  String toString() => '${super.toString()}; paintOrder=$paintOrder';
}

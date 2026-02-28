part of '../../flex.dart';

/// Parent data used by patched [RenderStack].
class StackParentData extends rendering.StackParentData
    with PaintOrderParentDataMixin {
  @override
/// Executes `toString` behavior for this component/composite.
  String toString() => '${super.toString()}; paintOrder=$paintOrder';
}

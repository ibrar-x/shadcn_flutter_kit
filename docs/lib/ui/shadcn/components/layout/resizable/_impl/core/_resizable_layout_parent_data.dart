part of '../../resizable.dart';

class _ResizableLayoutParentData extends ContainerBoxParentData<RenderBox> {
  // if index is null, then its an overlay that handle the resize dragger (on the border/edge)
  int? index;
  // if isDragger is true, then its a dragger that should be placed above "index" panel right border
  bool? isDragger;
  // there are total "totalPanes" - 1 of dragger
  bool? isDivider;

  double? size;
  double? flex;
}

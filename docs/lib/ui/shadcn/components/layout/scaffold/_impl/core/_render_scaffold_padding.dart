part of '../../scaffold.dart';

class _RenderScaffoldPadding extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, _ScaffoldParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, _ScaffoldParentData> {
  final _ScaffoldPaddingType _paddingType;

  _RenderScaffoldPadding({
    _ScaffoldPaddingType paddingType = _ScaffoldPaddingType.header,
  }) : _paddingType = paddingType;

  _ScaffoldRenderFlex? findParent() {
    RenderObject? parent = this;
    while (parent != null) {
      if (parent is _ScaffoldRenderFlex) {
        return parent;
      }
      parent = parent.parent;
    }
    return null;
  }

  _ScaffoldRenderFlex? currentParent;

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    var scaffoldParent = findParent();
    currentParent = scaffoldParent;
    scaffoldParent?._headerSize.addListener(markNeedsLayout);
    scaffoldParent?._footerSize.addListener(markNeedsLayout);
  }

  @override
  void detach() {
    var scaffoldParent = currentParent;
    scaffoldParent?._headerSize.removeListener(markNeedsLayout);
    scaffoldParent?._footerSize.removeListener(markNeedsLayout);
    super.detach();
  }

  @override
  void performLayout() {
    _ScaffoldRenderFlex? parentData = findParent();
    assert(parentData != null, 'Must be a child of a Scaffold');
    BoxConstraints constraints;
    switch (_paddingType) {
      case _ScaffoldPaddingType.header:
        constraints = this.constraints.copyWith(
              minHeight: parentData!._headerSize.value,
              maxHeight: parentData._headerSize.value,
            );
        break;
      case _ScaffoldPaddingType.footer:
        constraints = this.constraints.copyWith(
              minHeight: parentData!._footerSize.value,
              maxHeight: parentData._footerSize.value,
            );
        break;
    }
    final child = firstChild;
    if (child != null) {
      child.layout(constraints, parentUsesSize: true);
      size = constraints.constrain(child.size);
      (child.parentData as BoxParentData).offset = Offset.zero;
    } else {
      size = constraints.biggest;
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    defaultPaint(context, offset);
  }
}

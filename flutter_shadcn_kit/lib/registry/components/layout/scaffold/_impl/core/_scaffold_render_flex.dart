part of '../../scaffold.dart';

class _ScaffoldRenderFlex extends RenderBox
    with ContainerRenderObjectMixin<RenderBox, _ScaffoldParentData> {
  _ScaffoldRenderFlex({
    required bool floatingHeader,
    required bool floatingFooter,
  }) : _floatingHeader = floatingHeader,
       _floatingFooter = floatingFooter;

  bool _floatingHeader = false;
  bool _floatingFooter = false;

  final ValueNotifier<double> _headerSize = ValueNotifier(0);
  final ValueNotifier<double> _footerSize = ValueNotifier(0);

  @override
  void setupParentData(covariant RenderObject child) {
    if (child.parentData is! _ScaffoldParentData) {
      child.parentData = _ScaffoldParentData();
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    // There is gonna be only 3 children
    // 1. header
    // 2. content
    // 3. footer
    // By default, the paint order is 1, 2, 3
    // but with this custom implementation, we can change the order to 2, 1, 3
    // which means the header will be painted after the content
    // and the footer will be painted after the header
    RenderBox header = firstChild!;
    RenderBox content = (header.parentData as _ScaffoldParentData).nextSibling!;
    RenderBox footer = (content.parentData as _ScaffoldParentData).nextSibling!;
    context.paintChild(
      content,
      (content.parentData as BoxParentData).offset + offset,
    );
    context.paintChild(
      header,
      (header.parentData as BoxParentData).offset + offset,
    );
    context.paintChild(
      footer,
      (footer.parentData as BoxParentData).offset + offset,
    );
  }

  bool _hitTestBox(BoxHitTestResult result, RenderBox child, Offset position) {
    final BoxParentData childParentData = child.parentData as BoxParentData;
    final bool isHit = result.addWithPaintOffset(
      offset: childParentData.offset,
      position: position,
      hitTest: (BoxHitTestResult result, Offset transformed) {
        assert(transformed == position - childParentData.offset);
        return child.hitTest(result, position: transformed);
      },
    );
    return isHit;
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    RenderBox header = firstChild!;
    RenderBox content = (header.parentData as _ScaffoldParentData).nextSibling!;
    RenderBox footer = (content.parentData as _ScaffoldParentData).nextSibling!;
    if (_hitTestBox(result, header, position)) {
      return true;
    }
    if (_hitTestBox(result, footer, position)) {
      return true;
    }
    if (_hitTestBox(result, content, position)) {
      return true;
    }
    return false;
  }

  @override
  void performLayout() {
    RenderBox header = firstChild!;
    RenderBox content = (header.parentData as _ScaffoldParentData).nextSibling!;
    RenderBox footer = (content.parentData as _ScaffoldParentData).nextSibling!;
    final constraints = this.constraints;

    header.layout(
      constraints.copyWith(minHeight: 0, maxHeight: double.infinity),
      parentUsesSize: true,
    );
    footer.layout(
      constraints.copyWith(minHeight: 0, maxHeight: double.infinity),
      parentUsesSize: true,
    );

    BoxConstraints contentConstraints;
    Offset contentOffset;

    double footerSize = footer.size.height;
    double headerSize = header.size.height;

    switch ((_floatingHeader, _floatingFooter)) {
      case (true, true): // floating header and footer
        contentConstraints = constraints;
        contentOffset = Offset.zero;
        break;
      case (true, false): // floating header
        contentConstraints = constraints.deflate(
          EdgeInsets.only(bottom: footerSize),
        );
        contentOffset = Offset.zero;
        break;
      case (false, true): // floating footer
        contentConstraints = constraints.deflate(
          EdgeInsets.only(top: headerSize),
        );
        contentOffset = Offset(0, headerSize);
        break;
      case (false, false):
        contentConstraints = constraints.deflate(
          EdgeInsets.only(top: headerSize, bottom: footerSize),
        );
        contentOffset = Offset(0, headerSize);
        break;
    }
    content.layout(
      ScaffoldBoxConstraints.fromBoxConstraints(
        constraints: contentConstraints,
        headerHeight: headerSize,
        footerHeight: footerSize,
      ),
    );
    size = constraints.biggest;
    (content.parentData as BoxParentData).offset = contentOffset;
    (footer.parentData as BoxParentData).offset = Offset(
      0,
      constraints.biggest.height - footerSize,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _headerSize.value = headerSize;
      _footerSize.value = footerSize;
    });
  }
}

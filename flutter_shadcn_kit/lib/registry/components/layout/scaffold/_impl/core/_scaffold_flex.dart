part of '../../scaffold.dart';

class _ScaffoldFlex extends MultiChildRenderObjectWidget {
  final bool floatingHeader;
  final bool floatingFooter;
  const _ScaffoldFlex({
    super.children,
    required this.floatingHeader,
    required this.floatingFooter,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _ScaffoldRenderFlex(
      floatingHeader: floatingHeader,
      floatingFooter: floatingFooter,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    _ScaffoldRenderFlex renderObject,
  ) {
    bool needsLayout = false;
    if (renderObject._floatingHeader != floatingHeader) {
      renderObject._floatingHeader = floatingHeader;
      needsLayout = true;
    }
    if (renderObject._floatingFooter != floatingFooter) {
      renderObject._floatingFooter = floatingFooter;
      needsLayout = true;
    }
    if (needsLayout) {
      renderObject.markNeedsLayout();
    }
  }
}

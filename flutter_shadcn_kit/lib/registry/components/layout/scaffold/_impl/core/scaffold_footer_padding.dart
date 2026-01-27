part of '../../scaffold.dart';

class ScaffoldFooterPadding extends SingleChildRenderObjectWidget {
  /// Creates [ScaffoldFooterPadding].
  const ScaffoldFooterPadding({super.key, super.child});

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderScaffoldPadding(paddingType: _ScaffoldPaddingType.footer);
  }
}

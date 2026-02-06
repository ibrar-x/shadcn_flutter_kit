part of '../../scaffold.dart';

class ScaffoldHeaderPadding extends SingleChildRenderObjectWidget {
  /// Creates [ScaffoldHeaderPadding].
  const ScaffoldHeaderPadding({super.key, super.child});

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderScaffoldPadding(paddingType: _ScaffoldPaddingType.header);
  }
}

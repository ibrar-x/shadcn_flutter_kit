part of '../../scaffold.dart';

/// ScaffoldHeaderPadding defines a reusable type for this registry module.
class ScaffoldHeaderPadding extends SingleChildRenderObjectWidget {
  /// Creates [ScaffoldHeaderPadding].
  const ScaffoldHeaderPadding({super.key, super.child});

  @override
/// Executes `createRenderObject` behavior for this component/composite.
  RenderObject createRenderObject(BuildContext context) {
    return _RenderScaffoldPadding(paddingType: _ScaffoldPaddingType.header);
  }
}

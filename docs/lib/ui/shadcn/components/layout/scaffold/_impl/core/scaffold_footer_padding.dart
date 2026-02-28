part of '../../scaffold.dart';

/// ScaffoldFooterPadding defines a reusable type for this registry module.
class ScaffoldFooterPadding extends SingleChildRenderObjectWidget {
  /// Creates [ScaffoldFooterPadding].
  const ScaffoldFooterPadding({super.key, super.child});

  @override
/// Executes `createRenderObject` behavior for this component/composite.
  RenderObject createRenderObject(BuildContext context) {
    return _RenderScaffoldPadding(paddingType: _ScaffoldPaddingType.footer);
  }
}

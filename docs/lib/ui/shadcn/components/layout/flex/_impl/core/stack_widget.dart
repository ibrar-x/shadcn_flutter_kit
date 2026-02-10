part of '../../flex.dart';

/// Patched [widgets.Stack] that supports child paint order.
class Stack extends widgets.Stack {
  const Stack({
    super.key,
    super.alignment,
    super.textDirection,
    super.fit,
    super.clipBehavior,
    super.children,
  });

  @override
  RenderStack createRenderObject(widgets.BuildContext context) {
    assert(_debugCheckHasDirectionality(context));
    return RenderStack(
      alignment: alignment,
      textDirection: textDirection ?? widgets.Directionality.maybeOf(context),
      fit: fit,
      clipBehavior: clipBehavior,
    );
  }

  @override
  void updateRenderObject(
    widgets.BuildContext context,
    covariant RenderStack renderObject,
  ) {
    assert(_debugCheckHasDirectionality(context));
    renderObject
      ..alignment = alignment
      ..textDirection = textDirection ?? widgets.Directionality.maybeOf(context)
      ..fit = fit
      ..clipBehavior = clipBehavior;
  }

  bool _debugCheckHasDirectionality(widgets.BuildContext context) {
    if (alignment is! widgets.AlignmentDirectional) {
      return true;
    }
    assert(
      textDirection != null || widgets.Directionality.maybeOf(context) != null,
      'Stack alignment requires a TextDirection',
    );
    return true;
  }
}

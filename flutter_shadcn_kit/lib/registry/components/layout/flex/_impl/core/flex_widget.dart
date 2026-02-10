part of '../../flex.dart';

/// Patched [widgets.Flex] that supports paint order.
class Flex extends widgets.Flex {
  const Flex({
    super.key,
    required super.direction,
    super.mainAxisAlignment,
    super.mainAxisSize,
    super.crossAxisAlignment,
    super.textDirection,
    super.verticalDirection,
    super.textBaseline,
    super.clipBehavior,
    super.spacing,
    super.children,
  });

  @override
  RenderFlex createRenderObject(widgets.BuildContext context) {
    return RenderFlex(
      direction: direction,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: getEffectiveTextDirection(context),
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      clipBehavior: clipBehavior,
      spacing: spacing,
    );
  }

  @override
  void updateRenderObject(
    widgets.BuildContext context,
    covariant RenderFlex renderObject,
  ) {
    renderObject
      ..direction = direction
      ..mainAxisAlignment = mainAxisAlignment
      ..mainAxisSize = mainAxisSize
      ..crossAxisAlignment = crossAxisAlignment
      ..textDirection = getEffectiveTextDirection(context)
      ..verticalDirection = verticalDirection
      ..textBaseline = textBaseline
      ..clipBehavior = clipBehavior
      ..spacing = spacing;
  }
}

/// Patched [widgets.Row] that supports paint order.
class Row extends Flex {
  const Row({
    super.key,
    super.mainAxisAlignment,
    super.mainAxisSize,
    super.crossAxisAlignment,
    super.textDirection,
    super.verticalDirection,
    super.textBaseline,
    super.spacing,
    super.clipBehavior,
    super.children,
  }) : super(direction: widgets.Axis.horizontal);
}

/// Patched [widgets.Column] that supports paint order.
class Column extends Flex {
  const Column({
    super.key,
    super.mainAxisAlignment,
    super.mainAxisSize,
    super.crossAxisAlignment,
    super.textDirection,
    super.verticalDirection,
    super.textBaseline,
    super.spacing,
    super.clipBehavior,
    super.children,
  }) : super(direction: widgets.Axis.vertical);
}

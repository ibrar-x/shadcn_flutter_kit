import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../theme/theme.dart';
import '../utils/constants.dart';
import '../utils/style_value.dart';
import 'animated_value_builder.dart';

/// Theme for [Hidden].
class HiddenTheme extends ComponentThemeData {
  final Axis? direction;
  final Duration? duration;
  final Curve? curve;
  final bool? reverse;
  final bool? keepCrossAxisSize;
  final bool? keepMainAxisSize;

  const HiddenTheme({
    this.direction,
    this.duration,
    this.curve,
    this.reverse,
    this.keepCrossAxisSize,
    this.keepMainAxisSize,
  });

  HiddenTheme copyWith({
    ValueGetter<Axis?>? direction,
    ValueGetter<Duration?>? duration,
    ValueGetter<Curve?>? curve,
    ValueGetter<bool?>? reverse,
    ValueGetter<bool?>? keepCrossAxisSize,
    ValueGetter<bool?>? keepMainAxisSize,
  }) {
    return HiddenTheme(
      direction: direction == null ? this.direction : direction(),
      duration: duration == null ? this.duration : duration(),
      curve: curve == null ? this.curve : curve(),
      reverse: reverse == null ? this.reverse : reverse(),
      keepCrossAxisSize: keepCrossAxisSize == null
          ? this.keepCrossAxisSize
          : keepCrossAxisSize(),
      keepMainAxisSize:
          keepMainAxisSize == null ? this.keepMainAxisSize : keepMainAxisSize(),
    );
  }
}

/// A widget that conditionally hides its child with optional animation.
class Hidden extends StatelessWidget {
  final bool hidden;
  final Widget child;
  final Axis? direction;
  final bool? reverse;
  final Duration? duration;
  final Curve? curve;
  final bool? keepCrossAxisSize;
  final bool? keepMainAxisSize;

  const Hidden({
    super.key,
    required this.hidden,
    required this.child,
    this.direction,
    this.duration,
    this.curve,
    this.reverse,
    this.keepCrossAxisSize,
    this.keepMainAxisSize,
  });

  @override
  Widget build(BuildContext context) {
    final textDirection = Directionality.of(context);
    final compTheme = ComponentTheme.maybeOf<HiddenTheme>(context);
    final directionValue = styleValue(
      widgetValue: direction,
      themeValue: compTheme?.direction,
      defaultValue: Axis.horizontal,
    );
    final durationValue = styleValue(
      widgetValue: duration,
      themeValue: compTheme?.duration,
      defaultValue: kDefaultDuration,
    );
    final curveValue = styleValue(
      widgetValue: curve,
      themeValue: compTheme?.curve,
      defaultValue: Curves.easeInOut,
    );
    final reverseValue = styleValue(
      widgetValue: reverse,
      themeValue: compTheme?.reverse,
      defaultValue: false,
    );
    final keepCrossAxisSizeValue = styleValue(
      widgetValue: keepCrossAxisSize,
      themeValue: compTheme?.keepCrossAxisSize,
      defaultValue: false,
    );
    final keepMainAxisSizeValue = styleValue(
      widgetValue: keepMainAxisSize,
      themeValue: compTheme?.keepMainAxisSize,
      defaultValue: false,
    );
    return AnimatedOpacity(
      opacity: hidden ? 0.0 : 1.0,
      duration: durationValue,
      curve: curveValue,
      child: AnimatedValueBuilder(
        value: hidden ? 0.0 : 1.0,
        duration: durationValue,
        curve: curveValue,
        child: child,
        builder: (context, value, child) {
          return _HiddenLayout(
            keepCrossAxisSize: keepCrossAxisSizeValue,
            keepMainAxisSize: keepMainAxisSizeValue,
            textDirection: textDirection,
            direction: directionValue,
            reverse: reverseValue,
            progress: value.clamp(0.0, 1.0),
            child: child,
          );
        },
      ),
    );
  }
}

class _HiddenLayout extends SingleChildRenderObjectWidget {
  final bool keepCrossAxisSize;
  final bool keepMainAxisSize;
  final TextDirection textDirection;
  final Axis direction;
  final bool reverse;
  final double progress;

  const _HiddenLayout({
    required this.keepCrossAxisSize,
    required this.keepMainAxisSize,
    required this.textDirection,
    required this.direction,
    required this.reverse,
    required this.progress,
    super.child,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _HiddenLayoutRender(
      keepCrossAxisSize: keepCrossAxisSize,
      keepMainAxisSize: keepMainAxisSize,
      textDirection: textDirection,
      direction: direction,
      reverse: reverse,
      progress: progress,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, _HiddenLayoutRender renderObject) {
    renderObject
      ..keepCrossAxisSize = keepCrossAxisSize
      ..keepMainAxisSize = keepMainAxisSize
      ..textDirection = textDirection
      ..direction = direction
      ..reverse = reverse
      ..progress = progress;
  }
}

class _HiddenLayoutRender extends RenderShiftedBox {
  bool keepCrossAxisSize;
  bool keepMainAxisSize;
  TextDirection textDirection;
  Axis direction;
  bool reverse;
  double progress;

  _HiddenLayoutRender({
    required this.keepCrossAxisSize,
    required this.keepMainAxisSize,
    required this.textDirection,
    required this.direction,
    required this.reverse,
    required this.progress,
    RenderBox? child,
  }) : super(child);

  @override
  void performLayout() {
    if (child == null) {
      size = constraints.smallest;
      return;
    }

    child!.layout(constraints, parentUsesSize: true);
    final childSize = child!.size;

    var mainAxisSize = direction == Axis.horizontal ? childSize.width : childSize.height;
    var crossAxisSize = direction == Axis.horizontal ? childSize.height : childSize.width;

    final mainAxisProgress = keepMainAxisSize ? 1.0 : progress;
    final crossAxisProgress = keepCrossAxisSize ? 1.0 : progress;

    final constrainedMainAxis = mainAxisSize * mainAxisProgress;
    final constrainedCrossAxis = crossAxisSize * crossAxisProgress;

    final width = direction == Axis.horizontal ? constrainedMainAxis : constrainedCrossAxis;
    final height = direction == Axis.horizontal ? constrainedCrossAxis : constrainedMainAxis;

    size = constraints.constrain(Size(width, height));

    final alignment = direction == Axis.horizontal
        ? (textDirection == TextDirection.ltr ? Alignment.centerLeft : Alignment.centerRight)
        : Alignment.topCenter;
    final offset = alignment.alongOffset(
      Offset(size.width - childSize.width, size.height - childSize.height),
    );
    final shift =
        reverse ? Offset(-offset.dx, -offset.dy) : Offset(offset.dx, offset.dy);
    (child!.parentData as BoxParentData).offset = shift;
  }
}

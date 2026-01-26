part of '../button.dart';

class ButtonGroup extends StatelessWidget {
  /// The layout direction for the button group.
  ///
  /// [Axis.horizontal] arranges buttons in a row, removing vertical borders
  /// between adjacent buttons. [Axis.vertical] arranges buttons in a column,
  /// removing horizontal borders between adjacent buttons.
  final Axis direction;

  /// The list of button widgets to group together.
  ///
  /// Each widget should typically be a [Button] or similar interactive widget.
  /// The group automatically applies border modifications to create the
  /// connected appearance.
  final List<Widget> children;

  /// Whether the button group should be shrink-wrapped or expanded.
  ///
  /// When true, the group will expand to fill available space in the
  /// cross axis. When false, the group will size itself based on its
  /// children's intrinsic size.
  final bool expands;

  /// Creates a [ButtonGroup] that arranges buttons with connected borders.
  ///
  /// Parameters:
  /// - [direction] (Axis, default: Axis.horizontal): Layout direction for the buttons.
  /// - [children] (`List<Widget>`, required): The buttons to group together.
  ///
  /// The group automatically handles:
  /// - Border radius adjustments for first/middle/last buttons
  /// - Proper sizing with [IntrinsicHeight] or [IntrinsicWidth]
  /// - Stretch alignment for consistent button heights/widths
  ///
  /// Example:
  /// ```dart
  /// ButtonGroup(
  ///   direction: Axis.vertical,
  ///   children: [
  ///     Button.outline(child: Text('Option 1')),
  ///     Button.outline(child: Text('Option 2')),
  ///     Button.outline(child: Text('Option 3')),
  ///   ],
  /// );
  /// ```
  const ButtonGroup({
    super.key,
    this.direction = Axis.horizontal,
    this.expands = false,
    required this.children,
  });

  /// Creates a horizontal button group.
  ///
  /// A convenience constructor equivalent to `ButtonGroup(direction: Axis.horizontal)`.
  /// Arranges buttons in a row with connected borders.
  const ButtonGroup.horizontal({
    super.key,
    this.expands = false,
    required this.children,
  }) : direction = Axis.horizontal;

  /// Creates a vertical button group.
  ///
  /// A convenience constructor equivalent to `ButtonGroup(direction: Axis.vertical)`.
  /// Arranges buttons in a column with connected borders.
  const ButtonGroup.vertical({
    super.key,
    this.expands = false,
    required this.children,
  }) : direction = Axis.vertical;

  @override
  Widget build(BuildContext context) {
    final parentGroupData = Data.maybeOf<ButtonGroupData>(context);
    List<Widget> children = List.from(this.children);
    if (children.length > 1) {
      for (int i = 0; i < children.length; i++) {
        var groupData = direction == Axis.horizontal
            ? ButtonGroupData.horizontalIndex(i, children.length)
            : ButtonGroupData.verticalIndex(i, children.length);
        if (parentGroupData != null) {
          groupData = parentGroupData.applyToButtonGroupData(groupData);
        }
        children[i] = Data.inherit(
          data: groupData,
          child: ButtonStyleOverride(
            decoration: (context, states, value) {
              if (value is BoxDecoration) {
                final borderRadius = groupData.applyToBorderRadius(
                    value.borderRadius ?? BorderRadius.zero,
                    Directionality.of(context));
                return value.copyWith(borderRadius: borderRadius);
              }
              return value;
            },
            child: children[i],
          ),
        );
      }
    }
    Widget flex = Flex(
      clipBehavior: Clip.none,
      mainAxisSize: MainAxisSize.min,
      direction: direction,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    );
    if (!expands) {
      if (direction == Axis.horizontal) {
        flex = IntrinsicHeight(child: flex);
      } else {
        flex = IntrinsicWidth(child: flex);
      }
    }
    return flex;
  }
}

/// Data class defining border radius multipliers for grouped buttons.
///
/// [ButtonGroupData] specifies which corners of a button should have reduced
/// border radius when part of a [ButtonGroup]. Values of 0.0 remove the radius
/// entirely (for internal buttons), while 1.0 preserves the full radius (for
/// end buttons).
///
/// This class uses directional values (start/end) to support RTL layouts properly.
/// The static constants provide common configurations for different positions
/// within a button group.
///
/// Example:
/// ```dart
/// // First button in horizontal group - preserve left radius, remove right
/// ButtonGroupData.horizontal(end: 0.0)
///
/// // Middle button - remove all radius
/// ButtonGroupData.zero
///
/// // Last button in horizontal group - remove left radius, preserve right
/// ButtonGroupData.horizontal(start: 0.0)
/// ```
class ButtonGroupData {
  /// No modification - full border radius on all corners.
  static const ButtonGroupData none = ButtonGroupData.all(1.0);

  /// Zero radius - removes border radius from all corners.
  static const ButtonGroupData zero = ButtonGroupData.all(0.0);

  /// Horizontal start position - full start radius, no end radius.
  static const ButtonGroupData horizontalStart =
      ButtonGroupData.horizontal(end: 0.0);

  /// Horizontal end position - no start radius, full end radius.
  static const ButtonGroupData horizontalEnd =
      ButtonGroupData.horizontal(start: 0.0);

  /// Vertical top position - full top radius, no bottom radius.
  static const ButtonGroupData verticalTop =
      ButtonGroupData.vertical(bottom: 0.0);

  /// Vertical bottom position - no top radius, full bottom radius.
  static const ButtonGroupData verticalBottom =
      ButtonGroupData.vertical(top: 0.0);

  /// Border radius multiplier for top-start corner (0.0 to 1.0).
  final double topStartValue;

  /// Border radius multiplier for top-end corner (0.0 to 1.0).
  final double topEndValue;

  /// Border radius multiplier for bottom-start corner (0.0 to 1.0).
  final double bottomStartValue;

  /// Border radius multiplier for bottom-end corner (0.0 to 1.0).
  final double bottomEndValue;

  /// Creates button group data with individual corner multipliers.
  const ButtonGroupData({
    required this.topStartValue,
    required this.topEndValue,
    required this.bottomStartValue,
    required this.bottomEndValue,
  });

  /// Creates horizontal group data with start and end multipliers.
  ///
  /// Both top and bottom on each side use the same value.
  const ButtonGroupData.horizontal({
    double start = 1.0,
    double end = 1.0,
  })  : topStartValue = start,
        topEndValue = end,
        bottomStartValue = start,
        bottomEndValue = end;

  /// Creates vertical group data with top and bottom multipliers.
  ///
  /// Both start and end on each side use the same value.
  const ButtonGroupData.vertical({
    double top = 1.0,
    double bottom = 1.0,
  })  : topStartValue = top,
        topEndValue = top,
        bottomStartValue = bottom,
        bottomEndValue = bottom;

  /// Creates group data with the same multiplier for all corners.
  const ButtonGroupData.all(double value)
      : topStartValue = value,
        topEndValue = value,
        bottomStartValue = value,
        bottomEndValue = value;

  /// Creates group data for a button at [index] in a horizontal group of [length] buttons.
  ///
  /// Returns:
  /// - [horizontalStart] for the first button (index 0)
  /// - [zero] for middle buttons
  /// - [horizontalEnd] for the last button
  /// - [none] if group has only one button
  factory ButtonGroupData.horizontalIndex(int index, int length) {
    if (length <= 1) {
      return none;
    } else {
      if (index == 0) {
        return horizontalStart;
      } else if (index == length - 1) {
        return horizontalEnd;
      } else {
        return zero;
      }
    }
  }

  /// Creates group data for a button at [index] in a vertical group of [length] buttons.
  ///
  /// Returns:
  /// - [verticalTop] for the first button (index 0)
  /// - [zero] for middle buttons
  /// - [verticalBottom] for the last button
  /// - [none] if group has only one button
  factory ButtonGroupData.verticalIndex(int index, int length) {
    if (length <= 1) {
      return none;
    } else {
      if (index == 0) {
        return verticalTop;
      } else if (index == length - 1) {
        return verticalBottom;
      } else {
        return zero;
      }
    }
  }

  /// Applies corner multipliers to a border radius.
  ///
  /// Multiplies each corner's radius by the corresponding corner value,
  /// properly handling text direction for start/end mapping to left/right.
  ///
  /// Parameters:
  /// - [borderRadius]: The base border radius to modify
  /// - [textDirection]: Text direction for resolving start/end to left/right
  ///
  /// Returns a new [BorderRadiusGeometry] with modified corner radii.
  BorderRadiusGeometry applyToBorderRadius(
      BorderRadiusGeometry borderRadius, TextDirection textDirection) {
    final topLeftValue =
        textDirection == TextDirection.ltr ? topStartValue : topEndValue;
    final topRightValue =
        textDirection == TextDirection.ltr ? topEndValue : topStartValue;
    final bottomLeftValue =
        textDirection == TextDirection.ltr ? bottomStartValue : bottomEndValue;
    final bottomRightValue =
        textDirection == TextDirection.ltr ? bottomEndValue : bottomStartValue;
    final resolvedBorderRadius = borderRadius.resolve(textDirection);
    return BorderRadius.only(
      topLeft: Radius.elliptical(
        resolvedBorderRadius.topLeft.x * topLeftValue,
        resolvedBorderRadius.topLeft.y * topLeftValue,
      ),
      topRight: Radius.elliptical(
        resolvedBorderRadius.topRight.x * topRightValue,
        resolvedBorderRadius.topRight.y * topRightValue,
      ),
      bottomLeft: Radius.elliptical(
        resolvedBorderRadius.bottomLeft.x * bottomLeftValue,
        resolvedBorderRadius.bottomLeft.y * bottomLeftValue,
      ),
      bottomRight: Radius.elliptical(
        resolvedBorderRadius.bottomRight.x * bottomRightValue,
        resolvedBorderRadius.bottomRight.y * bottomRightValue,
      ),
    );
  }

  /// Combines this group data with another by multiplying corresponding corner values.
  ///
  /// Useful for nesting button groups or applying multiple grouping effects.
  /// Each corner value is multiplied: result = this.value * other.value.
  ///
  /// Example:
  /// ```dart
  /// final half = ButtonGroupData.all(0.5);
  /// final end = ButtonGroupData.horizontal(start: 0.0);
  /// final combined = half.applyToButtonGroupData(end);
  /// // combined has: topStart=0, bottomStart=0, topEnd=0.5, bottomEnd=0.5
  /// ```
  ButtonGroupData applyToButtonGroupData(ButtonGroupData other) {
    return ButtonGroupData(
      topStartValue: topStartValue * other.topStartValue,
      topEndValue: topEndValue * other.topEndValue,
      bottomStartValue: bottomStartValue * other.bottomStartValue,
      bottomEndValue: bottomEndValue * other.bottomEndValue,
    );
  }

  @override
  String toString() {
    return 'ButtonGroupData(topStartValue: $topStartValue, topEndValue: $topEndValue, bottomStartValue: $bottomStartValue, bottomEndValue: $bottomEndValue)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is ButtonGroupData &&
        other.topStartValue == topStartValue &&
        other.topEndValue == topEndValue &&
        other.bottomStartValue == bottomStartValue &&
        other.bottomEndValue == bottomEndValue;
  }

  @override
  int get hashCode {
    return Object.hash(
      topStartValue,
      topEndValue,
      bottomStartValue,
      bottomEndValue,
    );
  }
}

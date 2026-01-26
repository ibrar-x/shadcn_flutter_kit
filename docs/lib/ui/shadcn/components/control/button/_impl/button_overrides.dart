part of '../button.dart';

class ButtonStyleOverride extends StatelessWidget {
  /// Whether to inherit and chain with parent overrides.
  ///
  /// When `true`, this override's delegates receive the parent override's result
  /// as their default value, allowing nested style modifications. When `false`,
  /// parent overrides are ignored.
  final bool inherit;

  /// Optional decoration override delegate.
  final ButtonStatePropertyDelegate<Decoration>? decoration;

  /// Optional mouse cursor override delegate.
  final ButtonStatePropertyDelegate<MouseCursor>? mouseCursor;

  /// Optional padding override delegate.
  final ButtonStatePropertyDelegate<EdgeInsetsGeometry>? padding;

  /// Optional text style override delegate.
  final ButtonStatePropertyDelegate<TextStyle>? textStyle;

  /// Optional icon theme override delegate.
  final ButtonStatePropertyDelegate<IconThemeData>? iconTheme;

  /// Optional margin override delegate.
  final ButtonStatePropertyDelegate<EdgeInsetsGeometry>? margin;

  /// The widget subtree where overrides apply.
  final Widget child;

  /// Creates a button style override in replace mode.
  ///
  /// Overrides apply to all descendant buttons, ignoring parent overrides.
  const ButtonStyleOverride({
    super.key,
    this.decoration,
    this.mouseCursor,
    this.padding,
    this.textStyle,
    this.iconTheme,
    this.margin,
    required this.child,
  }) : inherit = false;

  /// Creates a button style override in inherit mode.
  ///
  /// Overrides chain with parent overrides, allowing nested customization where
  /// each level can modify the result of the previous level.
  const ButtonStyleOverride.inherit({
    super.key,
    this.decoration,
    this.mouseCursor,
    this.padding,
    this.textStyle,
    this.iconTheme,
    this.margin,
    required this.child,
  }) : inherit = true;

  @override
  Widget build(BuildContext context) {
    var decoration = this.decoration;
    var mouseCursor = this.mouseCursor;
    var padding = this.padding;
    var textStyle = this.textStyle;
    var iconTheme = this.iconTheme;
    var margin = this.margin;
    if (inherit) {
      var data = Data.maybeOf<ButtonStyleOverrideData>(context);
      if (data != null) {
        decoration = (context, state, value) {
          return data.decoration?.call(context, state,
                  decoration?.call(context, state, value) ?? value) ??
              decoration?.call(context, state, value) ??
              value;
        };
        mouseCursor = (context, state, value) {
          return data.mouseCursor?.call(context, state,
                  mouseCursor?.call(context, state, value) ?? value) ??
              mouseCursor?.call(context, state, value) ??
              value;
        };
        padding = (context, state, value) {
          return data.padding?.call(context, state,
                  padding?.call(context, state, value) ?? value) ??
              padding?.call(context, state, value) ??
              value;
        };
        textStyle = (context, state, value) {
          return data.textStyle?.call(context, state,
                  textStyle?.call(context, state, value) ?? value) ??
              textStyle?.call(context, state, value) ??
              value;
        };
        iconTheme = (context, state, value) {
          return data.iconTheme?.call(context, state,
                  iconTheme?.call(context, state, value) ?? value) ??
              iconTheme?.call(context, state, value) ??
              value;
        };
        margin = (context, state, value) {
          return data.margin?.call(context, state,
                  margin?.call(context, state, value) ?? value) ??
              margin?.call(context, state, value) ??
              value;
        };
      }
    }
    return Data.inherit(
      data: ButtonStyleOverrideData(
        decoration: decoration,
        mouseCursor: mouseCursor,
        padding: padding,
        textStyle: textStyle,
        iconTheme: iconTheme,
        margin: margin,
      ),
      child: child,
    );
  }
}

/// Data class holding button style override delegates.
///
/// [ButtonStyleOverrideData] is used internally by [ButtonStyleOverride] to pass
/// style override delegates through the widget tree via the [Data] inherited widget
/// system. It stores optional delegates for each button style property.
///
/// This class is typically not used directly by application code; instead, use
/// [ButtonStyleOverride] widget to apply style overrides.
class ButtonStyleOverrideData {
  /// Optional decoration override delegate.
  final ButtonStatePropertyDelegate<Decoration>? decoration;

  /// Optional mouse cursor override delegate.
  final ButtonStatePropertyDelegate<MouseCursor>? mouseCursor;

  /// Optional padding override delegate.
  final ButtonStatePropertyDelegate<EdgeInsetsGeometry>? padding;

  /// Optional text style override delegate.
  final ButtonStatePropertyDelegate<TextStyle>? textStyle;

  /// Optional icon theme override delegate.
  final ButtonStatePropertyDelegate<IconThemeData>? iconTheme;

  /// Optional margin override delegate.
  final ButtonStatePropertyDelegate<EdgeInsetsGeometry>? margin;

  /// Creates button style override data with the specified delegates.
  const ButtonStyleOverrideData({
    this.decoration,
    this.mouseCursor,
    this.padding,
    this.textStyle,
    this.iconTheme,
    this.margin,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is ButtonStyleOverrideData &&
        other.decoration == decoration &&
        other.mouseCursor == mouseCursor &&
        other.padding == padding &&
        other.textStyle == textStyle &&
        other.iconTheme == iconTheme &&
        other.margin == margin;
  }

  @override
  int get hashCode {
    return Object.hash(
      decoration,
      mouseCursor,
      padding,
      textStyle,
      iconTheme,
      margin,
    );
  }

  @override
  String toString() {
    return 'ButtonStyleOverrideData(decoration: $decoration, mouseCursor: $mouseCursor, padding: $padding, textStyle: $textStyle, iconTheme: $iconTheme, margin: $margin)';
  }
}

/// A widget that groups multiple buttons together with connected borders.
///
/// [ButtonGroup] visually connects a series of related buttons by removing
/// the borders between adjacent buttons and maintaining consistent styling.
/// This creates a segmented appearance where the buttons appear as a single
/// cohesive unit.
///
/// The group can be oriented horizontally or vertically, and automatically
/// handles border radius adjustments so that only the first and last buttons
/// in the group have rounded corners on their outer edges.
///
/// Commonly used for:
/// - Toggle button groups (like text formatting options)
/// - Related action sets (like alignment controls)
/// - Pagination controls
/// - View switchers
///
/// Example:
/// ```dart
/// ButtonGroup(
///   direction: Axis.horizontal,
///   children: [
///     Button.secondary(
///       onPressed: () => align('left'),
///       child: Icon(Icons.format_align_left),
///     ),
///     Button.secondary(
///       onPressed: () => align('center'),
///       child: Icon(Icons.format_align_center),
///     ),
///     Button.secondary(
///       onPressed: () => align('right'),
///       child: Icon(Icons.format_align_right),
///     ),
///   ],
/// );
/// ```

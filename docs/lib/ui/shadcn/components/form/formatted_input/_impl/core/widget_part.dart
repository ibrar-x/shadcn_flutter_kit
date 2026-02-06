part of '../../formatted_input.dart';

/// A part that displays a custom widget.
class WidgetPart extends InputPart {
  /// The widget to display.
  final Widget widget;

  /// Creates a [WidgetPart] with the specified widget.
  const WidgetPart(this.widget);

  @override
  Widget build(BuildContext context, FormattedInputData data) {
    return widget;
  }

  @override
  Object? get partKey => widget.key;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WidgetPart && other.widget == widget;
  }

  @override
  int get hashCode => widget.hashCode;
}

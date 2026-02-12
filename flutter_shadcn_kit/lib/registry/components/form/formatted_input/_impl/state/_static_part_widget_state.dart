part of '../../formatted_input.dart';

/// _StaticPartWidgetState stores and manages mutable widget state.
class _StaticPartWidgetState extends State<_StaticPartWidget> {
  /// Builds the widget tree for this component state.
  @override
  Widget build(BuildContext context) {
    return Center(child: Text(widget.text).muted().base());
  }
}

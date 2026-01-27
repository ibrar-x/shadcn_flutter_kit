part of '../../formatted_input.dart';

class _StaticPartWidgetState extends State<_StaticPartWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(widget.text).muted().base(),
    );
  }
}

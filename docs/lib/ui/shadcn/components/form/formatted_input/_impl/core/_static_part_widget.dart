part of '../../formatted_input.dart';

/// _StaticPartWidget renders form UI and wires input behavior.
class _StaticPartWidget extends StatefulWidget {
  /// Field storing `text` for this form implementation.
  final String text;
  const _StaticPartWidget({required this.text});

  /// Creates the `State` object for this widget.
  @override
  State<_StaticPartWidget> createState() => _StaticPartWidgetState();
}

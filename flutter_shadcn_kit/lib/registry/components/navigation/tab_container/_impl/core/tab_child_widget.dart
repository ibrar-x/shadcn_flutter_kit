part of '../../tab_container.dart';

class TabChildWidget extends StatelessWidget with TabChild {
  /// The child widget to display.
  final Widget child;

  @override
  /// Whether this tab uses indexed positioning.
  ///
  /// Defaults to `false` unless specified in the constructor.
  final bool indexed;

  /// Creates a tab child widget.
  ///
  /// Parameters:
  /// - [child]: The widget to wrap (required)
  /// - [indexed]: Whether to use indexed positioning (defaults to `false`)
  const TabChildWidget({
    super.key,
    required this.child,
    this.indexed = false,
  });

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

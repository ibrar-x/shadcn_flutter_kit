part of '../../window.dart';

/// WindowNavigator defines a reusable type for this registry module.
class WindowNavigator extends StatefulWidget {
  /// Initial list of windows to display.
  final List<Window> initialWindows;

  /// Optional background child widget.
  final Widget? child;

  /// Whether to show the top snap bar for window snapping.
  final bool showTopSnapBar;

  /// Creates a [WindowNavigator].
  ///
  /// Parameters:
  /// - [initialWindows] (`List<Window>`, required): Windows to display initially.
  /// - [child] (`Widget?`, optional): Background widget.
  /// - [showTopSnapBar] (`bool`, default: `true`): Show snap bar.
  const WindowNavigator({
    super.key,
    required this.initialWindows,
    this.child,
    this.showTopSnapBar = true,
  });

  @override
/// Executes `createState` behavior for this component/composite.
  State<WindowNavigator> createState() => _WindowNavigatorState();
}

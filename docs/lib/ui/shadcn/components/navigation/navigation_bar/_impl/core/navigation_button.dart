part of '../../navigation_bar.dart';

class NavigationButton extends AbstractNavigationButton {
  /// Callback when button is pressed.
  final VoidCallback? onPressed;

  /// Creates a navigation button.
  ///
  /// Parameters:
  /// - [child] (Widget, required): Icon or content widget
  /// - [onPressed] (VoidCallback?): Press callback
  /// - [label] (Widget?): Optional label text
  /// - [spacing] (double?): Space between icon and label
  /// - [style] (AbstractButtonStyle?): Button style
  /// - [alignment] (AlignmentGeometry?): Content alignment
  /// - [enabled] (bool?): Whether enabled for interaction
  /// - [overflow] (TextOverflow?): Label overflow behavior
  /// - [marginAlignment] (AlignmentGeometry?): Margin alignment
  const NavigationButton({
    super.key,
    this.onPressed,
    super.label,
    super.spacing,
    super.style,
    super.alignment,
    super.enabled,
    super.overflow,
    super.marginAlignment,
    required super.child,
  });

  @override
  bool get selectable {
    return false;
  }

  @override
  State<AbstractNavigationButton> createState() => _NavigationButtonState();
}

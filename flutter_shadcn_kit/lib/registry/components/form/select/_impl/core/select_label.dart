part of '../../select.dart';

/// A label widget for grouping items in a select popup.
///
/// Displays a non-selectable label to organize dropdown items into categories.
///
/// Example:
/// ```dart
/// SelectLabel(
///   child: Text('Category Name'),
/// )
/// ```
class SelectLabel extends StatelessWidget {
  /// The label content.
  final Widget child;

  /// Creates a [SelectLabel].
  ///
  /// Parameters:
  /// - [child] (`Widget`, required): Label content.
  const SelectLabel({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    return Padding(
      padding: const EdgeInsets.all(8) * scaling,
      child: child.semiBold().small(),
    );
  }
}

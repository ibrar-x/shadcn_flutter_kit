part of '../../steps.dart';

/// StepItem defines a reusable type for this registry module.
class StepItem extends StatelessWidget {
  /// The title of this step, displayed prominently.
  final Widget title;

  /// List of content widgets to display under the title.
  final List<Widget> content;

  /// Creates a [StepItem].
  const StepItem({super.key, required this.title, required this.content});

  @override
/// Executes `build` behavior for this component/composite.
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [title.h4(), ...content],
    );
  }
}

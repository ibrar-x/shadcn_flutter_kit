part of '../../steps.dart';

class StepItem extends StatelessWidget {
  /// The title of this step, displayed prominently.
  final Widget title;

  /// List of content widgets to display under the title.
  final List<Widget> content;

  /// Creates a [StepItem].
  const StepItem({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        title.h4(),
        ...content,
      ],
    );
  }
}

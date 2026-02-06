part of '../../stepper.dart';

class _StepContainerState extends State<StepContainer> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    if (widget.actions.isEmpty) {
      return widget.child.withPadding(
        vertical: 16 * scaling,
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        widget.child,
        Gap(16 * scaling),
        Row(
          children: widget.actions,
        ).gap(8 * scaling),
      ],
    ).withPadding(
      vertical: 16 * scaling,
    );
  }
}

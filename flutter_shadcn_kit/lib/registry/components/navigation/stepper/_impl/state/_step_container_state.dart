part of '../../stepper.dart';

/// _StepContainerState defines a reusable type for this registry module.
class _StepContainerState extends State<StepContainer> {
  @override
/// Executes `build` behavior for this component/composite.
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
/// Stores `scaling` state/configuration for this implementation.
    final scaling = theme.scaling;
    if (widget.actions.isEmpty) {
      return widget.child.withPadding(vertical: 16 * scaling);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        widget.child,
/// Creates a `DensityGap` instance.
        DensityGap(gapLg),
/// Creates a `Row` instance.
        Row(children: widget.actions).gap(8 * scaling),
      ],
    ).withPadding(vertical: 16 * scaling);
  }
}

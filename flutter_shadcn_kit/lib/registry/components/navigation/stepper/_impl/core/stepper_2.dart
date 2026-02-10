part of '../../stepper.dart';

class Stepper extends StatelessWidget {
  /// Controller for managing stepper state and navigation.
  final StepperController controller;

  /// List of steps to display in the stepper.
  final List<Step> steps;

  /// Layout direction (horizontal or vertical).
  final Axis? direction;

  /// Size variant for step indicators.
  final StepSize? size;

  /// Visual variant for step presentation.
  final StepVariant? variant;

  /// Creates a [Stepper].
  ///
  /// The [controller] and [steps] are required. Other parameters are optional
  /// and will use theme defaults or built-in defaults if not provided.
  ///
  /// Parameters:
  /// - [controller] (StepperController, required): manages state and navigation
  /// - [steps] (`List<Step>`, required): list of steps to display
  /// - [direction] (Axis?): horizontal or vertical layout (default: horizontal)
  /// - [size] (StepSize?): step indicator size (default: medium)
  /// - [variant] (StepVariant?): visual style (default: circle)
  ///
  /// Example:
  /// ```dart
  /// final controller = StepperController(currentStep: 0);
  ///
  /// Stepper(
  ///   controller: controller,
  ///   direction: Axis.vertical,
  ///   size: StepSize.large,
  ///   variant: StepVariant.line,
  ///   steps: [
  ///     Step(title: Text('Step 1')),
  ///     Step(title: Text('Step 2')),
  ///     Step(title: Text('Step 3')),
  ///   ],
  /// );
  /// ```
  const Stepper({
    super.key,
    required this.controller,
    required this.steps,
    this.direction,
    this.size,
    this.variant,
  });

  @override
  Widget build(BuildContext context) {
    final compTheme = ComponentTheme.maybeOf<StepperTheme>(context);
    final dir = direction ?? compTheme?.direction ?? Axis.horizontal;
    final sz = size ?? compTheme?.size ?? StepSize.medium;
    final varnt = variant ?? compTheme?.variant ?? StepVariant.circle;
    var stepProperties = StepProperties(
      size: sz,
      steps: steps,
      state: controller,
      direction: dir,
    );
    return Data.inherit(
      data: stepProperties,
      child: varnt.build(context, stepProperties),
    );
  }
}

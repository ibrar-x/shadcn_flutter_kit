part of '../../stepper.dart';

class StepNumber extends StatelessWidget {
  /// Custom icon to display instead of step number.
  final Widget? icon;

  /// Callback invoked when the step indicator is pressed.
  final VoidCallback? onPressed;

  /// Creates a [StepNumber].
  ///
  /// Both parameters are optional. If [icon] is provided, it replaces
  /// the default step number. If [onPressed] is provided, the step
  /// becomes clickable.
  ///
  /// Parameters:
  /// - [icon] (Widget?): custom icon replacing step number
  /// - [onPressed] (VoidCallback?): tap callback for interaction
  ///
  /// Example:
  /// ```dart
  /// StepNumber(
  ///   icon: Icon(Icons.person),
  ///   onPressed: () => jumpToStep(stepIndex),
  /// );
  /// ```
  const StepNumber({
    super.key,
    this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final properties = Data.maybeOf<StepProperties>(context);
    final stepNumberData = Data.maybeOf<StepNumberData>(context);
    assert(properties != null, 'StepNumber must be a descendant of Stepper');
    assert(stepNumberData != null,
        'StepNumber must be a descendant of StepNumberData');
    final int stepIndex = stepNumberData!.stepIndex;
    final theme = Theme.of(context);
    return AnimatedBuilder(
        animation: properties!.state,
        builder: (context, child) {
          return properties.size.wrapper(
            context,
            DefaultTextStyle.merge(
              style: TextStyle(
                color: properties.state.value.stepStates[stepIndex] ==
                        StepState.failed
                    ? theme.colorScheme.destructive
                    : theme.colorScheme.primary,
              ).merge(theme.typography.medium),
              child: IconTheme.merge(
                data: IconThemeData(
                  color: properties.state.value.stepStates[stepIndex] ==
                          StepState.failed
                      ? theme.colorScheme.destructive
                      : properties.state.value.currentStep > stepIndex
                          ? theme.colorScheme.background
                          : theme.colorScheme.primary,
                ),
                child: SizedBox(
                  // these sizes are not constant, but the source value is from constant enum value
                  width: properties.size.size * theme.scaling,
                  height: properties.size.size * theme.scaling,
                  child: Clickable(
                    enabled: onPressed != null,
                    onPressed: onPressed,
                    mouseCursor: WidgetStatePropertyAll(
                      onPressed != null
                          ? SystemMouseCursors.click
                          : SystemMouseCursors.basic,
                    ),
                    decoration: WidgetStateProperty.resolveWith(
                      (states) {
                        return BoxDecoration(
                          shape: theme.radius == 0
                              ? BoxShape.rectangle
                              : BoxShape.circle,
                          color: properties.state.value.stepStates[stepIndex] ==
                                  StepState.failed
                              ? theme.colorScheme.destructive
                              : properties.state.value.currentStep > stepIndex
                                  ? theme.colorScheme.primary
                                  : properties.state.value.currentStep ==
                                              stepIndex ||
                                          states
                                              .contains(WidgetState.hovered) ||
                                          states.contains(WidgetState.focused)
                                      ? theme.colorScheme.secondary
                                      : theme.colorScheme.background,
                          border: Border.all(
                            color:
                                properties.state.value.stepStates[stepIndex] ==
                                        StepState.failed
                                    ? theme.colorScheme.destructive
                                    : properties.state.value.currentStep >=
                                            stepIndex
                                        ? theme.colorScheme.primary
                                        : theme.colorScheme.border,
                            width: 2 * theme.scaling,
                          ),
                        );
                      },
                    ),
                    child: Center(
                      child: properties.state.value.stepStates[stepIndex] ==
                              StepState.failed
                          ? const Icon(
                              Icons.close,
                              color: Colors.white,
                            )
                          : properties.state.value.currentStep > stepIndex
                              ? Icon(
                                  Icons.check,
                                  color: theme.colorScheme.background,
                                )
                              : icon ?? Text((stepIndex + 1).toString()),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}

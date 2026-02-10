part of '../../stepper.dart';

class StepperValue {
  /// Map of step indices to their special states.
  final Map<int, StepState> stepStates;

  /// Index of the currently active step (0-based).
  final int currentStep;

  /// Creates a [StepperValue].
  ///
  /// Parameters:
  /// - [stepStates] (`Map<int, StepState>`, required): step states by index
  /// - [currentStep] (int, required): currently active step index
  StepperValue({required this.stepStates, required this.currentStep});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is StepperValue &&
        mapEquals(other.stepStates, stepStates) &&
        other.currentStep == currentStep;
  }

  @override
  int get hashCode => Object.hash(stepStates, currentStep);

  @override
  String toString() {
    return 'StepperValue{stepStates: $stepStates, currentStep: $currentStep}';
  }
}

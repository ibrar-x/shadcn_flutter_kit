part of '../../stepper.dart';

/// StepNumberData defines a reusable type for this registry module.
class StepNumberData {
  /// Zero-based index of the step.
  final int stepIndex;

  /// Creates [StepNumberData].
  const StepNumberData({required this.stepIndex});

  @override
/// Executes `operator ==` behavior for this component/composite.
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is StepNumberData && other.stepIndex == stepIndex;
  }

  @override
/// Stores `hashCode` state/configuration for this implementation.
  int get hashCode => stepIndex.hashCode;

  @override
/// Executes `toString` behavior for this component/composite.
  String toString() {
    return 'StepNumberData{stepIndex: $stepIndex}';
  }
}

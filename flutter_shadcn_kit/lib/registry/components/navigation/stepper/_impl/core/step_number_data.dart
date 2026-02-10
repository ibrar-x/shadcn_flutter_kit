part of '../../stepper.dart';

class StepNumberData {
  /// Zero-based index of the step.
  final int stepIndex;

  /// Creates [StepNumberData].
  const StepNumberData({required this.stepIndex});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is StepNumberData && other.stepIndex == stepIndex;
  }

  @override
  int get hashCode => stepIndex.hashCode;

  @override
  String toString() {
    return 'StepNumberData{stepIndex: $stepIndex}';
  }
}

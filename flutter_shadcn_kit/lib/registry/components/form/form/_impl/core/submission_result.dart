part of '../../form.dart';

/// Result of a form submission containing values and validation errors.
///
/// Returned when a form is submitted, containing all field values
/// and any validation errors that occurred.
class SubmissionResult {
  /// Map of form field values keyed by their FormKey.
  final Map<FormKey, Object?> values;

  /// Map of validation errors keyed by their FormKey.
  final Map<FormKey, ValidationResult> errors;

  /// Creates a submission result.
  const SubmissionResult(this.values, this.errors);

  /// Returns a debug-friendly string representation.
  @override
  String toString() {
    return 'SubmissionResult($values, $errors)';
  }

  /// Compares this object with another for value equality.
  @override
  bool operator ==(Object other) {
    return other is SubmissionResult &&
        mapEquals(other.values, values) &&
        mapEquals(other.errors, errors);
  }

  @override
  int get hashCode => Object.hash(
    Object.hashAll(values.entries),
    Object.hashAll(errors.entries),
  );
}

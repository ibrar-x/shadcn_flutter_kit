part of '../../form.dart';

/// _ValidatorResultStash represents a form-related type in the registry.
class _ValidatorResultStash {
  /// Field storing `result` for this form implementation.
  final FutureOr<ValidationResult?> result;

  /// Field storing `state` for this form implementation.
  final FormValidationMode state;

  const _ValidatorResultStash(this.result, this.state);
}

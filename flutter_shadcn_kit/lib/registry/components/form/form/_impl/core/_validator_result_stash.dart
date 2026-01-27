part of '../../form.dart';

class _ValidatorResultStash {
  final FutureOr<ValidationResult?> result;
  final FormValidationMode state;

  const _ValidatorResultStash(this.result, this.state);
}

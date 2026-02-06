part of '../../form.dart';

/// A validator that ensures a string is not null or empty.
///
/// [NotEmptyValidator] extends [NonNullValidator] to also check for empty strings.
/// Commonly used for text field validation.
///
/// Example:
/// ```dart
/// NotEmptyValidator(
///   message: 'Please enter a value',
/// )
/// ```
class NotEmptyValidator extends NonNullValidator<String> {
  /// Creates a [NotEmptyValidator] with an optional custom message.
  const NotEmptyValidator({super.message});

  @override
  FutureOr<ValidationResult?> validate(
      BuildContext context, String? value, FormValidationMode state) {
    if (value == null || value.isEmpty) {
      var localizations = Localizations.of(context, ShadcnLocalizations);
      return InvalidResult(message ?? localizations.formNotEmpty, state: state);
    }
    return null;
  }

  @override
  bool operator ==(Object other) {
    return other is NotEmptyValidator && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

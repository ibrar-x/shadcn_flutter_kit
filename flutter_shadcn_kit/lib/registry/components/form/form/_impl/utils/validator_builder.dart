part of '../../form.dart';

/// A validator that uses a custom builder function for validation logic.
///
/// [ValidatorBuilder] provides a flexible way to create validators using
/// inline functions or custom validation logic without extending the Validator class.
///
/// Example:
/// ```dart
/// ValidatorBuilder<String>(
///   (value) {
///     if (value != null && value.contains('@')) {
///       return null; // Valid
///     }
///     return InvalidResult('Must contain @');
///   },
/// )
/// ```
class ValidatorBuilder<T> extends Validator<T> {
  /// The function that performs the validation.
  final ValidatorBuilderFunction<T> builder;

  /// List of form field keys this validator depends on.
  final List<FormKey> dependencies;

  /// Creates a [ValidatorBuilder] with the specified builder function.
  const ValidatorBuilder(this.builder, {this.dependencies = const []});

  @override
  FutureOr<ValidationResult?> validate(
    BuildContext context,
    T? value,
    FormValidationMode lifecycle,
  ) {
    return builder(value);
  }

  @override
  bool shouldRevalidate(FormKey<dynamic> source) {
    return dependencies.contains(source);
  }

  @override
  operator ==(Object other) {
    return other is ValidatorBuilder && other.builder == builder;
  }

  @override
  int get hashCode => builder.hashCode;
}

part of '../../form.dart';

/// A key that uniquely identifies a form field and its type.
///
/// [FormKey] extends [LocalKey] and is used throughout the form system to
/// reference specific form fields. It includes type information to ensure
/// type-safe access to form values.
///
/// Example:
/// ```dart
/// const emailKey = FormKey<String>('email');
/// const ageKey = FormKey<int>('age');
/// ```
class FormKey<T> extends LocalKey {
  /// The underlying key object.
  final Object key;

  /// Creates a [FormKey] with the specified key object.
  const FormKey(this.key);

  /// Gets the generic type parameter of this key.
  Type get type => T;

  /// Checks if a dynamic value is an instance of this key's type.
  bool isInstanceOf(dynamic value) {
    return value is T;
  }

  /// Gets the value associated with this key from the form values map.
  T? getValue(FormMapValues values) {
    return values.getValue(this);
  }

  /// Operator overload to get the value from form values (same as [getValue]).
  T? operator [](FormMapValues values) {
    return values.getValue(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FormKey && other.key == key;
  }

  @override
  int get hashCode => key.hashCode;

  @override
  String toString() {
    return 'FormKey($key)';
  }
}

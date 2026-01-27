part of '../../form_value_supplier.dart';

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

/// Abstract base class representing the result of a validation operation.

import 'dart:async';

import 'package:data_widget/data_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// Defines when form field validation should occur during the component lifecycle.
enum FormValidationMode {
  initial,
  changed,
  submitted,
}

/// A key that uniquely identifies a form field and its type.
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
abstract class ValidationResult {
  /// The form validation mode that triggered this result.
  final FormValidationMode state;

  /// Creates a [ValidationResult] with the specified validation state.
  const ValidationResult({required this.state});

  /// The form field key associated with this validation result.
  FormKey get key;

  /// Attaches a form field key to this validation result.
  ValidationResult attach(FormKey key);
}

/// A validation result that indicates a value should be replaced.
class ReplaceResult<T> extends ValidationResult {
  /// The replacement value to use.
  final T value;

  final FormKey? _key;

  /// Creates a [ReplaceResult] with the specified replacement value.
  const ReplaceResult(this.value, {required super.state}) : _key = null;

  /// Creates a [ReplaceResult] already attached to a form field key.
  const ReplaceResult.attached(this.value,
      {required FormKey key, required super.state})
      : _key = key;

  @override
  FormKey get key {
    assert(_key != null, 'The result has not been attached to a key');
    return _key!;
  }

  @override
  ReplaceResult<T> attach(FormKey key) {
    return ReplaceResult.attached(value, key: key, state: state);
  }
}

/// Interface for form field state management.
mixin FormFieldHandle {
  /// Whether the widget is currently mounted in the widget tree.
  bool get mounted;

  /// The unique key identifying this field within its form.
  FormKey get formKey;

  /// Reports a new value to the form and triggers validation.
  FutureOr<ValidationResult?> reportNewFormValue<T>(T? value);

  /// Re-runs validation on the current value.
  FutureOr<ValidationResult?> revalidate();

  /// A listenable for the current validation state.
  ValueListenable<ValidationResult?>? get validity;
}

class _FormEntryCachedValue {
  Object? value;

  _FormEntryCachedValue(this.value);
}

/// Mixin that provides form value management for stateful widgets.
mixin FormValueSupplier<T, X extends StatefulWidget> on State<X> {
  _FormEntryCachedValue? _cachedValue;
  int _futureCounter = 0;
  FormFieldHandle? _entryState;

  /// Gets the current form value.
  T? get formValue => _cachedValue?.value as T?;

  /// Sets a new form value and triggers validation.
  set formValue(T? value) {
    if (_cachedValue != null && _cachedValue!.value == value) {
      return;
    }
    _cachedValue = _FormEntryCachedValue(value);
    _reportNewFormValue(value);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var newState = Data.maybeOf<FormFieldHandle>(context);
    if (newState != _entryState) {
      _entryState = newState;
      _reportNewFormValue(_cachedValue?.value as T?);
    }
  }

  /// Called when a form value is replaced by validation logic.
  @protected
  void didReplaceFormValue(T value);

  void _reportNewFormValue(T? value) {
    var state = _entryState;
    if (state == null) {
      return;
    }
    final currentCounter = ++_futureCounter;
    var validationResult = state.reportNewFormValue<T>(value);
    if (validationResult is Future<ValidationResult?>) {
      validationResult.then((value) {
        if (_futureCounter == currentCounter) {
          if (value is ReplaceResult<T>) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              if (context.mounted) {
                didReplaceFormValue(value.value);
              }
            });
          }
        }
      });
    } else if (validationResult is ReplaceResult<T>) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (context.mounted) {
          didReplaceFormValue(validationResult.value);
        }
      });
    }
  }
}

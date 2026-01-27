part of '../../form.dart';

class _FormEntryHandleInterceptor with FormFieldHandle {
  final FormFieldHandle? handle;
  final void Function(Object? value) onValueReported;

  const _FormEntryHandleInterceptor(this.handle, this.onValueReported);

  @override
  FormKey get formKey => handle!.formKey;

  @override
  bool get mounted => handle!.mounted;

  @override
  FutureOr<ValidationResult?> reportNewFormValue<T>(T? value) {
    onValueReported(value);
    return handle?.reportNewFormValue<T>(value);
  }

  @override
  FutureOr<ValidationResult?> revalidate() {
    return handle?.revalidate();
  }

  @override
  ValueListenable<ValidationResult?>? get validity => handle?.validity;

  @override
  String toString() {
    return '_FormEntryHandleInterceptor($handle, $onValueReported)';
  }

  @override
  bool operator ==(Object other) {
    return other is _FormEntryHandleInterceptor &&
        other.handle == handle &&
        other.onValueReported == onValueReported;
  }

  @override
  int get hashCode => Object.hash(handle, onValueReported);
}

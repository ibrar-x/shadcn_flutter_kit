part of '../../form.dart';

class _FormEntryInterceptorState<T> extends State<FormEntryInterceptor<T>> {
  FormFieldHandle? _handle;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _handle = Data.maybeOf<FormFieldHandle>(context);
  }

  void _onValueReported(Object? value) {
    var callback = widget.onValueReported;
    if (callback != null && value is T) {
      callback(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Data<FormFieldHandle>.inherit(
      data: _FormEntryHandleInterceptor(_handle, _onValueReported),
      child: widget.child,
    );
  }
}

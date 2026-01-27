part of 'form.dart';

/// State class for [FormEntry] widgets.
///
/// Manages form field lifecycle and integrates with parent [FormController]
/// for validation and value reporting.
class FormEntryState extends State<FormEntry> with FormFieldHandle {
  FormController? _controller;
  _FormEntryCachedValue? _cachedValue;
  final ValueNotifier<ValidationResult?> _validity = ValueNotifier(null);

  @override
  FormKey get formKey => widget.key;

  @override
  ValueListenable<ValidationResult?>? get validity => _validity;

  int _toWaitCounter = 0;
  FutureOr<ValidationResult?>? _toWait;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var oldController = _controller;
    var newController = Data.maybeOf<FormController>(context);
    if (oldController != newController) {
      oldController?.removeListener(_onControllerChanged);
      // oldController?.detach(this);
      _controller = newController;
      _onControllerChanged();
      newController?.addListener(_onControllerChanged);
      if (_cachedValue != null) {
        newController?.attach(
            context, this, _cachedValue?.value, widget.validator);
      }
    }
  }

  @override
  void dispose() {
    _controller?.removeListener(_onControllerChanged);
    // _controller?.detach(this);
    super.dispose();
  }

  void _onControllerChanged() {
    var validityFuture = _controller?.getError(widget.key);
    if (validityFuture == _toWait) {
      return;
    }
    _toWait = validityFuture;
    int counter = ++_toWaitCounter;
    if (_toWait is Future<ValidationResult?>) {
      (_toWait as Future<ValidationResult?>).then((value) {
        if (counter == _toWaitCounter) {
          _validity.value = value;
        }
      });
    } else {
      _validity.value = _toWait as ValidationResult?;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Data<FormFieldHandle>.inherit(
      data: this,
      child: widget.child,
    );
  }

  @override
  FutureOr<ValidationResult?> reportNewFormValue<T>(T? value) {
    bool isSameType = widget.key.type == T;
    if (!isSameType) {
      var parentLookup = Data.maybeFind<FormFieldHandle>(context);
      assert(parentLookup != this, 'FormEntry cannot be its own parent');
      return parentLookup?.reportNewFormValue<T>(value);
    }
    var cachedValue = _cachedValue;
    if (cachedValue != null && cachedValue.value == value) {
      return _validity.value;
    }
    _cachedValue = _FormEntryCachedValue(value);
    return _controller?.attach(context, this, value, widget.validator);
  }

  @override
  FutureOr<ValidationResult?> revalidate() {
    return _controller?.attach(
        context, this, _cachedValue, widget.validator, true);
  }
}

part of '../../multiple_choice.dart';

class _MultipleChoiceState<T> extends State<MultipleChoice<T>>
    with Choice<T>, FormValueSupplier<T?, MultipleChoice<T>> {
  @override
  void didReplaceFormValue(T? value) {
    widget.onChanged?.call(value);
  }

  @override
  void initState() {
    super.initState();
    formValue = widget.value;
  }

  @override
  void didUpdateWidget(covariant MultipleChoice<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      formValue = widget.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Data<Choice<T>>.inherit(
      data: this,
      child: widget.child,
    );
  }

  @override
  void selectItem(T item) {
    if (widget.enabled == false) {
      return;
    }
    if (widget.value != null && widget.value != item) {
      return;
    }
    if (widget.onChanged != null) {
      if (widget.value == item) {
        if (_allowUnselect) {
          widget.onChanged?.call(null);
        }
      } else {
        widget.onChanged?.call(item);
      }
    }
  }

  @override
  Iterable<T>? get value {
    T? value = widget.value;
    if (value == null) {
      return null;
    }
    return [value];
  }

  bool get _allowUnselect {
    final theme = ComponentTheme.maybeOf<MultipleChoiceTheme>(context);
    return widget.allowUnselect ?? theme?.allowUnselect ?? false;
  }
}

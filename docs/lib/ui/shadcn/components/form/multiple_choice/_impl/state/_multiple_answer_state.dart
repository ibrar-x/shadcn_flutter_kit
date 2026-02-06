part of '../../multiple_choice.dart';

class _MultipleAnswerState<T> extends State<MultipleAnswer<T>>
    with Choice<T>, FormValueSupplier<Iterable<T>, MultipleAnswer<T>> {
  @override
  void initState() {
    super.initState();
    formValue = widget.value;
  }

  @override
  void didUpdateWidget(covariant MultipleAnswer<T> oldWidget) {
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
    var value = widget.value;
    if (value == null) {
      widget.onChanged?.call([item]);
    } else if (value.contains(item)) {
      if (_allowUnselect) {
        widget.onChanged?.call(value.where((e) => e != item));
      }
    } else {
      widget.onChanged?.call(value.followedBy([item]));
    }
  }

  @override
  Iterable<T>? get value {
    return widget.value;
  }

  @override
  void didReplaceFormValue(Iterable<T>? value) {
    widget.onChanged?.call(value);
  }

  bool get _allowUnselect {
    final theme = ComponentTheme.maybeOf<MultipleChoiceTheme>(context);
    return widget.allowUnselect ?? theme?.allowUnselect ?? true;
  }
}

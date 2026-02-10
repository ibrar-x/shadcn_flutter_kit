part of '../../form_field.dart';

class _ObjectFormFieldPopupState<T> extends State<_ObjectFormFieldPopup<T>>
    implements ObjectFormHandler<T> {
  late T? _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  T? get value => _value;

  @override
  set value(T? value) {
    if (mounted) {
      setState(() {
        _value = value;
      });
    } else {
      _value = value;
    }
    widget.onChanged?.call(value);
  }

  @override
  void prompt([T? value]) {
    widget.prompt.call(value);
  }

  @override
  Future<void> close() {
    return closeOverlay(context);
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.decorate) {
      return widget.editorBuilder(context, this);
    }
    final theme = Theme.of(context);
    return Data<ObjectFormHandler<T>>.inherit(
      data: this,
      child: SurfaceCard(
        padding:
            widget.popoverPadding ??
            (EdgeInsets.symmetric(
                  vertical: theme.density.baseContentPadding,
                  horizontal: theme.density.baseContentPadding,
                ) *
                theme.scaling),
        child: widget.editorBuilder(context, this),
      ),
    );
  }
}

part of 'form_field.dart';

class _ObjectFormFieldDialogState<T> extends State<_ObjectFormFieldDialog<T>>
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
    widget.onChanged(value);
  }

  @override
  void prompt([T? value]) {
    widget.prompt.call(value);
  }

  @override
  Future<void> close() {
    final modalRoute = ModalRoute.of(context);
    Navigator.of(context).pop();
    return modalRoute?.completed ?? Future.value();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.decorate) {
      return widget.editorBuilder(context, this);
    }
    final localizations = ShadcnLocalizations.of(context);
    final theme = Theme.of(context);
    return Data<ObjectFormHandler<T>>.inherit(
      data: this,
      child: AlertDialog(
        title: widget.dialogTitle,
        content: Padding(
          padding: EdgeInsets.only(top: 8 * theme.scaling),
          child: widget.editorBuilder(
            context,
            this,
          ),
        ),
        actions: [
          if (widget.dialogActions != null)
            ...widget.dialogActions!(context, this),
          ObjectInputCancelButton(
              child: Text(localizations.buttonCancel),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          ObjectInputSaveButton(
              child: Text(localizations.buttonSave),
              onPressed: () {
                Navigator.of(context).pop(ObjectFormFieldDialogResult(_value));
              }),
        ],
      ),
    );
  }
}

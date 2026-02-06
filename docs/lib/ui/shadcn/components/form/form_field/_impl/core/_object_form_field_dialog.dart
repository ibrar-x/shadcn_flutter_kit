part of '../../form_field.dart';

class _ObjectFormFieldDialog<T> extends StatefulWidget {
  final T? value;
  final Widget Function(BuildContext context, ObjectFormHandler<T> handler)
      editorBuilder;
  final Widget? dialogTitle;
  final List<Widget> Function(
      BuildContext context, ObjectFormHandler<T> handler)? dialogActions;
  final ValueChanged<T?> prompt;
  final bool decorate;
  final ValueChanged<T?> onChanged;

  const _ObjectFormFieldDialog({
    super.key,
    required this.value,
    required this.editorBuilder,
    this.dialogTitle,
    this.dialogActions,
    required this.prompt,
    this.decorate = true,
    required this.onChanged,
  });

  @override
  State<_ObjectFormFieldDialog<T>> createState() =>
      _ObjectFormFieldDialogState<T>();
}

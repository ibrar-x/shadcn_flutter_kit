part of '../../form_field.dart';

class _ObjectFormFieldPopup<T> extends StatefulWidget {
  final T? value;
  final Widget Function(BuildContext context, ObjectFormHandler<T> handler)
      editorBuilder;
  final EdgeInsetsGeometry? popoverPadding;
  final ValueChanged<T?>? onChanged;
  final ValueChanged<T?> prompt;
  final bool decorate;

  const _ObjectFormFieldPopup({
    super.key,
    required this.value,
    required this.editorBuilder,
    required this.prompt,
    this.popoverPadding,
    this.onChanged,
    this.decorate = true,
  });

  @override
  State<_ObjectFormFieldPopup<T>> createState() =>
      _ObjectFormFieldPopupState<T>();
}

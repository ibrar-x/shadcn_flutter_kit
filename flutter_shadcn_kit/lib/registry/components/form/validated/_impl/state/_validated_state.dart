part of '../../validated.dart';

class _ValidatedState extends State<Validated> {
  final formKey = const FormKey(#validated);
  @override
  Widget build(BuildContext context) {
    return Form(
      child: FormEntry(
        key: formKey,
        validator: widget.validator,
        child: FormEntryErrorBuilder(
          builder: (context, error, child) {
            return widget.builder(context, error, child);
          },
          child: widget.child,
        ),
      ),
    );
  }
}

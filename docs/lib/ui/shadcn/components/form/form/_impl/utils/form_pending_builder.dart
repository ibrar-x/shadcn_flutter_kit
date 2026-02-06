part of '../../form.dart';

/// Widget builder for displaying pending form validations.
///
/// Shows feedback while asynchronous validations are in progress.
class FormPendingBuilder extends StatelessWidget {
  /// Optional child widget passed to the builder.
  final Widget? child;

  /// Builder function for creating pending validation display.
  final FormPendingWidgetBuilder builder;

  /// Creates a form pending builder.
  const FormPendingBuilder({super.key, required this.builder, this.child});

  @override
  Widget build(BuildContext context) {
    final controller = Data.maybeOf<FormController>(context);
    if (controller != null) {
      return AnimatedBuilder(
        animation: controller,
        child: child,
        builder: (context, child) {
          final errors = controller.validities;
          final pending = <FormKey, Future<ValidationResult?>>{};
          for (var entry in errors.entries) {
            var key = entry.key;
            var value = entry.value;
            if (value is Future<ValidationResult?>) {
              pending[key] = value;
            }
          }
          return builder(context, pending, child);
        },
      );
    }
    return builder(context, {}, child);
  }
}

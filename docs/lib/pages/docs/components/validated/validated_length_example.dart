import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/form/form/form.dart' as shadcn_form;
import '../../../../ui/shadcn/components/form/text_field/text_field.dart'
    as shadcn_text_field;
import '../../../../ui/shadcn/components/form/validated/validated.dart'
    as shadcn_validated;
import '../../../../ui/shadcn/shared/theme/theme.dart' as shadcn_theme;

const ComponentExample validatedLengthExample = ComponentExample(
  title: 'Length check',
  builder: _buildValidatedLengthExample,
  code: '''Validated<String>(
  validator: LengthValidator(min: 8),
  builder: (context, error, child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        child!,
        Text(
          error?.message ?? 'At least 8 characters',
        ),
      ],
    );
  },
  child: TextField(
    placeholder: Text('Password'),
    obscureText: true,
  ),
)''',
);

Widget _buildValidatedLengthExample(BuildContext context) {
  final colors = shadcn_theme.Theme.of(context).colorScheme;
  return shadcn_validated.Validated<String>(
    validator: const shadcn_form.LengthValidator(min: 8),
    builder: (context, error, child) {
      final message = error is shadcn_form.InvalidResult
          ? error.message
          : 'At least 8 characters';
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          child!,
          const SizedBox(height: 6),
          Text(
            message,
            style: TextStyle(
              color:
                  error == null ? colors.mutedForeground : colors.destructive,
            ),
          ),
        ],
      );
    },
    child: const shadcn_text_field.TextField(
      placeholder: Text('Password'),
      obscureText: true,
    ),
  );
}

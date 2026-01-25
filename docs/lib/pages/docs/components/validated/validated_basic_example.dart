import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/form/form/form.dart' as shadcn_form;
import '../../../../ui/shadcn/components/form/text_field/text_field.dart'
    as shadcn_text_field;
import '../../../../ui/shadcn/components/form/validated/validated.dart'
    as shadcn_validated;
import '../../../../ui/shadcn/shared/theme/theme.dart' as shadcn_theme;

const ComponentExample validatedBasicExample = ComponentExample(
  title: 'Required',
  builder: _buildValidatedBasicExample,
  code: '''Validated<String>(
  validator: NotEmptyValidator(),
  builder: (context, error, child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        child!,
        if (error != null)
          Text(
            error.message,
            style: TextStyle(color: Theme.of(context).colorScheme.destructive),
          ),
      ],
    );
  },
  child: TextField(
    placeholder: Text('Enter a value'),
  ),
)''',
);

Widget _buildValidatedBasicExample(BuildContext context) {
  final colors = shadcn_theme.Theme.of(context).colorScheme;
  return shadcn_validated.Validated<String>(
    validator: const shadcn_form.NotEmptyValidator(),
    builder: (context, error, child) {
      final message = error is shadcn_form.InvalidResult ? error.message : null;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          child!,
          if (message != null) ...[
            const SizedBox(height: 6),
            Text(
              message,
              style: TextStyle(color: colors.destructive),
            ),
          ],
        ],
      );
    },
    child: const shadcn_text_field.TextField(
      placeholder: Text('Enter a value'),
    ),
  );
}

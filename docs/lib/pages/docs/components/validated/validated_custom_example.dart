import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/form/form/form.dart' as shadcn_form;
import '../../../../ui/shadcn/components/form/text_field/text_field.dart'
    as shadcn_text_field;
import '../../../../ui/shadcn/components/form/validated/validated.dart'
    as shadcn_validated;
import '../../../../ui/shadcn/shared/theme/theme.dart' as shadcn_theme;

const ComponentExample validatedCustomExample = ComponentExample(
  title: 'Custom rule',
  builder: _buildValidatedCustomExample,
  code: r'''Validated<String>(
  validator: ValidatorBuilder<String>(
    (value) {
      if (value == null || value.trim().isEmpty) {
        return InvalidResult('Required', state: FormValidationMode.changed);
      }
      final lettersOnly = RegExp(r'^[a-zA-Z ]+$');
      if (!lettersOnly.hasMatch(value)) {
        return InvalidResult('Letters only', state: FormValidationMode.changed);
      }
      return null;
    },
  ),
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
    placeholder: Text('Display name'),
  ),
)''',
);

final shadcn_form.Validator<String> _lettersOnlyValidator =
    shadcn_form.ValidatorBuilder<String>(
  (value) {
    final trimmed = value?.trim();
    if (trimmed == null || trimmed.isEmpty) {
      return const shadcn_form.InvalidResult(
        'Required',
        state: shadcn_form.FormValidationMode.changed,
      );
    }
    final lettersOnly = RegExp(r'^[a-zA-Z ]+$');
    if (!lettersOnly.hasMatch(trimmed)) {
      return const shadcn_form.InvalidResult(
        'Letters only',
        state: shadcn_form.FormValidationMode.changed,
      );
    }
    return null;
  },
);

Widget _buildValidatedCustomExample(BuildContext context) {
  final colors = shadcn_theme.Theme.of(context).colorScheme;
  return shadcn_validated.Validated<String>(
    validator: _lettersOnlyValidator,
    builder: (context, error, child) {
      final hasError = error != null;
      final message =
          error is shadcn_form.InvalidResult ? error.message : 'Letters only';
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          child!,
          const SizedBox(height: 6),
          Text(
            message,
            style: TextStyle(
              color: hasError ? colors.destructive : colors.mutedForeground,
            ),
          ),
        ],
      );
    },
    child: const shadcn_text_field.TextField(
      placeholder: Text('Display name'),
    ),
  );
}

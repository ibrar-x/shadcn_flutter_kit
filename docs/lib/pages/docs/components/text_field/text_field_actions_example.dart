import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/form/text_field/text_field.dart'
    as shadcn_text_field;
import '../../../../ui/shadcn/components/overlay/tooltip/tooltip.dart'
    as shadcn_tooltip;

const ComponentExample textFieldActionsExample = ComponentExample(
  title: 'Actions',
  builder: _buildTextFieldActionsExample,
  code: '''TextField(
  placeholder: Text('Enter your name'),
  features: [
    InputFeature.clear(),
    InputFeature.hint(...),
    InputFeature.copy(),
    InputFeature.paste(),
  ],
)
TextField(
  placeholder: Text('Enter your password'),
  features: [
    InputFeature.clear(visibility: InputFeatureVisibility.textNotEmpty),
    InputFeature.passwordToggle(mode: PasswordPeekMode.hold),
  ],
)''',
);

Widget _buildTextFieldActionsExample(BuildContext context) {
  return const _TextFieldActionsExample();
}

class _TextFieldActionsExample extends StatelessWidget {
  const _TextFieldActionsExample();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        shadcn_text_field.TextField(
          placeholder: const Text('Enter your name'),
          features: [
            const shadcn_text_field.InputFeature.clear(),
            shadcn_text_field.InputFeature.hint(
              popupBuilder: (context) {
                return const shadcn_tooltip.TooltipContainer(
                  child: Text('This is for your username'),
                );
              },
            ),
            const shadcn_text_field.InputFeature.copy(),
            const shadcn_text_field.InputFeature.paste(),
          ],
        ),
        const SizedBox(height: 24),
        const shadcn_text_field.TextField(
          placeholder: Text('Enter your password'),
          features: [
            shadcn_text_field.InputFeature.clear(
              visibility: shadcn_text_field.InputFeatureVisibility.textNotEmpty,
            ),
            shadcn_text_field.InputFeature.passwordToggle(
              mode: shadcn_text_field.PasswordPeekMode.hold,
            ),
          ],
        ),
      ],
    );
  }
}

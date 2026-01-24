import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/form/form_field/form_field.dart'
    as shadcn_form_field;
import '../../../../ui/shadcn/components/layout/card/card.dart' as shadcn_card;
import '../../../../ui/shadcn/components/control/button/button.dart'
    as shadcn_buttons;

const ComponentExample formFieldBasicExample = ComponentExample(
  title: 'Dialog selector',
  builder: _buildFormFieldBasicExample,
  code: '''ObjectFormField<String>(
  value: value,
  placeholder: Text('Select status'),
  builder: (context, value) => Text(value),
  editorBuilder: (context, handler) => ...,
)''',
);

Widget _buildFormFieldBasicExample(BuildContext context) {
  return const _FormFieldBasicExample();
}

class _FormFieldBasicExample extends StatefulWidget {
  const _FormFieldBasicExample();

  @override
  State<_FormFieldBasicExample> createState() => _FormFieldBasicExampleState();
}

class _FormFieldBasicExampleState extends State<_FormFieldBasicExample> {
  String? _value;

  @override
  Widget build(BuildContext context) {
    return shadcn_form_field.ObjectFormField<String>(
      value: _value,
      placeholder: const Text('Select status'),
      builder: (context, value) => Text(value),
      editorBuilder: (context, handler) {
        return shadcn_card.SurfaceCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              shadcn_buttons.GhostButton(
                onPressed: () {
                  handler.value = 'Draft';
                  handler.close();
                },
                child: const Text('Draft'),
              ),
              shadcn_buttons.GhostButton(
                onPressed: () {
                  handler.value = 'In review';
                  handler.close();
                },
                child: const Text('In review'),
              ),
              shadcn_buttons.GhostButton(
                onPressed: () {
                  handler.value = 'Published';
                  handler.close();
                },
                child: const Text('Published'),
              ),
            ],
          ),
        );
      },
      onChanged: (value) => setState(() => _value = value),
    );
  }
}

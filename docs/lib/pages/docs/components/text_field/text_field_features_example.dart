import 'package:flutter/material.dart';
import 'package:docs/shadcn_ui.dart' as shadcn;

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/form/text_field/text_field.dart'
    as shadcn_text_field;
import '../../../../ui/shadcn/shared/primitives/clickable.dart'
    as shadcn_clickable;

const ComponentExample textFieldFeaturesExample = ComponentExample(
  title: 'Features',
  builder: _buildTextFieldFeaturesExample,
  code: '''TextField(
  initialValue: 'Hello World!',
  placeholder: Text('Search something...'),
  features: [
    InputFeature.leading(...),
    InputFeature.clear(...),
  ],
)''',
);

Widget _buildTextFieldFeaturesExample(BuildContext context) {
  return const _TextFieldFeaturesExample();
}

class _TextFieldFeaturesExample extends StatefulWidget {
  const _TextFieldFeaturesExample();

  @override
  State<_TextFieldFeaturesExample> createState() =>
      _TextFieldFeaturesExampleState();
}

class _TextFieldFeaturesExampleState extends State<_TextFieldFeaturesExample> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: shadcn.join(
        [
          shadcn_text_field.TextField(
            initialValue: 'Hello World!',
            placeholder: const Text('Search something...'),
            features: [
              shadcn_text_field.InputFeature.leading(
                shadcn_clickable.StatedWidget.builder(
                  builder: (context, states) {
                    if (states.contains(WidgetState.hovered)) {
                      return const Icon(Icons.search);
                    }
                    return Icon(
                      Icons.search,
                      color:
                          shadcn.Theme.of(context).colorScheme.mutedForeground,
                    );
                  },
                ),
                visibility: shadcn_text_field.InputFeatureVisibility.textEmpty,
              ),
              shadcn_text_field.InputFeature.clear(
                visibility:
                    (shadcn_text_field.InputFeatureVisibility.textNotEmpty &
                            shadcn_text_field.InputFeatureVisibility.focused) |
                        shadcn_text_field.InputFeatureVisibility.hovered,
              ),
            ],
          ),
          // ignore: prefer_const_constructors
          shadcn.PrimaryButton(
            onPressed: shadcn.clearActiveTextInput,
            child: const Text('Clear Focused Input'),
          ),
        ],
        const shadcn.Gap(12),
      ).toList(),
    );
  }
}

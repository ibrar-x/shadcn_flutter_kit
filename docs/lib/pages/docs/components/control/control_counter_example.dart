import 'package:flutter/material.dart' show Icons;
import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/control/button/button.dart'
    as shadcn_buttons;
import '../../../../ui/shadcn/components/form/control/control.dart'
    as shadcn_control;
import '../../../../ui/shadcn/shared/primitives/text.dart';

const ComponentExample controlCounterExample = ComponentExample(
  title: 'Adapter counter',
  builder: _buildControlCounterExample,
  code: '''ControlledComponentAdapter<int>(
  initialValue: 2,
  builder: (context, data) => Row(
    children: [
      IconButton(onPressed: () => data.onChanged(data.value - 1)),
      Text(data.value.toString()),
      IconButton(onPressed: () => data.onChanged(data.value + 1)),
    ],
  ),
)''',
);

Widget _buildControlCounterExample(BuildContext context) {
  return shadcn_control.ControlledComponentAdapter<int>(
    initialValue: 2,
    builder: (context, data) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          shadcn_buttons.IconButton(
            onPressed:
                data.enabled ? () => data.onChanged(data.value - 1) : null,
            icon: const Icon(Icons.remove),
            variance: shadcn_buttons.ButtonVariance.secondary,
          ),
          const SizedBox(width: 12),
          Text('${data.value}').small().semiBold(),
          const SizedBox(width: 12),
          shadcn_buttons.IconButton(
            onPressed:
                data.enabled ? () => data.onChanged(data.value + 1) : null,
            icon: const Icon(Icons.add),
            variance: shadcn_buttons.ButtonVariance.secondary,
          ),
        ],
      );
    },
  );
}

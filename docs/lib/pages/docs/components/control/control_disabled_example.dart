import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/form/control/control.dart'
    as shadcn_control;
import '../../../../ui/shadcn/components/form/switch/switch.dart'
    as shadcn_switch;

const ComponentExample controlDisabledExample = ComponentExample(
  title: 'Disabled state',
  builder: _buildControlDisabledExample,
  code: '''ControlledComponentAdapter<bool>(
  initialValue: false,
  enabled: false,
  builder: (context, data) => Switch(
    value: data.value,
    onChanged: data.enabled ? data.onChanged : null,
  ),
)''',
);

Widget _buildControlDisabledExample(BuildContext context) {
  return shadcn_control.ControlledComponentAdapter<bool>(
    initialValue: false,
    enabled: false,
    builder: (context, data) => shadcn_switch.Switch(
      value: data.value,
      onChanged: data.enabled ? data.onChanged : null,
    ),
  );
}

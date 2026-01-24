import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/form/control/control.dart'
    as shadcn_control;
import '../../../../ui/shadcn/components/form/switch/switch.dart'
    as shadcn_switch;

const ComponentExample controlSwitchExample = ComponentExample(
  title: 'Controlled switch',
  builder: _buildControlSwitchExample,
  code: '''final controller = ComponentValueController<bool>(true);
ControlledComponentAdapter<bool>(
  controller: controller,
  builder: (context, data) => Switch(
    value: data.value,
    onChanged: data.enabled ? data.onChanged : null,
  ),
)''',
);

Widget _buildControlSwitchExample(BuildContext context) {
  return const _ControlSwitchExample();
}

class _ControlSwitchExample extends StatefulWidget {
  const _ControlSwitchExample();

  @override
  State<_ControlSwitchExample> createState() => _ControlSwitchExampleState();
}

class _ControlSwitchExampleState extends State<_ControlSwitchExample> {
  final _controller = shadcn_control.ComponentValueController<bool>(true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return shadcn_control.ControlledComponentAdapter<bool>(
      controller: _controller,
      builder: (context, data) => shadcn_switch.Switch(
        value: data.value,
        onChanged: data.enabled ? data.onChanged : null,
      ),
    );
  }
}

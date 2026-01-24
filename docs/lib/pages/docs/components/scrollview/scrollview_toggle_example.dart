import 'package:flutter/material.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/control/scrollview/scrollview.dart'
    as shadcn_scrollview;
import '../../../../ui/shadcn/components/form/switch/switch.dart'
    as shadcn_switch;
import '../../../../ui/shadcn/shared/primitives/text.dart';

const ComponentExample scrollviewToggleExample = ComponentExample(
  title: 'Toggle interception',
  builder: _buildScrollviewToggleExample,
  code: '''
ScrollViewInterceptor(
  enabled: enabled,
  child: ListView(...),
)
''',
);

Widget _buildScrollviewToggleExample(BuildContext context) {
  return const SizedBox(
    width: 300,
    height: 260,
    child: _ScrollviewToggleExample(),
  );
}

class _ScrollviewToggleExample extends StatefulWidget {
  const _ScrollviewToggleExample();

  @override
  State<_ScrollviewToggleExample> createState() =>
      _ScrollviewToggleExampleState();
}

class _ScrollviewToggleExampleState extends State<_ScrollviewToggleExample> {
  final ScrollController _controller = ScrollController();
  bool _enabled = true;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        shadcn_switch.Switch(
          value: _enabled,
          onChanged: (value) => setState(() => _enabled = value),
          trailing: Text(_enabled ? 'Interceptor enabled' : 'Disabled'),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: shadcn_scrollview.ScrollViewInterceptor(
            enabled: _enabled,
            child: ListView.builder(
              controller: _controller,
              itemCount: 12,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Text('Item ${index + 1}').muted(),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

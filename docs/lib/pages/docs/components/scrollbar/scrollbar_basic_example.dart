import 'package:flutter/material.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/control/scrollbar/scrollbar.dart'
    as shadcn_scrollbar;
import '../../../../ui/shadcn/shared/primitives/text.dart';

const ComponentExample scrollbarBasicExample = ComponentExample(
  title: 'Basic scrollbar',
  builder: _buildScrollbarBasicExample,
  code: '''
Scrollbar(
  thumbVisibility: true,
  child: ListView.builder(
    itemCount: 20,
    itemBuilder: (context, index) => ListTile(title: Text('Item')),
  ),
)
''',
);

Widget _buildScrollbarBasicExample(BuildContext context) {
  return const SizedBox(
    width: 280,
    height: 220,
    child: _ScrollbarBasicExample(),
  );
}

class _ScrollbarBasicExample extends StatefulWidget {
  const _ScrollbarBasicExample();

  @override
  State<_ScrollbarBasicExample> createState() => _ScrollbarBasicExampleState();
}

class _ScrollbarBasicExampleState extends State<_ScrollbarBasicExample> {
  final ScrollController _controller = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return shadcn_scrollbar.Scrollbar(
      controller: _controller,
      thumbVisibility: true,
      child: ListView.separated(
        controller: _controller,
        itemCount: 14,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          return Text('Row ${index + 1}').muted();
        },
      ),
    );
  }
}

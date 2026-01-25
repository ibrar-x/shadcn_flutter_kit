import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/utility/focus_outline/focus_outline.dart';

const ComponentExample focusOutlineBasicExample = ComponentExample(
  title: 'Focus ring',
  builder: _buildFocusOutlineBasicExample,
  code: '''FocusOutline(
  focused: isFocused,
  child: Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: BoxDecoration(
      color: Color(0xFF1F2937),
      borderRadius: BorderRadius.circular(10),
    ),
    child: const Text('Press Tab'),
  ),
)''',
);

Widget _buildFocusOutlineBasicExample(BuildContext context) {
  return const _FocusOutlineBasicExample();
}

class _FocusOutlineBasicExample extends StatefulWidget {
  const _FocusOutlineBasicExample();

  @override
  State<_FocusOutlineBasicExample> createState() =>
      _FocusOutlineBasicExampleState();
}

class _FocusOutlineBasicExampleState extends State<_FocusOutlineBasicExample> {
  final FocusNode _focusNode = FocusNode();
  bool _focused = false;

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _focusNode,
      onFocusChange: (focused) => setState(() => _focused = focused),
      child: GestureDetector(
        onTap: () => _focusNode.requestFocus(),
        child: FocusOutline(
          focused: _focused,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFF1F2937),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text('Press Tab'),
          ),
        ),
      ),
    );
  }
}

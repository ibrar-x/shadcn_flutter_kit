import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/utility/focus_outline/focus_outline.dart';

const ComponentExample focusOutlineCustomExample = ComponentExample(
  title: 'Custom ring',
  builder: _buildFocusOutlineCustomExample,
  code: '''FocusOutline(
  focused: isFocused,
  align: 5,
  border: Border.all(color: Color(0xFF38BDF8), width: 2),
  borderRadius: BorderRadius.circular(18),
  child: Container(
    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
    decoration: BoxDecoration(
      color: Color(0xFF111827),
      borderRadius: BorderRadius.circular(14),
    ),
    child: const Text('Custom focus'),
  ),
)''',
);

Widget _buildFocusOutlineCustomExample(BuildContext context) {
  return const _FocusOutlineCustomExample();
}

class _FocusOutlineCustomExample extends StatefulWidget {
  const _FocusOutlineCustomExample();

  @override
  State<_FocusOutlineCustomExample> createState() =>
      _FocusOutlineCustomExampleState();
}

class _FocusOutlineCustomExampleState
    extends State<_FocusOutlineCustomExample> {
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
          align: 5,
          border: Border.all(
            color: const Color(0xFF38BDF8),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(18),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF111827),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Text('Custom focus'),
          ),
        ),
      ),
    );
  }
}

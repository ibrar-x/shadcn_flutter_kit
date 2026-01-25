import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/utility/focus_outline/focus_outline.dart';

const ComponentExample focusOutlineCircleExample = ComponentExample(
  title: 'Circle outline',
  builder: _buildFocusOutlineCircleExample,
  code: '''FocusOutline(
  focused: isFocused,
  shape: BoxShape.circle,
  child: Container(
    width: 56,
    height: 56,
    alignment: Alignment.center,
    decoration: const BoxDecoration(
      color: Color(0xFF0F172A),
      shape: BoxShape.circle,
    ),
    child: const Text('A'),
  ),
)''',
);

Widget _buildFocusOutlineCircleExample(BuildContext context) {
  return const _FocusOutlineCircleExample();
}

class _FocusOutlineCircleExample extends StatefulWidget {
  const _FocusOutlineCircleExample();

  @override
  State<_FocusOutlineCircleExample> createState() =>
      _FocusOutlineCircleExampleState();
}

class _FocusOutlineCircleExampleState
    extends State<_FocusOutlineCircleExample> {
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
          shape: BoxShape.circle,
          child: Container(
            width: 56,
            height: 56,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Color(0xFF0F172A),
              shape: BoxShape.circle,
            ),
            child: const Text('A'),
          ),
        ),
      ),
    );
  }
}

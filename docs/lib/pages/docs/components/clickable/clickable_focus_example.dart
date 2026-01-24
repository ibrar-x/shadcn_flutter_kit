import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/control/clickable/clickable.dart'
    as shadcn_control_clickable;
import '../../../../ui/shadcn/shared/primitives/text.dart';
import '../../../../ui/shadcn/shared/theme/theme.dart' as shadcn_theme;

const ComponentExample clickableFocusExample = ComponentExample(
  title: 'Keyboard focus & shortcuts',
  builder: _buildClickableFocusExample,
  code: '''
Clickable(
  onPressed: () {},
  shortcuts: {LogicalKeySet(LogicalKeyboardKey.space): ActivateIntent()},
  actions: {ActivateIntent: CallbackAction(onInvoke: (_) {})},
  child: Text('Focus me and press space'),
)
''',
);

Widget _buildClickableFocusExample(BuildContext context) {
  return const _ClickableFocusExample();
}

class _ClickableFocusExample extends StatefulWidget {
  const _ClickableFocusExample();

  @override
  State<_ClickableFocusExample> createState() => _ClickableFocusExampleState();
}

class _ClickableFocusExampleState extends State<_ClickableFocusExample> {
  final FocusNode _focusNode = FocusNode();
  String _status = 'Press Enter or Space';

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _setStatus(String value) {
    setState(() => _status = value);
  }

  @override
  Widget build(BuildContext context) {
    final theme = shadcn_theme.Theme.of(context);
    return shadcn_control_clickable.Clickable(
      focusNode: _focusNode,
      focusOutline: true,
      onPressed: () => _setStatus('Activated with mouse'),
      shortcuts: {
        LogicalKeySet(LogicalKeyboardKey.space): const ActivateIntent(),
        LogicalKeySet(LogicalKeyboardKey.enter): const ActivateIntent(),
      },
      actions: {
        ActivateIntent: CallbackAction<Intent>(
          onInvoke: (_) {
            _setStatus('Activated with keyboard');
            return null;
          },
        ),
      },
      padding: WidgetStateProperty.all(
        EdgeInsets.symmetric(
          horizontal: 24 * theme.scaling,
          vertical: 16 * theme.scaling,
        ),
      ),
      decoration: WidgetStateProperty.resolveWith((states) {
        final color = states.contains(WidgetState.focused)
            ? theme.colorScheme.muted
            : theme.colorScheme.card;
        return BoxDecoration(
          color: color,
          borderRadius: theme.borderRadiusMd,
          border: Border.all(color: theme.colorScheme.border),
        );
      }),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Focus me').semiBold(),
          const SizedBox(height: 8),
          Text(_status).muted(),
        ],
      ),
    );
  }
}

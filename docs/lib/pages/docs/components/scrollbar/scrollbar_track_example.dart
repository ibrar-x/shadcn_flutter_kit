import 'package:flutter/material.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/control/scrollbar/scrollbar.dart'
    as shadcn_scrollbar;
import '../../../../ui/shadcn/shared/primitives/text.dart';
import '../../../../ui/shadcn/shared/theme/theme.dart' as shadcn_theme;

const ComponentExample scrollbarTrackExample = ComponentExample(
  title: 'Track + custom thickness',
  builder: _buildScrollbarTrackExample,
  code: '''
Scrollbar(
  trackVisibility: true,
  thickness: 10,
  radius: Radius.circular(12),
  child: ListView(...),
)
''',
);

Widget _buildScrollbarTrackExample(BuildContext context) {
  return const SizedBox(
    width: 280,
    height: 200,
    child: _ScrollbarTrackExample(),
  );
}

class _ScrollbarTrackExample extends StatefulWidget {
  const _ScrollbarTrackExample();

  @override
  State<_ScrollbarTrackExample> createState() => _ScrollbarTrackExampleState();
}

class _ScrollbarTrackExampleState extends State<_ScrollbarTrackExample> {
  final ScrollController _controller = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = shadcn_theme.Theme.of(context);
    return shadcn_scrollbar.Scrollbar(
      controller: _controller,
      trackVisibility: true,
      thickness: 10 * theme.scaling,
      radius: theme.radiusMdRadius,
      color: theme.colorScheme.accent,
      child: ListView.builder(
        controller: _controller,
        itemCount: 12,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Text('Message ${index + 1}').muted(),
          );
        },
      ),
    );
  }
}

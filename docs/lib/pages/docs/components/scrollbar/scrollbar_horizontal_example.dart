import 'package:flutter/material.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/control/scrollbar/scrollbar.dart'
    as shadcn_scrollbar;
import '../../../../ui/shadcn/components/layout/card/card.dart' as shadcn_card;

const ComponentExample scrollbarHorizontalExample = ComponentExample(
  title: 'Horizontal scrollbar',
  builder: _buildScrollbarHorizontalExample,
  code: '''
Scrollbar(
  scrollbarOrientation: ScrollbarOrientation.bottom,
  child: ListView(scrollDirection: Axis.horizontal, children: [...]),
)
''',
);

Widget _buildScrollbarHorizontalExample(BuildContext context) {
  return const SizedBox(
    width: 320,
    height: 140,
    child: _ScrollbarHorizontalExample(),
  );
}

class _ScrollbarHorizontalExample extends StatefulWidget {
  const _ScrollbarHorizontalExample();

  @override
  State<_ScrollbarHorizontalExample> createState() =>
      _ScrollbarHorizontalExampleState();
}

class _ScrollbarHorizontalExampleState
    extends State<_ScrollbarHorizontalExample> {
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
      scrollbarOrientation: ScrollbarOrientation.bottom,
      child: ListView.separated(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        itemCount: 8,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          return shadcn_card.SurfaceCard(
            child: SizedBox(
              width: 110,
              child: Center(
                child: Text('Card ${index + 1}'),
              ),
            ),
          );
        },
      ),
    );
  }
}

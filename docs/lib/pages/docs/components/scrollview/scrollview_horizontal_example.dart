import 'package:flutter/material.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/control/scrollview/scrollview.dart'
    as shadcn_scrollview;
import '../../../../ui/shadcn/components/layout/card/card.dart' as shadcn_card;

const ComponentExample scrollviewHorizontalExample = ComponentExample(
  title: 'Horizontal drag scrolling',
  builder: _buildScrollviewHorizontalExample,
  code: '''
ScrollViewInterceptor(
  child: ListView(scrollDirection: Axis.horizontal, children: [...]),
)
''',
);

Widget _buildScrollviewHorizontalExample(BuildContext context) {
  return const SizedBox(
    width: 320,
    height: 160,
    child: _ScrollviewHorizontalExample(),
  );
}

class _ScrollviewHorizontalExample extends StatefulWidget {
  const _ScrollviewHorizontalExample();

  @override
  State<_ScrollviewHorizontalExample> createState() =>
      _ScrollviewHorizontalExampleState();
}

class _ScrollviewHorizontalExampleState
    extends State<_ScrollviewHorizontalExample> {
  final ScrollController _controller = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return shadcn_scrollview.ScrollViewInterceptor(
      child: ListView.separated(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          return shadcn_card.SurfaceCard(
            child: SizedBox(
              width: 120,
              child: Center(
                child: Text('Panel ${index + 1}'),
              ),
            ),
          );
        },
      ),
    );
  }
}

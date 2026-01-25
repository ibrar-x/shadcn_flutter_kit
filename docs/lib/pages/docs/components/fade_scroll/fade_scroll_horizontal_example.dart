import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/layout/fade_scroll/fade_scroll.dart'
    as shadcn_fade_scroll;
import '../../../../ui/shadcn/components/display/chip/chip.dart' as shadcn_chip;
const ComponentExample fadeScrollHorizontalExample = ComponentExample(
  title: 'Horizontal list',
  builder: _buildFadeScrollHorizontalExample,
  code: '''final controller = ScrollController();

SizedBox(
  height: 48,
  child: FadeScroll(
    controller: controller,
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      controller: controller,
      child: Row(
        children: [Chip(child: Text('Design')), Chip(child: Text('Dev'))],
      ),
    ),
  ),
)''',
);

Widget _buildFadeScrollHorizontalExample(BuildContext context) {
  return const _FadeScrollHorizontalExample();
}

class _FadeScrollHorizontalExample extends StatefulWidget {
  const _FadeScrollHorizontalExample();

  @override
  State<_FadeScrollHorizontalExample> createState() =>
      _FadeScrollHorizontalExampleState();
}

class _FadeScrollHorizontalExampleState
    extends State<_FadeScrollHorizontalExample> {
  final ScrollController _controller = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: shadcn_fade_scroll.FadeScroll(
        controller: _controller,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: _controller,
          child: const Row(
            children: [
              shadcn_chip.Chip(child: Text('Design')),
              SizedBox(width: 8),
              shadcn_chip.Chip(child: Text('Docs')),
              SizedBox(width: 8),
              shadcn_chip.Chip(child: Text('Flutter')),
              SizedBox(width: 8),
              shadcn_chip.Chip(child: Text('Registry')),
              SizedBox(width: 8),
              shadcn_chip.Chip(child: Text('Theme')),
              SizedBox(width: 8),
              shadcn_chip.Chip(child: Text('Playground')),
            ],
          ),
        ),
      ),
    );
  }
}

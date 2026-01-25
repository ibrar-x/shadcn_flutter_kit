import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/layout/fade_scroll/fade_scroll.dart'
    as shadcn_fade_scroll;

const ComponentExample fadeScrollExample = ComponentExample(
  title: 'Fade scroll',
  builder: _buildFadeScrollExample,
  code: '''final controller = ScrollController();

SizedBox(
  height: 200,
  child: FadeScroll(
    controller: controller,
    child: ListView.builder(
      controller: controller,
      itemCount: 20,
      itemBuilder: (context, index) => ListTile(title: Text('Item \$index')),
    ),
  ),
)''',
);

Widget _buildFadeScrollExample(BuildContext context) {
  return const _FadeScrollExample();
}

class _FadeScrollExample extends StatefulWidget {
  const _FadeScrollExample();

  @override
  State<_FadeScrollExample> createState() => _FadeScrollExampleState();
}

class _FadeScrollExampleState extends State<_FadeScrollExample> {
  final ScrollController _controller = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: shadcn_fade_scroll.FadeScroll(
        controller: _controller,
        child: ListView.builder(
          controller: _controller,
          itemCount: 20,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Text('Item $index'),
            );
          },
        ),
      ),
    );
  }
}

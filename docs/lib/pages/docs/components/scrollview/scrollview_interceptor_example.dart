import 'package:flutter/material.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/control/scrollview/scrollview.dart'
    as shadcn_scrollview;
import '../../../../ui/shadcn/shared/primitives/text.dart';

const ComponentExample scrollviewInterceptorExample = ComponentExample(
  title: 'ScrollView interceptor',
  builder: _buildScrollviewInterceptorExample,
  code: '''
ScrollViewInterceptor(
  child: ListView(...),
)
''',
);

Widget _buildScrollviewInterceptorExample(BuildContext context) {
  return const SizedBox(
    width: 280,
    height: 220,
    child: _ScrollviewInterceptorExample(),
  );
}

class _ScrollviewInterceptorExample extends StatefulWidget {
  const _ScrollviewInterceptorExample();

  @override
  State<_ScrollviewInterceptorExample> createState() =>
      _ScrollviewInterceptorExampleState();
}

class _ScrollviewInterceptorExampleState
    extends State<_ScrollviewInterceptorExample> {
  final ScrollController _controller = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return shadcn_scrollview.ScrollViewInterceptor(
      child: ListView.builder(
        controller: _controller,
        itemCount: 18,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Text('Scrollable row ${index + 1}').muted(),
          );
        },
      ),
    );
  }
}

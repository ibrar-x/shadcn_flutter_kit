import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/utility/async/async.dart';

const ComponentExample asyncBasicExample = ComponentExample(
  title: 'Synchronous value',
  builder: _buildAsyncBasicExample,
  code: '''FutureOrBuilder<String>(
  future: 'Instant result',
  builder: (context, snapshot) {
    return Text(snapshot.data ?? 'Loading...');
  },
)''',
);

Widget _buildAsyncBasicExample(BuildContext context) {
  return const _AsyncBasicExample();
}

class _AsyncBasicExample extends StatelessWidget {
  const _AsyncBasicExample();

  @override
  Widget build(BuildContext context) {
    return FutureOrBuilder<String>(
      future: 'Instant result',
      builder: (context, snapshot) {
        return Text(snapshot.data ?? 'Loading...');
      },
    );
  }
}

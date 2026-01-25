import 'dart:async';

import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/utility/async/async.dart';

const ComponentExample asyncInitialExample = ComponentExample(
  title: 'Initial value',
  builder: _buildAsyncInitialExample,
  code: '''FutureOrBuilder<String>(
  future: Future.delayed(const Duration(seconds: 1), () => 'Ready'),
  initialValue: 'Preparing...',
  builder: (context, snapshot) => Text(snapshot.data ?? ''),
)''',
);

Widget _buildAsyncInitialExample(BuildContext context) {
  return const _AsyncInitialExample();
}

class _AsyncInitialExample extends StatefulWidget {
  const _AsyncInitialExample();

  @override
  State<_AsyncInitialExample> createState() => _AsyncInitialExampleState();
}

class _AsyncInitialExampleState extends State<_AsyncInitialExample> {
  late final Future<String> _future;

  @override
  void initState() {
    super.initState();
    _future = Future<String>.delayed(
      const Duration(seconds: 1),
      () => 'Ready',
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureOrBuilder<String>(
      future: _future,
      initialValue: 'Preparing...',
      builder: (context, snapshot) {
        return Text(snapshot.data ?? '');
      },
    );
  }
}

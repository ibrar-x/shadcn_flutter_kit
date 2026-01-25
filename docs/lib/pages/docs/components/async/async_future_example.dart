import 'dart:async';

import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/utility/async/async.dart';

const ComponentExample asyncFutureExample = ComponentExample(
  title: 'Future loading',
  builder: _buildAsyncFutureExample,
  code: '''FutureOrBuilder<String>(
  future: Future.delayed(const Duration(milliseconds: 650), () => 'Loaded'),
  builder: (context, snapshot) {
    if (snapshot.connectionState != ConnectionState.done) {
      return Text('Loading...');
    }
    return Text(snapshot.data ?? '');
  },
)''',
);

Widget _buildAsyncFutureExample(BuildContext context) {
  return const _AsyncFutureExample();
}

class _AsyncFutureExample extends StatefulWidget {
  const _AsyncFutureExample();

  @override
  State<_AsyncFutureExample> createState() => _AsyncFutureExampleState();
}

class _AsyncFutureExampleState extends State<_AsyncFutureExample> {
  late final Future<String> _future;

  @override
  void initState() {
    super.initState();
    _future = _load();
  }

  Future<String> _load() {
    return Future<String>.delayed(
      const Duration(milliseconds: 650),
      () => 'Loaded',
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureOrBuilder<String>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Text('Loading...');
        }
        return Text(snapshot.data ?? '');
      },
    );
  }
}

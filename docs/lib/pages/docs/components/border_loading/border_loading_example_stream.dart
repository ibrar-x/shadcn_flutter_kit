import 'package:flutter/widgets.dart';

import '../../../../ui/shadcn/components/display/border_loading/border_loading.dart'
    as shadcn_border_loading;
import '../../component_example_models.dart';

const ComponentExample borderLoadingStreamExample = ComponentExample(
  title: 'Stream progress',
  builder: _buildBorderLoadingStreamExample,
  code: '''final stream = Stream<double>.periodic(
  const Duration(milliseconds: 90),
  (tick) => (tick % 101) / 100,
);

BorderLoading(
  mode: BorderLoadingMode.progress,
  progress: 0.0,
  progressStream: stream,
  spec: BorderGradientSpec(
    type: BorderGradientType.linear,
    colors: [Color(0xFF3B82F6), Color(0xFF22C55E)],
  ),
  child: Padding(
    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
    child: Text('Stream upload'),
  ),
)''',
);

Widget _buildBorderLoadingStreamExample(BuildContext context) {
  return const _BorderLoadingStreamExample();
}

class _BorderLoadingStreamExample extends StatefulWidget {
  const _BorderLoadingStreamExample();

  @override
  State<_BorderLoadingStreamExample> createState() =>
      _BorderLoadingStreamExampleState();
}

class _BorderLoadingStreamExampleState
    extends State<_BorderLoadingStreamExample> {
  late final Stream<double> _progressStream = Stream<double>.periodic(
    const Duration(milliseconds: 90),
    (tick) => (tick % 101) / 100,
  );

  @override
  Widget build(BuildContext context) {
    return shadcn_border_loading.BorderLoading(
      mode: shadcn_border_loading.BorderLoadingMode.progress,
      progress: 0.0,
      progressStream: _progressStream,
      spec: const shadcn_border_loading.BorderGradientSpec(
        type: shadcn_border_loading.BorderGradientType.linear,
        colors: [Color(0xFF3B82F6), Color(0xFF22C55E)],
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        child: Text('Stream upload'),
      ),
    );
  }
}

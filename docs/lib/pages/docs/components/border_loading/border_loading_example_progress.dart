import 'package:flutter/widgets.dart';

import '../../../../ui/shadcn/components/control/button/button.dart'
    as shadcn_button;
import '../../../../ui/shadcn/components/display/border_loading/border_loading.dart'
    as shadcn_border_loading;
import '../../component_example_models.dart';

const ComponentExample borderLoadingProgressExample = ComponentExample(
  title: 'Determinate progress',
  builder: _buildBorderLoadingProgressExample,
  code: '''BorderLoading(
  mode: BorderLoadingMode.progress,
  progress: 0.62,
  spec: BorderGradientSpec(
    type: BorderGradientType.linear,
    colors: [Color(0xFF3B82F6), Color(0xFF22C55E)],
  ),
  child: Padding(
    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
    child: Text('Uploading...'),
  ),
)''',
);

Widget _buildBorderLoadingProgressExample(BuildContext context) {
  return const _BorderLoadingProgressExample();
}

class _BorderLoadingProgressExample extends StatefulWidget {
  const _BorderLoadingProgressExample();

  @override
  State<_BorderLoadingProgressExample> createState() =>
      _BorderLoadingProgressExampleState();
}

class _BorderLoadingProgressExampleState
    extends State<_BorderLoadingProgressExample> {
  double _progress = 0.42;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        shadcn_border_loading.BorderLoading(
          mode: shadcn_border_loading.BorderLoadingMode.progress,
          progress: _progress,
          spec: const shadcn_border_loading.BorderGradientSpec(
            type: shadcn_border_loading.BorderGradientType.linear,
            colors: [Color(0xFF3B82F6), Color(0xFF22C55E)],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            child: Text('${(_progress * 100).round()}%'),
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            shadcn_button.DestructiveButton(
              onPressed: () => setState(() => _progress = 0),
              child: const Text('Reset'),
            ),
            shadcn_button.PrimaryButton(
              onPressed: () => setState(() {
                _progress = (_progress - 0.1).clamp(0.0, 1.0);
              }),
              child: const Text('-10%'),
            ),
            shadcn_button.PrimaryButton(
              onPressed: () => setState(() {
                _progress = (_progress + 0.1).clamp(0.0, 1.0);
              }),
              child: const Text('+10%'),
            ),
          ],
        ),
      ],
    );
  }
}

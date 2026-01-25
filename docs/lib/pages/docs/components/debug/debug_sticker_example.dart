import 'package:flutter/widgets.dart';

import '../../component_example_models.dart';
import '../../../../ui/shadcn/components/control/button/button.dart'
    as shadcn_buttons;
import '../../../../ui/shadcn/components/utility/debug/debug.dart';

const ComponentExample debugStickerExample = ComponentExample(
  title: 'Debug sticker',
  builder: _buildDebugStickerExample,
  code: '''PrimaryButton(
  onPressed: () => debugPostSticker(
    context,
    const Rect.fromLTWH(24, 24, 120, 40),
    Color(0xFF7C3AED),
    'Sticker',
  ),
  child: Text('Show sticker'),
)''',
);

Widget _buildDebugStickerExample(BuildContext context) {
  return const _DebugStickerExample();
}

class _DebugStickerExample extends StatelessWidget {
  const _DebugStickerExample();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return shadcn_buttons.PrimaryButton(
          onPressed: () {
            final renderBox = context.findRenderObject() as RenderBox?;
            if (renderBox == null || !renderBox.hasSize) return;
            final offset = renderBox.localToGlobal(Offset.zero);
            final rect = offset & renderBox.size;
            debugPostSticker(
              context,
              rect,
              const Color(0xFF7C3AED),
              'Sticker',
            );
          },
          child: const Text('Show sticker'),
        );
      },
    );
  }
}

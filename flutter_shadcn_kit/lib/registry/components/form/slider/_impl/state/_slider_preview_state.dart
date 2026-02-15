part of '../../preview.dart';

/// _SliderPreviewState stores and manages mutable widget state.
class _SliderPreviewState extends State<SliderPreview> {
  SliderValue _brightness = const SliderValue.single(62);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;

    return Scaffold(
      backgroundColor: const Color(0xFFDCDCDC),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.all(24 * scaling),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _PreviewCard(
              width: 540,
              height: 180,
              child: Slider(
                value: _brightness,
                min: 0,
                max: 100,
                onChanged: (value) => setState(() => _brightness = value),
                trackHeight: 88,
                trackRadius: BorderRadius.circular(999),
                trackColor: const Color(0x422D2D33),
                valueColor: const Color(0x6A3D444C),
                thumbSize: 36,
                fillEndBias: 1,
                thumbBuilder: (context, state) => Container(
                  width: 12 * scaling,
                  height: 56 * scaling,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(999),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x4A000000),
                        blurRadius: 14,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 24 * scaling),
            const _PreviewCard(
              width: 540,
              height: 180,
              child: MediaControlSliderVariant(
                style: MediaControlSliderStyle.glass,
              ),
            ),
            SizedBox(width: 24 * scaling),
            const _PreviewCard(
              width: 540,
              height: 180,
              child: MediaControlSliderVariant(
                style: MediaControlSliderStyle.compact,
              ),
            ),
            SizedBox(width: 24 * scaling),
            const _PreviewCard(
              width: 460,
              height: 300,
              child: RangeSelectorSliderVariant(
                thumbStyle: RangeSelectorThumbStyle.line,
              ),
            ),
            SizedBox(width: 24 * scaling),
            const _PreviewCard(
              width: 460,
              height: 300,
              child: RangeSelectorSliderVariant(
                thumbStyle: RangeSelectorThumbStyle.ring,
              ),
            ),
            SizedBox(width: 24 * scaling),
            const _PreviewCard(
              width: 460,
              height: 300,
              child: RangeSelectorSliderVariant(
                thumbStyle: RangeSelectorThumbStyle.square,
              ),
            ),
            SizedBox(width: 24 * scaling),
            const _PreviewCard(
              width: 420,
              height: 180,
              child: HybridTickSliderVariant(),
            ),
            SizedBox(width: 24 * scaling),
            const _PreviewCard(
              width: 420,
              height: 180,
              child: StripedSliderVariant(),
            ),
            SizedBox(width: 24 * scaling),
            const _PreviewCard(
              width: 460,
              height: 220,
              child: WaveRangeSliderVariant(),
            ),
          ],
        ),
      ),
    );
  }
}

class _PreviewCard extends StatelessWidget {
  const _PreviewCard({
    required this.child,
    this.width = 450,
    this.height = 210,
  });

  final Widget child;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F4F4),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFCDCDCD)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 22,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: child,
    );
  }
}

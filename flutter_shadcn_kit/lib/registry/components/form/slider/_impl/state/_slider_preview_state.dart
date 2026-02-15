part of '../../preview.dart';

/// _SliderPreviewState stores and manages mutable widget state.
class _SliderPreviewState extends State<SliderPreview> {
  double _brightness = 0.64;
  double _stepped = 5;
  double _wave = 0.35;
  ShadRangeValue _range = const ShadRangeValue(3, 8, minRange: 0);

  late final List<double> _amps = List.generate(80, (index) {
    final t = index / 79.0;
    return (sin(t * pi) * (0.35 + 0.65 * sin(t * pi * 3).abs())).clamp(
      0.05,
      1.0,
    );
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final width = MediaQuery.of(context).size.width;
    final columns = width >= 1500
        ? 4
        : width >= 1100
        ? 3
        : width >= 760
        ? 2
        : 1;

    return Scaffold(
      backgroundColor: const Color(0xFFEFEFEF),
      body: GridView.count(
        padding: EdgeInsets.all(24 * scaling),
        crossAxisCount: columns,
        crossAxisSpacing: 24 * scaling,
        mainAxisSpacing: 24 * scaling,
        childAspectRatio: 1.9,
        children: [
          _PreviewCard(
            title: 'Adjust brightness',
            trailing: '${(_brightness * 100).round()}%',
            child: ShadSlider.single(
              min: 0,
              max: 1,
              value: _brightness,
              onChanged: (value) => setState(() => _brightness = value),
              preset: 'brightness',
            ),
          ),
          _PreviewCard(
            title: 'Range selector (ring thumb)',
            child: ShadSlider.range(
              min: 0,
              max: 10,
              rangeValue: _range,
              onChanged: (value) => setState(() => _range = value),
              preset: 'rangeSoft',
              thumbBuilder: ShadSliderDefaults.circleThumb,
            ),
          ),
          _PreviewCard(
            title: 'Steps + dots',
            child: ShadSlider.single(
              min: 0,
              max: 10,
              value: _stepped,
              snap: const ShadSnap.steps(10),
              onChanged: (value) => setState(() => _stepped = value),
              preset: 'stepsDots',
            ),
          ),
          _PreviewCard(
            title: 'Waveform',
            child: ShadSlider.single(
              min: 0,
              max: 1,
              value: _wave,
              onChanged: (value) => setState(() => _wave = value),
              preset: 'waveform',
              ticksBuilder: (context, state) =>
                  _waveformTicks(context, state, _amps),
              thumbBuilder: ShadSliderDefaults.circleThumb,
            ),
          ),
        ],
      ),
    );
  }
}

class _PreviewCard extends StatelessWidget {
  const _PreviewCard({required this.title, this.trailing, required this.child});

  final String title;
  final String? trailing;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(
            blurRadius: 26,
            color: Colors.black12,
            offset: Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(title)),
              if (trailing != null) Text(trailing!),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: SizedBox(width: 420, child: child),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _waveformTicks(
  BuildContext context,
  ShadSliderStateView state,
  List<double> amplitudes,
) {
  final width = state.trackRect.width;
  final height = state.trackRect.height;
  final barCount = amplitudes.length;
  final barWidth = width / barCount;
  final maxBarHeight = height * 0.78;
  final activeT = state.t ?? 0;
  final activeX = width * activeT;
  final activeColor = Theme.of(context).colorScheme.primary;
  final inactiveColor = Theme.of(
    context,
  ).colorScheme.mutedForeground.withOpacity(0.16);

  return IgnorePointer(
    child: ClipRRect(
      borderRadius: BorderRadius.circular(state.trackRadius),
      child: Stack(
        children: [
          for (int index = 0; index < barCount; index++)
            Positioned(
              left: index * barWidth,
              top: (height - (amplitudes[index] * maxBarHeight)) / 2,
              child: Container(
                width: max(1, barWidth * 0.55),
                height: amplitudes[index] * maxBarHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999),
                  color: (index * barWidth) <= activeX
                      ? activeColor
                      : inactiveColor,
                ),
              ),
            ),
        ],
      ),
    ),
  );
}

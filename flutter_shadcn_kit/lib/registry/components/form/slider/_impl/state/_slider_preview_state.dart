part of '../../preview.dart';

/// _SliderPreviewState stores and manages mutable widget state.
class _SliderPreviewState extends State<SliderPreview> {
  double _shadBrightness = 0.64;
  double _shadStepped = 5;
  ShadSliderRangeValue _shadRange = const ShadSliderRangeValue(3, 8);
  late final List<double> _amps = List.generate(64, (index) {
    final t = index / 63.0;
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
      backgroundColor: const Color(0xFFDCDCDC),
      body: GridView.count(
        padding: EdgeInsets.all(24 * scaling),
        crossAxisCount: columns,
        crossAxisSpacing: 24 * scaling,
        mainAxisSpacing: 24 * scaling,
        childAspectRatio: 2.2,
        children: [
          _PreviewCard(
            child: ShadSlider.single(
              min: 0,
              max: 1,
              value: _shadBrightness,
              onChanged: (value) => setState(() => _shadBrightness = value),
            ),
          ),
          _PreviewCard(
            child: ShadSlider.range(
              min: 0,
              max: 10,
              rangeValue: _shadRange,
              onChanged: (value) => setState(() => _shadRange = value),
              thumbBuilder: _shadHollowThumb,
            ),
          ),
          _PreviewCard(
            child: ShadSlider.single(
              min: 0,
              max: 10,
              value: _shadStepped,
              snap: const ShadSliderSnap.steps(10),
              onChanged: (value) => setState(() => _shadStepped = value),
              ticksBuilder: _shadDotTicks,
              thumbBuilder: _shadCircleThumb,
            ),
          ),
          _PreviewCard(
            child: ShadSlider.single(
              min: 0,
              max: 1,
              value: _shadBrightness,
              onChanged: (value) => setState(() => _shadBrightness = value),
              ticksBuilder: (context, state) =>
                  _shadWaveformTicks(context, state, _amps),
              thumbBuilder: _shadCircleThumb,
            ),
          ),
        ],
      ),
    );
  }
}

class _PreviewCard extends StatelessWidget {
  const _PreviewCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
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

Widget _shadCircleThumb(BuildContext context, ShadSliderThumbStateView thumb) {
  final color = Theme.of(context).colorScheme.primary;
  return IgnorePointer(
    child: Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(color: color, width: 3),
        boxShadow: const [
          BoxShadow(
            blurRadius: 12,
            color: Colors.black12,
            offset: Offset(0, 4),
          ),
        ],
      ),
    ),
  );
}

Widget _shadHollowThumb(BuildContext context, ShadSliderThumbStateView thumb) {
  final color = Theme.of(context).colorScheme.primary;
  return IgnorePointer(
    child: Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(color: color, width: 4),
        boxShadow: const [
          BoxShadow(
            blurRadius: 12,
            color: Colors.black12,
            offset: Offset(0, 4),
          ),
        ],
      ),
    ),
  );
}

Widget _shadDotTicks(BuildContext context, ShadSliderStateView state) {
  final activeT = state.t ?? 0;
  final activeColor = Theme.of(context).colorScheme.primary;
  final inactiveColor = Theme.of(
    context,
  ).colorScheme.mutedForeground.withOpacity(0.4);

  return IgnorePointer(
    child: Stack(
      children: [
        for (final mark in state.marks)
          Positioned(
            left: mark.x - 3,
            top: state.trackRect.center.dy - 3,
            child: Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: mark.t <= activeT ? activeColor : inactiveColor,
              ),
            ),
          ),
      ],
    ),
  );
}

Widget _shadWaveformTicks(
  BuildContext context,
  ShadSliderStateView state,
  List<double> amplitudes,
) {
  final width = state.trackRect.width;
  final height = state.trackRect.height;
  final barWidth = width / amplitudes.length;
  final maxBarHeight = height * 0.75;
  final activeT = state.t ?? 0;
  final activeX = state.trackRect.left + (width * activeT);
  final activeColor = Theme.of(context).colorScheme.primary;
  final inactiveColor = Theme.of(
    context,
  ).colorScheme.mutedForeground.withOpacity(0.4);

  return IgnorePointer(
    child: Stack(
      children: [
        for (int index = 0; index < amplitudes.length; index++)
          Positioned(
            left: index * barWidth,
            top: (height - (amplitudes[index] * maxBarHeight)) / 2,
            child: Container(
              width: max(1, barWidth * 0.6),
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
  );
}

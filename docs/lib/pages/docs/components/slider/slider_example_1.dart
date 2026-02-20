import 'package:docs/shadcn_ui.dart';

class SliderExample1 extends StatefulWidget {
  const SliderExample1({super.key});

  @override
  State<SliderExample1> createState() => _SliderExample1State();
}

class _SliderExample1State extends State<SliderExample1> {
  double value = 0.64;

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: value,
      thumbEdgeOffsetPx: 10,
      thumbSize: const Size(10, 25),
      fillStopsAtThumbCenter: true,
      // thumbInset:20,
      trackHeight: 30,
      onChanged: (next) {
        setState(() => value = next);
      },
    );
  }
}

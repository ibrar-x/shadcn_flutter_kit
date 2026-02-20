import 'package:docs/shadcn_ui.dart';

class SliderExample3 extends StatefulWidget {
  const SliderExample3({super.key});

  @override
  State<SliderExample3> createState() => _SliderExample3State();
}

class _SliderExample3State extends State<SliderExample3> {
  double value = 6;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        StepsDotsSlider(
          min: 0,
          max: 12,
          steps: 12,
          value: value,
          onChanged: (next) {
            setState(() {
              value = next;
            });
          },
        ),
        const Gap(16),
        Text('Step: ${value.round()}'),
      ],
    );
  }
}

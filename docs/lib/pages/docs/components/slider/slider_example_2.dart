import 'package:docs/shadcn_ui.dart';
import 'package:docs/ui/shadcn/components/form/slider/_impl/core/shad_slider_models.dart'
    show ShadRangeValue;

class SliderExample2 extends StatefulWidget {
  const SliderExample2({super.key});

  @override
  State<SliderExample2> createState() => _SliderExample2State();
}

class _SliderExample2State extends State<SliderExample2> {
  ShadRangeValue value = const ShadRangeValue(240, 980, minRange: 120);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        RangeSoftSlider(
          min: 0,
          max: 1600,
          rangeValue: value,
          onChanged: (next) {
            setState(() => value = next);
          },
        ),
        const Gap(16),
        Text('Price: \$${value.start.round()} - \$${value.end.round()}'),
      ],
    );
  }
}

import 'package:docs/shadcn_ui.dart';
import 'package:docs/ui/shadcn/components/form/slider/_impl/core/shad_slider_models.dart'
    show ShadPopoverVisibility;
import 'package:docs/ui/shadcn/components/form/slider/_impl/styles/shad_slider_defaults.dart'
    show ShadSliderDefaults;

class SliderExample4 extends StatefulWidget {
  const SliderExample4({super.key});

  @override
  State<SliderExample4> createState() => _SliderExample4State();
}

class _SliderExample4State extends State<SliderExample4> {
  double price = 420;

  static const List<double> _samples = [
    0.12,
    0.2,
    0.32,
    0.44,
    0.51,
    0.58,
    0.64,
    0.55,
    0.7,
    0.82,
    0.68,
    0.5,
    0.62,
    0.74,
    0.66,
    0.53,
    0.42,
    0.37,
    0.29,
    0.24,
    0.2,
    0.16,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WaveSlider.domain(
          min: 120,
          max: 1600,
          value: price,
          samples: _samples,
          onChanged: (next) => setState(() => price = next),
          valueFormatter: (value) => '\$${value.round()}',
          popoverVisibility: ShadPopoverVisibility.always,
          popoverBuilder: ShadSliderDefaults.valuePopoverPill(
            formatter: (value) => '\$${value.round()}',
          ),
        ),
        const Gap(12),
        Text('Selected: \$${price.round()}'),
      ],
    );
  }
}

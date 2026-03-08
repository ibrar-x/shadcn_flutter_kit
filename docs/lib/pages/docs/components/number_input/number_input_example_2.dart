import 'package:docs/shadcn_ui.dart';

class NumberInputExample2 extends StatefulWidget {
  const NumberInputExample2({super.key});

  @override
  State<NumberInputExample2> createState() => _NumberInputExample2State();
}

class _NumberInputExample2State extends State<NumberInputExample2> {
  static const double _min = 0;
  static const double _max = 64;

  late final TextEditingController _spinnerController;
  late final TextEditingController _stepperController;

  double value = 8;

  @override
  void initState() {
    super.initState();
    _spinnerController = TextEditingController(text: value.toStringAsFixed(0));
    _stepperController = TextEditingController(text: value.toStringAsFixed(0));
  }

  @override
  void dispose() {
    _spinnerController.dispose();
    _stepperController.dispose();
    super.dispose();
  }

  void _syncValue(double nextValue) {
    final clamped = nextValue.clamp(_min, _max).toDouble();
    final text = clamped.toStringAsFixed(0);
    setState(() {
      value = clamped;
      _spinnerController.text = text;
      _stepperController.text = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Spinner').medium(),
        const Gap(8),
        SizedBox(
          width: 140,
          child: TextField(
            controller: _spinnerController,
            submitFormatters: [
              TextInputFormatters.digitsOnly(min: _min, max: _max),
            ],
            features: const [
              InputFeature.spinner(step: 1, enableGesture: false),
            ],
            onChanged: (text) {
              final parsed = double.tryParse(text);
              if (parsed != null) {
                _syncValue(parsed);
              }
            },
          ),
        ),
        const Gap(16),
        const Text('Plus / Minus stepper').medium(),
        const Gap(8),
        SizedBox(
          width: 240,
          child: Row(
            children: [
              IconButton.outline(
                density: ButtonDensity.iconDense,
                size: ButtonSize.small,
                icon: const Icon(Icons.remove),
                onPressed: () => _syncValue(value - 1),
              ),
              const Gap(8),
              Expanded(
                child: TextField(
                  controller: _stepperController,
                  submitFormatters: [
                    TextInputFormatters.digitsOnly(
                      min: _min,
                      max: _max,
                    ),
                  ],
                  onChanged: (text) {
                    final parsed = double.tryParse(text);
                    if (parsed != null) {
                      _syncValue(parsed);
                    }
                  },
                ),
              ),
              const Gap(8),
              IconButton.outline(
                density: ButtonDensity.iconDense,
                size: ButtonSize.small,
                icon: const Icon(Icons.add),
                onPressed: () => _syncValue(value + 1),
              ),
            ],
          ),
        ),
        const Gap(8),
        Text('Value: ${value.toStringAsFixed(0)}').muted(),
      ],
    );
  }
}

import 'package:flutter/material.dart' hide Stepper, Step;

import '../../control/button/button.dart';
import '../stepper/stepper.dart';

class StepperPreview extends StatefulWidget {
  const StepperPreview({super.key});

  @override
  State<StepperPreview> createState() => _StepperPreviewState();
}

class _StepperPreviewState extends State<StepperPreview> {
  late final StepperController _controller;

  @override
  void initState() {
    super.initState();
    _controller = StepperController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final steps = [
      Step(title: const Text('Details'), contentBuilder: (_) {
        return const Text('Provide your details.');
      }),
      Step(title: const Text('Payment'), contentBuilder: (_) {
        return const Text('Choose a payment method.');
      }),
      Step(title: const Text('Confirm'), contentBuilder: (_) {
        return const Text('Review and submit.');
      }),
    ];

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 520,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stepper(
                controller: _controller,
                direction: Axis.vertical,
                steps: steps,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlineButton(
                    onPressed: () {
                      if (_controller.value.currentStep > 0) {
                        _controller.previousStep();
                      }
                    },
                    child: const Text('Back'),
                  ),
                  const SizedBox(width: 12),
                  PrimaryButton(
                    onPressed: () {
                      if (_controller.value.currentStep < steps.length - 1) {
                        _controller.nextStep();
                      }
                    },
                    child: const Text('Next'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

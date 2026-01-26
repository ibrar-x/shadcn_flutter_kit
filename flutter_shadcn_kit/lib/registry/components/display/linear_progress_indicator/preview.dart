import 'package:flutter/material.dart' hide LinearProgressIndicator;
import 'package:gap/gap.dart';
import '../linear_progress_indicator/linear_progress_indicator.dart';
import '../../control/button/button.dart';

class LinearProgressIndicatorPreview extends StatefulWidget {
  const LinearProgressIndicatorPreview({super.key});

  @override
  State<LinearProgressIndicatorPreview> createState() =>
      _LinearProgressIndicatorPreviewState();
}

class _LinearProgressIndicatorPreviewState
    extends State<LinearProgressIndicatorPreview> {
  double value = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              width: 200,
              child: LinearProgressIndicator(),
            ),
            const Gap(24),
            SizedBox(
              width: 200,
              child: LinearProgressIndicator(value: value),
            ),
            const Gap(24),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                PrimaryButton(
                  onPressed: () {
                    setState(() {
                      value = 0;
                    });
                  },
                  child: const Text('Reset'),
                ),
                const Gap(24),
                PrimaryButton(
                  onPressed: () {
                    setState(() {
                      value = (value + 0.1).clamp(0, 1);
                    });
                  },
                  child: const Text('Increment'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

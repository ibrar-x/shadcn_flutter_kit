part of 'preview.dart';

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
            const SizedBox(width: 200, child: LinearProgressIndicator()),
            const DensityGap(gap2xl),
            SizedBox(width: 200, child: LinearProgressIndicator(value: value)),
            const DensityGap(gap2xl),
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
                const DensityGap(gap2xl),
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

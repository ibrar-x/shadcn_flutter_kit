part of 'preview.dart';

class _NumberTickerPreviewState extends State<NumberTickerPreview> {
  int _number = 0;
  int _currentNumber = 100;
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final random = Random();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Example 1',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const DensityGap(gapSm),
            NumberTicker(
              initialNumber: 0,
              number: _number,
              style: const TextStyle(fontSize: 32),
              formatter: (number) {
                return NumberFormat.compact().format(number);
              },
            ),
            const DensityGap(gap2xl),
            TextField(
              initialValue: _number.toString(),
              controller: _controller,
              onEditingComplete: () {
                final number = int.tryParse(_controller.text);
                if (number != null) {
                  setState(() {
                    _number = number;
                  });
                }
              },
            ),
            const DensityGap(gap2xl),
            const Divider(),
            const DensityGap(gap2xl),
            const Text(
              'Example 2',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const DensityGap(gapSm),
            NumberTicker(
              initialNumber: 100,
              number: _currentNumber,
              style: const TextStyle(
                fontSize: 32,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w600,
              ),
              formatter: (value) => value.toInt().toString(),
            ),
            const DensityGap(gapLg),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _currentNumber = random.nextInt(9000) + 1000;
                });
              },
              child: const Text('Next Random Number'),
            ),
          ],
        ),
      ),
    );
  }
}

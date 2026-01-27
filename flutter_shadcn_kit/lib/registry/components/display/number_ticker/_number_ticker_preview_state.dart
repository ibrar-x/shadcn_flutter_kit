part of 'preview.dart';

class _NumberTickerPreviewState extends State<NumberTickerPreview> {
  int _number = 0;
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            NumberTicker(
              initialNumber: 0,
              number: _number,
              style: const TextStyle(fontSize: 32),
              formatter: (number) {
                return NumberFormat.compact().format(number);
              },
            ),
            const Gap(24),
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
          ],
        ),
      ),
    );
  }
}

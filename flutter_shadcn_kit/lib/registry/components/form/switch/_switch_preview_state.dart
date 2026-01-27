part of 'preview.dart';

class _SwitchPreviewState extends State<SwitchPreview> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 16,
          children: [
            // Interactive switch
            Switch(
              value: value,
              onChanged: (newValue) {
                setState(() {
                  value = newValue;
                });
              },
            ),
            // Disabled switches
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 16,
              children: [
                Switch(
                  value: false,
                  onChanged: null,
                ),
                Switch(
                  value: true,
                  onChanged: null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

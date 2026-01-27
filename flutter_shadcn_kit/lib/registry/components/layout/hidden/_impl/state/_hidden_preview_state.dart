part of '../../preview.dart';

class _HiddenPreviewState extends State<HiddenPreview> {
  bool _hidden = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SwitchListTile(
              value: _hidden,
              onChanged: (value) {
                setState(() {
                  _hidden = value;
                });
              },
              title: const Text('Hidden'),
            ),
            const SizedBox(height: 12),
            Hidden(
              hidden: _hidden,
              direction: Axis.vertical,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text('Toggle me'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

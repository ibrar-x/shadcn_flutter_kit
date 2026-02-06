part of '../../preview.dart';

class _ToastPreviewState extends State<ToastPreview> {
  final ToastController _controller = ToastController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: PrimaryButton(
          onPressed: () {
            _controller.show(
              context: context,
              builder: (context) => const Text('Saved successfully'),
            );
          },
          child: const Text('Show Toast'),
        ),
      ),
    );
  }
}

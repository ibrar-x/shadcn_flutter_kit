part of '../../preview.dart';

class _FadeScrollPreviewState extends State<FadeScrollPreview> {
  final ScrollController _controller = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 200,
          width: 260,
          child: FadeScroll(
            controller: _controller,
            child: ListView.builder(
              controller: _controller,
              itemCount: 20,
              itemBuilder: (context, index) {
                return ListTile(title: Text('Item ${index + 1}'));
              },
            ),
          ),
        ),
      ),
    );
  }
}

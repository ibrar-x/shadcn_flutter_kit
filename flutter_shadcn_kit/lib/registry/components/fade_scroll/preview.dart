import 'package:flutter/material.dart';
import '../fade_scroll/fade_scroll.dart';
import '../fade_scroll/fade_scroll.dart';

class FadeScrollPreview extends StatefulWidget {
  const FadeScrollPreview({super.key});

  @override
  State<FadeScrollPreview> createState() => _FadeScrollPreviewState();
}

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

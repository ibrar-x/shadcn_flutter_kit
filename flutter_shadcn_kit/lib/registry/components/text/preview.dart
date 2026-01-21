import 'package:flutter/material.dart';

import '../text/text.dart';

class TextPreview extends StatelessWidget {
  const TextPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Headline').large().semiBold(),
            const SizedBox(height: 8),
            Text('Supporting copy goes here.').muted().small(),
          ],
        ),
      ),
    );
  }
}

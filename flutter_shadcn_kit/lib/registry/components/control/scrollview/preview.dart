import 'package:flutter/material.dart';
import '../scrollview/scrollview.dart';

class ScrollviewPreview extends StatelessWidget {
  const ScrollviewPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 200,
          width: 300,
          child: ScrollViewInterceptor(
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(
                  20,
                  (index) => Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text('Item ${index + 1}'),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

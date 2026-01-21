import 'package:flutter/material.dart' hide Scrollbar;
import '../scrollbar/scrollbar.dart';
import '../scrollbar/scrollbar.dart';

class ScrollbarPreview extends StatelessWidget {
  const ScrollbarPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 200,
          width: 300,
          child: Scrollbar(
            child: ListView(
              children: List.generate(
                20,
                (index) => ListTile(
                  title: Text('Item ${index + 1}'),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

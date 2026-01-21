import 'package:flutter/material.dart' hide CircularProgressIndicator;
import '../circular_progress_indicator/circular_progress_indicator.dart';
import '../circular_progress_indicator/circular_progress_indicator.dart';

class CircularProgressIndicatorPreview extends StatelessWidget {
  const CircularProgressIndicatorPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

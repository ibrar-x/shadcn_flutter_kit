import 'package:flutter/material.dart' hide CircularProgressIndicator;
import '../circular_progress_indicator/circular_progress_indicator.dart';

/// Core class used by the circular progress indicator component.
class CircularProgressIndicatorPreview extends StatelessWidget {
  const CircularProgressIndicatorPreview({super.key});

  /// Builds the widget tree for circular progress indicator.
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}

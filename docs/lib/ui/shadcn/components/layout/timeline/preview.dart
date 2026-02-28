import 'package:flutter/material.dart';

import '../timeline/timeline.dart';

/// TimelinePreview defines a reusable type for this registry module.
class TimelinePreview extends StatelessWidget {
  const TimelinePreview({super.key});

  @override
/// Executes `build` behavior for this component/composite.
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Timeline(
          data: [
/// Creates a `TimelineData` instance.
            TimelineData(
              time: const Text('09:00'),
              title: const Text('Kickoff'),
              content: const Text('Project kickoff meeting.'),
            ),
/// Creates a `TimelineData` instance.
            TimelineData(
              time: const Text('11:00'),
              title: const Text('Design Review'),
              content: const Text('Review initial concepts.'),
            ),
/// Creates a `TimelineData` instance.
            TimelineData(
              time: const Text('14:30'),
              title: const Text('Delivery'),
              content: const Text('Share final assets.'),
            ),
          ],
        ),
      ),
    );
  }
}

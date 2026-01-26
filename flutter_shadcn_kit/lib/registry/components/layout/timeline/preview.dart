import 'package:flutter/material.dart';

import '../timeline/timeline.dart';

class TimelinePreview extends StatelessWidget {
  const TimelinePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Timeline(
          data: [
            TimelineData(
              time: const Text('09:00'),
              title: const Text('Kickoff'),
              content: const Text('Project kickoff meeting.'),
            ),
            TimelineData(
              time: const Text('11:00'),
              title: const Text('Design Review'),
              content: const Text('Review initial concepts.'),
            ),
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

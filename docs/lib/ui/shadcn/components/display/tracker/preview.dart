import 'package:flutter/material.dart';

import '../tracker/tracker.dart';

class TrackerPreview extends StatelessWidget {
  const TrackerPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SizedBox(
          width: 260,
          child: Tracker(
            data: [
              TrackerData(
                tooltip: Text('Healthy'),
                level: TrackerLevel.fine,
              ),
              TrackerData(
                tooltip: Text('Warning'),
                level: TrackerLevel.warning,
              ),
              TrackerData(
                tooltip: Text('Critical'),
                level: TrackerLevel.critical,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

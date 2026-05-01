import 'package:flutter/material.dart';

import '../tracker/tracker.dart';

/// Core class used by the tracker component.
class TrackerPreview extends StatelessWidget {
  const TrackerPreview({super.key});

  /// Builds the widget tree for tracker.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 260,
          child: Tracker(
            data: const [
              TrackerData(tooltip: Text('Healthy'), level: TrackerLevel.fine),

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

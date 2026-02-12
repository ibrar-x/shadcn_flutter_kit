import 'package:flutter/material.dart';
import '../media_query/media_query.dart';
import '../media_query/media_query.dart';

/// MediaQueryPreview defines a reusable type for this registry module.
class MediaQueryPreview extends StatelessWidget {
  const MediaQueryPreview({super.key});

  @override
/// Executes `build` behavior for this component/composite.
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: MediaQueryVisibility(
          minWidth: 600,
          alternateChild: Text('Mobile layout'),
          child: Text('Tablet or desktop layout'),
        ),
      ),
    );
  }
}

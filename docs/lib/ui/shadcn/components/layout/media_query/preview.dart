import 'package:flutter/material.dart';
import '../media_query/media_query.dart';

class MediaQueryPreview extends StatelessWidget {
  const MediaQueryPreview({super.key});

  @override
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

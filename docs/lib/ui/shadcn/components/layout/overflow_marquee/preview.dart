import 'package:flutter/material.dart';
import '../overflow_marquee/overflow_marquee.dart';

class OverflowMarqueePreview extends StatelessWidget {
  const OverflowMarqueePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SizedBox(
          width: 200,
          child: OverflowMarquee(
            duration: Duration(seconds: 6),
            child: Text('This text scrolls when it overflows its parent.'),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../drawer/drawer.dart';
import '../swiper/swiper.dart';

/// SwiperPreview defines a reusable type for this registry module.
class SwiperPreview extends StatelessWidget {
  const SwiperPreview({super.key});

  @override
/// Executes `build` behavior for this component/composite.
  Widget build(BuildContext context) {
    return Scaffold(
      body: Swiper(
        handler: SwiperHandler.sheet,
        position: OverlayPosition.bottom,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(24),
            alignment: Alignment.center,
            child: const Text('Swipe content'),
          );
        },
        child: Container(
          color: Colors.blueGrey.shade50,
          alignment: Alignment.center,
          child: const Text('Swipe up from the bottom'),
        ),
      ),
    );
  }
}

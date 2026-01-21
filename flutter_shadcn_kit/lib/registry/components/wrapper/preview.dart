import 'package:flutter/material.dart';

import '../wrapper/wrapper.dart';

class WrapperPreview extends StatelessWidget {
  const WrapperPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Wrapper(
          wrap: true,
          builder: (context, child) => Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: child,
          ),
          child: const Text('Wrapped content'),
        ),
      ),
    );
  }
}

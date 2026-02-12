import 'package:flutter/material.dart';

import '../outlined_container/outlined_container.dart';

/// OutlinedContainerPreview defines a reusable type for this registry module.
class OutlinedContainerPreview extends StatelessWidget {
  const OutlinedContainerPreview({super.key});

  @override
/// Executes `build` behavior for this component/composite.
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: OutlinedContainer(
          padding: const EdgeInsets.all(16),
          borderRadius: BorderRadius.circular(16),
          child: const Text('Outlined container'),
        ),
      ),
    );
  }
}

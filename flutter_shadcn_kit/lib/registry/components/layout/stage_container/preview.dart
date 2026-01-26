import 'package:flutter/material.dart';

import '../stage_container/stage_container.dart';

class StageContainerPreview extends StatelessWidget {
  const StageContainerPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StageContainer(
          builder: (context, padding) {
            return Padding(
              padding: padding,
              child: Container(
                padding: const EdgeInsets.all(24),
                color: Colors.blueGrey.shade50,
                child: const Text('Stage content'),
              ),
            );
          },
        ),
      ),
    );
  }
}
